package com.atguigu.atcrowdfunding.util;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class ActUtil {

    private static ProcessEngine pe=null;

    public static ProcessEngine getProcessEngine(){
        if(pe==null){
            ApplicationContext context=new ClassPathXmlApplicationContext("spring/spring-*.xml");
            pe=context.getBean("processEngine",ProcessEngine.class);
        }
        return pe;
    }
}
