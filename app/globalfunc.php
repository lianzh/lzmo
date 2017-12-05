<?php

function classLoader()
{
	static $loader = null;
	if ( is_null($loader) )
	{
		$loader = new \Composer\Autoload\ClassLoader();
		$loader->register();
	}

	return $loader;
}

// 加入 wiwide 通用类库定义
//classLoader()->addPsr4('WiwideCommon\\', __DIR__ . '/../app/commons');


