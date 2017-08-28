package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.bean.Role;

import java.util.List;
import java.util.Map;

public interface RoleService {
    List<Role> listAll(Map<String,Object> map);
    int getTotalCount(Map<String,Object> map);

    int insertRole(Role role);

    int editRole(Role role);

    Role getRoleById(Integer id);

    int deleteRole(Integer id);

    int insertRolePermissions(Map<String, Object> param);
    int deleteRolePermissions(Map<String,Object> param);
}
