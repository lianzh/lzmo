<?php

/*
 * @copyright   2016 Mautic Contributors. All rights reserved
 * @author      Mautic
 *
 * @link        http://mautic.org
 *
 * @license     GNU/GPLv3 http://www.gnu.org/licenses/gpl-3.0.html
 */

namespace Mautic\CoreBundle\Controller;

use Mautic\CoreBundle\CoreEvents;
use Mautic\CoreBundle\Event\BuildJsEvent;
use Symfony\Component\HttpFoundation\Response;

/**
 * Class JsController.
 */
class JsController extends CommonController
{
    /**
     * @return Response
     */
    public function indexAction()
    {
        $dispatcher = $this->dispatcher;
        $debug      = $this->factory->getKernel()->isDebug();
        $event      = new BuildJsEvent($this->getJsHeader(), $debug);

        if ($dispatcher->hasListeners(CoreEvents::BUILD_MAUTIC_JS)) {
            $dispatcher->dispatch(CoreEvents::BUILD_MAUTIC_JS, $event);
        }

        return new Response($event->getJs(), 200, ['Content-Type' => 'application/javascript']);
    }

    /**
     * Build a JS header for the Mautic embedded JS.
     *
     * @return string
     */
    protected function getJsHeader()
    {
        return '';
    }
}
