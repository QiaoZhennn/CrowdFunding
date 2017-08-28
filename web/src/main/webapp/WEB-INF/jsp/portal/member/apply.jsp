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
    <link rel="stylesheet" href="${APP_PATH}/css/theme.css">
    <style>
        #footer {
            padding: 15px 0;
            background: #fff;
            border-top: 1px solid #ddd;
            text-align: center;
        }
        .seltype {
            position: absolute;
            margin-top: 70px;
            margin-left: 10px;
            color: red;
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/jsp/portal/include/topNavBar.jsp"%>

<div class="container theme-showcase" role="main">

    <div class="page-header">
        <h1>实名认证 - 账户类型选择</h1>
    </div>
    <div style="padding-top:10px;">
        <div class="row">
            <div class="col-xs-6 col-md-3">
                <h2>商业公司</h2>
                <a accttype="0" href="#" class="thumbnail">
                    <img alt="100%x180" src="img/services-box1.jpg" data-holder-rendered="true" style="height: 180px; width: 100%; display: block;">
                </a>
            </div>
            <div class="col-xs-6 col-md-3">
                <h2>个体工商户</h2>
                <a accttype="1" href="#" class="thumbnail">
                    <img alt="100%x180" src="img/services-box2.jpg" data-holder-rendered="true" style="height: 180px; width: 100%; display: block;">
                </a>
            </div>
            <div class="col-xs-6 col-md-3">
                <h2>个人经营</h2>
                <a accttype="2" href="#" class="thumbnail">
                    <img alt="100%x180" src="img/services-box3.jpg" data-holder-rendered="true" style="height: 180px; width: 100%; display: block;">
                </a>
            </div>
            <div class="col-xs-6 col-md-3">
                <h2>政府及非营利组织</h2>
                <a accttype="3" href="#" class="thumbnail">
                    <img alt="100%x180" src="img/services-box4.jpg" data-holder-rendered="true" style="height: 180px; width: 100%; display: block;">
                </a>
            </div>
        </div>
        <button type="button" class="btn btn-danger btn-lg btn-block" onclick="updateAccttype()">认证申请</button>
    </div> <!-- /container -->
    <!-- /END THE FEATURETTES -->


    <div class="container" style="margin-top:20px;">
        <div class="row clearfix">
            <div class="col-md-12 column">
                <div id="footer">
                    <div class="footerNav">
                        <a rel="nofollow" href="http://www.atguigu.com">关于我们</a> | <a rel="nofollow" href="http://www.atguigu.com">服务条款</a> | <a rel="nofollow" href="http://www.atguigu.com">免责声明</a> | <a rel="nofollow" href="http://www.atguigu.com">网站地图</a> | <a rel="nofollow" href="http://www.atguigu.com">联系我们</a>
                    </div>
                    <div class="copyRight">
                        Copyright ?2017-2017atguigu.com 版权所有
                    </div>
                </div>

            </div>
        </div>
    </div>
    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
    <script src="${APP_PATH}/script/docs.min.js"></script>
    <script src="${APP_PATH}/script/layer/layer.js"></script>
    <script>
        $(".thumbnail").click(function(){
            $('.seltype').remove();
            $(this).prepend('<div class="glyphicon glyphicon-ok seltype"></div>');

            accttype=$(this).attr("accttype");
        });

        //动态批量更改img的路径
        $("img").each(function () {
            $(this).attr("src","${APP_PATH}/"+$(this).attr("src"));
        });

        var accttype=null;

        function updateAccttype() {
            if(accttype==null){
                layer.msg("请选择账户类型",{time:1000});
                return;
            }
            $.ajax({
                type:"POST",
                url:"${APP_PATH}/member/updateAccttype.do",
                dataType:"json",
                data:{
                    "accttype":accttype
                },
                success:function (result) {
                    if(result.success){
                        layer.msg("提交成功",{time:500});
                        window.location.href="${APP_PATH}/member/apply.htm";
                    }else {
                        layer.msg("提交失败",{time:500});
                    }
                }
            });
        }
    </script>
</div>
</body>
</html>

