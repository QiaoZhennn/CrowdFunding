package com.atguigu.atcrowdfunding.manager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/project_type")
public class ProjectTypeController {

    @RequestMapping("/index")
    public String index(){
        return "manager/project_type/project_type";
    }
}
