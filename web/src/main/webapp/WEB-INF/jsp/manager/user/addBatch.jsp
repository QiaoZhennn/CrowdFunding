<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 用户维护</a></div>
        </div>
        <jsp:include page="/WEB-INF/jsp/manager/include/topNavBar.jsp"/>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <%@include file="/WEB-INF/jsp/manager/include/leftSlideBar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <button type="button" id="saveButton" class="btn btn-primary btn-success"
                            style="float:right;margin-left: 10px"><i
                            class="glyphicon glyphicon-plus"></i> 保存
                    </button>
                    <button type="button" class="btn btn-primary" style="float:right;"
                            onclick="addUserRow()"><i
                            class="glyphicon glyphicon-plus"></i> 添加一行
                    </button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <form id="batchInsertForm" action="${APP_PATH}/user/inserts.htm" method="post">
                            <table class="table  table-bordered">
                                <thead>
                                <tr>
                                    <th>账号</th>
                                    <th>名称</th>
                                    <th>邮箱地址</th>
                                    <th width="100">操作</th>
                                </tr>
                                </thead>
                                <tbody id="dataBody">
                                <tr>
                                    <td><input type="text" class="form-control" name="users[0].loginAccount"></td>
                                    <td><input type="text" class="form-control" name="users[0].username"></td>
                                    <td><input type="text" class="form-control" name="users[0].email"></td>
                                    <td>
                                        <button onclick="deleteUserRow(this)" type="button"
                                                class="btn btn-danger btn-xs"><i
                                                class=" glyphicon glyphicon-remove"></i></button>
                                    </td>
                                </tr>
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
                        </form>
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

    });
    $("tbody .btn-success").click(function () {
        window.location.href = "../../assignRole.html";
    });
    $("tbody .btn-primary").click(function () {
        window.location.href = "edit.jsp";
    });

    var userCount = 0;

    function addUserRow() {
        var dataContent = '';
        userCount++;
        dataContent += '<tr>';
        dataContent += '    <td><input type="text" class="form-control" name="users[' + userCount + '].loginAccount"></td>';
        dataContent += '    <td><input type="text" class="form-control" name="users[' + userCount + '].username"></td>';
        dataContent += '    <td><input type="text" class="form-control" name="users[' + userCount + '].email"></td>';
        dataContent += '    <td>';
        dataContent += '        <button onclick="deleteUserRow(this)" type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
        dataContent += '    </td>';
        dataContent += '</tr>';
        $("#dataBody").append(dataContent);
    }

    function deleteUserRow(btn) {
        $(btn).parents("tr").eq(0).remove();
    }

    $("#saveButton").click(function () {
        $("#batchInsertForm").submit();
    });
</script>
<script src="${APP_PATH}/script/changeRedForTabs.js"></script>
</body>
</html>
