package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.bean.Role;
import com.atguigu.atcrowdfunding.manager.dao.RoleDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleDao roleDao;

    public List<Role> listAll(Map<String, Object> map) {
        return roleDao.listAll(map);
    }

    public int getTotalCount(Map<String, Object> map) {
        return roleDao.getTotalCount(map);
    }

    public int insertRole(Role role) {
        return roleDao.insertRole(role);
    }

    public int editRole(Role role) {
        return roleDao.editRole(role);
    }

    public Role getRoleById(Integer id) {
        return roleDao.getRoleById(id);
    }

    public int deleteRole(Integer id) {
        return roleDao.deleteRole(id);
    }

    public int insertRolePermissions(Map<String, Object> param) {
        return roleDao.insertRolePermissions(param);
    }

    public int deleteRolePermissions(Map<String, Object> param) {
        return roleDao.deleteRolePermissions(param);
    }
}
