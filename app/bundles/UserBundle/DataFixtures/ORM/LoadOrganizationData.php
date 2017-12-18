<?php

/*
 * @copyright   2014 Mautic Contributors. All rights reserved
 * @author      Mautic
 *
 * @link        http://mautic.org
 *
 * @license     GNU/GPLv3 http://www.gnu.org/licenses/gpl-3.0.html
 */

namespace Mautic\UserBundle\DataFixtures\ORM;

use Doctrine\Common\DataFixtures\AbstractFixture;
use Doctrine\Common\DataFixtures\OrderedFixtureInterface;
use Doctrine\Common\Persistence\ObjectManager;
use Mautic\UserBundle\Entity\Organization;
use Symfony\Component\DependencyInjection\ContainerAwareInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * Class LoadOrganizationData.
 */
class LoadOrganizationData extends AbstractFixture implements OrderedFixtureInterface, ContainerAwareInterface
{
    /**
     * @var ContainerInterface
     */
    private $container;

    /**
     * {@inheritdoc}
     */
    public function setContainer(ContainerInterface $container = null)
    {
        $this->container = $container;
    }

    /**
     * @param ObjectManager $manager
     */
    public function load(ObjectManager $manager)
    {
        $org = new Organization();
        $org->setName('联智云');
        $org->setIsPublished(1);
        $org->setDateAdded(date('Y-m-d H:i:s'));
        $manager->persist($org);
        $manager->flush();

        $this->addReference('org-default', $org);

        $org = new Organization();
        $org->setName('小米妖');
        $org->setIsPublished(1);
        $org->setDateAdded(date('Y-m-d H:i:s'));
        $manager->persist($org);
        $manager->flush();

        $this->addReference('org-xiaomiyao', $org);
    }

    /**
     * {@inheritdoc}
     */
    public function getOrder()
    {
        return 1;
    }
}
