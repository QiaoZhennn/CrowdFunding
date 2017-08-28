<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/theme.css">
    <style>
        #footer {
            padding: 15px 0;
            background: #fff;
            border-top: 1px solid #ddd;
            text-align: center;
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/jsp/portal/include/topNavBar.jsp"%>

<div class="container theme-showcase" role="main">
    <div class="page-header">
        <h1>实名认证 - 申请</h1>
    </div>

    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active"><a href="#"><span class="badge">1</span> 基本信息</a></li>
        <li role="presentation"><a href="#"><span class="badge">2</span> 资质文件上传</a></li>
        <li role="presentation"><a href="#"><span class="badge">3</span> 邮箱确认</a></li>
        <li role="presentation"><a href="#"><span class="badge">4</span> 申请确认</a></li>
    </ul>

    <form role="form" style="margin-top:20px;">
        <div class="form-group">
            <label for="realname">真实名称</label>
            <input type="text" class="form-control" id="realname" placeholder="请输入真实名称">
        </div>
        <div class="form-group">
            <label for="cardnum">身份证号码</label>
            <input type="text" class="form-control" id="cardnum" placeholder="请输入身份证号码">
        </div>
        <div class="form-group">
            <label for="phonenum">电话号码</label>
            <input type="text" class="form-control" id="phonenum" placeholder="请输入电话号码">
        </div>
        <button id="prevBtn" type="button" class="btn btn-default">上一步</button>
        <button id="nextBtn" type="button" class="btn btn-success">下一步</button>
    </form>
    <hr>
</div> <!-- /container -->
<div class="container" style="margin-top:20px;">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <div id="footer">
                <div class="footerNav">
                    <a rel="nofollow" href="http://www.atguigu.com">关于我们</a> | <a rel="nofollow" href="http://www.atguigu.com">服务条款</a> | <a rel="nofollow" href="http://www.atguigu.com">免责声明</a> | <a rel="nofollow" href="http://www.atguigu.com">网站地图</a> | <a rel="nofollow" href="http://www.atguigu.com">联系我们</a>
                </div>
                <div class="copyRight">
                    Copyright ?2017-2017 atguigu.com 版权所有
                </div>
            </div>

        </div>
    </div>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script>
    $('#myTab a').click(function (e) {
        e.preventDefault()
        $(this).tab('show')
    });
    
    $("#nextBtn").click(function () {
        $.ajax({
            type:"POST",
            url:"${APP_PATH}/member/updateBasicInfo.do",
            dataType:"json",
            data:{
                "realname":$("#realname").val(),
                "cardnum":$("#cardnum").val()
            },
            success:function (result) {
                if(result){
                    window.location.href="${APP_PATH}/member/apply.htm"
                }else {

                }
            }
        });
    });

    $("#prevBtn").click(function () {
        $.ajax({
            type:"POST",
            url:"${APP_PATH}/member/returnAcctType.do",
            dataType:"json",
            success:function (result) {
                if(result){
                    window.location.href="${APP_PATH}/member/apply.htm"
                }else {
                }
            }
        });
    });
</script>
</body>
</html>

