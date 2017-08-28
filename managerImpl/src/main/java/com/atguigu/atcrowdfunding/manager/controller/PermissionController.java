package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.AJAXResult;
import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.common.BaseController;
import com.atguigu.atcrowdfunding.manager.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/permission")
public class PermissionController extends BaseController {

    @Autowired
    private PermissionService permissionService;

    @RequestMapping("index")
    public String index() {
        return "manager/permission/permission";
    }



/*    private void queryChildNode(Permission parent){
        List<Permission> childPermissions=permissionService.queryChildNodeByPid(parent.getId());
        for (Permission childPermission:childPermissions){
            queryChildNode(childPermission);
        }
        parent.setChildren(childPermissions);
    }*/

    @ResponseBody
    @RequestMapping("/loadAJAXData")
    public Object loadAJAXData() {
        start();
        List<Permission> tree = null;
        try {
            List<Permission> permissions = permissionService.queryAll();
            Map<Integer, Permission> map = new HashMap<Integer, Permission>();
            tree = new ArrayList<Permission>();
            for (Permission permission : permissions) {
                map.put(permission.getId(), permission);
            }
            for (Permission permission : permissions) {
                if (permission.getPid() == 0) {
                    tree.add(permission);
                } else {
                    Permission parent = map.get(permission.getPid());
                    parent.getChildren().add(permission);
                }
            }
            success(true);
        } catch (Exception e) {
            e.printStackTrace();
            fail();
        }
        end();
        return tree;
    }

    @ResponseBody
    @RequestMapping("/loadCheckedData")
    public Object loadCheckedData(Integer roleId) {
        start();
        List<Permission> tree = null;
        try {
            List<Permission> permissions = permissionService.queryAll();
            List<Integer> permissionIds=permissionService.queryPermissionIdsByRoleId(roleId);
            Map<Integer, Permission> map = new HashMap<Integer, Permission>();
            tree = new ArrayList<Permission>();
            for (Permission permission : permissions) {
                if(permissionIds.contains(permission.getId())){

                    permission.setChecked(true);
                }
                map.put(permission.getId(), permission);
            }
            for (Permission permission : permissions) {
                if (permission.getPid() == 0) {
                    tree.add(permission);
                } else {
                    Permission parent = map.get(permission.getPid());
                    parent.getChildren().add(permission);
                }
            }
            success(true);
        } catch (Exception e) {
            e.printStackTrace();
            fail();
        }
        end();
        return tree;
    }





















    /*@ResponseBody
    @RequestMapping("/loadAJAXData")
    public Object loadAJAXData() {
        List<Permission> permissions = permissionService.queryAll();
        List<Permission> root = new ArrayList<Permission>();
        Map<Integer, Permission> permissionMap = new HashMap<Integer, Permission>();
        for (Permission permission : permissions) {
            permissionMap.put(permission.getId(), permission);
        }
        for (Permission permission : permissions) {
            if (permission.getPid() == 0) {
                root.add(permission);
            } else {
                permissionMap.get(permission.getPid()).getChildren().add(permission);
            }
        }
        return root;
    }*/

    @ResponseBody
    @RequestMapping("/loadData")
    public Object loadData() {
        AJAXResult result = new AJAXResult();
        try {

//            使用递归来显示树
//            Permission permission=new Permission();
//            //构造了一个虚拟的根节点，设置该根节点的id为0
//            permission.setId(0);
//            queryChildNode(permission);

//            使用两层for循环来显示树
//            List<Permission> permissions = permissionService.queryAll();
//            List<Permission> root=new ArrayList<Permission>();
//            for(Permission child:permissions){
//                if (child.getPid()==0){
//                    root.add(child);
//                }
//                else {
//                    for (Permission innerPermission:permissions){
//                        if(child.getPid()==innerPermission.getId()){
//                            innerPermission.getChildren().add(child);
//                            break;
//                        }
//                    }
//                }
//            }


//            使用Map集合封装父节点与子节点，单层for循环，效率较高。
            List<Permission> permissions = permissionService.queryAll();
            List<Permission> root = new ArrayList<Permission>();
            Map<Integer, Permission> permissionMap = new HashMap<Integer, Permission>();
            for (Permission permission : permissions) {
                permissionMap.put(permission.getId(), permission);
            }
            for (Permission permission : permissions) {
                if (permission.getPid() == 0) {
                    root.add(permission);
                } else {
                    permissionMap.get(permission.getPid()).getChildren().add(permission);
                }
            }
            result.setData(root);
            result.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/add")
    public String toAddPage() {
        return "manager/permission/add";
    }

    @ResponseBody
    @RequestMapping("/insert")
    public Object insert(Permission permission) {
        AJAXResult result = new AJAXResult();
        try {
            permissionService.insertPermission(permission);
            result.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/edit")
    public String edit(Integer id, Map<String, Object> map) {
        Permission permission = permissionService.queryPermissionById(id);
        map.put("permission", permission);
        return "manager/permission/edit";
    }

    @ResponseBody
    @RequestMapping("/update")
    public Object update(Permission permission) {
        AJAXResult result = new AJAXResult();
        try {
            int i = permissionService.updatePermission(permission);
            result.setSuccess(i == 1);
        } catch (Exception e) {
            result.setSuccess(false);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/deleteNode")
    public Object deleteNode(Integer id){
        start();
        try{
            System.out.println("Node id: "+id);
            Permission parentPermission = permissionService.queryPermissionById(id);
            List<Integer> deleteIds=new ArrayList<Integer>();
            deleteIds.add(parentPermission.getId());

            List<Integer> list = findChildren(parentPermission, deleteIds);

            int i=permissionService.deleteEntireNode(list);
            System.out.println("deleteIds: "+deleteIds);
            success(i==list.size());
        }catch (Exception e){
            e.printStackTrace();
            fail();
        }
        return end();
    }

    public  List<Integer> findChildren(Permission parentPermission, List<Integer> deleteIds){
        List<Permission> permissions = permissionService.queryAll();
        List<Permission> root = new ArrayList<Permission>();
        Map<Integer, Permission> permissionMap = new HashMap<Integer, Permission>();
        for (Permission permission : permissions) {
            permissionMap.put(permission.getId(), permission);
        }
        for (Permission permission : permissions) {
            if (permission.getPid() == 0) {
                root.add(permission);
            } else {
                permissionMap.get(permission.getPid()).getChildren().add(permission);
            }
        }
        return findIds(permissionMap.get(parentPermission.getId()),deleteIds);
    }

    private List<Integer> findIds(Permission parentPermission,List<Integer> deleteIds){
        deleteIds.add(parentPermission.getId());
        for (Permission child:parentPermission.getChildren()){
            findChildren(child,deleteIds);
        }
        return deleteIds;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public Object delete(Integer id) {
        AJAXResult result = new AJAXResult();
        try {
            int i = permissionService.deletePermissionById(id);
            result.setSuccess(i == 1);
        } catch (Exception e) {
            result.setSuccess(false);
        }
        return result;
    }
}
