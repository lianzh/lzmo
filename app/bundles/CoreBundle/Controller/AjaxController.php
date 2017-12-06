<?php

/*
 * @copyright   2014 Mautic Contributors. All rights reserved
 * @author      Mautic
 *
 * @link        http://mautic.org
 *
 * @license     GNU/GPLv3 http://www.gnu.org/licenses/gpl-3.0.html
 */

namespace Mautic\CoreBundle\Controller;

use Mautic\CoreBundle\CoreEvents;
use Mautic\CoreBundle\Event\CommandListEvent;
use Mautic\CoreBundle\Event\GlobalSearchEvent;
use Mautic\CoreBundle\Event\UpgradeEvent;
use Mautic\CoreBundle\Helper\InputHelper;
use Mautic\CoreBundle\IpLookup\AbstractLocalDataLookup;
use Mautic\CoreBundle\IpLookup\AbstractLookup;
use Mautic\CoreBundle\IpLookup\IpLookupFormInterface;
use Symfony\Bundle\FrameworkBundle\Console\Application;
use Symfony\Component\Console\Input\ArgvInput;
use Symfony\Component\Console\Output\BufferedOutput;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;

/**
 * Class AjaxController.
 */
class AjaxController extends CommonController
{
    /**
     * @param array $dataArray
     * @param int   $statusCode
     * @param bool  $addIgnoreWdt
     *
     * @return JsonResponse
     *
     * @throws \Exception
     */
    protected function sendJsonResponse($dataArray, $statusCode = null, $addIgnoreWdt = true)
    {
        $response = new JsonResponse();

        if ($this->factory->getEnvironment() == 'dev' && $addIgnoreWdt) {
            $dataArray['ignore_wdt'] = 1;
        }

        if ($statusCode !== null) {
            $response->setStatusCode($statusCode);
        }

        $response->setData($dataArray);

        return $response;
    }

    /**
     * Executes an action requested via ajax.
     *
     * @return JsonResponse
     */
    public function delegateAjaxAction()
    {
        //process ajax actions
        $authenticationChecker = $this->get('security.authorization_checker');
        $action                = $this->request->get('action');
        $bundleName            = null;
        if (empty($action)) {
            //check POST
            $action = $this->request->request->get('action');
        }

        if ($authenticationChecker->isGranted('IS_AUTHENTICATED_REMEMBERED')) {
            if (strpos($action, ':') !== false) {
                //call the specified bundle's ajax action
                $parts     = explode(':', $action);
                $namespace = 'Mautic';
                $isPlugin  = false;

                if (count($parts) == 3 && $parts['0'] == 'plugin') {
                    $namespace = 'MauticPlugin';
                    array_shift($parts);
                    $isPlugin = true;
                }

                if (count($parts) == 2) {
                    $bundleName = $parts[0];
                    $bundle     = ucfirst($bundleName);
                    $action     = $parts[1];
                    if (!$classExists = class_exists($namespace.'\\'.$bundle.'Bundle\\Controller\\AjaxController')) {
                        // Check if a plugin is prefixed with Mautic
                        $bundle      = 'Mautic'.$bundle;
                        $classExists = class_exists($namespace.'\\'.$bundle.'Bundle\\Controller\\AjaxController');
                    } elseif (!$isPlugin) {
                        $bundle = 'Mautic'.$bundle;
                    }

                    if ($classExists) {
                        return $this->forward(
                            "{$bundle}Bundle:Ajax:executeAjax",
                            [
                                'action' => $action,
                                //forward the request as well as Symfony creates a subrequest without GET/POST
                                'request' => $this->request,
                                'bundle'  => $bundleName,
                            ]
                        );
                    }
                }
            }

            return $this->executeAjaxAction($action, $this->request, $bundleName);
        }

        return $this->sendJsonResponse(['success' => 0]);
    }

