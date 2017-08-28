<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<meta charset="GB18030">
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
			cursor:pointer;
		}
	</style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container-fluid">
		<div class="navbar-header">
			<div><a class="navbar-brand" style="font-size:32px;" href="user.html">众筹平台 - 用户维护</a></div>
		</div>
		<%@include file="/WEB-INF/jsp/manager/include/topNavBar.jsp"%>
	</div>
</nav>

<div class="container-fluid">
	<div class="row">
		<%@include file="/WEB-INF/jsp/manager/include/leftSlideBar.jsp"%>
		<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<ol class="breadcrumb">
				<li><a href="#">首页</a></li>
				<li><a href="#">数据列表</a></li>
				<li class="active">分配角色</li>
			</ol>
			<div class="panel panel-default">
				<div class="panel-body">
					<form role="form" class="form-inline">
						<div class="form-group">
							<label for="leftList">未分配角色列表</label><br>
							<select id="leftList" class="form-control" multiple size="10" style="width:200px;height: 230px;overflow-y:auto;">
								<c:forEach items="${unassignList}" var="role">
									<option value="${role.id}">${role.name}</option>
								</c:forEach>

								<%--<option value="pm">PM</option>--%>
								<%--<option value="sa">SA</option>--%>
								<%--<option value="se">SE</option>--%>
								<%--<option value="tl">TL</option>--%>
								<%--<option value="gl">GL</option>--%>
							</select>
						</div>
						<div class="form-group">
							<ul>
								<li id="leftToRightButton" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
								<br>
								<li id="RightToLeftButton" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>

							</ul>
						</div>
						<div class="form-group" style="margin-left:60px;">
							<label for="rightList">已分配角色列表</label><br>
							<select id="rightList" class="form-control" multiple size="10" style="width:200px;height:230px;pxoverflow-y:auto;">
								<c:forEach items="${assignList}" var="role">
									<option value="${role.id}">${role.name}</option>
								</c:forEach>
								<%--<option value="qa">QA</option>--%>
								<%--<option value="qc">QC</option>--%>
								<%--<option value="pg">PG</option>--%>
							</select>
						</div>
					</form>
					<br>
					<br>
					<button id="AddAllButton" class="btn btn-default glyphicon glyphicon-chevron-right" style="margin-top:0px;margin-left:225px;">Add All</button>
					<br>
					<button id="RemoveAllButton" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:10px;margin-left:210px;">Remove All</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
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
<script src="${APP_PATH}/script/changeRedForTabs.js"></script>
<script src="${APP_PATH}/script/layer/layer.js"></script>
<script type="text/javascript">
    $(function () {

    });


    $("#leftToRightButton").click(function () {
		var items=$("#leftList :selected");
		addItems(items);
    });

    $("#RightToLeftButton").click(function () {
        var items=$("#rightList :selected");
        removeItems(items);
    });

    $("#AddAllButton").click(function () {
        var items=$("#leftList").children();
        addItems(items);
    });

    $("#RemoveAllButton").click(function () {
        var items=$("#rightList").children();
        removeItems(items);
    });

    function addItems(items) {
        if (items.length==0){
            layer.msg("请选择元素",{time:1500});
            return;
        }else{
            var jsonData={userId:"${user.id}"};
            $.each(items,function (i,n) {
                jsonData["ids["+i+"]"]=n.value;
            });
            $.ajax({
                type:"POST",
                url:"${APP_PATH}/user/assignRole.do",
                data:jsonData,
                success:function (result) {
                    if(result.success){
                        $("#rightList").append(items);
                    }else{
                        layer.msg("添加角色失败",{time:1000});
                    }
                },
                error:function () {
                    layer.msg("请求发送失败",{time:1000});
                }
            });
        }
    }

    function removeItems(items) {
        if (items.length==0){
            layer.msg("请选择元素",{time:1500});
            return;
        }else{
            var jsonData={userId:"${user.id}"};
            $.each(items,function (i,n) {
                jsonData["ids["+i+"]"]=n.value;
            });
            $.ajax({
                type:"POST",
                url:"${APP_PATH}/user/unassignRole.do",
                data:jsonData,
                success:function (result) {
                    if(result.success){
                        $("#leftList").append(items);
                    }else{
                        layer.msg("移除角色失败",{time:1000});
                    }
                },
                error:function () {
                    layer.msg("请求发送失败",{time:1000});
                }
            });
        }
    }
</script>
</body>
</html>

