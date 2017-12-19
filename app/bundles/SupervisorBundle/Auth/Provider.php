<?php

namespace Mautic\SupervisorBundle\Auth;

use Mautic\UserBundle\Entity\User;

class Provider
{

	/**
	 * 权限资源前缀信息
	 */
	const ACCESS_PREFIX = 'supervisor::';

	/**
	 * 超级管理员组 组织id
	 */
	const ORGANIZATION_ID = 100;

	/**
	 * 普通角色
	 */
	const ROLE_USER = 'ROLE_USER';
	
	/**
	 * 管理员角色
	 */
	const ROLE_ADMIN = 'ROLE_ADMIN';

	/**
	 * 返回 角色访问符
	 * 
	 * @param  string $vRole 角色值
	 * 
	 * @return string
	 */
	public static function getRoleAccessor($vRole)
	{
		return self::ACCESS_PREFIX . trim($vRole);
	}

	/**
	 * 是否管理员才能访问
	 * 
	 * @param  array  $sps 权限列表
	 * @return 
	 */
	public static function withAdmin(array $sps)
	{
		foreach ($sps as $sp) {
			$parts = explode('::', $sp);
			if (count($parts) == 2) {
				$parts[1] = trim($parts[1]);
				if (self::ROLE_USER == $parts[1]) {
					return false;
				}
			}
		}

		return true;
	}

	/**
	 * 是否是 超级管理员组专享的权限
	 * 
     * @param $permissions
     * @param $sps 超级管理员权限
     *
     * @return bool
     */
	public static function isTrue($permissions, &$sps = null)
	{
		$permissions = (array) $permissions;

		$sps = self::parsePermissions($permissions);

		return !empty($sps);
	}

	private static function parsePermissions(array $permissions)
	{
		$arr = [];
		foreach ($permissions as $permission) {

			if (!is_string($permission)) continue;
			$is = strpos($permission, self::ACCESS_PREFIX) === 0;
			if ($is) {
				$arr[] = $permission;
			}

		}

		return $arr;
	}

}