    /**
     * @param         $action
     * @param Request $request
     * @param null    $bundle
     *
     * @return JsonResponse
     */
    public function executeAjaxAction($action, Request $request, $bundle = null)
    {
        if (method_exists($this, "{$action}Action")) {
            return $this->{"{$action}Action"}($request, $bundle);
        }

        return $this->sendJsonResponse(['success' => 0]);
    }

    /**
     * @param Request $request
     *
     * @return JsonResponse
     */
    protected function globalSearchAction(Request $request)
    {
        $dataArray = ['success' => 1];
        $searchStr = InputHelper::clean($request->query->get('global_search', ''));
        $this->get('session')->set('mautic.global_search', $searchStr);

        $event = new GlobalSearchEvent($searchStr, $this->get('translator'));
        $this->get('event_dispatcher')->dispatch(CoreEvents::GLOBAL_SEARCH, $event);

        $dataArray['newContent'] = $this->renderView(
            'MauticCoreBundle:GlobalSearch:results.html.php',
            ['results' => $event->getResults()]
        );

        return $this->sendJsonResponse($dataArray);
    }

    /**
     * @param Request $request
     *
     * @return JsonResponse
     */
    protected function commandListAction(Request $request)
    {
        $model      = InputHelper::clean($request->query->get('model'));
        $commands   = $this->getModel($model)->getCommandList();
        $dataArray  = [];
        $translator = $this->get('translator');
        foreach ($commands as $k => $c) {
            if (is_array($c)) {
                foreach ($c as $subc) {
                    $command = $translator->trans($k);
                    $command = (strpos($command, ':') === false) ? $command.':' : $command;

                    $dataArray[$command.$translator->trans($subc)] = ['value' => $command.$translator->trans($subc)];
                }
            } else {
                $command = $translator->trans($c);
                $command = (strpos($command, ':') === false) ? $command.':' : $command;

                $dataArray[$command] = ['value' => $command];
            }
        }
        sort($dataArray);

        return $this->sendJsonResponse($dataArray);
    }

    /**
     * @param Request $request
     *
     * @return JsonResponse
     */
    protected function globalCommandListAction(Request $request)
    {
        $dispatcher = $this->get('event_dispatcher');
        $event      = new CommandListEvent();
        $dispatcher->dispatch(CoreEvents::BUILD_COMMAND_LIST, $event);
        $allCommands = $event->getCommands();
        $translator  = $this->get('translator');
        $dataArray   = [];
        $dupChecker  = [];
        foreach ($allCommands as $header => $commands) {
            //@todo if/when figure out a way for typeahead dynamic headers
            //$header = $translator->trans($header);
            //$dataArray[$header] = array();
            foreach ($commands as $k => $c) {
                if (is_array($c)) {
                    $command = $translator->trans($k);
                    $command = (strpos($command, ':') === false) ? $command.':' : $command;

                    foreach ($c as $subc) {
                        $subcommand = $command.$translator->trans($subc);
                        if (!in_array($subcommand, $dupChecker)) {
                            $dataArray[]  = ['value' => $subcommand];
                            $dupChecker[] = $subcommand;
                        }
                    }
                } else {
                    $command = $translator->trans($k);
                    $command = (strpos($command, ':') === false) ? $command.':' : $command;

                    if (!in_array($command, $dupChecker)) {
                        $dataArray[]  = ['value' => $command];
                        $dupChecker[] = $command;
                    }
                }
            }
            //sort($dataArray[$header]);
        }
        //ksort($dataArray);
        sort($dataArray);

        return $this->sendJsonResponse($dataArray);
    }

