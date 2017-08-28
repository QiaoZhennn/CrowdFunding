package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.bean.BatchData;
import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.manager.dao.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService{

    @Autowired
    private UserDao userDao;
    public List<User> queryPageData(Map<String, Object> paramMap) {
        return userDao.queryPageData(paramMap);
    }

    public int queryPageCount(Map<String, Object> paramMap) {
        return userDao.queryPageCount(paramMap);
    }

    public int insertUser(User user) {
        return userDao.insertUser(user);
    }

    public User selectUserById(Integer id) {
        return userDao.selectUserById(id);
    }

    public int updateUser(User user) {
        return userDao.updateUser(user);
    }

    public int deleteUserById(Integer id) {
        return userDao.deleteUserById(id);
    }

    public int deleteUserByUsers(BatchData bd) {
        return userDao.deleteUserByUsers(bd);
    }

    public int deleteUserByIds(BatchData bd){
        return userDao.deleteUserByIds(bd);
    }

    public List<Permission> queryPermissions(User dbUser) {
        return userDao.queryPermissions(dbUser);
    }

    public List<User> queryUsersByLoginAccount(String loginAccount) {
        return userDao.queryUsersByLoginAccount(loginAccount);
    }


    public int batchInsertUsers(BatchData bd) {
        return userDao.batchInsertUsers(bd);
    }

    public int insertUserRoles(Map<String, Object> param) {
        return userDao.insertUserRoles(param);
    }

    public int deleteUserRoles(Map<String, Object> param) {
        return userDao.deleteUserRoles(param);
    }

    public List<Integer> queryRoleIdsByUserId(Integer id) {
        return userDao.queryRoleIdsByUserId(id);
    }
}
