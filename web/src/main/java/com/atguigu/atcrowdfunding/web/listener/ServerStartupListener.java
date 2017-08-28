package com.atguigu.atcrowdfunding.web.listener;

import com.atguigu.atcrowdfunding.bean.Permission;
import com.atguigu.atcrowdfunding.manager.service.PermissionService;
import com.atguigu.atcrowdfunding.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import javax.servlet.http.HttpSessionBindingEvent;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebListener()
public class ServerStartupListener implements ServletContextListener {


    // Public constructor is required by servlet spec
    public ServerStartupListener() {
    }

    // -------------------------------------------------------
    // ServletContextListener implementation
    // -------------------------------------------------------
    public void contextInitialized(ServletContextEvent sce) {
      //将web应用路径保存到应用范围中

        //web应用
        ServletContext application = sce.getServletContext();

        //路径
        String contextPath = application.getContextPath();

        //保存路径
        application.setAttribute("APP_PATH", contextPath);

        //授权路径的集合
        //无法自动注入，所以需要用此方式来从Spring IOC 容器中获取PermissionService。
        ApplicationContext applicationContext = WebApplicationContextUtils.getWebApplicationContext(application);
        PermissionService permissionService=applicationContext.getBean(PermissionService.class);

        List<Permission> permissions=permissionService.queryAll();
        Set<String> authPathSet=new HashSet<String>();
        for(Permission permission:permissions){
            if(!StringUtil.isEmpty(permission.getUrl())){
                authPathSet.add(contextPath+permission.getUrl());
            }
        }
        application.setAttribute("authPathSet",authPathSet);

    }

    public void contextDestroyed(ServletContextEvent sce) {

    }
}
