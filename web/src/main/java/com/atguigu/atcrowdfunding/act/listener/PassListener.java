package com.atguigu.atcrowdfunding.act.listener;

import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.bean.Ticket;
import com.atguigu.atcrowdfunding.portal.service.MemberService;
import com.atguigu.atcrowdfunding.util.ApplicationContextUtils;
import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.ExecutionListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

//@WebListener
public class PassListener implements ExecutionListener {

    public void notify(DelegateExecution execution) throws Exception {

        //Spring的ioc的DI，有三种方式，此为第三种，接口注入。
        ApplicationContext context = ApplicationContextUtils.applicationContext;
        MemberService memberService=context.getBean(MemberService.class);

        System.out.println("PassListener： 流程审批通过");
        //更新会员的实名认证的状态
        Integer memberId=(Integer)execution.getVariable("memberId");
        Member member=memberService.queryById(memberId);
        //authStatus="2"表示审核通过。
        member.setAuthstatus("2");
        memberService.updateAuthstatus(member);
        //更新流程审批单的状态
        Ticket ticket=memberService.queryTicket(member);
        //Ticket中的status="1"表示审核通过。
        ticket.setStatus("1");
        memberService.updateTicketStatus(ticket);
    }
}
