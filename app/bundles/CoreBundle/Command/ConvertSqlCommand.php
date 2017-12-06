<?php

/*
 * @copyright   2014 Mautic Contributors. All rights reserved
 * @author      Mautic
 *
 * @link        http://mautic.org
 *
 * @license     GNU/GPLv3 http://www.gnu.org/licenses/gpl-3.0.html
 */

namespace Mautic\CoreBundle\Command;

use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Sensio\Bundle\GeneratorBundle\Command\Validators;
use LianzhCommon\Helper\QuickAccess;

/**
 * CLI Command to convert EntityClass to SQL.
 */
class ConvertSqlCommand extends ContainerAwareCommand
{
    /**
     * {@inheritdoc}
     */
    protected function configure()
    {
        $this->setName('mautic:entity:tosql')
            ->setDescription('Convert EntityClass to SQL')
            ->setDefinition([
                new InputOption(
                    'entity', null, InputOption::VALUE_REQUIRED,
                    'The entity class name to initialize (shortcut notation)'
                ),
            ])
            ->setHelp(<<<'EOT'
The <info>%command.name%</info> command converts a entity class to SQL.

You must specify the name of the entity via the --entity parameter:

<info>php %command.full_name% --entity=BlogBundle:Post</info>

The above command would convert a sql for the following entity
namespace <info>BlogBundle\Entity\Post</info>.
EOT
            );
    }

    /**
     * {@inheritdoc}
     */
    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $options       = $input->getOptions();

        $entity = Validators::validateEntityName($input->getOption('entity'));
        list($bundle, $entity) = $this->parseShortcutNotation($entity);

        $bundle = $this->getContainer()->get('kernel')->getBundle($bundle);
        $namespace = $bundle->getNamespace();

        $class = "{$namespace}\\Entity\\{$entity}";

        if (!class_exists($class)) {
            $output->writeln("\n\n<error>The specified entity ($entity) does not exist.</error>");

            return 1;
        }

        $sql = (array) QuickAccess::buildORMEntitySchema($class);

        $string = '';
        foreach ($sql as $s) {
            $string .= "\n\n<info>{$s}</info>";
        }
        $output->writeln("\n\n{$string}");

        return 0;
    }

    private function parseShortcutNotation($shortcut)
    {
        $entity = str_replace('/', '\\', $shortcut);

        if (false === $pos = strpos($entity, ':')) {
            throw new \InvalidArgumentException(sprintf('The entity name must contain a : ("%s" given, expecting something like BlogBundle:Blog)', $entity));
        }

        return array(substr($entity, 0, $pos), substr($entity, $pos + 1));
    }

}
