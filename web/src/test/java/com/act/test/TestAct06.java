package com.act.test;


import com.atguigu.atcrowdfunding.util.ActUtil;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;

import java.util.List;

public class TestAct06 {
    public static void main(String[] args) {
        //获得任务服务
        TaskService taskService = ActUtil.getProcessEngine().getTaskService();
        //创建任务查询对象
        TaskQuery query = taskService.createTaskQuery();

        List<Task> tasks1 = query.taskAssignee("Obama").list();
        List<Task> tasks2 = query.taskAssignee("Trump").list();
        System.out.println("Obama 的任务数量："+tasks1.size());
        System.out.println("Trump 的任务数量："+tasks2.size());
        for(Task task:tasks1){
            taskService.complete(task.getId());
        }
    }
}
