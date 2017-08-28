package com.atguigu.atcrowdfunding.interceptor;

import com.atguigu.atcrowdfunding.bean.User;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * 登陆拦截器：用来拦截非法登陆
 * （1）实现接口：HandlerInterceptor
 * （2）继承父类：HandlerInterceptorAdapter（推荐继承方案）
 *      继承的方案，体现了"适配器设计模式"。实现接口的模式，需要实现所有接口方法；继承适配器，可以只使用需要用到的方法。
 * @author qiaoz
 */
public class LoginInterceptor extends HandlerInterceptorAdapter{
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //请求路径
        String uri = request.getRequestURI();
        //白名单：设置不进行拦截的页面
        List<String> whiteList=new ArrayList<String>();
        whiteList.add("/login.htm");
        whiteList.add("/doLogin.do");
        whiteList.add("/index.htm");
        if(whiteList.contains(uri)){
            return true;
        }else {
            //判断用户是否登陆
            HttpSession session=request.getSession();
            User loginUser = (User) session.getAttribute("loginUser");
            //如果未登录，跳转返回到登陆页面
            if(loginUser==null){
                response.sendRedirect("/login.htm");
                return false;
            }else {
                //如果已登陆，继续访问
                return true;
            }
        }
    }
}
