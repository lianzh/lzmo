<?php

namespace LianzhCommon\Helper;

/**
 * 调试工具类
 */
class Dumper
{

    /**
     * 输出一个变量的内容
     *
     * @param mixed $vars 要输出的变量
     * @param string $label 输出变量时显示的标签
     * @param boolean $return 是否返回输出内容
     *
     * @return string
     */
    public static function dump($vars, $label = '', $return = false)
    {
        $content = "<pre>\n";
        if ($label != '') {
            $content .= "<strong>{$label} :</strong>\n";
        }
        $content .= htmlspecialchars(print_r($vars, true),ENT_COMPAT | ENT_IGNORE);
        $content .= "\n</pre>\n";
        if ($return) { return $content; }
        echo $content;
    }

}