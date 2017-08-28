package com.act.test;

import com.atguigu.atcrowdfunding.util.ActUtil;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;

import java.util.List;

public class TestAct05 {
    public static void main(String[] args) {
        //获得任务服务
        TaskService taskService = ActUtil.getProcessEngine().getTaskService();
        //创建任务查询对象
        TaskQuery query = taskService.createTaskQuery();
        //开始查询所有任务
        List<Task> tasks = query.list();
        for(Task task:tasks){
            System.out.println("完成这个任务: "+task.getName()+"\t, task Key: "+task.getTaskDefinitionKey());
            //使当前任务完成
            taskService.complete(task.getId());
        }
    }
}
