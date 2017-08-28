package com.atguigu.atcrowdfunding.manager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/advertisement")
public class AdvertisementController {

    @RequestMapping("/index")
    public String index(){
        return "manager/advertisement/advertisement";
    }
}