    /**
     * @param Request $request
     *
     * @return JsonResponse
     */
    protected function togglePublishStatusAction(Request $request)
    {
        $dataArray = ['success' => 0];
        $name      = InputHelper::clean($request->request->get('model'));
        $id        = InputHelper::int($request->request->get('id'));
        $model     = $this->getModel($name);

        $post = $request->request->all();
        unset($post['model'], $post['id'], $post['action']);
        if (!empty($post)) {
            $extra = http_build_query($post);
        } else {
            $extra = '';
        }

        $entity = $model->getEntity($id);
        if ($entity !== null) {
            $permissionBase = $model->getPermissionBase();
            $security       = $this->get('mautic.security');
            $createdBy      = (method_exists($entity, 'getCreatedBy')) ? $entity->getCreatedBy() : null;

            if ($security->checkPermissionExists($permissionBase.':publishown')) {
                $hasPermission = $security->hasEntityAccess($permissionBase.':publishown', $permissionBase.':publishother', $createdBy);
            } elseif ($security->checkPermissionExists($permissionBase.':publish')) {
                $hasPermission = $security->isGranted($permissionBase.':publish');
            } elseif ($security->checkPermissionExists($permissionBase.':manage')) {
                $hasPermission = $security->isGranted($permissionBase.':manage');
            } elseif ($security->checkPermissionExists($permissionBase.':full')) {
                $hasPermission = $security->isGranted($permissionBase.':full');
            } elseif ($security->checkPermissionExists($permissionBase.':editown')) {
                $hasPermission = $security->hasEntityAccess($permissionBase.':editown', $permissionBase.':editother', $createdBy);
            } elseif ($security->checkPermissionExists($permissionBase.':edit')) {
                $hasPermission = $security->isGranted($permissionBase.':edit');
            } else {
                $hasPermission = false;
            }

            if ($hasPermission) {
                $dataArray['success'] = 1;
                //toggle permission state
                $refresh = $model->togglePublishStatus($entity);

                if ($refresh) {
                    $dataArray['reload'] = 1;
                } else {
                    //get updated icon HTML
                    $html = $this->renderView(
                        'MauticCoreBundle:Helper:publishstatus_icon.html.php',
                        [
                            'item'  => $entity,
                            'model' => $name,
                            'query' => $extra,
                            'size'  => (isset($post['size'])) ? $post['size'] : '',
                        ]
                    );
                    $dataArray['statusHtml'] = $html;
                }
            }
        }

        return $this->sendJsonResponse($dataArray);
    }

    /**
     * Unlock an entity locked by the current user.
     *
     * @param Request $request
     *
     * @return JsonResponse
     */
    protected function unlockEntityAction(Request $request)
    {
        $dataArray   = ['success' => 0];
        $name        = InputHelper::clean($request->request->get('model'));
        $id          = InputHelper::int($request->request->get('id'));
        $extra       = InputHelper::clean($request->request->get('parameter'));
        $model       = $this->getModel($name);
        $entity      = $model->getEntity($id);
        $currentUser = $this->user;

        if (method_exists($entity, 'getCheckedOutBy')) {
            $checkedOut = $entity->getCheckedOutBy();
            if ($entity !== null && !empty($checkedOut) && $checkedOut === $currentUser->getId()) {
                //entity exists, is checked out, and is checked out by the current user so go ahead and unlock
                $model->unlockEntity($entity, $extra);
                $dataArray['success'] = 1;
            }
        }

        return $this->sendJsonResponse($dataArray);
    }

    /**
     * @param Request $request
     *
     * @return JsonResponse
     */
    protected function updateUserStatusAction(Request $request)
    {
        $status = InputHelper::clean($request->request->get('status'));

        /** @var \Mautic\UserBundle\Model\UserModel $model */
        $model = $this->getModel('user');

        $currentStatus = $this->user->getOnlineStatus();
        if (!in_array($currentStatus, ['manualaway', 'dnd'])) {
            if ($status == 'back') {
                $status = 'online';
            }

            $model->setOnlineStatus($status);
        }

        return $this->sendJsonResponse(['success' => 1]);
    }

