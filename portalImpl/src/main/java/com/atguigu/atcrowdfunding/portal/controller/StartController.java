package com.atguigu.atcrowdfunding.portal.controller;

import com.atguigu.atcrowdfunding.common.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/start")
public class StartController extends BaseController {
    @RequestMapping("/index")
    public String toStart(){
        return "portal/start/start";
    }

    @RequestMapping("/start-step-1")
    public String step1(){
        return "portal/start/start-step-1";
    }

    @RequestMapping("/start-step-2")
    public String step2(){
        return "portal/start/start-step-2";
    }

    @RequestMapping("/start-step-3")
    public String step3(){
        return "portal/start/start-step-3";
    }

    @RequestMapping("/start-step-4")
    public String step4(){
        return "portal/start/start-step-4";
    }
}
