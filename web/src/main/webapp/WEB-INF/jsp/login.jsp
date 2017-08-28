<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/login.css">
    <style>

    </style>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <div><a class="navbar-brand" href="index.html" style="font-size:32px;">尚筹网-创意产品众筹平台</a></div>
        </div>
    </div>
</nav>

<div class="container">

    <h1></h1>
    <br>

    <form id="loginForm" class="form-signin" role="form" action="${APP_PATH}/doLogin.htm" method="post">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-picture"></i> 用户登录</h2>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="loginAccount" value="Lina" name="loginAccount"
                   placeholder="请输入登录账号" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="userPassword" value="123456" name="userPassword" placeholder="请输入登录密码"
                   style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <select id="userType" class="form-control">
                <option value="member">会员</option>
                <option value="user">管理</option>
            </select>
        </div>
        <div class="checkbox">
            <label>
                <input type="checkbox" value="remember-me"> 记住我
            </label>
            <br>
            <label>
                忘记密码
            </label>
            <label style="float:right">
                <a href="${APP_PATH}/reg.htm">我要注册</a>
            </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" onclick="dologin()"> 登录</a>
    </form>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/layer/layer.js"></script>
<script>
    function dologin() {
        var loginAccount = $("#loginAccount");
        if (loginAccount.val() == "") {
            layer.tips("登陆账号不能为空","#loginAccount");
//            layer.msg("登陆账号不能为空，请输入", {time: 1000, icon: 5, shift: 4}, function () {
//                loginAccount.focus();
//            });
            return;
        }
        var userPassword = $("#userPassword");
        if (userPassword.val() == "") {
            layer.tips("登陆密码不能为空","#userAccount");
            return;
        }

        //获取用户的类型
        var url="doLogin.do";
        var type=$("#userType").val();
        if(type=="member"){
            url="doMemberLogin.do";
        }

        var loadingIndex=-1;
        $.ajax({
            url: "${APP_PATH}/"+url,
            type: "POST",
            data: {
                loginAccount: loginAccount.val(),
                loginacct: loginAccount.val(),
                userPassword: userPassword.val(),
                memberpswd: userPassword.val()
            },
            dataType: "json",
            beforeSend:function () {
                loadingIndex=layer.load(1);
            },
            success: function (result) {
                if (result.success) {
                    layer.close(loadingIndex);
                    if(type=="member"){
                        window.location.href = "${APP_PATH}/member.htm";
                    }else {
                        window.location.href = "${APP_PATH}/main.htm";
                    }

                } else {
                    layer.close(loadingIndex);
                    if(result.msg){
                        layer.msg(result.msg,{time:1000,icon:2,shift:5})
                    }else {
                        layer.msg("登陆错误，请重新登陆",{time:1000,icon:2,shift:5})
                    }
                }
            },
            error:function () {
                layer.close(loadingIndex);
                layer.msg("请求发送错误",{time:1000,icon:2,shift:5})
            }
        });
    }

</script>
</body>
</html>

