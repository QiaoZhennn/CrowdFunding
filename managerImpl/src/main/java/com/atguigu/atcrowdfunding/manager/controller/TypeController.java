package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.Cert;
import com.atguigu.atcrowdfunding.common.BaseController;
import com.atguigu.atcrowdfunding.manager.service.CertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/type")
public class TypeController extends BaseController{

    @Autowired
    private CertService certService;

    @RequestMapping("/index")
    public String type(Map<String,Object> map, Model model){
        List<Cert> certs=certService.getCerts();
//        map.put("certs",certs);
        model.addAttribute("certs",certs);
        //查询关系表中的数据
        //本来应该封装成一个对象，但是Map可以替代对象，完成封装。
        List<Map<String,Object>> accttypeCerts= certService.queryAccttypeCerts();
//        map.put("accttypeCerts",accttypeCerts);
        model.addAttribute("accttypeCerts",accttypeCerts);


        return "manager/type/type";
    }

    @ResponseBody
    @RequestMapping("/insertAccttypeCert")
    public Object insertAccttypeCert(String accttype, Integer certid){
        start();
        try{
            Map<String,Object> param=new HashMap<String, Object>();
            param.put("accttype",accttype);
            param.put("certid",certid);
            int i=certService.insertAccttypeCert(param);
            success(i==1);
        }catch (Exception e){
            e.printStackTrace();
            fail();
        }
        return end();
    }

    @ResponseBody
    @RequestMapping("/deleteAccttypeCert")
    public Object deleteAccttypeCert(String accttype, Integer certid){
        start();
        try{
            Map<String,Object> param=new HashMap<String, Object>();
            param.put("accttype",accttype);
            param.put("certid",certid);
            int i=certService.deleteAccttypeCert(param);
            success(i==1);
        }catch (Exception e){
            e.printStackTrace();
            fail();
        }
        return end();
    }
}
