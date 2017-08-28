<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="row">
    <div class="col-md-12">
        <div class="thumbnail" style="    border-radius: 0px;">
            <img src="img/services-box1.jpg" class="img-thumbnail" alt="">
            <div class="caption" style="text-align:center;">
                <h3>
                    ${loginMember.membername}
                </h3>
                <c:choose>
                    <c:when test="${loginMember.authstatus eq '2'}">
                        <span class="label label-success">已实名认证</span>
                    </c:when>
                    <c:when test="${loginMember.authstatus eq '1'}">
                        <span class="label label-primary">实名认证申请中</span>
                    </c:when>
                    <c:otherwise>
                        <span class="label label-danger">未实名认证</span><br>
                        <button class="btn btn-success btn-lg" onclick="window.location.href='${APP_PATH}/member/apply.htm'" style="margin-top: 10px">
                            申请认证
                        </button>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
<div class="list-group">
    <div class="list-group-item active">
        资产总览<span class="badge"><i class="glyphicon glyphicon-chevron-right"></i></span>
    </div>
    <div class="list-group-item " style="cursor:pointer;" onclick="window.location.href='${APP_PATH}/member/minecrowdfunding.htm'">
        我的众筹<span class="badge"><i class="glyphicon glyphicon-chevron-right"></i></span>
    </div>
</div>
