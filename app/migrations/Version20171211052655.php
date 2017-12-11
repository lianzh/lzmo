<?php

namespace Mautic\Migrations;

use Doctrine\DBAL\Migrations\AbstractMigration;
use Doctrine\DBAL\Schema\Schema;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
class Version20171211052655 extends AbstractMigration
{
    /**
     * @param Schema $schema
     */
    public function up(Schema $schema)
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('DROP TABLE lz_form_results_1_kaleidosco');
        $this->addSql('DROP TABLE lz_form_results_2_kaleidosco');
    }

    /**
     * @param Schema $schema
     */
    public function down(Schema $schema)
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() != 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE lz_form_results_1_kaleidosco (submission_id INT NOT NULL, form_id INT NOT NULL, name LONGTEXT DEFAULT NULL COLLATE utf8_unicode_ci, email LONGTEXT DEFAULT NULL COLLATE utf8_unicode_ci, numberofattendees LONGTEXT DEFAULT NULL COLLATE utf8_unicode_ci, UNIQUE INDEX UNIQ_6B39C4C5E1FD49335FF69B7D (submission_id, form_id), PRIMARY KEY(submission_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
        $this->addSql('CREATE TABLE lz_form_results_2_kaleidosco (submission_id INT NOT NULL, form_id INT NOT NULL, nombre LONGTEXT DEFAULT NULL COLLATE utf8_unicode_ci, email LONGTEXT DEFAULT NULL COLLATE utf8_unicode_ci, nmerodeasistentes LONGTEXT DEFAULT NULL COLLATE utf8_unicode_ci, UNIQUE INDEX UNIQ_1CA71635E1FD49335FF69B7D (submission_id, form_id), PRIMARY KEY(submission_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = InnoDB');
    }
}
