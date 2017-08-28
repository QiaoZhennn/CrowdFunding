package com.atguigu.atcrowdfunding.portal.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/project")
public class ProjectController {

    @RequestMapping("index")
    public String project(){
        return "portal/project/project";
    }
}
