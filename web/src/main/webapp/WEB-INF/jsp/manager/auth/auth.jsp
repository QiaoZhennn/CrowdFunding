<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link rel="stylesheet" href="${APP_PATH}/css/main.css">
    <link rel="stylesheet" href="${APP_PATH}/css/pagination.css">

    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 业务审核</a></div>
        </div>
        <%@include file="/WEB-INF/jsp/manager/include/topNavBar.jsp"%>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <jsp:include page="/WEB-INF/jsp/manager/include/leftSlideBar.jsp"/>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th>流程名称</th>
                                <th>流程版本</th>
                                <th>任务名称</th>
                                <th>申请会员</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>

                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6" align="center">
                                    <div id="Pagination" class="pagination"></div>
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
<%--上传文件--%>
<form id="procDefForm" style="display:none;" action="${APP_PATH}/process/upload.do" method="post" enctype="multipart/form-data">
    <input id="fprocDefFile" type="file" name="procDefFile">
</form>

<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/script/layer/layer.js"></script>
<script src="${APP_PATH}/jquery/jquery.pagination.js"></script>
<script src="${APP_PATH}/jquery/jquery-form.min.js"></script>

<script type="text/javascript">

    $(function () {
        pageQuery(0);
    });

    function pageQuery(pageIndex) {
        var loadingIndex = -1;
        var jsonData = {
            pageNo: pageIndex+1,
            pageSize: 10
        };

        $.ajax({
            url: "${APP_PATH}/auth/pageQuery.do",
            type: "POST",
            data: jsonData,
            beforeSend: function () {
                loadingIndex = layer.load(1);
            },
            success: function (result) {
                layer.close(loadingIndex);
                if (result.success) {
                    var pageObj = result.data;
//                    alert("pdPage: "+pdPage.totalCount);
                    var taskList = pageObj.data;
                    var dataContent = '';
                    $.each(taskList, function (i, task) {
                    dataContent+='<tr>';
                    dataContent+='    <td>'+(i+1)+'</td>';
                    dataContent+='    <td>'+task.pdname+'</td>';
                    dataContent+='    <td>'+task.pdversion+'</td>';
                    dataContent+='    <td>'+task.name+'</td>';
                    dataContent+='    <td>'+task.membername+'</td>';
                    dataContent+='    <td>';
                    dataContent+='        <button type="button" onclick="showDetil('+task.memberid+',\''+task.id+'\')" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-eye-open"></i></button>';
                    dataContent+='    </td>';
                    dataContent+='/tr>';
                    });
                    $("tbody").html(dataContent);

                    $("#Pagination").pagination(pageObj.totalCount,{
                        num_edge_entries:1,
                        num_display_entries:4,
                        callback:pageQuery,
                        items_per_page:10,
                        prev_page:"上一页",
                        next_page:"下一页",
                        current_page:pageIndex
                    });

                } else {
                    layer.msg("Query failed!");
                }
            }
        });
    }

    function showDetil(memberId, taskId) {
        window.location.href="${APP_PATH}/auth/detail.htm?memberId="+memberId+"&taskId="+taskId;
    }
</script>
<script src="${APP_PATH}/script/changeRedForTabs.js"></script>
</body>
</html>

