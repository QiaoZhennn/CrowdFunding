package com.act.test;

import com.atguigu.atcrowdfunding.util.ActUtil;
import org.activiti.engine.HistoryService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricProcessInstanceQuery;

public class TaskAct07 {
    public static void main(String[] args) {
        //从历史数据中查询流程信息。
        //查询历史数据
        HistoryService historyService = ActUtil.getProcessEngine().getHistoryService();
        HistoricProcessInstanceQuery query = historyService.createHistoricProcessInstanceQuery();
        HistoricProcessInstance instance = query.processInstanceId("701").finished().singleResult();
        //finished()可以选出执行结束后的流程。
        System.out.println("流程是否结束："+(instance!=null));
    }
}
