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
           <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 许可维护</a></div>
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
            $(function () {


            });


            var setting={

                view: {
                    selectedMulti: false,
                    //addDiyDom可以给树状图添加图标。代码写法固定。
                    addDiyDom: function(treeId, treeNode){
                        var icoObj = $("#" + treeNode.tId + "_ico"); // tId = permissionTree_1, $("#permissionTree_1_ico")
                        if ( treeNode.icon ) { //如果icon存在
                            icoObj.removeClass("button ico_docu ico_open").addClass(treeNode.icon).css("background","");
                        }
                    },
                    addHoverDom: function(treeId, treeNode){
                        var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
                        aObj.attr("href", "javascript:;");
                        if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
                        var s = '<span id="btnGroup'+treeNode.tId+'">';
                        if ( treeNode.level == 0 ) {
                            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="${APP_PATH}/permission/add.htm?pid='+treeNode.id+'" title="添加权限">&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                        } else {
                            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="${APP_PATH}/permission/edit.htm?id='+treeNode.id+'" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                            if (treeNode.children.length>0){
                                s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" onclick="deleteNode('+treeNode.id+',\''+treeNode.name+'\')" title="删除所有权限">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                            }
                            if (treeNode.children.length == 0) {
                                s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" onclick="deletePermission('+treeNode.id+',\''+treeNode.name+'\')" title="删除权限">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                            }
                            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="${APP_PATH}/permission/add.htm?pid='+treeNode.id+'" title="添加权限">&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                        }
                        s += '</span>';
                        aObj.after(s);
                    },
                    removeHoverDom: function(treeId, treeNode){
                        $("#btnGroup"+treeNode.tId).remove();
                    }
                },
                //如果要实现节点的异步删除，则要添加async属性
                async: {
                    enable: true,
                    url:"${APP_PATH}/permission/loadAJAXData.do",
                    autoParam:["id", "name=n", "level=lv"]
                },
                callback: {
                    onClick : function(event, treeId, json) {

                    }
                }
            };
            /*//构造静态的树状目录
            var zNodes =[
                { name:"父节点1 - 展开", open:true,
                    children: [
                        { name:"父节点11 - 折叠",
                            children: [
                                { name:"叶子节点111"},
                                { name:"叶子节点112"},
                                { name:"叶子节点113"},
                                { name:"叶子节点114"}
                            ]},
                        { name:"父节点12 - 折叠",
                            children: [
                                { name:"叶子节点121"},
                                { name:"叶子节点122"},
                                { name:"叶子节点123"},
                                { name:"叶子节点124"}
                            ]},
                        { name:"父节点13 - 没有子节点", isParent:true}
                    ]},
                { name:"父节点2 - 折叠",
                    children: [
                        { name:"父节点21 - 展开", open:true,
                            children: [
                                { name:"叶子节点211"},
                                { name:"叶子节点212"},
                                { name:"叶子节点213"},
                                { name:"叶子节点214"}
                            ]},
                        { name:"父节点22 - 折叠",
                            children: [
                                { name:"叶子节点221"},
                                { name:"叶子节点222"},
                                { name:"叶子节点223"},
                                { name:"叶子节点224"}
                            ]},
                        { name:"父节点23 - 折叠",
                            children: [
                                { name:"叶子节点231"},
                                { name:"叶子节点232"},
                                { name:"叶子节点233"},
                                { name:"叶子节点234"}
                            ]}
                    ]},
                { name:"父节点3 - 没有子节点", isParent:true},
                { name:"父节点4 - 没有子节点", isParent:true},
                { name:"父节点5 - 没有子节点", isParent:true},

            ];*/

            //第一个属性是zTree的ul容器。不用传入树形结构，但是后台传来的对象必须是一个List: 格式[]，
            //而不是一个被封装为Object类型的List: 格式{[]}
            $.fn.zTree.init($("#permissionTree"),setting);

            <%--$.ajax({--%>
				<%--type:"POST",--%>
				<%--url:"${APP_PATH}/permission/loadData.do",--%>
				<%--success: function(result){--%>
				    <%--//已经准备好了result.data: 一个被封装为Object类型的List: 格式{[]},所以此时为同步查询，异步删除节点时会出错。--%>
                    <%--$.fn.zTree.init($("#permissionTree"),setting,result.data);--%>
                <%--}--%>
			<%--});--%>

            function deletePermission(id, name) {
                layer.confirm("确定要删除"+name+"吗？", {icon: 3, title: '提示'},function (cIndex) {
                    var loadingIndex=-1;
                    $.ajax({
                        type:"POST",
                        url:"${APP_PATH}/permission/delete.do",
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
                                var treeObj = $.fn.zTree.getZTreeObj("permissionTree");
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
                        url:"${APP_PATH}/permission/deleteNode.do",
                        dataType:"json",
                        data:{
                            id:id
                        },
                        success:function (result) {
                            layer.msg("删除成功",{time:1000});
                            //以下两行代码是异步刷新zTree的固定代码，getZTreeObj的入参是zTree的ul标签容器的id
                            var treeObj = $.fn.zTree.getZTreeObj("permissionTree");
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
