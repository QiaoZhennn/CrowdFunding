<%@ page pageEncoding="UTF-8" %>
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
    <link rel="stylesheet" href="${APP_PATH}/css/main.css">
    <link rel="stylesheet" href="${APP_PATH}/css/doc.min.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor: pointer;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="index.jsp">众筹平台 - 用户维护</a></div>
        </div>
        <jsp:include page="/WEB-INF/jsp/manager/include/topNavBar.jsp"/>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <%@include file="/WEB-INF/jsp/manager/include/leftSlideBar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="#">首页</a></li>
                <li><a href="#">数据列表</a></li>
                <li class="active">新增</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据
                    <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i
                            class="glyphicon glyphicon-question-sign"></i></div>
                </div>
                <div class="panel-body">
                    <form action="${APP_PATH}/user/saveFile.htm" id="userForm" method="post"
                          enctype="multipart/form-data" role="form">
                        <div class="form-group">
                            <label for="loginAccount">登陆账号</label>
                            <input type="text" class="form-control" id="loginAccount" name="loginAccount"
                                   placeholder="请输入登陆账号">
                        </div>
                        <div class="form-group">
                            <label for="username">用户名称</label>
                            <input type="text" class="form-control" id="username" name="username" placeholder="请输入用户名称">
                        </div>
                        <div class="form-group">
                            <label for="email">邮箱地址</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="请输入邮箱地址">
                            <p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
                        </div>
                        <div class="form-group">
                            <label for="userIcon">头像</label>
                            <input type="file" class="form-control" id="userIcon" name="userIcon" placeholder="请输入用户名称">
                        </div>
                        <button id="insertButton" type="button" class="btn btn-success"><i
                                class="glyphicon glyphicon-plus"></i> 新增
                        </button>
                        <button type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">帮助</h4>
            </div>
            <div class="modal-body">
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题1</h4>
                    <p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
                </div>
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题2</h4>
                    <p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
                </div>
            </div>
            <!--
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary">Save changes</button>
            </div>
            -->
        </div>
    </div>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/script/layer/layer.js"></script>
<script src="${APP_PATH}/jquery/jquery-form.min.js"></script>

<script type="text/javascript">
    $(function () {


//			    var loginAccount=$("#loginAccount");
        $("#insertButton").click(function () {
            $("#userForm").ajaxSubmit({
                beforeSubmit: function () {
                    loadingIndex = layer.load(1);
                },
                success: function (result) {
                    if (result.success) {
                        layer.close(loadingIndex);
                        window.location.href = "${APP_PATH}/user/index.htm";
                        layer.msg("新增成功", {time: 500});
                    } else {
                        layer.close(loadingIndex);
                        layer.msg("新增失败", {time: 500});
                    }
                },
                timeout: 3000
            });
            /*$.ajax({
                url:"
            ${APP_PATH}/user/insert.do",
						type: "POST",
						data:{
							loginAccount: $("#loginAccount").val(),
							username:$("#username").val(),
							email:$("#email").val()
                    	},
						dataType:"json",
						beforeSend: function () {
                            loadingIndex=layer.load(1);
                        },
                    	success: function (result) {
							if(result.success){
								window.location.href="
            ${APP_PATH}/user/index.htm";
//                                layer.msg("新增成功",{time:1000});
                            }else {
							    layer.msg("新增失败",{time:1000});
                            }
                        }
					});*/
        });
    });
</script>
<script src="${APP_PATH}/script/changeRedForTabs.js"></script>
</body>
</html>
