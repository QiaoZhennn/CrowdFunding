package com.atguigu.atcrowdfunding.util;

public class StringUtil {
    public static boolean isEmpty(String content){
            return content==null||"".equals(content); //||是短路，前者成立，不看后者。|会判断两个条件语句
    }
}
