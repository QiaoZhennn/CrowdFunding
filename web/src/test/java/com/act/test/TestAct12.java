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

public class TestAct12 {
    public static void main(String[] args) {
        //部署
        RepositoryService repositoryService = ActUtil.getProcessEngine().getRepositoryService();
        repositoryService
                .createDeployment()
                .addClasspathResource("MyProcess08.bpmn")
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
        paramMap.put("days",2);
        paramMap.put("cost",2000);
        ProcessInstance processInstance = runtimeService.startProcessInstanceById(pd.getId(), paramMap);
        TaskService taskService= ActUtil.getProcessEngine().getTaskService();
        List<Task> tasks1 = taskService.createTaskQuery().taskAssignee("Obama").list();
        List<Task> tasks2 = taskService.createTaskQuery().taskAssignee("Trump").list();
        System.out.println("Obama's tasks count: "+tasks1.size());
        System.out.println("Trump's tasks count: "+tasks2.size());
        for(Task task:tasks1){
            System.out.println("Obama完成任务："+task.getName());
            taskService.complete(task.getId());
        }
        HistoryService historyService = ActUtil.getProcessEngine().getHistoryService();
        HistoricProcessInstance hpi = historyService
                .createHistoricProcessInstanceQuery()
                .processInstanceId(processInstance.getId())
                .finished()
                .singleResult();
        System.out.println("1、流程是否结束："+(hpi!=null));

        tasks1 = taskService.createTaskQuery().taskAssignee("Obama").list();
        tasks2 = taskService.createTaskQuery().taskAssignee("Trump").list();
        System.out.println("Obama's tasks count: "+tasks1.size());
        System.out.println("Trump's tasks count: "+tasks2.size());

        for(Task task:tasks2){
            System.out.println("Trump完成任务："+task.getName());
            taskService.complete(task.getId());
        }
        hpi = historyService
                .createHistoricProcessInstanceQuery()
                .processInstanceId(processInstance.getId())
                .finished()
                .singleResult();
        System.out.println("2、流程是否结束："+(hpi!=null));
    }
}
