package com.atguigu.atcrowdfunding.portal.service;

import com.atguigu.atcrowdfunding.bean.*;
import com.atguigu.atcrowdfunding.portal.dao.MemberDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MemberServiceImpl implements MemberService{

    @Autowired
    MemberDao memberDao;

    public Member queryMemberForLogin(Member member) {
        return memberDao.queryMemberForLogin(member);
    }

    public void insertTicket(Ticket ticket) {
        memberDao.insertTicket(ticket);
    }

    public int updateAccttype(Member loginMember) {
        return memberDao.updateAccttype(loginMember);
    }

    public Ticket queryTicket(Member loginMember) {
        return memberDao.queryTicket(loginMember);
    }

    public int updateBasicInfo(Member member) {
        return memberDao.updateBasicInfo(member);
    }

    public List<Cert> queryCertsByAccttype(String accttype) {
        return memberDao.queryCertsByAccttype(accttype);
    }

    public void insertMemberCerts(BatchData bd) {
        memberDao.insertMemberCerts(bd);
    }

    public int updateEmail(Member loginMember) {
        return memberDao.updateEmail(loginMember);
    }

    public void updateAuthcode(Ticket ticket) {
        memberDao.updateAuthcode(ticket);
    }

    public int updateAuthstatus(Member loginMember) {
        return memberDao.updateAuthstatus(loginMember);
    }

    public Member queryMemberByTickerPiid(String piid) {
        return memberDao.queryMemberByTickerPiid(piid);
    }

    public List<MemberCert> queryMemberCertsByMemberId(Integer memberId) {
        return memberDao.queryMemberCertsByMemberId(memberId);
    }

    public Member queryById(Integer memberId) {
        return memberDao.queryById(memberId);
    }

    public void updateTicketStatus(Ticket ticket) {
        memberDao.updateTicketStatus(ticket);
    }

    public int insertMember(Member member) {
        return memberDao.insertMember(member);
    }

    public List<Member> queryMembersByLoginAccount(String loginAccount) {
        return memberDao.queryMembersByLoginAccount(loginAccount);
    }
}
