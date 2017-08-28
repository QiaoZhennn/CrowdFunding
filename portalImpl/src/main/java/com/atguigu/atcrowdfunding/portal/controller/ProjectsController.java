package com.atguigu.atcrowdfunding.portal.controller;

import com.atguigu.atcrowdfunding.common.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/projects")
public class ProjectsController extends BaseController{

    @RequestMapping("index")
    public String projects(){
        return "portal/projects/projects";
    }
}
