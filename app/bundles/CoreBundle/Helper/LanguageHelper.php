<?php

/*
 * @copyright   2014 Mautic Contributors. All rights reserved
 * @author      Mautic
 *
 * @link        http://mautic.org
 *
 * @license     GNU/GPLv3 http://www.gnu.org/licenses/gpl-3.0.html
 */

namespace Mautic\CoreBundle\Helper;

use Mautic\CoreBundle\Factory\MauticFactory;

/**
 * Helper class for managing Mautic's installed languages.
 */
class LanguageHelper
{
    
    /**
     * @var MauticFactory
     */
    private $factory;

    /**
     * @param MauticFactory $factory
     */
    public function __construct(MauticFactory $factory)
    {
        $this->factory = $factory;
    }

    /**
     * Extracts a package for the specified language.
     *
     * @param $languageCode
     *
     * @return array
     */
    public function extractLanguagePackage($languageCode)
    {
        $result = $this->fetchPackage($languageCode);

        // If there was a failure, there's nothing else we can do here
        if ($result['error']) {
            return $result;
        }

        return [
            'error'   => false,
            'message' => 'mautic.core.language.helper.language.saved.successfully',
        ];
    }

    /**
     * Fetches the list of available languages.
     * 
     * 使用本地的国际化文件,拒绝从 updates.mautic.org 拉取
     *
     * @return array
     */
    private function getLanguageList()
    {
        static $languages = null;

        if (is_null($languages)) {
            
            $languages = [];

            $file = $this->factory->getParameter('language_list_file');

            if (!empty($file) && is_readable($file)) {
                $data = json_decode(file_get_contents($file), true);
                if (isset($data['languages'])) {
                    $languages = $data['languages'];
                } elseif (isset($data['name'])) {
                    $languages = $data;
                }
            }
        }

        return $languages;
    }

    /**
     * Fetches the list of available languages.
     *
     * @param bool $overrideCache
     *
     * @return array
     */
    public function fetchLanguages($overrideCache = false, $returnError = true)
    {
        return $this->getLanguageList();
    }

    /**
     * Fetches a language package.
     *
     * @param string $languageCode
     *
     * @return array
     */
    public function fetchPackage($languageCode)
    {
        $languages = $this->getLanguageList();

        if (empty($languages[$languageCode])) {
             return [
                'error'   => true,
                'message' => 'mautic.core.language.helper.invalid.language',
                'vars'    => [
                    '%language%' => $languageCode,
                ],
            ];
        }

        // Return an array for the sake of consistency
        return [
            'error' => false,
        ];
    }
}
