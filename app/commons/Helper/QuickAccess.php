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
     * @return ContainerInterface
     */
    public static function getContainer()
    {
        return self::$container;
    }

    /**
     * 返回登录的用户数据
     *
     * @return Mautic\UserBundle\Entity\User
     */
    public static function getCurrentLoginUser()
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
    public static function getDoctrine()
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
    public static function getHttpConnector()
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
     * @return \Mautic\CoreBundle\Factory\IpLookupFactory
     */
    public static function getIpLookup()
    {
        $ipServiceFactory = self::$container->get('mautic.ip_lookup.factory');

        return $ipServiceFactory;
    }

    /**
     * 解压缩 zip 文件到指定目录中
     * 
     * @param  file $zipFile
     * @param  string $distDir
     * 
     * @return boolean
     */
    public static function extractZipFile($zipFile, $distDir)
    {
        if (!file_exists($zipFile)) {
            return [
                'error'   => true,
                'message' => 'mautic.core.update.archive_no_such_file',
            ];
        }

        if (!is_dir($distDir)) {
            return [
                'error'   => true,
                'message' => 'mautic.core.update.no_such_dir',
            ];
        }

        $zipper  = new \ZipArchive();
        $archive = $zipper->open($zipFile);

        if ($archive !== true) {
            // Get the exact error
            switch ($archive) {
                case \ZipArchive::ER_EXISTS:
                    $error = 'mautic.core.update.archive_file_exists';
                    break;
                case \ZipArchive::ER_INCONS:
                case \ZipArchive::ER_INVAL:
                case \ZipArchive::ER_MEMORY:
                    $error = 'mautic.core.update.archive_zip_corrupt';
                    break;
                case \ZipArchive::ER_NOENT:
                    $error = 'mautic.core.update.archive_no_such_file';
                    break;
                case \ZipArchive::ER_NOZIP:
                    $error = 'mautic.core.update.archive_not_valid_zip';
                    break;
                case \ZipArchive::ER_READ:
                case \ZipArchive::ER_SEEK:
                case \ZipArchive::ER_OPEN:
                default:
                    $error = 'mautic.core.update.archive_zip_corrupt';
                    break;
            }

            return [
                'error'   => true,
                'message' => $error,
            ];
        }

        // Extract the archive file now
        $zipper->extractTo($distDir);
        $zipper->close();

        return [
            'error'   => false,
            'message' => 'mautic.core.success',
        ];
    }

    /**
     * 返回实体生成的表结构 sql
     *
     * @param $entityClass
     *
     * @return array
     */
    public static function buildORMEntitySchema($entityClass)
    {
        $em         = self::getDoctrine()->getManager();
        /**@var EntityManager $em */

        $metadata = new ORM\ClassMetadata($entityClass);
        $entityClass::loadMetadata($metadata);

        $schemaTool    = new SchemaTool($em);
        $schemas = $schemaTool->getSchemaFromMetadata([$metadata]);

        $dbPlatform = $em->getConnection()->getDatabasePlatform();

        $sql = $dbPlatform->getName() === 'sqlite' ? [] : ['SET foreign_key_checks = 0;'];
        $sql = array_merge($sql, $schemas->toSql($dbPlatform));

        return $sql;
    }

}