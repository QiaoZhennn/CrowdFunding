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
            cursor:pointer;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 数据字典</a></div>
        </div>
        <%@include file="/WEB-INF/jsp/manager/include/topNavBar.jsp"%>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <%@include file="/WEB-INF/jsp/manager/include/leftSlideBar.jsp"%>

        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

            <div class="panel panel-default">
                <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 权限菜单列表 <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <%--这个ul标签是zTree的容器--%>
                    <ul id="dictionaryTree" class="ztree"></ul>
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

    var setting={

        view: {
            selectedMulti: false,
            //addDiyDom可以给树状图添加图标。代码写法固定。
            addDiyDom: function(treeId, treeNode){
                var icoObj = $("#" + treeNode.tId + "_ico");
                if ( treeNode.icon ) { //如果icon存在
                    icoObj.removeClass("button ico_docu ico_open").addClass(treeNode.icon).css("background","");
                }
            },
            addHoverDom: function(treeId, treeNode){
                var aObj = $("#" + treeNode.tId + "_a");
                aObj.attr("href", "javascript:;");
                if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
                var s = '<span id="btnGroup'+treeNode.tId+'">';
                if ( treeNode.level == 0 ) {
                    s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="${APP_PATH}/dictionary/add.htm?pid='+treeNode.id+'" title="添加字典">&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                } else {
                    s += '<span class="text text-info text-xs" style="margin-left:10px;padding-top:0px;">value:'+(treeNode.val||"无")+'</span>';
                    s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="${APP_PATH}/dictionary/edit.htm?id='+treeNode.id+'" title="修改字典信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                    if (treeNode.children.length>0){
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" onclick="deleteNode('+treeNode.id+',\''+treeNode.name+'\')" title="删除所有字典">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                    }
                    if (treeNode.children.length == 0) {
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" onclick="deletePermission('+treeNode.id+',\''+treeNode.name+'\')" title="删除字典">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                    }
                    s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="${APP_PATH}/dictionary/add.htm?pid='+treeNode.id+'" title="添加字典">&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                }
                s += '</span>';
                aObj.after(s);
            },
            removeHoverDom: function(treeId, treeNode){
                $("#btnGroup"+treeNode.tId).remove();
            }
        },
        //如果要实现节点的异步加载，从而实现异步删除，则要添加async属性
        async: {
            enable: true,
            url:"${APP_PATH}/dictionary/loadAJAXData.do",
            autoParam:["id", "name=n", "level=lv"]
        },
        callback: {
            onClick : function(event, treeId, json) {

            }
        }
    };

    //第一个属性是zTree的ul容器。
    $.fn.zTree.init($("#dictionaryTree"),setting);

    /*$.ajax({
    type:"POST",
    url:"/dictionary/loadAJAXData.do",
    success: function(result){
    //已经准备好了result.data,所以此时为同步查询，异步删除节点时会出错。
    $.fn.zTree.init($("#dictionaryTree"),setting,result.data);
    }
    });*/


    function deletePermission(id, name) {
        layer.confirm("确定要删除"+name+"吗？", {icon: 3, title: '提示'},function (cIndex) {
            var loadingIndex=-1;
            $.ajax({
                type:"POST",
                url:"${APP_PATH}/dictionary/delete.do",
                jsonType:"json",
                data:{
                    id:id
                },
                beforeSend:function () {
                    loadingIndex=layer.load(1)
                },
                success:function (result) {
                    if(result.success){
                        layer.close(loadingIndex);
                        layer.msg("删除成功",{time:1000});
                        //以下两行代码是异步刷新zTree的固定代码，getZTreeObj的入参是zTree的ul标签容器的id
                        var treeObj = $.fn.zTree.getZTreeObj("dictionaryTree");
                        treeObj.reAsyncChildNodes(null, "refresh");
                    }else {
                        layer.close(loadingIndex);
                        layer.msg("删除失败",{time:1000})
                    }
                },
                error:function () {
                    layer.close(loadingIndex)
                    layer.msg("请求失败",{time:1000})
                }
            });
        },function (cIndex) {

        });
    }

    function deleteNode(id, name) {
        layer.confirm("Do you want to delete "+name+"?",{icon: 3, title: '提示'},function (cIndex) {
            $.ajax({
                type:"POST",
                url:"${APP_PATH}/dictionary/deleteNode.do",
                dataType:"json",
                data:{
                    id:id
                },
                success:function (result) {
                    layer.msg("删除成功",{time:1000});
                    //以下两行代码是异步刷新zTree的固定代码，getZTreeObj的入参是zTree的ul标签容器的id
                    var treeObj = $.fn.zTree.getZTreeObj("dictionaryTree");
                    treeObj.reAsyncChildNodes(null, "refresh");
                },
                error:function () {
                    layer.msg("Request fails",{time:500})
                }
            });
        })
    }
</script>
</body>
</html>
