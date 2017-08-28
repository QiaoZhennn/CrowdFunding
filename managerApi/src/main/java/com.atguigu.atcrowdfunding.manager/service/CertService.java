package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.bean.Cert;

import java.util.List;
import java.util.Map;

public interface CertService {
    List<Cert> getCerts();
    int insertCert(Cert cert);
    Cert getCertById(Integer id);
    int updateCert(Cert cert);

    int insertAccttypeCert(Map<String, Object> param);

    int deleteAccttypeCert(Map<String, Object> param);

    List<Map<String,Object>> queryAccttypeCerts();
}
