package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.bean.Permission;

import java.util.List;

public interface PermissionService {
    Permission queryRootNode();

    List<Permission> queryChildNodeByPid(Integer id);

    List<Permission> queryAll();

    int insertPermission(Permission permission);

    Permission queryPermissionById(Integer id);

    int updatePermission(Permission permission);

    int deletePermissionById(Integer id);

    int deleteEntireNode(List<Integer> list);

    List<Integer> queryPermissionIdsByRoleId(Integer roleId);
}
