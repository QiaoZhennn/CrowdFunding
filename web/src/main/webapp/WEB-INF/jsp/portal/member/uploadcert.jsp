<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="GB18030">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/theme.css">
    <style>
        #footer {
            padding: 15px 0;
            background: #fff;
            border-top: 1px solid #ddd;
            text-align: center;
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/jsp/portal/include/topNavBar.jsp"%>


<div class="container theme-showcase" role="main">
    <div class="page-header">
        <h1>实名认证 - 申请</h1>
    </div>

    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" ><a href="#"><span class="badge">1</span> 基本信息</a></li>
        <li role="presentation" class="active"><a href="#"><span class="badge">2</span> 资质文件上传</a></li>
        <li role="presentation"><a href="#"><span class="badge">3</span> 邮箱确认</a></li>
        <li role="presentation"><a href="#"><span class="badge">4</span> 申请确认</a></li>
    </ul>

    <form id="uploadForm" role="form" style="margin-top:20px;" method="post" enctype="multipart/form-data"
          action="${APP_PATH}/member/uploadCerts.do">
        <c:forEach items="${certs}" var="cert" varStatus="status">
            <div class="form-group">
                <!--memberCerts是数据封装类BatchData的一个List型的属性。memberCerts[i].certid可以将前端输入的值自动封装到BatchData的对应List型属性中-->
                <input type="hidden" name="memberCerts[${status.index}].certid" value="${cert.id}">
                <label for="certImgFile">${cert.name}</label>
                <input type="file" class="form-control" id="certImgFile" name="memberCerts[${status.index}].certImgFile">

                <img style="display: none; height: 300px;" src="">
            </div>
        </c:forEach>

        <button type="button" class="btn btn-default">上一步</button>
        <button type="button" id="nextBtn" class="btn btn-success">下一步</button>
    </form>
    <hr>
</div> <!-- /container -->
<div class="container" style="margin-top:20px;">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <div id="footer">
                <div class="footerNav">
                    <a rel="nofollow" href="http://www.atguigu.com">关于我们</a> | <a rel="nofollow" href="http://www.atguigu.com">服务条款</a> | <a rel="nofollow" href="http://www.atguigu.com">免责声明</a> | <a rel="nofollow" href="http://www.atguigu.com">网站地图</a> | <a rel="nofollow" href="http://www.atguigu.com">联系我们</a>
                </div>
                <div class="copyRight">
                    Copyright ?2017-2017 atguigu.com 版权所有
                </div>
            </div>

        </div>
    </div>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/jquery/jquery-form.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/script/layer/layer.js"></script>


<script>
    $('#myTab a').click(function (e) {
        e.preventDefault()
        $(this).tab('show')
    });

    //文件上传与显示图片预览
    $(":file").change(function (event) {
        //获取当前选择的文件 event.target.files
        var files=event.target.files;
        var file;
        if(files && files.length>0){
            file=files[0];
            var URL=window.URL || window.webkitURL;
            var imgURL=URL.createObjectURL(file);
            var imgObj=$(this).next();
            imgObj.attr("src",imgURL);
            imgObj.show();
        }
    });

    $("#nextBtn").click(function () {
        $("#uploadForm").ajaxSubmit({
            beforeSubmit: function () {
                loadingIndex = layer.load(1);
            },
            success: function (result) {
                if (result.success) {
                    layer.close(loadingIndex);
                    window.location.href = "${APP_PATH}/member/apply.htm";
                    layer.msg("上传成功", {time: 500});
                } else {
                    layer.close(loadingIndex);
                    layer.msg("上传失败", {time: 500});
                }
            },
            timeout: 3000,
            error:function () {
                layer.close(loadingIndex);
                layer.msg("请求失败", {time: 500});
            }
        });
    });
</script>
</body>
</html>

