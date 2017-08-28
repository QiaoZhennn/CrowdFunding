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
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 资质管理</a></div>
        </div>
        <jsp:include page="${APP_PATH}/WEB-INF/jsp/manager/include/topNavBar.jsp"/>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <jsp:include page="${APP_PATH}/WEB-INF/jsp/manager/include/leftSlideBar.jsp"/>
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
                                <input class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询
                        </button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i
                            class=" glyphicon glyphicon-remove"></i> 删除
                    </button>
                    <button type="button" class="btn btn-primary" style="float:right;"
                            onclick="window.location.href='${APP_PATH}/cert/add.htm'"><i class="glyphicon glyphicon-plus"></i> 新增
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

    });

    var loadingIndex=-1;
    $.ajax({
        url:"${APP_PATH}/cert/listAll.do",
        type:"POST",
        dataType:"json",
        beforeSend:function () {
            loadingIndex=layer.load(1);
        },
        success:function (result) {
            layer.close(loadingIndex);
            if(result.success){
                var certs=result.data;
                var dataContect='';
                $.each(certs,function (i, cert) {
                    dataContect+='<tr>';
                    dataContect+='    <td>'+(i+1)+'</td>';
                    dataContect+='    <td><input type="checkbox"></td>';
                    dataContect+='    <td>'+cert.name+'</td>';
                    dataContect+='    <td>';
                    dataContect+='    <button type="button" onclick="updateCert('+cert.id+')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                    dataContect+='    <button type="button" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                    dataContect+='    </td>';
                    dataContect+='</tr> ';
                });
                $("tbody").html(dataContect);
            }else {
                layer.msg("获取数据失败",{time:1500});
            }
        },
        error:function () {
            layer.msg("请求失败",{time:1500});
        }
    });

    function updateCert(certId) {
        window.location.href="${APP_PATH}/cert/update.htm?id="+certId;
    }
</script>
<script src="${APP_PATH}/script/changeRedForTabs.js"></script>
</body>
</html>
