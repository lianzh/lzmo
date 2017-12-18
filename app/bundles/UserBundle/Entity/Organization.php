<?php

namespace Mautic\UserBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Mautic\CoreBundle\Doctrine\Mapping\ClassMetadataBuilder;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * Organization
 */
class Organization
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
     * @var bool
     */
    private $isPublished;

    /**
     * @var \DateTime
     */
    private $dateAdded;

    /**
     * @var ArrayCollection
     */
    private $roles;

    /**
     * @var ArrayCollection
     */
    private $users;

    /**
     * Constructor.
     */
    public function __construct()
    {
        $this->roles    = new ArrayCollection();
        $this->users    = new ArrayCollection();
    }

    /**
     * @param ORM\ClassMetadata $metadata
     */
    public static function loadMetadata(ORM\ClassMetadata $metadata)
    {
        $builder = new ClassMetadataBuilder($metadata);

        $builder->setTable('organizations')
            ->setCustomRepositoryClass('\Mautic\UserBundle\Entity\OrganizationRepository')
            ->addUniqueConstraint(['name'], 'unique_perm');

        $builder->addId();

        $builder->createField('name', 'string')
            ->length(120)
            ->nullable(false)
            ->build();

        $builder->createField('isPublished', 'boolean')
            ->columnName('is_published')
            ->build();

        $builder->createField('dateAdded', 'datetime')
            ->columnName('date_added')
            ->nullable()
            ->build();

        $builder->createOneToMany('roles', '\Mautic\UserBundle\Entity\Role')
            ->mappedBy('organization')
            ->fetchExtraLazy()
            ->build();

        $builder->createOneToMany('users', '\Mautic\UserBundle\Entity\User')
            ->mappedBy('organization')
            ->fetchExtraLazy()
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
        $metadata->setGroupPrefix('organization')
            ->addListProperties(
                [
                    'id',
                    'name',
                ]
            )
            ->build();
    }

    /**
     * Get id
     *
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set name
     *
     * @param string $name
     *
     * @return Organization
     */
    public function setName($name)
    {
        $this->name = $name;

        return $this;
    }

    /**
     * Get name
     *
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Set isPublished
     *
     * @param boolean $isPublished
     *
     * @return Organization
     */
    public function setIsPublished($isPublished)
    {
        $this->isPublished = $isPublished;

        return $this;
    }

    /**
     * Get isPublished
     *
     * @return bool
     */
    public function getIsPublished()
    {
        return $this->isPublished;
    }

    /**
     * Set dateAdded
     *
     * @param \DateTime $dateAdded
     *
     * @return Organization
     */
    public function setDateAdded($dateAdded)
    {
        $this->dateAdded = $dateAdded;

        return $this;
    }

    /**
     * Get dateAdded
     *
     * @return \DateTime
     */
    public function getDateAdded()
    {
        return $this->dateAdded;
    }

    /**
     * Add user.
     *
     * @param User $user
     *
     * @return Organization
     */
    public function addUser(User $user)
    {
        $this->users[] = $user;

        return $this;
    }

    /**
     * Remove user.
     *
     * @param User $user
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
     * Add role.
     *
     * @param Role $role
     *
     * @return Organization
     */
    public function addRole(Role $role)
    {
        $this->roles[] = $role;

        return $this;
    }

    /**
     * Remove role.
     *
     * @param Role $roles
     */
    public function removeRole(Role $role)
    {
        $this->roles->removeElement($role);
    }

    /**
     * Get roles.
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getRoles()
    {
        return $this->roles;
    }

}
