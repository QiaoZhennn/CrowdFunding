package com.atguigu.atcrowdfunding.manager.dao;

import com.atguigu.atcrowdfunding.bean.Permission;

import java.util.List;

public interface PermissionDao {
    Permission queryRootNode();

    List<Permission> queryChildNodeByPid(Integer pId);

    List<Permission> queryAll();

    int insertPermission(Permission permission);

    Permission queryPermissionById(Integer id);

    int updatePermission(Permission permission);

    int deletePermissionById(Integer id);

    int deleteEntireNode(List<Integer> list);

    List<Integer> queryPermissionIdsByRoleId(Integer roleId);
}
