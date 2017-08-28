package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.Page;
import com.atguigu.atcrowdfunding.common.BaseController;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import sun.nio.ch.IOUtil;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/process")
public class ProcessController extends BaseController {

    @Autowired
    private RepositoryService repositoryService;

    @RequestMapping("/index")
    public String index(){
        return "manager/process/process";
    }

    @ResponseBody
    @RequestMapping("/pageQuery")
    public Object pageQuery(Integer pageNo,Integer pageSize){
        start();
        try{
            //调用方法来查询流程定义
            ProcessDefinitionQuery query = repositoryService.createProcessDefinitionQuery();
            //获得流程定义的集合
            List<ProcessDefinition> pds = query.listPage((pageNo - 1) * pageSize, pageSize);

            List<Map<String,Object>> pdMaps=new ArrayList<Map<String, Object>>();

            //原来的ProcessDefinition中含有一个自关联，即给框架提供的类的中有方法又返回了ProcessDefinition，
            //所以，不能直接将ProcessDefinition的作为返回值，再去自动转换为json。
            //因此，人为构造一个集合，将ProcessDefinition中有用的属性放到这个新的集合中。返回这个新集合。
            //List被转换为json，由[ ]包围。
            // Object被转换为json，由{ }包围。
            //Map被转换为json，也由{ }包围。所以用Map。

            for(ProcessDefinition pd:pds){
                Map<String,Object> pdMap=new HashMap<String, Object>();
                pdMap.put("name",pd.getName());
                pdMap.put("key",pd.getKey());
                pdMap.put("version",pd.getVersion());
                pdMap.put("id",pd.getId());

                pdMaps.add(pdMap);
            }

            int totalCount= (int) query.count();
            int totalPage;
            if(totalCount%pageSize==0){
                totalPage=totalCount/pageSize;
            }else {
                totalPage=totalCount/pageSize+1;
            }
            Page<Map<String,Object>> pdPage=new Page<Map<String,Object>>();
            pdPage.setTotalPage(totalPage);
            pdPage.setTotalCount(totalCount);
            pdPage.setPageSize(pageSize);
            pdPage.setPageNo(pageNo);
            pdPage.setData(pdMaps);
            setData(pdPage);
            success(true);
        }catch (Exception e){
            e.printStackTrace();
            fail();
        }
        return end();
    }

    @ResponseBody
    @RequestMapping("/upload")
    public Object upload(HttpServletRequest request){
        start();
        try{
        MultipartHttpServletRequest req= (MultipartHttpServletRequest) request;
        MultipartFile procDefFile=req.getFile("procDefFile");
            System.out.println(procDefFile.getOriginalFilename());

            //部署流程定义
            repositoryService
                    .createDeployment()
                    //.addClasspathResource(procDefFile.getOriginalFilename()) //从硬盘上的classPath中找该文件，但此时文件在内存上，而不在硬盘中，找不到。
                    .addInputStream(procDefFile.getOriginalFilename(),procDefFile.getInputStream())
                    .deploy();
            success(true);
        }catch (Exception e){
            e.printStackTrace();
            fail();
        }
        return end();
    }

    @RequestMapping("/showImg")
    public String showImg(){
        return "manager/process/add";
    }


    @RequestMapping("/loadImg")
    //图片是二进制，无法变成json，所以返回void
    public void loadImg(String pdid ,HttpServletResponse response) throws IOException {
        //根据流程定义的id来查询流程定义的数据
        ProcessDefinition pd= repositoryService
                .createProcessDefinitionQuery()
                .processDefinitionId(pdid)
                .singleResult();
        //读取流程定义图片
        InputStream in=repositoryService.getResourceAsStream(pd.getDeploymentId(),pd.getDiagramResourceName());
        //通过响应输出流，将图片输出到浏览器中
        OutputStream out = response.getOutputStream();
        IOUtils.copy(in,out);
    }

    @ResponseBody
    @RequestMapping("/delete")
    public Object delete(String id){
        start();
        try{
            ProcessDefinition pd=repositoryService
                    .createProcessDefinitionQuery()
                    .processDefinitionId(id)
                    .singleResult();
            //删除流程定义
            repositoryService.deleteDeployment(pd.getDeploymentId(),true);
            success(true);
        }catch (Exception e){
            e.printStackTrace();
            fail();
        }
        return end();
    }
}
