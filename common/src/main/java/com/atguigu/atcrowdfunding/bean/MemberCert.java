package com.atguigu.atcrowdfunding.bean;

import org.springframework.web.multipart.MultipartFile;

public class MemberCert {
    private Integer id,memberid,certid;
    private String iconpath,certname;
    private MultipartFile certImgFile;

    public String getCertname() {
        return certname;
    }

    public void setCertname(String certname) {
        this.certname = certname;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getMemberid() {
        return memberid;
    }

    public void setMemberid(Integer memberid) {
        this.memberid = memberid;
    }

    public Integer getCertid() {
        return certid;
    }

    public void setCertid(Integer certid) {
        this.certid = certid;
    }

    public String getIconpath() {
        return iconpath;
    }

    public void setIconpath(String iconpath) {
        this.iconpath = iconpath;
    }

    public MultipartFile getCertImgFile() {
        return certImgFile;
    }

    public void setCertImgFile(MultipartFile certImgFile) {
        this.certImgFile = certImgFile;
    }
}
