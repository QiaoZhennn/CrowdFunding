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
    <link rel="stylesheet" href="${APP_PATH}/css/pagination.css">
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
        <jsp:include page="/WEB-INF/jsp/manager/include/leftSlideBar.jsp" />
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
                                <input class="form-control has-success" id="queryText" type="text"
                                       placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="button" id="queryButton" class="btn btn-warning"><i
                                class="glyphicon glyphicon-search"></i> 查询
                        </button>
                    </form>
                    <button onclick="batchDeleteUsers()" type="button" class="btn btn-danger"
                            style="float:right;margin-left:10px;"><i
                            class=" glyphicon glyphicon-remove"></i> 删除
                    </button>
                    <button onclick="window.location.href='${APP_PATH}/user/addBatch.htm'" type="button" class="btn btn-success"
                            style="float:right;margin-left:10px;"><i
                            class=" glyphicon glyphicon-plus-sign"></i> 批量新增
                    </button>
                    <button type="button" class="btn btn-primary" style="float:right;"
                            onclick="window.location.href='${APP_PATH}/user/add.htm'"><i
                            class="glyphicon glyphicon-plus"></i> 新增
                    </button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr>
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox" onclick="selectAllChecboxes(this)"></th>
                                <th>账号</th>
                                <th>名称</th>
                                <th>邮箱地址</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody id="dataBody">
                                <%--此处等待JS动态添加html--%>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6" align="center">
                                    <%--<ul class="pagination">
                                        &lt;%&ndash;此处等待JS动态添加html&ndash;%&gt;
                                    </ul>--%>
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

<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/script/layer/layer.js"></script>
<script src="${APP_PATH}/jquery/jquery.pagination.js"></script>

