package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.bean.BatchData;
import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.bean.User;

import java.util.List;
import java.util.Map;

public interface UserService {
    List<User> queryPageData(Map<String ,Object> paramMap);

    int queryPageCount(Map<String, Object> paramMap);

    int insertUser(User user);

    User selectUserById(Integer id);

    int updateUser(User user);

    int deleteUserById(Integer id);

    int deleteUserByUsers(BatchData bd);

    int batchInsertUsers(BatchData bd);

    int insertUserRoles(Map<String, Object> param);

    int deleteUserRoles(Map<String, Object> param);

    List<Integer> queryRoleIdsByUserId(Integer id);

    int deleteUserByIds(BatchData bd);

    List<Permission> queryPermissions(User dbUser);

    List<User> queryUsersByLoginAccount(String loginAccount);
}
