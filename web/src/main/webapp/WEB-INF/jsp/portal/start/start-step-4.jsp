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
        #topcontrol {
            color: #fff;
            z-index: 99;
            width: 30px;
            height: 30px;
            font-size: 20px;
            background: #222;
            position: relative;
            right: 14px !important;
            bottom: 11px !important;
            border-radius: 3px !important;
        }

        #topcontrol:after {
            /*top: -2px;*/
            left: 8.5px;
            content: "\f106";
            position: absolute;
            text-align: center;
            font-family: FontAwesome;
        }

        #topcontrol:hover {
            color: #fff;
            background: #18ba9b;
            -webkit-transition: all 0.3s ease-in-out;
            -moz-transition: all 0.3s ease-in-out;
            -o-transition: all 0.3s ease-in-out;
            transition: all 0.3s ease-in-out;
        }

        .label-type, .label-status, .label-order {
            background-color: #fff;
            color: #f60;
            padding : 5px;
            border: 1px #f60 solid;
        }
        #typeList  :not(:first-child) {
            margin-top:20px;
        }
        .label-txt {
            margin:10px 10px;
            border:1px solid #ddd;
            padding : 4px;
            font-size:14px;
        }
        .panel {
            border-radius:0;
        }

        .progress-bar-default {
            background-color: #ddd;
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/jsp/portal/include/topNavBar.jsp"%>


<div class="container theme-showcase" role="main">

    <div class="container">
        <div class="row clearfix">
            <div class="col-md-12 column">
                <nav class="navbar navbar-default" role="navigation">
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav">
                            <li>
                                <a rel="nofollow" href="${APP_PATH}/index.htm"><i class="glyphicon glyphicon-home"></i> 众筹首页</a>
                            </li>
                            <li >
                                <a rel="nofollow" href="${APP_PATH}/projects/index.htm"><i class="glyphicon glyphicon-th-large"></i> 项目总览</a>
                            </li>
                            <li class="active">
                                <a rel="nofollow" href="javascript:;"><i class="glyphicon glyphicon-edit"></i> 发起项目</a>
                            </li>
                            <li>
                                <a rel="nofollow" href="${APP_PATH}/member/minecrowdfunding.htm"><i class="glyphicon glyphicon-user"></i> 我的众筹</a>
                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
    </div>


    <div class="container">
        <div class="row clearfix">
            <div class="col-md-12 column">
                <div class="panel panel-default" >
                    <div class="panel-heading" style="text-align:center;">
                        <div class="container-fluid">
                            <div class="row clearfix">
                                <div class="col-md-3 column">
                                    <div class="progress" style="height:50px;border-radius:0;    position: absolute;width: 75%;right:49px;">
                                        <div class="progress-bar progress-bar-default" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;height:50px;">
                                            <div style="font-size:16px;margin-top:15px;">1. 项目及发起人信息</div>
                                        </div>
                                    </div>
                                    <div style="right: 0;border:10px solid #ddd;border-left-color: #88b7d5;border-width: 25px;position: absolute;
                                             border-left-color: rgba(221, 221, 221, 1);
                                             border-top-color: rgba(221, 221, 221, 0);
                                             border-bottom-color: rgba(221, 221, 221, 0);
                                             border-right-color: rgba(221, 221, 221, 0);
                                        ">
                                    </div>
                                </div>
                                <div class="col-md-3 column">
                                    <div class="progress" style="height:50px;border-radius:0;position: absolute;width: 75%;right:49px;">
                                        <div class="progress-bar progress-bar-default" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;height:50px;">
                                            <div style="font-size:16px;margin-top:15px;">2. 回报设置</div>
                                        </div>
                                    </div>
                                    <div style="right: 0;border:10px solid #ddd;border-left-color: #88b7d5;border-width: 25px;position: absolute;
                                             border-left-color: rgba(221, 221, 221, 1);
                                             border-top-color: rgba(221, 221, 221, 0);
                                             border-bottom-color: rgba(221, 221, 221, 0);
                                             border-right-color: rgba(221, 221, 221, 0);
                                        ">
                                    </div>
                                </div>
                                <div class="col-md-3 column">
                                    <div class="progress" style="height:50px;border-radius:0;position: absolute;width: 75%;right:49px;">
                                        <div class="progress-bar progress-bar-default" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;height:50px;">
                                            <div style="font-size:16px;margin-top:15px;">3. 确认信息</div>
                                        </div>
                                    </div>
                                    <div style="right: 0;border:10px solid #ddd;border-left-color: #88b7d5;border-width: 25px;position: absolute;
                                              border-left-color: rgba(221, 221, 221, 1);
                                             border-top-color: rgba(221, 221, 221, 0);
                                             border-bottom-color: rgba(221, 221, 221, 0);
                                             border-right-color: rgba(221, 221, 221, 0);
                                        ">
                                    </div>
                                </div>
                                <div class="col-md-3 column">
                                    <div class="progress" style="height:50px;border-radius:0;">
                                        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%;height:50px;">
                                            <div style="font-size:16px;margin-top:15px;">4. 完成</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">

                        <div class="container-fluid">
                            <div class="row clearfix">
                                <div class="col-md-12 column">
                                    <blockquote style="border-left: 5px solid #f60;color:#f60;padding: 0 0 0 20px;">
                                        <b>
                                            完成
                                        </b>
                                    </blockquote>
                                </div>
                                <div class="col-md-12 column">


                                    <div class="row clearfix">
                                        <div class="col-md-12 column">
                                            <div class="panel panel-default">
                                                <div class="panel-body" style="padding:60px;">
                                                    <i class="glyphicon glyphicon-ok" style="color:green;font-size:40px;"></i> <span style="margin-left:20px;">你发起的众筹项目信息已经提交完毕，我们会在5~7个工作日内对项目进行审核，请耐心等候</span>
                                                    <p style="margin-left:60px;">你能在会员中心-我的众筹- 发起的项目中查看</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer" style="text-align:center;">
                        <button type="button" class="btn  btn-warning btn-lg" onclick="window.location.href='${APP_PATH}/member/minecrowdfunding.htm'">我的众筹</button>
                    </div>
                </div>
            </div>
        </div>
    </div>


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

</div> <!-- /container -->
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/script/back-to-top.js"></script>
<script>
    $('#myTab a').click(function (e) {
        e.preventDefault()
        $(this).tab('show')
    })
</script>
</body>
</html>
