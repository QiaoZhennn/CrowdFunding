package com.atguigu.atcrowdfunding.bean;

public class Member {
    private String loginacct,memberpswd,membername, email,
            authstatus,type,realname,cardnum,accttype,actstatus;
    private Integer id;

    @Override
    public String toString() {
        return "Member{" +
                "loginacct='" + loginacct + '\'' +
                ", memberpswd='" + memberpswd + '\'' +
                ", membername='" + membername + '\'' +
                ", email='" + email + '\'' +
                ", authstatus='" + authstatus + '\'' +
                ", type='" + type + '\'' +
                ", realname='" + realname + '\'' +
                ", cardnum='" + cardnum + '\'' +
                ", accttype='" + accttype + '\'' +
                ", actstatus='" + actstatus + '\'' +
                ", id=" + id +
                '}';
    }

    public String getLoginacct() {
        return loginacct;
    }

    public void setLoginacct(String loginacct) {
        this.loginacct = loginacct;
    }

    public String getMemberpswd() {
        return memberpswd;
    }

    public void setMemberpswd(String memberpswd) {
        this.memberpswd = memberpswd;
    }

    public String getMembername() {
        return membername;
    }

    public void setMembername(String membername) {
        this.membername = membername;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAuthstatus() {
        return authstatus;
    }

    public void setAuthstatus(String authstatus) {
        this.authstatus = authstatus;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname;
    }

    public String getCardnum() {
        return cardnum;
    }

    public void setCardnum(String cardnum) {
        this.cardnum = cardnum;
    }

    public String getAccttype() {
        return accttype;
    }

    public void setAccttype(String accttype) {
        this.accttype = accttype;
    }

    public String getActstatus() {
        return actstatus;
    }

    public void setActstatus(String actstatus) {
        this.actstatus = actstatus;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

}
