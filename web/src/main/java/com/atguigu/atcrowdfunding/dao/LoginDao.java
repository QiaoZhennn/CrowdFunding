package com.atguigu.atcrowdfunding.dao;

import com.atguigu.atcrowdfunding.bean.User;
import org.springframework.stereotype.Component;


public interface LoginDao {
    User queryUserForLogin(User user);
}
