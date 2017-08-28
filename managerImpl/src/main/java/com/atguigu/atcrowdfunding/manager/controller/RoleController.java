package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.*;
import com.atguigu.atcrowdfunding.common.BaseController;
import com.atguigu.atcrowdfunding.manager.service.RoleService;
import com.atguigu.atcrowdfunding.manager.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/role")
public class RoleController extends BaseController{

    @Autowired
    private RoleService roleService;

    @RequestMapping("/index")
    public String toRolePage(){
        return "manager/role/role";
    }

    @ResponseBody
    @RequestMapping("/listAll")
    public Object listAll(String queryText){
        AJAXResult result=new AJAXResult();
        Page<Role> rolePage=new Page<Role>();
        try{
            Map<String,Object> param=new HashMap<String, Object>();
            param.put("queryText",queryText);

            List<Role> roles = roleService.listAll(param);
            result.setData(roles);
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("add")
    public String add(){
        return "manager/role/add";
    }

    @ResponseBody
    @RequestMapping("insert")
    public Object insert(Role role){
        AJAXResult result=new AJAXResult();
        try{
            int i = roleService.insertRole(role);
            result.setSuccess(i==1);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("update")
    public String update(Integer id,Map<String,Object> map){
        Role role=roleService.getRoleById(id);
        map.put("editRole",role);
        return "manager/role/edit";
    }

    @ResponseBody
    @RequestMapping("edit")
    public Object edit(Role role){
        AJAXResult result=new AJAXResult();
        try{
            int i = roleService.editRole(role);
            result.setSuccess(i==1);
        }catch (Exception e){
            result.setSuccess(false);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("deleteRole")
    public Object deleteRole(Integer id){
        AJAXResult result = new AJAXResult();
        try{
            int i = roleService.deleteRole(id);
            result.setSuccess(i==1);
        }catch (Exception e){
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/assign")
    public String assign(){
        return "manager/role/assign";
    }

    @ResponseBody
    @RequestMapping("/doAssign")
    public Object doAssign(Integer roleId, BatchData bd){
        start();
        try{
            Map<String,Object> param=new HashMap<String, Object>();
            param.put("permissionIds",bd.getIds());
            param.put("roleId",roleId);
            int j=roleService.deleteRolePermissions(param);
            int i=roleService.insertRolePermissions(param);
            success(i==bd.getIds().size());
        }catch (Exception e){
            e.printStackTrace();
            fail();
        }
        return end();
    }

}
