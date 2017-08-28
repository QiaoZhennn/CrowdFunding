package com.atguigu.atcrowdfunding.bean;

import java.util.List;

public class BatchData {
    private List<User> users;
    private List<Integer> ids;
    private List<MemberCert> memberCerts;

    public List<MemberCert> getMemberCerts() {
        return memberCerts;
    }

    public void setMemberCerts(List<MemberCert> memberCerts) {
        this.memberCerts = memberCerts;
    }

    public List<User> getUsers() {
        return users;
    }
    public void setUsers(List<User> users) {
        this.users = users;
    }

    public List<Integer> getIds() {
        return ids;
    }
    public void setIds(List<Integer> ids) {
        this.ids = ids;
    }
}
