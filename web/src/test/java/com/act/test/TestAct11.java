package com.act.test;

import com.atguigu.atcrowdfunding.util.ActUtil;
import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TestAct11 {
    public static void main(String[] args) {
        //部署
        RepositoryService repositoryService = ActUtil.getProcessEngine().getRepositoryService();
        repositoryService
                .createDeployment()
                .addClasspathResource("MyProcess07.bpmn")
                .deploy();
        //启动
        RuntimeService runtimeService = ActUtil.getProcessEngine().getRuntimeService();
        ProcessDefinition pd = repositoryService
                .createProcessDefinitionQuery()
                .processDefinitionKey("myProcess_1")
                .latestVersion()
                .singleResult();

        Map<String,Object> paramMap = new HashMap<String, Object>();
        paramMap.put("TL","Obama");
        paramMap.put("TM","Trump");
        paramMap.put("days",4);
        ProcessInstance processInstance = runtimeService.startProcessInstanceById(pd.getId(), paramMap);
        TaskService taskService= ActUtil.getProcessEngine().getTaskService();
        List<Task> tasks = ActUtil
                .getProcessEngine()
                .getTaskService()
                .createTaskQuery()
                .taskAssignee("Obama")
                .list();
        for(Task task:tasks){
            System.out.println("Obama完成任务："+task.getName());
            taskService.complete(task.getId());
        }
        HistoryService historyService = ActUtil.getProcessEngine().getHistoryService();
        HistoricProcessInstance hpi = historyService
                .createHistoricProcessInstanceQuery()
                .processInstanceId(processInstance.getId())
                .finished()
                .singleResult();
        System.out.println("流程是否结束："+(hpi!=null));
    }
}
