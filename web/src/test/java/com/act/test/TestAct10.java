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
import org.activiti.engine.task.TaskQuery;

import java.util.List;

/**
 * 完整的Activiti5步骤
 */
public class TestAct10 {
    public static void main(String[] args) {
        //部署
        RepositoryService repositoryService = ActUtil.getProcessEngine().getRepositoryService();
        repositoryService
                .createDeployment()
                .addClasspathResource("MyProcess06.bpmn")
                .deploy();
        //启动
        RuntimeService runtimeService = ActUtil.getProcessEngine().getRuntimeService();
        ProcessDefinition pd = repositoryService
                .createProcessDefinitionQuery()
                .processDefinitionKey("myProcess_1")
                .latestVersion()
                .singleResult();
        ProcessInstance processInstance = runtimeService.startProcessInstanceById(pd.getId());
        //完成任务
        TaskService taskService = ActUtil.getProcessEngine().getTaskService();
        TaskQuery taskQuery = taskService.createTaskQuery();
        List<Task> tasks = taskQuery.taskCandidateGroup("ManagerTeam").list();
        long count=taskService.createTaskQuery().taskAssignee("Tinker").count();
        System.out.println("Before assign task: "+count);
        //分配&领取任务
        for(Task task:tasks){
            //将任务分配给委托人去执行
            taskService.claim(task.getId(),"Tinker");
        }
        count=taskService.createTaskQuery().taskAssignee("Tinker").count();
        System.out.println("After assign task: "+count);
    }
}
