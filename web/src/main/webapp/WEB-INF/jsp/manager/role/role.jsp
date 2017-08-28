<%@page pageEncoding="UTF-8" %>
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
    <style>
        .tree li {
            list-style-type: none;
            cursor: pointer;
        }

        table tbody tr:nth-child(odd) {
            background: #F4F4F4;
        }

        table tbody td:nth-child(even) {
            color: #C00;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 角色维护</a></div>
        </div>
        <jsp:include page="/WEB-INF/jsp/manager/include/topNavBar.jsp"/>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <%@ include file="/WEB-INF/jsp/manager/include/leftSlideBar.jsp"%>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="queryText" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button id="queryButton" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询
                        </button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i
                            class=" glyphicon glyphicon-remove"></i> 删除
                    </button>
                    <button type="button" class="btn btn-primary" style="float:right;"
                            onclick="window.location.href='${APP_PATH}/role/add.htm'"><i class="glyphicon glyphicon-plus"></i> 新增
                    </button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr>
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6" align="center">
                                    <ul class="pagination">
                                    </ul>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/script/layer/layer.js"></script>
<script type="text/javascript">
    $(function () {

        query();
    });

    $("tbody .btn-success").click(function () {
        window.location.href = "../../assignPermission.html";
    });

    var flag=false;
    $("#queryButton").click(function () {
        var queryText=$("#queryText");
        if(queryText.val()==""){
            layer.tips("Please input your query parameters","#queryText",{tips:3});
        }
        flag=true;
        query();
    });

    function query() {
        var loadingIndex=-1;
        var jsonData={};
        if(flag){
            jsonData.queryText = $("#queryText").val();
        }
        $.ajax({
            url: "${APP_PATH}/role/listAll.do",
            type: "POST",
            dataType: "json",
            data: jsonData,
            beforeSend: function () {
               loadingIndex=layer.load(1);
            },
            success: function (result) {
                layer.close(loadingIndex);
                if (result.success) {
                    var roles=result.data;
                    var dataContent = "";
                    $.each(roles,function (i, role) {
                        dataContent += '<tr>';
                        dataContent += '	   <td>'+(i+1)+'</td>';
                        dataContent += '	   <td><input type="checkbox"></td>';
                        dataContent += '    <td>'+role.name+'</td>';
                        dataContent += '    <td>';
                        dataContent += '		  <button type="button" class="btn btn-success btn-xs" onclick="window.location.href=\'/role/assign.htm?id='+role.id+'\'"><i class=" glyphicon glyphicon-check"></i></button>';
                        dataContent += '		  <button type="button" onclick="update('+role.id+')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                        dataContent += '		  <button type="button" onclick="deleteRole('+role.id+',\''+role.name+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                        dataContent += '    </td> ';
                        dataContent += '/tr>';
                    });
                    $("tbody").html(dataContent);

                } else {
                    layer.msg("Cannot list all roles");
                }
            },
            error: function () {
                layer.close(loadingIndex);
                alert("Request Error");
            }
        });
    }

    function update(roleId) {
        window.location.href="${APP_PATH}/role/update.htm?id="+roleId;
    }

    function deleteRole(roleId,roleName){
        layer.confirm("确定要删除"+roleName+"吗？", {icon: 3, title: '提示'},function (cIndex) {
            var loadingIndex=-1;
            $.ajax({
                url:"${APP_PATH}/role/deleteRole.do",
                type:"POST",
                dataType:"json",
                data:{
                    id:roleId
                },
                beforeSend: function(){
                    loadingIndex=layer.load(1);
                },
                success: function (result) {
                    if(result.success){
                        window.location.href="${APP_PATH}/role/index.htm"
                    }else{
                        layer.msg("删除失败",{time:1000});
                    }
                }
            });
        },function (cIndex) {

        });
    }
</script>
<script src="${APP_PATH}/script/changeRedForTabs.js"></script>
</body>
</html>
