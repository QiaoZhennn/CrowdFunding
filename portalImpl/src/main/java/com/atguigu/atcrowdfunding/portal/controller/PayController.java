package com.atguigu.atcrowdfunding.portal.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/pay")
public class PayController {

    @RequestMapping("/pay-step-1")
    public String payStep1(){
        return "portal/pay/pay-step-1";
    }

    @RequestMapping("/pay-step-2")
    public String payStep2(){
        return "portal/pay/pay-step-2";
    }
}
