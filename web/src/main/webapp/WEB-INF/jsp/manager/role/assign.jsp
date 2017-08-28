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
    <link rel="stylesheet" href="${APP_PATH}/css/doc.min.css">
    <link rel="stylesheet" href="${APP_PATH}/ztree/zTreeStyle.css">
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
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 许可维护</a></div>
        </div>
        <%@include file="/WEB-INF/jsp/manager/include/topNavBar.jsp" %>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <%@include file="/WEB-INF/jsp/manager/include/leftSlideBar.jsp" %>

        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

            <div class="panel panel-default">
                <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 权限菜单列表
                    <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i
                            class="glyphicon glyphicon-question-sign"></i></div>
                </div>
                <div class="panel-body">
                    <button id="assignButton" type="button" class="btn btn-success"><i
                            class="glyphicon glyphicon-plus"></i> 分配权限
                    </button>
                    <br>
                    <%--这个ul标签是zTree的容器--%>
                    <ul id="permissionTree" class="ztree"></ul>
                </div>
            </div>
        </div>
    </div>
</div>


<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/ztree/jquery.ztree.all-3.5.min.js"></script>
<script src="${APP_PATH}/script/changeRedForTabs.js"></script>
<script src="${APP_PATH}/script/layer/layer.js"></script>
<script type="text/javascript">
    var setting = {
        //setting中添加check属性，即可使页面的树状结构出现复选框。在后台的JavaBean中添加名为“checked”的boolean属性，
        //当checked=true时，前端自动勾选该项
        check: {
            enable: true
        },

        view: {
            selectedMulti: false,
            //addDiyDom可以给树状图添加图标。代码写法固定。
            addDiyDom: function (treeId, treeNode) {
                var icoObj = $("#" + treeNode.tId + "_ico"); // tId = permissionTree_1, $("#permissionTree_1_ico")
                if (treeNode.icon) { //如果icon存在
                    icoObj.removeClass("button ico_docu ico_open").addClass(treeNode.icon).css("background", "");
                }
            }
        },
        //如果要实现节点的异步删除，则要添加async属性
        async: {
            enable: true,
            url: "${APP_PATH}/permission/loadCheckedData.do?roleId="+${param.id},
            //id,name,level等是自动封装成的json对象的属性值。
            autoParam: ["id", "name=n", "level=lv"]
        },
        callback: {
            onClick: function (event, treeId, json) {

            }
        }
    };

    $.fn.zTree.init($("#permissionTree"), setting);

    $("#assignButton").click(function () {
        var treeObj=$.fn.zTree.getZTreeObj("permissionTree");
        //getCheckedNodes的返回值：nodes，是一个json数组。
        var nodes=treeObj.getCheckedNodes(true);
        if(nodes.length==0){
            layer.msg("请选择需要分配的权限",{time:500});
            return;
        }
        var jsonData={"roleId":"${param.id}"};
        $.each(nodes,function (i,n) {
            //n为json数组的元素，n.id的“id”属性是上文autoParam定义的。
            jsonData["ids["+i+"]"]=n.id;
        });

        $.ajax({
            type:"POST",
            url:"${APP_PATH}/role/doAssign.do",
            dataType:"json",
            data:jsonData,
            success:function (result) {
                if(result.success){
                    layer.msg("权限分配成功",{time:500});
                }else{
                    layer.msg("权限分配失败",{time:500});
                }
            },
            error:function () {
                layer.msg("请求失败",{time:500});
            }
        });
    });
</script>
</body>
</html>
