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
public class TestAct08 {
    public static void main(String[] args) {
        //部署
        RepositoryService repositoryService = ActUtil.getProcessEngine().getRepositoryService();
        repositoryService
                .createDeployment()
                .addClasspathResource("MyProcess04.bpmn")
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
        List<Task> groupLeaderTasks = taskQuery.taskAssignee("groupLeader").list();
        List<Task> managerTasks = taskQuery.taskAssignee("manager").list();
        System.out.println("groupLeader's Tasks: " + groupLeaderTasks.size());
        System.out.println("manager's Tasks: " + managerTasks.size());
        for (Task task : groupLeaderTasks) {
            System.out.println("groupLeader complete this task: " + task.getName());
            taskService.complete(task.getId());
        }
        //查询历史任务
        HistoryService historyService = ActUtil.getProcessEngine().getHistoryService();
        HistoricProcessInstance hpi = historyService
                .createHistoricProcessInstanceQuery()
                .processInstanceId(processInstance.getId())
                .finished()
                .singleResult();
        System.out.println("该流程是否结束："+(hpi!=null));
        System.out.println("continue process...");
        //如果没有结束，流程继续进行。
        groupLeaderTasks = taskQuery.taskAssignee("groupLeader").list();
        managerTasks = taskQuery.taskAssignee("Manager").list();
        System.out.println("groupLeader's Tasks: " + groupLeaderTasks.size());
        System.out.println("manager's Tasks: " + managerTasks.size());
        for (Task task : managerTasks) {
            System.out.println("manager complete this task: " + task.getName());
            taskService.complete(task.getId());
        }
        //再查询历史任务
        hpi = historyService
                .createHistoricProcessInstanceQuery()
                .processInstanceId(processInstance.getId())
                .finished()
                .singleResult();
        System.out.println("该流程是否结束："+(hpi!=null));
    }
}
