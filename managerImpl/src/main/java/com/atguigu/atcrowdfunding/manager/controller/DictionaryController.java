package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.Dictionary;
import com.atguigu.atcrowdfunding.common.BaseController;
import com.atguigu.atcrowdfunding.manager.service.DictionaryService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/dictionary")
public class DictionaryController extends BaseController{

    @Autowired
    private DictionaryService dictionaryService;

    @RequestMapping("/index")
    public String index(){
        return "manager/dictionary/dictionary";
    }



    @ResponseBody
    @RequestMapping("/loadAJAXData")
    public Object loadAJAXData(){
        start();
        List<Dictionary> zTree=null;
        try{
            List<Dictionary> dictionaries=dictionaryService.queryAll();
            Map<Integer,Dictionary> map=new HashMap<Integer, Dictionary>();
            for(Dictionary dictionary:dictionaries){
                map.put(dictionary.getId(),dictionary);
            }
            zTree=new ArrayList<Dictionary>();
            for (Dictionary dictionary:dictionaries){
                if(dictionary.getPid()==0){
                    zTree.add(dictionary);
                }else {
                    Dictionary parent=map.get(dictionary.getPid());
                    parent.getChildren().add(dictionary);
                }
            }
            setData(zTree);
            success(true);
        }catch (Exception e){
            e.printStackTrace();
            fail();
        }
        return zTree;
    }
}
