package com.atguigu.atcrowdfunding.bean;

/**
 * 流程审批单,一个Member，对应一个流程实例ProcessInstance
 * 将loginMember和ProcessDefinition中Key名为authflow的ProcessInstance绑定，见表t_ticket
 * piid: processInstanceId
 * status: 该processInstance流程实例被管理员审核，0表示审核不通过，1表示通过
 */
public class Ticket {
    private String piid,status,authcode,pstep;
    private Integer id,memberid;

    @Override
    public String toString() {
        return "Ticket{" +
                "piid='" + piid + '\'' +
                ", status='" + status + '\'' +
                ", authcode='" + authcode + '\'' +
                ", pstep='" + pstep + '\'' +
                ", id=" + id +
                ", memberid=" + memberid +
                '}';
    }

    public String getPiid() {
        return piid;
    }

    public void setPiid(String piid) {
        this.piid = piid;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAuthcode() {
        return authcode;
    }

    public void setAuthcode(String authcode) {
        this.authcode = authcode;
    }

    public String getPstep() {
        return pstep;
    }

    public void setPstep(String pstep) {
        this.pstep = pstep;
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
}
