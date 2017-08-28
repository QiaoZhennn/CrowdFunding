package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.manager.dao.PermissionDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PermissionServiceImpl implements PermissionService{

    @Autowired
    PermissionDao permissionDao;

    public Permission queryRootNode() {
        return permissionDao.queryRootNode();
    }

    public List<Permission> queryChildNodeByPid(Integer id) {
        return permissionDao.queryChildNodeByPid(id);
    }

    public List<Permission> queryAll() {
        return permissionDao.queryAll();
    }

    public int insertPermission(Permission permission) {
        return permissionDao.insertPermission(permission);
    }

    public Permission queryPermissionById(Integer id) {
        return permissionDao.queryPermissionById(id);
    }

    public int updatePermission(Permission permission) {
        return permissionDao.updatePermission(permission);
    }

    public int deletePermissionById(Integer id) {
        return permissionDao.deletePermissionById(id);
    }

    public int deleteEntireNode(List<Integer> list) {
        return permissionDao.deleteEntireNode(list);
    }

    public List<Integer> queryPermissionIdsByRoleId(Integer roleId) {
        return permissionDao.queryPermissionIdsByRoleId(roleId);
    }
}
