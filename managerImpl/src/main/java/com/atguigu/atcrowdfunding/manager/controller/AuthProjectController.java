package com.atguigu.atcrowdfunding.manager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/auth_project")
public class AuthProjectController {

    @RequestMapping("/index")
    public String index(){
        return "manager/auth_project/auth_project";
    }
}
