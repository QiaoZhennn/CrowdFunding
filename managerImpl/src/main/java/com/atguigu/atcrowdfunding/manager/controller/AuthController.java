package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.bean.MemberCert;
import com.atguigu.atcrowdfunding.bean.Page;
import com.atguigu.atcrowdfunding.common.BaseController;
import com.atguigu.atcrowdfunding.portal.service.MemberService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/auth")
public class AuthController extends BaseController{

    @Autowired
    private RepositoryService repositoryService;
    @Autowired
    private TaskService taskService;

    @Autowired
    private MemberService memberService;

    @RequestMapping("/index")
    public String index(){
        return "manager/auth/auth";
    }


    @RequestMapping("/detail")
    public String detail(Integer memberId,String taskId,Map<String,Object> map){
        Member member=memberService.queryById(memberId);
        List<MemberCert> memberCerts=memberService.queryMemberCertsByMemberId(memberId);
        map.put("member",member);
        map.put("memberCerts",memberCerts);
        return "manager/auth/detail";
    }

    @ResponseBody
    @RequestMapping("/pageQuery")
    public Object pageQuery(Integer pageNo,Integer pageSize){
        start();
        try{
            TaskQuery query = taskService
                    .createTaskQuery()
                    // TODO
                    //bpmn图中定义了authpermission这个组的人可以完成审核任务。
                    .taskCandidateGroup("authpermission");
            //获得流程定义的集合
            List<Task> tasks = query.listPage((pageNo - 1) * pageSize, pageSize);

            List<Map<String,Object>> taskMaps=new ArrayList<Map<String, Object>>();

            //原来的ProcessDefinition中含有一个自关联，即给框架提供的类的中有方法又返回了ProcessDefinition，
            //所以，不能直接将ProcessDefinition的作为返回值，再去自动转换为json。
            //因此，人为构造一个集合，将ProcessDefinition中有用的属性放到这个新的集合中。返回这个新集合。
            //List被转换为json，由[ ]包围。
            // Object被转换为json，由{ }包围。
            //Map被转换为json，也由{ }包围。所以用Map。

            for(Task task:tasks){
                Map<String,Object> taskMap=new HashMap<String, Object>();
                //获取Task相关信息。
                taskMap.put("name",task.getName());

                //获取ProcessDefinition相关信息。
                ProcessDefinition pd = repositoryService
                        .createProcessDefinitionQuery()
                        .processDefinitionId(task.getProcessDefinitionId())
                        .singleResult();
                taskMap.put("pdname",pd.getName());
                taskMap.put("pdversion",pd.getVersion());
                taskMap.put("id",task.getId());

                //根据t_ticket表获取member name信息。
                String piid=task.getProcessInstanceId();
                Member member=memberService.queryMemberByTickerPiid(piid);
                taskMap.put("membername",member.getMembername());
                taskMap.put("memberid",member.getId());
                taskMaps.add(taskMap);
            }

            int totalCount= (int) query.count();
            int totalPage;
            if(totalCount%pageSize==0){
                totalPage=totalCount/pageSize;
            }else {
                totalPage=totalCount/pageSize+1;
            }
            Page<Map<String,Object>> pageObj=new Page<Map<String,Object>>();
            pageObj.setTotalPage(totalPage);
            pageObj.setTotalCount(totalCount);
            pageObj.setPageSize(pageSize);
            pageObj.setPageNo(pageNo);
            pageObj.setData(taskMaps);
            setData(pageObj);
            success(true);
        }catch (Exception e){
            e.printStackTrace();
            fail();
        }
        return end();
    }

    @ResponseBody
    @RequestMapping("/pass")
    public Object pass(String taskId,Integer memberId){
        start();
        try{
            taskService.setVariable(taskId,"flg",true);
            //在task中设置memberId，是为了让PassListener的notify(execution)方法可以使用这个变量。bpmn图中并没有memberId这个变量。
            taskService.setVariable(taskId,"memberId",memberId);
            taskService.complete(taskId);
            success(true);
        }catch (Exception e){
            e.printStackTrace();
            fail();
        }
        return end();
    }
}
