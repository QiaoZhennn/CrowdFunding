package com.atguigu.atcrowdfunding.portal.controller;

import com.atguigu.atcrowdfunding.bean.*;
import com.atguigu.atcrowdfunding.common.BaseController;
import com.atguigu.atcrowdfunding.common.Const;
import com.atguigu.atcrowdfunding.portal.service.MemberService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.jfree.chart.axis.Tick;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.*;

@Controller
@RequestMapping("/member")
public class MemberController extends BaseController{

    @Autowired
    RepositoryService repositoryService;
    @Autowired
    RuntimeService runtimeService;
    @Autowired
    TaskService taskService;
    @Autowired
    private MemberService memberService;

    @RequestMapping("/apply")
    public String accttype(HttpSession session,Map<String,Object> map){

        Member loginMember= (Member) session.getAttribute(Const.LOGIN_MEMBER);

        //判断该当前会员是否正在申请
        Ticket ticket=memberService.queryTicket(loginMember);
        if(ticket==null){
            //如果没有申请，开始流程

            //查询实名认证审批流程定义的最新版本
            ProcessDefinition pd= repositoryService
                    .createProcessDefinitionQuery()
                    //Activiti5的bpmn图形，靠不同的processDefinitionKey区分不同的ProcessDefinition
                    .processDefinitionKey("authflow")
                    .latestVersion()
                    .singleResult();

            //启动实名认证审批流程
            Map<String,Object> varMap=new HashMap<String, Object>();
            //repositoryService需要用Map来给ProcessInstance赋值,bpmn图中指定${loginacct}为某UserTask的Assignee。TaskService，可以taskService.setVariable赋值。
            varMap.put("loginacct",loginMember.getLoginacct());
            ProcessInstance pi = runtimeService.startProcessInstanceById(pd.getId(), varMap);

            //流程审批单，将loginMember和ProcessDefinition中Key名为authflow的ProcessInstance绑定，见表t_ticket

            Ticket t=new Ticket();
            t.setMemberid(loginMember.getId());
            t.setPiid(pi.getId());
            t.setStatus("0");
            memberService.insertTicket(t);

            return "portal/member/apply";
        }else {
            //如果已经申请，继续之前流程
            //1、获取当前流程的正在进行的任务
            Task task=taskService
                    .createTaskQuery()
                    .processInstanceId(ticket.getPiid())
                    .taskAssignee(loginMember.getLoginacct())
                    .singleResult();

            //在bpmn中定义了不同的task的definition key。
            if("accttype".equals(task.getTaskDefinitionKey())){
                return "portal/member/apply";
            }else if("basicinfo".equals(task.getTaskDefinitionKey())){
                return "portal/member/basicinfo";
            }else if("uploadcert".equals(task.getTaskDefinitionKey())){

                List<Cert> certs = memberService.queryCertsByAccttype(loginMember.getAccttype());
                map.put("certs",certs);
                return "portal/member/uploadcert";
            }else if("checkemail".equals(task.getTaskDefinitionKey())){
                return "portal/member/checkemail";
            }else if("checkcode".equals(task.getTaskDefinitionKey())){
                return "portal/member/checkcode";
            }
        }
        return "";
    }

    //流程第一步，选择会员用户的类型，4选1
    @ResponseBody
    @RequestMapping("/updateAccttype")
    public Object updateAccttype(String accttype,HttpSession session){
        start();
        try {
            Member loginMember= (Member) session.getAttribute(Const.LOGIN_MEMBER);
            loginMember.setAccttype(accttype);
            int i=memberService.updateAccttype(loginMember);

            //让流程继续执行
            Ticket ticket=memberService.queryTicket(loginMember);

            Task task=taskService
                    .createTaskQuery()
                    .processInstanceId(ticket.getPiid())
                    .taskAssignee(loginMember.getLoginacct())
                    .singleResult();
            taskService.complete(task.getId());

            success(i==1);
        }catch (Exception e){
            e.printStackTrace();
            fail();
        }
        return end();
    }



    //流程第二步，录入基本信息。
    @ResponseBody
    @RequestMapping("/updateBasicInfo")
    public Object updateBasicInfo(HttpSession session,Member member){
        start();
        try{
            Member loginMember= (Member) session.getAttribute(Const.LOGIN_MEMBER);
            //更新基本信息
            loginMember.setRealname(member.getRealname());
            loginMember.setCardnum(member.getCardnum());
            int i=memberService.updateBasicInfo(loginMember);

            //让流程继续执行
            Ticket ticket=memberService.queryTicket(loginMember);
            Task task=taskService
                    .createTaskQuery()
                    .processInstanceId(ticket.getPiid())
                    .taskAssignee(loginMember.getLoginacct())
                    .singleResult();
            //设置排他网关走向何方？bpmn的图中，排他网关有个参数叫step，它有两个路径prev，next。
            taskService.setVariable(task.getId(),"step","next");
            //完成当前任务，进入下一个任务。
            taskService.complete(task.getId());

            success(i==1);
        }catch (Exception e){
            e.printStackTrace();
            fail();
        }
        return end();
    }

