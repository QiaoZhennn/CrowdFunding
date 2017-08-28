package com.act.test;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class TestAct02 {
    public static void main(String[] args) {
        ApplicationContext context=new ClassPathXmlApplicationContext("spring/spring-*.xml");

        ProcessEngine pe=context.getBean("processEngine",ProcessEngine.class);

        RepositoryService repositoryService=pe.getRepositoryService();
        Deployment deployment=repositoryService
                .createDeployment()
                .addClasspathResource("bpmn/authflow.bpmn")
                .deploy();

        System.out.println("deploy = "+deployment);
    }
}
