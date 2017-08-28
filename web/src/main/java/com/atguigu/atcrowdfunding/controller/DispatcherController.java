package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.bean.AJAXResult;
import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.common.BaseController;
import com.atguigu.atcrowdfunding.manager.service.UserService;
import com.atguigu.atcrowdfunding.portal.service.MemberService;
import com.atguigu.atcrowdfunding.service.LoginService;
import com.atguigu.atcrowdfunding.util.MD5Util;
import com.atguigu.atcrowdfunding.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class DispatcherController extends BaseController{

    @RequestMapping("/index")
    public String index( HttpServletResponse response){
        return "index";
    }

    @RequestMapping("/login")
    public String login(HttpServletResponse response){
        return "login";
    }

    @RequestMapping("/reg")
    public String reg(HttpServletResponse response){
        return "reg";
    }

    @Autowired
    LoginService loginService;
    @Autowired
    MemberService memberService;
    @Autowired
    UserService userService;


    @ResponseBody
    @RequestMapping("/queryUsersByLoginAccount")
    public Object queryUsersByLoginAccount(String loginAccount,String userType){
        start();
        try{
            if("manager".equals(userType)) {
                List<User> users = userService.queryUsersByLoginAccount(loginAccount);
                if (users.size() != 0) {
                    fail();
                    return end();
                }else {
                    success(true);
                    return end();
                }
            }else {
                List<Member> members=memberService.queryMembersByLoginAccount(loginAccount);
                if (members.size() != 0) {
                    fail();
                    return end();
                }else {
                    success(true);
                    return end();
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            fail();
        }
        return end();
    }

    @ResponseBody
    @RequestMapping("/doRegister")
    public Object doRegister(String loginAccount,String username,String userPassword,
                             String email,String userType,String memberType,HttpSession session){
        start();
        int i;

        try{
            if("manager".equals(userType)){
                User user=new User();
                user.setLoginAccount(loginAccount);
                user.setUsername(username);
                user.setUserPassword(MD5Util.digest(userPassword));
                user.setEmail(email);
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String createTime = sdf.format(new Date());
                user.setCreateTime(createTime);
                i=userService.insertUser(user);
                User dbUser=loginService.queryUserForLogin(user);

                session.setAttribute("loginUser",dbUser);
                loginPreparation(session,user);
                message("main");
            }else {
                Member member=new Member();
                member.setLoginacct(loginAccount);
                member.setMembername(username);
                member.setMemberpswd(MD5Util.digest(userPassword));
                member.setEmail(email);
                member.setType(memberType);
                i=memberService.insertMember(member);
                Member loginMember=memberService.queryMemberForLogin(member);
                session.setAttribute("loginMember",loginMember);
                message("member");
            }
            success(i==1);
        }catch (Exception e){
            e.printStackTrace();
            message("注册失败");
            fail();
        }
        return end();
    }

    @ResponseBody
    @RequestMapping("/doLogin")
	public Object doLogin(User user,HttpSession session){
        //将密码进行MD5加密
        user.setUserPassword(MD5Util.digest(user.getUserPassword()));
        User dbUser=loginService.queryUserForLogin(user);
        AJAXResult result=new AJAXResult();
        if(dbUser!=null){
            session.setAttribute("loginUser",dbUser);
            loginPreparation(session,dbUser);

            result.setSuccess(true);
        }else {
            result.setSuccess(false);
        }
        return result;
	}

	public void loginPreparation(HttpSession session,User loginUser){
//获取当前用户的权限菜单
        List<Permission> permissions=userService.queryPermissions(loginUser);
        Permission root=null;
        Map<Integer,Permission> permissionMap=new HashMap<Integer, Permission>();

        Set<String> userAuthPathSet=new HashSet<String>();

        for(Permission permission:permissions){
            permissionMap.put(permission.getId(),permission);
            //保存当前用户的授权路径
            if(!StringUtil.isEmpty(permission.getUrl())){
                userAuthPathSet.add(permission.getUrl());
            }
        }
        for(Permission permission:permissions){
            //子菜单
            if(permission.getPid()==0){
                root=permission;
            }else {
                Permission parent=permissionMap.get(permission.getPid());
                parent.getChildren().add(permission);
//                    System.out.println("DispatcherCtrl Parent Children: "+parent.getChildren());
            }
        }
        session.setAttribute("rootPermissions",root);
        session.setAttribute("userAuthPathSet",userAuthPathSet);
    }


	@ResponseBody
	@RequestMapping("/doMemberLogin")
	public Object doMemberLogin(Member member, HttpSession session){
        start();
	    try{
            Member loginMember=memberService.queryMemberForLogin(member);
            if(loginMember==null){
                message("用户名不存在");
                fail();
            }else {
                if(loginMember.getMemberpswd().equals(MD5Util.digest(member.getMemberpswd()))){
                    success(true);
                    session.setAttribute("loginMember",loginMember);
                }else {
                    message("密码错误");
                }
            }
        }catch (Exception e){
	        e.printStackTrace();
	        fail();
        }
        return end();
    }

    @RequestMapping("/member")
    public String member(){
        return "member";
    }


    @RequestMapping("/main")
    public String mainPage() {
        return "main";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){
//        session.removeAttribute("loginUser");
        session.invalidate();
        return "redirect:/index.htm";
    }

    @RequestMapping("/error")
    public String error(){
        return "/error";
    }

}
