package com.atguigu.atcrowdfunding.manager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/auth_adv")
public class AuthAdvController {

    @RequestMapping("/index")
    public String index(){
        return "manager/auth_adv/auth_adv";
    }
}
