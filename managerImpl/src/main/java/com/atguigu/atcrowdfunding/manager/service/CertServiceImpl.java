package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.bean.Cert;
import com.atguigu.atcrowdfunding.manager.dao.CertDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service
public class CertServiceImpl implements CertService {

    @Autowired
    private CertDao certDao;

    public List<Cert> getCerts() {
        return certDao.getCerts();
    }

    public int insertCert(Cert cert) {
        return certDao.insertCert(cert);
    }

    public Cert getCertById(Integer id) {
        return certDao.getCertById(id);
    }

    public int updateCert(Cert cert) {
        return certDao.updateCert(cert);
    }

    public int insertAccttypeCert(Map<String, Object> param) {
        return certDao.insertAccttypeCert(param);
    }

    public int deleteAccttypeCert(Map<String, Object> param) {
        return certDao.deleteAccttypeCert(param);
    }

    public List<Map<String, Object>> queryAccttypeCerts() {
        return certDao.queryAccttypeCerts();
    }
}
