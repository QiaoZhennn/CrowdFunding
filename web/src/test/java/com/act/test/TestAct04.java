package com.act.test;

import com.atguigu.atcrowdfunding.util.ActUtil;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;

public class TestAct04 {
    public static void main(String[] args) {
        //所谓的流程示例，其实就是流程定义的具体应用。
        RuntimeService runtimeService= ActUtil.getProcessEngine().getRuntimeService();
        //查询流程定义对象
        RepositoryService repositoryService=ActUtil.getProcessEngine().getRepositoryService();
        ProcessDefinitionQuery query=repositoryService.createProcessDefinitionQuery();
        ProcessDefinition pd= query.processDefinitionKey("authflow").latestVersion().singleResult();
        //启动流程实例。
        runtimeService.startProcessInstanceById(pd.getId());
    }
}
