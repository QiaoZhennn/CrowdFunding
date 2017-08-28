package com.atguigu.atcrowdfunding.common;

import com.atguigu.atcrowdfunding.bean.AJAXResult;

public abstract class BaseController {

    private ThreadLocal<AJAXResult> threadLocal = new ThreadLocal<AJAXResult>();

    //使得该方法只能子类访问，而不是任何地方可以访问
    protected void start(){
        threadLocal.set(new AJAXResult());
    }

    protected Object end(){
        Object obj=threadLocal.get();
        threadLocal.remove();
        return obj;
    }

    protected void success(boolean flag){
        AJAXResult result=threadLocal.get();
        result.setSuccess(flag);
    }

    /**
     * To set result.success=false
     */
    protected void fail(){
        AJAXResult result=threadLocal.get();
        result.setSuccess(false);
    }

    protected  void message(String msg){
        AJAXResult result=threadLocal.get();
        result.setMsg(msg);
    }

    protected  String getMessage(){
        AJAXResult result=threadLocal.get();
        return result.getMsg();
    }

    protected void setData(Object object){
        AJAXResult result=threadLocal.get();
        result.setData(object);
    }

    protected Object getData(){
        AJAXResult result=threadLocal.get();
        return result.getData();
    }

}