<script type="text/javascript">
    $(function () {
        <c:if test="${empty param.pageNo}">
            pageQuery(0);
        </c:if>
        <c:if test="${not empty param.pageNo}">
            pageQuery(${param.pageNo}-1);
        </c:if>
    });
    $("tbody .btn-success").click(function () {
        window.location.href = "../../assignRole.html";
    });
    $("tbody .btn-primary").click(function () {
        window.location.href = "edit.jsp";
    });

    var flag = false;
    $("#queryButton").click(function () {
        var queryText = $("#queryText");
        if (queryText.val() == "") {
            layer.msg("请输入查询条件", {time: 1000});
            return;
        }
        flag = true;
        pageQuery(0);
    });


    function pageQuery(pageIndex) {
        var loadingIndex = -1;
        var jsonData = {
            pageNo: pageIndex+1,
            pageSize: 4
        };
        if (flag) {
            //jsonData.jsonText=$("#queryText").val();
            jsonData["queryText"] = $("#queryText").val();
        }
        $.ajax({
            url: "${APP_PATH}/user/pageQuery.do",
            type: "POST",
            data: jsonData,
            beforeSend: function () {
                loadingIndex = layer.load(1);
            },
            success: function (result) {
                layer.close(loadingIndex);
                if (result.success) {
                    var userPage = result.data;
                    var users = userPage.data;
                    var dataContent = '';
                    $.each(users, function (i, user) {
                        dataContent += '<tr>';
                        dataContent += '    <td>' + (i + 1) + '</td>';
                        dataContent += '    <td><input type="checkbox" value="'+user.id+'"><input type="hidden" value="' + user.id + '"></td>';
                        dataContent += '    <td>' + user.loginAccount + '</td>';
                        dataContent += '    <td>' + user.username + '</td>';
                        dataContent += '    <td>' + user.email + '</td>';
                        dataContent += '    <td>';
                        dataContent += '        <button onclick="window.location.href=\'/user/assign.htm?id='+user.id+'\'" type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
                        dataContent += '        <button onclick="updateUser(' + user.id +','+(pageIndex+1)+ ')" type="button" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                        dataContent += '        <button onclick="deleteUser(' + user.id + ',\'' + user.loginAccount + '\')" type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                        dataContent += '    </td>';
                        dataContent += '</tr>';
                    });
                    $("#dataBody").html(dataContent);
                    $("#Pagination").pagination(userPage.totalCount,{
                        num_edge_entries:1,
                        num_display_entries:4,
                        callback:pageQuery,
                        items_per_page:4,
                        prev_page:"上一页",
                        next_page:"下一页",
                        current_page:pageIndex
                    });
                    /*//生成页码
                    var pageContent = "";
                    if (pageNo > 1) {
                        pageContent += '<li><a href="#" onclick="pageQuery(' + (pageNo - 1) + ')">上一页</a></li>';
                    }
                    for (var i = 1; i <= userPage.totalPage; i++) {
                        if (i == pageNo) {
                            pageContent += '<li class="active"><a href="#">' + i + '</a></li>';
                        } else {
                            pageContent += '<li><a href="#" onclick="pageQuery(' + i + ')">' + i + '</a></li>';
                        }
                    }
                    if (pageNo < userPage.totalPage) {
                        pageContent += '<li><a href="#" onclick="pageQuery(' + (pageNo + 1) + ')">下一页</a></li>';
                    }
                    $(".pagination").html(pageContent);
                    layer.close(loadingIndex);*/
                } else {
                    layer.msg("Query failed!");
                }
            }
        });
    }

    function updateUser(userId,pageNo) {
        window.location.href = "${APP_PATH}/user/edit.htm?id=" + userId+"&pageNo="+pageNo;
    }

    function deleteUser(userId, loginAccount) {
        layer.confirm("删除用户: " + loginAccount + "，是否继续?", {icon: 3, title: '提示'}, function (cindex) {
            //删除用户
            $.ajax({
                url: "${APP_PATH}/user/delete.do",
                type: "POST",
                data: {
                    id: userId
                },
                success: function (result) {
                    if (result) {
                        window.location.href = "${APP_PATH}/user/index.htm";
                    } else {
                        layer.msg("删除失败", {time: 1000});
                    }
                }
            });
            layer.close(cindex);
        }, function (cindex) {
            layer.close(cindex);
        })
    }
    
       function batchDeleteUsers() {
        //1、获取用户复选框选择的数量：
        var userBoxes=$("#dataBody :checked");
        var count=userBoxes.length;
        if(count==0){
            layer.msg("请选择需要删除的用户",{time:1500});
        }else{
            var size = $(":checkbox:checked").size();
            layer.confirm("是否要删除选中的" + size + "位用户?", {icon: 3, title: '提示',shift:5}, function (cindex) {
                    var jsonData={};
                    userBoxes.each(function (i, c) {
                        //动态向JS对象中添加属性，funciton中的c是一个DOM对象，没有.val()方法，但是有.value属性。将用户的id赋给checkbox的value属性
                        //因为动态添加的属性名含有特殊字符，所以不能写jsonData.key=value，而须写jsonData["key"]=value
                        //$.each("集合",function(index,item){}),或者--集合.each(function(index,item){})
                        jsonData["users["+i+"].id"]=c.value;
                    });

                    var loadingIndex=-1;
                    $.ajax({
                        url: "${APP_PATH}/user/deletes.do",
                        type: "POST",
                        dataType: "json",
                        data: jsonData,
                        beforeSend: function () {
                            loadingIndex=layer.load(1);
                        },
                        success: function (result) {
                            if (result.success) {
                                layer.close(loadingIndex);
                                pageQuery(0);

                            } else {
                                layer.close(loadingIndex);
                                layer.msg("删除失败", {time: 1000, icon:5, shift:6});
                            }
                        },
                        error: function () {
                            layer.close(loadingIndex);
                            layer.msg("请求发送失败", {time: 1000, icon:5, shift:6});
                        }
                    });
                layer.close(cindex)
            }, function (cindex) {
                layer.close(cindex);
            });
        }
    }

    //选择所有的复选框
    function selectAllChecboxes(cBox) {
        var flag=cBox.checked;
        $("#dataBody :checkbox").each(function (i,box) {
             box.checked=flag;
        });
    }

/*    $(".list-group-item").click(function () {
        if ($(this).find("ul")) {
            $(this).toggleClass("tree-closed");
            if ($(this).hasClass("tree-closed")) {
                $("ul", this).hide("fast");
            } else {
                $("ul", this).show("fast");
            }
        }
    });*/
</script>

<script src="${APP_PATH}/script/changeRedForTabs.js"></script>
</body>
</html>