    @ResponseBody
    @RequestMapping("/returnAcctType")
    public Object returnAcctType(HttpSession session){
        start();
        try{
            Member loginMember= (Member) session.getAttribute(Const.LOGIN_MEMBER);
            Ticket ticket=memberService.queryTicket(loginMember);
            Task task=taskService
                    .createTaskQuery()
                    .processInstanceId(ticket.getPiid())
                    .taskAssignee(loginMember.getLoginacct())
                    .singleResult();
            taskService.setVariable(task.getId(),"step","prev");
            taskService.complete(task.getId());
            success(true);
        }catch (Exception e) {
            e.printStackTrace();
            fail();
        }
        return end();
    }

    //流程第三步，上传资质文件证明
    @ResponseBody
    @RequestMapping("/uploadCerts")
    public Object uploadCerts(HttpSession session ,BatchData bd){
        start();
        try{
            Member loginMember= (Member) session.getAttribute(Const.LOGIN_MEMBER);
            //保存会员上传的资质文件
            //得到”img“文件夹的RealPath（部署后路径）。
            String path=session.getServletContext().getRealPath("img");

            //一个Member对应一个AccountType（accttype，一共有4种），一个AccountType可能需要要上传多种资质文件，在type.jsp页面中设置。
            //BatchData为解决前端传来多个同名文件的问题而存在。它有一个List<MemberCert> memberCerts属性。
            for(MemberCert mc:bd.getMemberCerts()){
                //文件对应的类为MultipartFile。
                MultipartFile file=mc.getCertImgFile();
                //保存图片
                String filename=file.getOriginalFilename();
                //由suffix获取文件的后缀名”.jpg“
                String suffix=filename.substring(filename.lastIndexOf('.'));
                //随机产生一个UUID作为文件在服务器储存的文件名。
                String uuid= UUID.randomUUID().toString();
                //保存到了img/cert/${uuid}.jpg下
                file.transferTo(new File(path+"/cert/"+uuid+suffix));
                mc.setIconpath(uuid+suffix);

                mc.setMemberid(loginMember.getId());
            }

            //增加数据库t_member_cert数据
            memberService.insertMemberCerts(bd);
            //流程继续执行
            Ticket ticket=memberService.queryTicket(loginMember);
            Task task=taskService
                    .createTaskQuery()
                    .processInstanceId(ticket.getPiid())
                    .taskAssignee(loginMember.getLoginacct())
                    .singleResult();
            //设置排他网关走向何方？bpmn的图中，排他网关有个参数叫step，它有两个路径prev，next。
            taskService.setVariable(task.getId(),"step","next");
            //完成当前任务，进入下一个任务。
            taskService.complete(task.getId());

            success(true);
        }catch (Exception e){
            e.printStackTrace();
            fail();
        }
        return end();
    }

    //流程第四步，输入邮箱地址，准备验证邮箱
    @ResponseBody
    @RequestMapping("/updateEmail")
    public Object updateEmail(HttpSession session, String email){
        start();
        try{
            Member loginMember= (Member) session.getAttribute(Const.LOGIN_MEMBER);
            if(! email.equals(loginMember.getEmail())){
                loginMember.setEmail(email);
                int i=memberService.updateEmail(loginMember);
            }

            //流程继续执行
            Ticket ticket=memberService.queryTicket(loginMember);
            Task task=taskService
                    .createTaskQuery()
                    .processInstanceId(ticket.getPiid())
                    .taskAssignee(loginMember.getLoginacct())
                    .singleResult();
            //设置排他网关走向何方？bpmn的图中，排他网关有个参数叫step，它有两个路径prev，next。
            taskService.setVariable(task.getId(),"step","next");
            //设置邮箱地址
            taskService.setVariable(task.getId(),"userEmail",loginMember.getEmail());
            //设置验证码
            StringBuilder authcode=new StringBuilder();
            for (int i = 0; i < 4; i++) {
                authcode.append(new Random().nextInt(10));
            }
            taskService.setVariable(task.getId(),"authcode",authcode.toString());
            ticket.setAuthcode(authcode.toString());
            memberService.updateAuthcode(ticket);
            //完成当前任务，进入下一个任务。
            taskService.complete(task.getId());

            success(true);
        }catch (Exception e){
            e.printStackTrace();
            fail();
        }
        return end();
    }

    //流程第五步，验证邮箱，完成申请。
    @ResponseBody
    @RequestMapping("/finishApply")
    public Object finishApply(HttpSession session,String authcode){
        start();
        try{
            Member loginMember= (Member) session.getAttribute(Const.LOGIN_MEMBER);
            Ticket ticket=memberService.queryTicket(loginMember);
            if(authcode.equals(ticket.getAuthcode())){
                //申请成功
                //更改授权状态为1，authStatus="1"表示正在审核中。"0"表示未审核，"2"表示审核成功。
                loginMember.setAuthstatus("1");
                int i=memberService.updateAuthstatus(loginMember);

                //流程继续执行
                Task task=taskService
                        .createTaskQuery()
                        .processInstanceId(ticket.getPiid())
                        .taskAssignee(loginMember.getLoginacct())
                        .singleResult();
                //设置排他网关走向何方？bpmn的图中，排他网关有个参数叫step，它有两个路径prev，next。
                taskService.setVariable(task.getId(),"step","next");
                //完成当前任务，进入下一个任务。
                taskService.complete(task.getId());
                success(true);
            }else {
                fail();
            }
        }catch (Exception e){
            e.printStackTrace();
            fail();
        }
        return end();
    }


    @RequestMapping("/minecrowdfunding")
    public String minecrowdfunding(){
        return "portal/member/minecrowdfunding";
    }


}
