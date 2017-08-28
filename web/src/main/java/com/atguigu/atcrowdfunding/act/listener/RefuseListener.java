package com.atguigu.atcrowdfunding.act.listener;

import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.ExecutionListener;

//@WebListener
public class RefuseListener implements ExecutionListener {
    public void notify(DelegateExecution execution) throws Exception {
        System.out.println("流程审批拒绝");
    }
}
