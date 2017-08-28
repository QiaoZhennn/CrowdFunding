package com.atguigu.atcrowdfunding.portal.service;

import com.atguigu.atcrowdfunding.bean.*;

import java.util.List;

public interface MemberService {
    Member queryMemberForLogin(Member member);
    void insertTicket(Ticket ticket);

    int updateAccttype(Member loginMember);

    Ticket queryTicket(Member loginMember);

    int updateBasicInfo(Member member);

    List<Cert> queryCertsByAccttype(String accttype);

    void insertMemberCerts(BatchData bd);

    int updateEmail(Member loginMember);

    void updateAuthcode(Ticket ticket);

    int updateAuthstatus(Member loginMember);

    Member queryMemberByTickerPiid(String piid);

    List<MemberCert> queryMemberCertsByMemberId(Integer memberId);

    Member queryById(Integer memberId);

    void updateTicketStatus(Ticket ticket);

    int insertMember(Member member);

    List<Member> queryMembersByLoginAccount(String loginAccount);
}
