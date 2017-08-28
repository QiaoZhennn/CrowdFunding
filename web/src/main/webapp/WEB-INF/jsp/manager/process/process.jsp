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
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 流程管理</a></div>
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
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="uploadProcDefFile()"><i class="glyphicon glyphicon-upload"></i> 上传流程定义文件BPMN</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th>流程名称</th>
                                <th>流程版本</th>
                                <th>流程标识</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%--<tr>
                                <td>1</td>
                                <td>实名认证审批流程</td>
                                <td>2</td>
                                <td>人工审核</td>
                                <td>张三</td>
                                <td>
                                    <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-eye-open"></i></button>
                                    <button type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>
                                </td>
                            </tr>--%>
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
        <%--<c:if test="${empty param.pageNo}">
        pageQuery(0);
        </c:if>
        <c:if test="${not empty param.pageNo}">
        pageQuery(${param.pageNo}-1);
        </c:if>--%>
    });

    function pageQuery(pageIndex) {
        var loadingIndex = -1;
        var jsonData = {
            pageNo: pageIndex+1,
            pageSize: 10
        };

        $.ajax({
            url: "${APP_PATH}/process/pageQuery.do",
            type: "POST",
            data: jsonData,
            beforeSend: function () {
                loadingIndex = layer.load(1);
            },
            success: function (result) {
                layer.close(loadingIndex);
                if (result.success) {
                    var pdPage = result.data;
//                    alert("pdPage: "+pdPage.totalCount);
                    var pdMap = pdPage.data;
                    var dataContent = '';
                    $.each(pdMap, function (i, pd) {
                    dataContent+='<tr>';
                    dataContent+='    <td>'+(i+1)+'</td>';
                    dataContent+='    <td>'+pd.name+'</td>';
                    dataContent+='    <td>'+pd.version+'</td>';
                    dataContent+='    <td>'+pd.key+'</td>';
                    dataContent+='    <td>';
                    dataContent+='        <button type="button" onclick="showProcDef(\''+pd.id+'\')" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-eye-open"></i></button>';
                    dataContent+='        <button type="button" onclick="deleteProcDef(\''+pd.name+'\',\''+pd.id+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                    dataContent+='    </td>';
                    dataContent+='/tr>';

                    });
                    $("tbody").html(dataContent);

                    $("#Pagination").pagination(pdPage.totalCount,{
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
    
    function uploadProcDefFile() {
        $("#fprocDefFile").click();
    }
    $("#fprocDefFile").change(function () {
        //开始上传文件
        var loadingIndex;
        $("#procDefForm").ajaxSubmit({
            beforeSubmit: function () {
                loadingIndex = layer.load(1);
            },
            success: function (result) {
                if (result.success) {
                    layer.close(loadingIndex);
                    pageQuery(0);
                    layer.msg("上传成功", {time: 500});
                } else {
                    layer.close(loadingIndex);
                    layer.msg("上传失败", {time: 500});
                }
            },
            timeout: 3000,
            resetForm: true,
            error:function () {
                layer.msg("请求失败",{time:500});
            }
        });
    });

    function showProcDef(pdid) {
        window.location.href="${APP_PATH}/process/showImg.htm?pdid="+pdid;
    }

    function deleteProcDef(pdName,pdid) {
        layer.confirm("删除流程: " + pdName + "，是否继续?", {icon: 3, title: '提示'}, function (cindex) {
            //删除用户
            $.ajax({
                url: "${APP_PATH}/process/delete.do",
                type: "POST",
                data: {
                    id: pdid
                },
                success: function (result) {
                    if (result) {
                        layer.msg("删除成功", {time: 500});
                        window.location.href = "${APP_PATH}/process/index.htm";
                    } else {
                        layer.msg("删除失败", {time: 500});
                    }
                }
            });
            layer.close(cindex);
        }, function (cindex) {
            layer.close(cindex);
        })
    }
</script>
<script src="${APP_PATH}/script/changeRedForTabs.js"></script>
</body>
</html>

