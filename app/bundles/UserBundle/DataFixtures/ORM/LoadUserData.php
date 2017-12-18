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
use Mautic\UserBundle\Entity\User;
use Symfony\Component\DependencyInjection\ContainerAwareInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * Class LoadUserData.
 */
class LoadUserData extends AbstractFixture implements OrderedFixtureInterface, ContainerAwareInterface
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
        $user = new User();
        $user->setFirstName('Admin');
        $user->setLastName('User');
        $user->setUsername('admin');
        $user->setEmail('admin@lianzh.com');
        $encoder = $this->container
            ->get('security.encoder_factory')
            ->getEncoder($user)
        ;
        $user->setPassword($encoder->encodePassword('111111', $user->getSalt()));
        $user->setRole($this->getReference('admin-role'));
        $user->setOrganization($this->getReference('org-default'));
        $manager->persist($user);
        $manager->flush();

        $this->addReference('admin-user', $user);

        $user = new User();
        $user->setFirstName('Sales');
        $user->setLastName('User');
        $user->setUsername('sales');
        $user->setEmail('sales@lianzh.com');
        $encoder = $this->container
            ->get('security.encoder_factory')
            ->getEncoder($user)
        ;
        $user->setPassword($encoder->encodePassword('111111', $user->getSalt()));
        $user->setRole($this->getReference('sales-role'));
        $user->setOrganization($this->getReference('org-default'));
        $manager->persist($user);
        $manager->flush();

        $this->addReference('sales-user', $user);

        $user = new User();
        $user->setFirstName('Admin');
        $user->setLastName('User');
        $user->setUsername('xiaomiyao-admin');
        $user->setEmail('admin@xiaomiyao.com');
        $encoder = $this->container
            ->get('security.encoder_factory')
            ->getEncoder($user)
        ;
        $user->setPassword($encoder->encodePassword('111111', $user->getSalt()));
        $user->setRole($this->getReference('admin-role@xiaomiyao'));
        $user->setOrganization($this->getReference('org-xiaomiyao'));
        $manager->persist($user);
        $manager->flush();

        $this->addReference('admin-user@xiaomiyao', $user);

        $user = new User();
        $user->setFirstName('Sales');
        $user->setLastName('User');
        $user->setUsername('xiaomiyao-sales');
        $user->setEmail('sales@xiaomiyao.com');
        $encoder = $this->container
            ->get('security.encoder_factory')
            ->getEncoder($user)
        ;
        $user->setPassword($encoder->encodePassword('111111', $user->getSalt()));
        $user->setRole($this->getReference('admin-role@xiaomiyao'));
        $user->setOrganization($this->getReference('org-xiaomiyao'));
        $manager->persist($user);
        $manager->flush();

        $this->addReference('sales-user@xiaomiyao', $user);
    }

    /**
     * {@inheritdoc}
     */
    public function getOrder()
    {
        return 3;
    }
}
