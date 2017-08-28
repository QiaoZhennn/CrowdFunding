<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

      <form class="form-signin" method="post" role="form">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户注册</h2>
          <div style="height: 30px">
              <span id="errorMsg"></span>
          </div>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="loginAccount" name="loginAccount" placeholder="请输入注册账号" autofocus>
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		  </div>
          <div class="form-group has-success has-feedback">
              <input type="text" class="form-control" id="username" name="username" placeholder="请输入用户名" value="测试1" autofocus>
              <span class="glyphicon glyphicon-user form-control-feedback"></span>
          </div>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="userPassword" name="userPassword" placeholder="请输入注册密码" value="123456" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>
		  <div id="emailDiv" class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="email" name="email" placeholder="请输入邮箱地址" value="test1@test.com" style="margin-top:10px;">
			<span class="glyphicon glyphicon glyphicon-envelope form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<select id="userType" name="userType" class="form-control" >
                <option value="manager">管理</option>
                <option value="member">会员</option>
            </select>
		  </div>
        <div class="checkbox">
          <label>
            忘记密码
          </label>
          <label style="float:right">
            <a href="${APP_PATH}/login.htm">我有账号</a>
          </label>
        </div>
        <a id="regBtn" class="btn btn-lg btn-success btn-block" onclick="reg()" > 注册</a>
      </form>
    </div>
    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
  <script>
      $("#userType").change(function () {
          var userType=$("#userType");
          if (userType.val()=="member"){
              var dataContent="";

              dataContent+='<div id="memberTypeDiv" class="form-group has-success has-feedback">';
              dataContent+='<select id="memberType" name="memberType" class="form-control" >';
              dataContent+='<option value="0">个人</option>';
              dataContent+='<option value="1">企业</option>';
              dataContent+='/select>';
              dataContent+='/div>';

              $("#emailDiv").after(dataContent);
          }else{
              $("#memberTypeDiv").remove();
          }
      });


      $("#loginAccount").change(function () {
          $.ajax({
              type:"POST",
              url:"${APP_PATH}/queryUsersByLoginAccount.do",
              dataType:"json",
              data:{
                  loginAccount:$("#loginAccount").val(),
                  userType:$("#userType").val()
              },
              success:function(result){
                  if(result.success){
                      $("#errorMsg").html("<i class='text-success'>用户名可用</i>");
                      $("#regBtn").attr("disabled",false);
                      $("#regBtn").removeClass("btn-danger");
                      $("#regBtn").addClass("btn-success");
                  }else {
                      $("#errorMsg").html("<i class='text-danger'>用户名已存在</i>");
                      $("#regBtn").attr("disabled",true);
                      $("#regBtn").removeClass("btn-success");
                      $("#regBtn").addClass("btn-danger");
                  }
              }
          });
      });

      function reg() {
          $.ajax({
              type:"POST",
              url:"${APP_PATH}/doRegister.do",
              dataType:"json",
              data:{
                  loginAccount:$("#loginAccount").val(),
                  username:$("#username").val(),
                  userPassword:$("#userPassword").val(),
                  email:$("#email").val(),
                  userType:$("#userType").val(),
                  memberType:$("#memberType").val()
              },
              success:function (result) {
                  if(result.success){
                      var href="${APP_PATH}/"+result.msg+".htm";
                      window.location.href=href;
                  }else {
                      layer.msg("注册失败",{time:500});
                  }
              },
              error:function () {
                  layer.msg("请求失败",{time:500});
              }
          });
      }
  </script>
  </body>
</html>