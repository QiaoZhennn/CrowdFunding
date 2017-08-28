package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.*;
import com.atguigu.atcrowdfunding.common.BaseController;
import com.atguigu.atcrowdfunding.manager.service.RoleService;
import com.atguigu.atcrowdfunding.manager.service.UserService;
import com.atguigu.atcrowdfunding.util.MD5Util;
import com.atguigu.atcrowdfunding.util.StringUtil;
import org.omg.CORBA.OBJ_ADAPTER;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController{

    @Autowired
    private UserService userService;

    /*@RequestMapping("/index")
    public String listUsers(@RequestParam(required = false,defaultValue = "1") Integer pageNo,
                            @RequestParam(required = false,defaultValue = "10") Integer pageSize,
                            Map<String,Object> objectMap){
        Map<String,Object> paramMap=new HashMap<String, Object>();
        paramMap.put("start",(pageNo-1)*pageSize);
        paramMap.put("pageSize",pageSize);
        paramMap.put("pageNo",pageNo);
        List<User> users = userService.queryPageData(paramMap);
        System.out.println("___________ "+users);
        objectMap.put("users",users);
        return "manager/user/index";
    }*/

    @RequestMapping("/index")
    public String listUsers(){
        return "manager/user/index";
    }

    @ResponseBody
    @RequestMapping("/pageQuery")
    public Object pageQuery(Integer pageNo,Integer pageSize,String queryText){
        AJAXResult result=new AJAXResult();
        try {
            Page<User> userPage=new Page<User>();
            userPage.setPageNo(pageNo);
            userPage.setPageSize(pageSize);
            result.setSuccess(true);

            Map<String,Object> paramMap=new HashMap<String, Object>();
            paramMap.put("start",(pageNo-1)*pageSize);
            paramMap.put("pageSize",pageSize);
            paramMap.put("pageNo",pageNo);

            //条件查询
            if(!StringUtil.isEmpty(queryText)){
                if(queryText.indexOf("%")!=-1){
                    //java中单\\表示\。MySQL中'%'表示通配符，'\\%'表示匹配%，
                    queryText=queryText.replaceAll("%","\\\\%");
                }
                if(queryText.indexOf("_")!=-1){
                    //java中单\\表示\。MySQL中'%'表示通配符，'\\%'表示匹配%，
                    queryText=queryText.replaceAll("_","\\\\_");
                }
                if(queryText.indexOf("\\")!=-1){
                    //java中单\\表示\。MySQL中'%'表示通配符，'\\%'表示匹配%，
                    queryText=queryText.replaceAll("\\\\","\\\\\\\\");
                }
                paramMap.put("queryText",queryText);
            }
            //数据
            List<User> users = userService.queryPageData(paramMap);
            //总数据条数
            int count=userService.queryPageCount(paramMap);
            userPage.setTotalCount(count);
            int totalPage;
            if(count%pageSize==0) totalPage=count/pageSize;
            else totalPage=count/pageSize+1;
            userPage.setTotalPage(totalPage);
            userPage.setData(users);
            result.setData(userPage);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/add")
    public String toAddPage(){
        return "manager/user/add";
    }


    @ResponseBody
    @RequestMapping("/insert")
    public Object insert(User user){
        AJAXResult result=new AJAXResult();
        try{
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String createTime = sdf.format(new Date());
            user.setUserPassword(MD5Util.digest("123456"));
            user.setCreateTime(createTime);
            userService.insertUser(user);
            System.out.println("________________"+user);
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("addBatch")
    public String addBatch(){
        return "manager/user/addBatch";
    }


    @RequestMapping("inserts")
    public String inserts(BatchData bd){
        AJAXResult result=new AJAXResult();
        try{
            List<User> users = bd.getUsers();
            Iterator<User> iterator=users.iterator();

            while (iterator.hasNext()){
                User user=iterator.next();
                if(StringUtil.isEmpty(user.getLoginAccount())){
                    iterator.remove();
                }
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String createTime = sdf.format(new Date());
                user.setCreateTime(createTime);
                user.setUserPassword(MD5Util.digest("123456"));
            }
            result.setData(users);
            userService.batchInsertUsers(bd);
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return "redirect:/user/index.htm";
    }

    @RequestMapping("/edit")
    public String edit(@RequestParam("id") Integer id, Map<String, Object> map){
        User user=userService.selectUserById(id);
        map.put("selectedUser",user);
        return "/manager/user/edit";
    }

    @ResponseBody
    @RequestMapping("/update")
    public Object update(User user){
        AJAXResult result=new AJAXResult();
        try{
//            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//            String createTime=sdf.format(new Date());
//            user.setCreateTime(createTime);
            int count=userService.updateUser(user);
            result.setSuccess(count==1);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public Object deleteUserById(Integer id){
        start();
        try{
            int count=userService.deleteUserById(id);
            success(count==1);
        }catch (Exception e){
            e.printStackTrace();
            fail();
        }
        return end();
    }

    @ResponseBody
    @RequestMapping("/deleteBatch")
    public Object deleteBatch(BatchData bd){
        start();
        try{
            int i=userService.deleteUserByIds(bd);
            success(i==bd.getIds().size());
            System.out.println("i: "+i);
        }catch (Exception e){
            e.printStackTrace();
            fail();
        }
        return end();
    }

    @ResponseBody
    @RequestMapping("/deletes")
    public Object deletes(BatchData bd){
        AJAXResult result=new AJAXResult();
        try{
            int i=userService.deleteUserByUsers(bd);
            result.setSuccess(i==bd.getUsers().size());
        }catch (Exception e){
            result.setSuccess(false);
        }
        return result;
    }

    @Autowired
    RoleService roleService;


    @RequestMapping("assign")
    public String assign(Integer id,Map<String,Object> map){
        User user = userService.selectUserById(id);
        map.put("user",user);
        List<Role> roles = roleService.listAll(null);

        //未分配角色的集合
        List<Role> unassignList=new ArrayList<Role>();
        //已经分配角色的集合
        List<Role> assignList=new ArrayList<Role>();
        //查询当前用户已经分配的角色ID集合。
        List<Integer> roleIds=userService.queryRoleIdsByUserId(id);
        for (Role role:roles) {
            if(roleIds.contains(role.getId())){
                assignList.add(role);
            }else {
                unassignList.add(role);
            }
        }
        map.put("assignList",assignList);
        map.put("unassignList",unassignList);
        map.put("roles",roles);
        return "manager/user/assignRole";
    }

    /**
     * 分配角色
     * @return
     */
    @ResponseBody
    @RequestMapping("/assignRole")
    public Object assignRole(Integer userId, BatchData bd){
        AJAXResult result=new AJAXResult();
        try{
            Map<String ,Object> param=new HashMap<String, Object>();
            param.put("userId",userId);
            param.put("roleIds",bd.getIds());
            System.out.println(bd.getIds());
            int i=userService.insertUserRoles(param);
            result.setSuccess(i==bd.getIds().size());
        }catch (Exception e){
            result.setSuccess(false);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/unassignRole")
    public Object unassignRole(Integer userId, BatchData bd){
        AJAXResult result=new AJAXResult();
        try{
            Map<String ,Object> param=new HashMap<String, Object>();
            param.put("userId",userId);
            param.put("roleIds",bd.getIds());
            userService.deleteUserRoles(param);
            result.setSuccess(true);
        }catch (Exception e){
            result.setSuccess(false);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/saveFile")
    public Object saveFile(HttpServletRequest request){
        AJAXResult result=new AJAXResult();
        try{
            MultipartHttpServletRequest req= (MultipartHttpServletRequest) request;
            MultipartFile file = req.getFile("userIcon");
            String imgPath=request.getSession().getServletContext().getRealPath("img");
            file.transferTo(new File(imgPath+"/user/"+file.getOriginalFilename()));
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }
}
