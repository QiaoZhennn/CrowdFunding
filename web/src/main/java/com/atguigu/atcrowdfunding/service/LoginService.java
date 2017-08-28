package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.User;

public interface LoginService {
    User queryUserForLogin(User user);
}
