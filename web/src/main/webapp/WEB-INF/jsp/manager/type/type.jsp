<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}

        input[type=checkbox] {
            width:18px;
            height:18px;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 分类管理</a></div>
        </div>
        <jsp:include page="/WEB-INF/jsp/manager/include/topNavBar.jsp"/>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <jsp:include page="/WEB-INF/jsp/manager/include/leftSlideBar.jsp"/>

        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据矩阵</h3>
                </div>
                <div class="panel-body">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th>名称</th>
                                <th >商业公司</th>
                                <th >个体工商户</th>
                                <th >个人经营</th>
                                <th >政府及非营利组织</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${certs}" var="cert">
                                <tr>
                                    <td>${cert.name}</td>
                                    <td><input accttype="0" certid="${cert.id}" type="checkbox"></td>
                                    <td><input accttype="1" certid="${cert.id}" type="checkbox"></td>
                                    <td><input accttype="2" certid="${cert.id}" type="checkbox"></td>
                                    <td><input accttype="3" certid="${cert.id}" type="checkbox"></td>
                                </tr>
                            </c:forEach>

                            </tbody>
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

        //    完成自动勾选数据库中存在的复选框。
        <c:forEach items="${accttypeCerts}" var="atcert">
        //    通过特定属性匹配，来查找对应的元素。
        var selectCheckbox=$(":checkbox[accttype='${atcert.accttype}'][certid='${atcert.certid}']");
        selectCheckbox[0].checked=true;
        </c:forEach>



    $(":checkbox").click(function () {
        var flag=this.checked;

        if(flag){
            $.ajax({
                type:"POST",
                url:"${APP_PATH}/type/insertAccttypeCert.do",
                dataType:"json",
                data:{
                    accttype:$(this).attr("accttype"),
                    certid:$(this).attr("certid")
                },
                success:function (result) {
                },
                error:function () {
                    alert("request fail");
                }
            });
        }else{
            $.ajax({
                type:"POST",
                url:"${APP_PATH}/type/deleteAccttypeCert.do",
                dataType:"json",
                data:{
                    accttype:$(this).attr("accttype"),
                    certid:$(this).attr("certid")
                },
                success:function (result) {
                },
                error:function () {
                    alert("request fail");
                }
            });
        }
    });

</script>
<script src="${APP_PATH}/script/changeRedForTabs.js"></script>
</body>
</html>


