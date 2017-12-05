<?php
namespace LianzhCommon\Helper;

use Symfony\Component\DependencyInjection\ContainerInterface;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Tools\SchemaTool;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\Bundle\DoctrineBundle\Registry;
use Joomla\Http\HttpFactory;

/**
 * 定义一批快速使用的函数集
 */
abstract class QuickAccess
{

    /**
     * @var ContainerInterface
     */
    private static $container = null;

    /**
     * 设置容器对象
     *
     * @param ContainerInterface|null $container
     */
    public static function setContainer(ContainerInterface $container = null)
    {
        self::$container = $container;
    }

    /**
     * 返回单例对象
     *
     * @return QuickAccess|null
     */
    public static function getInstance()
    {
        static $self = null;

        if (empty(self::$container))
        {
            throw new \LogicException("Please init `container`!");
        }

        if (is_null($self)) $self = new self();
        return $self;
    }

    /**
     * 返回容器对象
     *
     * @return ContainerInterface|null
     */
    public function getContainer()
    {
        return self::$container;
    }

    /**
     * 返回登录的用户数据
     *
     * @return Mautic\UserBundle\Entity\User
     */
    public function getCurrentLoginUser()
    {
        return self::$container->get('security.context')->getToken()->getUser();
    }

    /**
     * Shortcut to return the Doctrine Registry service.
     *
     * @return Registry
     *
     * @throws \LogicException If DoctrineBundle is not available
     */
    public function getDoctrine()
    {
        if (!self::$container->has('doctrine')) {
            throw new \LogicException('The DoctrineBundle is not registered in your application.');
        }

        return self::$container->get('doctrine');
    }

    /**
     * 返回 Http 客户端对象
     * 
     * @return \Joomla\Http\Http
     */
    public function getHttpConnector()
    {
        static $connector = null;
        if (is_null($connector)) {
            $connector = HttpFactory::getHttp();
        }

        // $options = [
        //         'transport.curl'    => [
        //             CURLOPT_SSL_VERIFYPEER => false,
        //         ]
        //     ];

        return $connector;
    }

    /**
     * 返回 IpLookup 服务对象
     * 
     * @return [type] [description]
     */
    public function getIpLookup()
    {
        $ipServiceFactory = self::$container->get('mautic.ip_lookup.factory');

        return $ipServiceFactory;
    }



}