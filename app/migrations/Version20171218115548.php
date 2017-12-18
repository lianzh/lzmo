<?php

/*
 * @package     Mautic
 * @copyright   2017 Mautic Contributors. All rights reserved.
 * @author      Mautic
 * @link        http://mautic.org
 * @license     GNU/GPLv3 http://www.gnu.org/licenses/gpl-3.0.html
 */

namespace Mautic\Migrations;

use Mautic\CoreBundle\Doctrine\AbstractMauticMigration;
use Doctrine\DBAL\Schema\Schema;
use Doctrine\DBAL\Migrations\SkipMigrationException;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20171218115548 extends AbstractMauticMigration
{
    /**
     * @param Schema $schema
     *
     * @throws SkipMigrationException
     * @throws \Doctrine\DBAL\Schema\SchemaException
     */
    public function preUp(Schema $schema)
    {
        // Test to see if this migration has already been applied
        $userTable = $schema->getTable($this->prefix.'users');
        if ($userTable->hasColumn('organization_id')) {
            throw new SkipMigrationException('Schema includes this migration');
        }

        // Test to see if this migration has already been applied
        $roleTable = $schema->getTable($this->prefix.'roles');
        if ($roleTable->hasColumn('organization_id')) {
            throw new SkipMigrationException('Schema includes this migration');
        }
    }

    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        $this->addSql('ALTER TABLE '.$this->prefix.'users ADD COLUMN organization_id int(11) NOT NULL');
        $this->addSql('ALTER TABLE '.$this->prefix.'roles ADD COLUMN organization_id int(11) NOT NULL');

        // Foreign key constraints
        $usersFk = $this->generatePropertyName('users', 'fk', ['organization_id']);
        $this->addSql("ALTER TABLE {$this->prefix}users ADD CONSTRAINT $usersFk FOREIGN KEY (organization_id) REFERENCES {$this->prefix}organizations (id) ON DELETE CASCADE");

        // Foreign key constraints
        $rolesFk = $this->generatePropertyName('roles', 'fk', ['organization_id']);
        $this->addSql("ALTER TABLE {$this->prefix}roles ADD CONSTRAINT $rolesFk FOREIGN KEY (organization_id) REFERENCES {$this->prefix}organizations (id) ON DELETE CASCADE"); 
    }
}
