<?php

/*
 * @copyright   2014 Mautic Contributors. All rights reserved
 * @author      Mautic
 *
 * @link        http://mautic.org
 *
 * @license     GNU/GPLv3 http://www.gnu.org/licenses/gpl-3.0.html
 */

namespace Mautic\UserBundle\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Mautic\ApiBundle\Serializer\Driver\ApiMetadataDriver;
use Mautic\CoreBundle\Doctrine\Mapping\ClassMetadataBuilder;
use Mautic\CoreBundle\Entity\FormEntity;
use Symfony\Component\Validator\Constraints as Assert;
use Symfony\Component\Validator\Mapping\ClassMetadata;
use Mautic\SupervisorBundle\Auth\Provider as SAP;

/**
 * Class Role.
 */
class Role extends FormEntity
{
    /**
     * @var int
     */
    private $id;

    /**
     * @var string
     */
    private $name;

    /**
     * @var string
     */
    private $description;

    /**
     * @var bool
     */
    private $isAdmin = false;

    /**
     * @var ArrayCollection
     */
    private $permissions;

    /**
     * @var array
     */
    private $rawPermissions;

    /**
     * @var ArrayCollection
     */
    private $users;

    /**
     * @var Organization
     */
    private $organization;

    /**
     * Constructor.
     */
    public function __construct()
    {
        $this->permissions = new ArrayCollection();
        $this->users       = new ArrayCollection();
    }

    /**
     * @param ORM\ClassMetadata $metadata
     */
    public static function loadMetadata(ORM\ClassMetadata $metadata)
    {
        $builder = new ClassMetadataBuilder($metadata);

        $builder->setTable('roles')
            ->setCustomRepositoryClass('\Mautic\UserBundle\Entity\RoleRepository');

        $builder->addIdColumns();

        $builder->createField('isAdmin', 'boolean')
            ->columnName('is_admin')
            ->build();

        $builder->createOneToMany('permissions', '\Mautic\UserBundle\Entity\Permission')
            ->orphanRemoval()
            ->mappedBy('role')
            ->cascadePersist()
            ->cascadeRemove()
            ->fetchExtraLazy()
            ->build();

        $builder->createField('rawPermissions', 'array')
            ->columnName('readable_permissions')
            ->build();

        $builder->createOneToMany('users', '\Mautic\UserBundle\Entity\User')
            ->mappedBy('role')
            ->fetchExtraLazy()
            ->build();

        $builder->createManyToOne('organization', '\Mautic\UserBundle\Entity\Organization')
            ->inversedBy('roles')
            ->cascadeMerge()
            ->addJoinColumn('organization_id', 'id', false)
            ->build();
    }

    /**
     * @param ClassMetadata $metadata
     */
    public static function loadValidatorMetadata(ClassMetadata $metadata)
    {
        $metadata->addPropertyConstraint('name', new Assert\NotBlank(
            ['message' => 'mautic.core.name.required']
        ));
    }

    /**
     * Prepares the metadata for API usage.
     *
     * @param $metadata
     */
    public static function loadApiMetadata(ApiMetadataDriver $metadata)
    {
        $metadata->setGroupPrefix('role')
            ->addListProperties(
                [
                    'id',
                    'name',
                    'description',
                    'isAdmin',
                    'rawPermissions',
                ]
            )
            ->build();
    }

    /**
     * Get id.
     *
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set name.
     *
     * @param string $name
     *
     * @return Role
     */
    public function setName($name)
    {
        $this->isChanged('name', $name);
        $this->name = $name;

        return $this;
    }

    /**
     * Get name.
     *
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Add permissions.
     *
     * @param Permission $permissions
     *
     * @return Role
     */
    public function addPermission(Permission $permissions)
    {
        $permissions->setRole($this);

        $this->permissions[] = $permissions;

        return $this;
    }

    /**
     * Remove permissions.
     *
     * @param Permission $permissions
     */
    public function removePermission(Permission $permissions)
    {
        $this->permissions->removeElement($permissions);
    }

    /**
     * Get permissions.
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getPermissions()
    {
        return $this->permissions;
    }

    /**
     * Set description.
     *
     * @param string $description
     *
     * @return Role
     */
    public function setDescription($description)
    {
        $this->isChanged('description', $description);
        $this->description = $description;

        return $this;
    }

    /**
     * Get description.
     *
     * @return string
     */
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * Set isAdmin.
     *
     * @param bool $isAdmin
     *
     * @return Role
     */
    public function setIsAdmin($isAdmin)
    {
        $this->isChanged('isAdmin', $isAdmin);
        $this->isAdmin = $isAdmin;

        return $this;
    }

    /**
     * Get isAdmin.
     *
     * @return bool
     */
    public function getIsAdmin()
    {
        return $this->isAdmin;
    }

    /**
     * Get isAdmin.
     *
     * @return bool
     */
    public function isAdmin()
    {
        return $this->getIsAdmin();
    }

    /**
     * Determines if user is supervisor ORGANIZATION.
     *
     * @return bool
     */
    public function isSupervisor()
    {
        if ($this->organization !== null) {
            return SAP::ORGANIZATION_ID === $this->organization->getId();
        }

        return false;
    }

    /**
     * Simply used to store a readable format of permissions for the changelog.
     *
     * @param array $permissions
     */
    public function setRawPermissions(array $permissions)
    {
        $this->isChanged('rawPermissions', $permissions);
        $this->rawPermissions = $permissions;
    }

    /**
     * Get rawPermissions.
     *
     * @return array
     */
    public function getRawPermissions()
    {
        return $this->rawPermissions;
    }

    /**
     * Add user.
     *
     * @param User $user
     *
     * @return Role
     */
    public function addUser(User $user)
    {
        $this->users[] = $user;

        return $this;
    }

    /**
     * Remove users.
     *
     * @param User $users
     */
    public function removeUser(User $user)
    {
        $this->users->removeElement($user);
    }

    /**
     * Get users.
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getUsers()
    {
        return $this->users;
    }
    
    /**
     * Set organization.
     *
     * @param Organization $organization
     *
     * @return User
     */
    public function setOrganization(Organization $organization = null)
    {
        $this->isChanged('organization', $organization);
        $this->organization = $organization;
        return $this;
    }

    /**
     * Get organization.
     *
     * @return Organization
     */
    public function getOrganization()
    {
        return $this->organization;
    }
}
