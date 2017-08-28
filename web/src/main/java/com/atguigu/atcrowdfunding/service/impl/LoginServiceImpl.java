package com.atguigu.atcrowdfunding.service.impl;


import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.dao.LoginDao;
import com.atguigu.atcrowdfunding.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl implements LoginService{

    @Autowired
    LoginDao loginDao;
    public User queryUserForLogin(User user) {
        return loginDao.queryUserForLogin(user);
    }
}
