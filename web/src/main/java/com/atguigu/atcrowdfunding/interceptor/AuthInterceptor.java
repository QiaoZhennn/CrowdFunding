package com.atguigu.atcrowdfunding.interceptor;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.manager.service.PermissionService;
import com.atguigu.atcrowdfunding.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * 授权拦截器
 * 只有用户拥有相应的权限，才能发送相应的请求。
 * （1）获取请求路径
 * （2）判断当前路径是否需要授权
 * （3）如果不需要授权，那么直接访问
 * （4）如果需要授权，那么判断当前用户是否具有相应的权限
 * （5）如果有权限，那么继续访问。
 * （6）如果没有权限，则跳转到错误页面。
 */
public class AuthInterceptor extends HandlerInterceptorAdapter{
    @Autowired //在springmvc.xml中配置了该类的bean，所以可以使用自动注入
    private PermissionService permissionService;
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //（1）获取请求路径
        String uri=request.getRequestURI();
        //（2）判断当前路径是否需要授权
        //(2-1)获取所有的授权访问路径
//        ApplicationContext context = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getSession().getServletContext());
//        Permission permission= (Permission) context.getBean(PermissionService.class);
//        如果自动注入不成功，可以通过上述方法获取Spring的ApplicationContext，进而获取Spring池中的类
//        每次跳转页面都要查一遍数据库，不方便，所以要在Listener中查一次，获取到所有permission，然后每次从Application域中取
//        List<Permission> permissions=permissionService.queryAll();
        ServletContext application=request.getSession().getServletContext();
        Set<String> authPathSet= (Set<String>) application.getAttribute("authPathSet");
//        for(Permission permission:permissions){
//            if(!StringUtil.isEmpty(permission.getUrl())){
//                authPathSet.add(permission.getUrl());
//            }
//        }
        if(authPathSet.contains(uri)){
        //（4）如果需要授权，那么判断当前用户是否具有相应的权限
            Set<String> userAuthPathSet= (Set<String>) request.getSession().getAttribute("userAuthPathSet");
            if(userAuthPathSet.contains(uri)){
                //（5）如果有权限，那么继续访问。
                return true;
            }else {
                //（6）如果没有权限，则跳转到错误页面。
                response.sendRedirect("/message.htm");
                return false;
            }
        }else {
            //（3）如果不需要授权，那么直接访问
            return true;
        }
    }
}
