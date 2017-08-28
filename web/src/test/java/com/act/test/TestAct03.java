package com.act.test;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;



import java.util.List;

public class TestAct03 {
    public static void main(String[] args) {
        //查询流程框架中的数据（流程定义）
        ApplicationContext context=new ClassPathXmlApplicationContext("spring/spring-*.xml");
        ProcessEngine pe=context.getBean("processEngine",ProcessEngine.class);
        RepositoryService repositoryService=pe.getRepositoryService();
        //获取query，用query查询多样的内容。
        ProcessDefinitionQuery query=repositoryService.createProcessDefinitionQuery();

        List<ProcessDefinition> procDefList= query.list();

        /**
         * 根据条件查询数据
         */
        query.processDefinitionVersion(1).singleResult();

        /**
         * 根据版本号排序，获取最新
         */
        ProcessDefinition pd= query.orderByProcessDefinitionVersion().desc().list().get(0);
        System.out.println(pd.getId()+"\t"+pd.getKey()+"\t"+pd.getName()+"\t"+pd.getVersion());

        /**
         * 获取最新版本
         */
        query.latestVersion();
        System.out.println(pd.getId()+"\t"+pd.getKey()+"\t"+pd.getName()+"\t"+pd.getVersion());

        /**
         * 分页查询
         */
//        query.count();
//        query.listPage(start,pageSize);

    }
}