    /**
     * @param Request $request
     *
     * @return JsonResponse
     */
    protected function clearNotificationAction(Request $request)
    {
        $id = InputHelper::int($request->get('id', 0));

        /** @var \Mautic\CoreBundle\Model\NotificationModel $model */
        $model = $this->getModel('core.notification');
        $model->clearNotification($id, 200);

        return $this->sendJsonResponse(['success' => 1]);
    }

    /**
     * @param Request $request
     *
     * @return JsonResponse
     */
    protected function getBuilderTokensAction(Request $request)
    {
        $tokens = [];

        if (method_exists($this, 'getBuilderTokens')) {
            $query  = $request->get('query');
            $tokens = $this->getBuilderTokens($query);
        }

        return $this->sendJsonResponse($tokens);
    }

    /**
     * Fetch remote data store.
     *
     * @param Request $request
     *
     * @return JsonResponse
     */
    protected function downloadIpLookupDataStoreAction(Request $request)
    {
        $dataArray = ['success' => 0];

        if ($request->request->has('service')) {
            $serviceName = $request->request->get('service');
            $serviceAuth = $request->request->get('auth');

            /** @var \Mautic\CoreBundle\Factory\IpLookupFactory $ipServiceFactory */
            $ipServiceFactory = $this->container->get('mautic.ip_lookup.factory');
            $ipService        = $ipServiceFactory->getService($serviceName, $serviceAuth);

            if ($ipService instanceof AbstractLocalDataLookup) {
                if ($ipService->downloadRemoteDataStore()) {
                    $dataArray['success'] = 1;
                    $dataArray['message'] = $this->container->get('translator')->trans('mautic.core.success');
                } else {
                    $remoteUrl = $ipService->getRemoteDateStoreDownloadUrl();
                    $localPath = $ipService->getLocalDataStoreFilepath();

                    if ($remoteUrl && $localPath) {
                        $dataArray['error'] = $this->container->get('translator')->trans(
                            'mautic.core.ip_lookup.remote_fetch_error',
                            [
                                '%remoteUrl%' => $remoteUrl,
                                '%localPath%' => $localPath,
                            ]
                        );
                    } else {
                        $dataArray['error'] = $this->container->get('translator')->trans(
                            'mautic.core.ip_lookup.remote_fetch_error_generic'
                        );
                    }
                }
            }
        }

        return $this->sendJsonResponse($dataArray);
    }

    /**
     * Fetch IP Lookup form.
     *
     * @param Request $request
     *
     * @return JsonResponse
     */
    protected function getIpLookupFormAction(Request $request)
    {
        $dataArray = ['html' => '', 'attribution' => ''];

        if ($request->request->has('service')) {
            $serviceName = $request->request->get('service');

            /** @var \Mautic\CoreBundle\Factory\IpLookupFactory $ipServiceFactory */
            $ipServiceFactory = $this->container->get('mautic.ip_lookup.factory');
            $ipService        = $ipServiceFactory->getService($serviceName);

            if ($ipService instanceof AbstractLookup) {
                $dataArray['attribution'] = $ipService->getAttribution();
                if ($ipService instanceof IpLookupFormInterface) {
                    if ($formType = $ipService->getConfigFormService()) {
                        $themes   = $ipService->getConfigFormThemes();
                        $themes[] = 'MauticCoreBundle:FormTheme\Config';

                        $form = $this->get('form.factory')->create($formType, [], ['ip_lookup_service' => $ipService]);
                        $html = $this->renderView(
                            'MauticCoreBundle:FormTheme\Config:ip_lookup_config_row.html.php',
                            [
                                'form' => $this->setFormTheme($form, 'MauticCoreBundle:FormTheme\Config:ip_lookup_config_row.html.php', $themes),
                            ]
                        );

                        $html              = str_replace($formType.'_', 'config_coreconfig_ip_lookup_config_', $html);
                        $html              = str_replace($formType, 'config[coreconfig][ip_lookup_config]', $html);
                        $dataArray['html'] = $html;
                    }
                }
            }
        }

        return $this->sendJsonResponse($dataArray);
    }
}
