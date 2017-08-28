package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.AJAXResult;
import com.atguigu.atcrowdfunding.bean.Cert;
import com.atguigu.atcrowdfunding.manager.service.CertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/cert")
public class CertController {

    @Autowired
    private CertService certService;

    @RequestMapping("/index")
    public String cert(){
        return "manager/cert/cert";
    }

    @ResponseBody
    @RequestMapping("/listAll")
    public Object listAll(){
        AJAXResult result=new AJAXResult();
        try{
            List<Cert> certs = certService.getCerts();
            result.setData(certs);
            result.setSuccess(true);
        }catch (Exception e){
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/add")
    public String toAddPage(){
        return "manager/cert/add";
    }

    @ResponseBody
    @RequestMapping("/insert")
    public Object insertCert(Cert cert){
        AJAXResult result=new AJAXResult();
        try{
            int i=certService.insertCert(cert);
            result.setSuccess(i==1);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/update")
    public String toUpdatePage(Integer id,Map<String,Object> map){
        Cert cert=certService.getCertById(id);
        map.put("editCert",cert);
        return "manager/cert/edit";
    }

    @ResponseBody
    @RequestMapping("/edit")
    public Object editCert(Cert cert){
        AJAXResult result=new AJAXResult();
        try{
            int i=certService.updateCert(cert);
            result.setSuccess(i==1);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }
}
