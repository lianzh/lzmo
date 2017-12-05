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

// 加入 自定义类库定义
classLoader()->addPsr4('LianzhCommon\\', __DIR__ . '/../app/commons');


