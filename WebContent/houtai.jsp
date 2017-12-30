<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <title> 酒店后台管理系统</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min2.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style2.css" rel="stylesheet">
</head>
<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
<input style="display: none" id="usersession" value="1">
<input style="display: none" id="dlsession" value="">
    <div id="wrapper">
		<nav class="navbar-default navbar-static-side" role="navigation">
            <div class="nav-close"><i class="fa fa-times-circle"></i>
            </div>
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li class="nav-header">
                        <div class="dropdown profile-element">
                            <a data-toggle="dropdown" class="dropdown-toggle" href="welcome.jsp">
                                <span class="clear">
                                    <span class="block m-t-xs" style="font-size:20px;">
                                        
                                        <strong class="font-bold">酒店管理系统</strong>
                                    </span>
                                </span>
                            </a>
                        </div>
                        <div class="logo-element">
                     	   后台	
                        </div>
                    </li>
                    <li>
                        <a class="J_menuItem" href="welcome.jsp">
                            <i class="fa fa-home"></i>
                            <span class="nav-label">主页</span>
                        </a>
                    </li>
                    
                    <li class="hidden-folded padder m-t m-b-sm text-muted text-xs">
                        <span class="ng-scope">前台管理</span>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fa fa-group"></i>
                            <span class="nav-label">预定入住</span>
                            <span class="fa arrow"></span>
                        </a>
                        <ul class="nav nav-second-level">
                       		<li>
                                <a class="J_menuItem" href="">订单查询</a>
                            </li>
                            <li>
                                <a class="J_menuItem" href="">分配房间</a>
                            </li>
                      		
                        </ul>
                   	 </li>
                   	  <li>
                        <a href="#">
                            <i class="fa fa-group"></i>
                            <span class="nav-label">退房管理</span>
                            <span class="fa arrow"></span>
                        </a>
                        <ul class="nav nav-second-level">
                       		<li>
                                <a class="J_menuItem" href="">结账</a>
                            </li>
                            <li>
                                <a class="J_menuItem" href="">退房</a>
                            </li>
                      		
                        </ul>
                   	 </li>
                    <li class="line dk"></li>
                    <li class="hidden-folded padder m-t m-b-sm text-muted text-xs">
                        <span class="ng-scope">客房管理</span>
                    </li>
                    <li>
                    <li>
                        <a href="#">
                        	<i class="fa fa-calendar"></i>
                            <span class="nav-label">可用房查询</span>
                            <span class="fa arrow"></span>
                        </a>
                        <ul class="nav nav-second-level">
                    		<li>
                            	<a class="J_menuItem" href="">可用房查询</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                    	<a href="">
                        	<i class="fa fa-pencil-square-o"></i>
                            <span class="nav-label">房态统计</span>
                            <span class="fa arrow"></span>
                        </a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a class="J_menuItem" href="">房态统计</a>
                            </li>
                        </ul>
                    </li>
                    <li class="line dk"></li>
                    <li class="hidden-folded padder m-t m-b-sm text-muted text-xs">
                        <span class="ng-scope">信息管理</span>
                    <li>
                        <a href="">
                        	<i class="fa fa-cogs"></i>
                            <span class="nav-label">客房设置</span>
                            <span class="fa arrow"></span>
                        </a>
                        <ul class="nav nav-second-level">
                             <li>
                            	<a class="J_menuItem" href="manager-setroomtype.jsp">客房类型设置</a>
                                <a class="J_menuItem" href="manager-setroominfo.jsp">客房信息设置</a>
                            </li>
                        </ul>
                    </li>
                 	 <li>
                        <a href="">
                        	<i class="fa fa-cogs"></i>
                            <span class="nav-label">账户设置</span>
                            <span class="fa arrow"></span>
                        </a>
                        <ul class="nav nav-second-level">
                             <li>
                            	<a class="J_menuItem" href="manager-addstaff.jsp">添加员工</a>
                            	<a class="J_menuItem" href="manager-removestaff.jsp">移除员工</a>
                            	<a class="J_menuItem" href="manager-logoutuser.jsp">注销用户</a>
                            </li>
                        </ul>
                    </li>
                   
                    <li class="line dk"></li>
                    <li>&nbsp;&nbsp;</li>
                    <li>&nbsp;&nbsp;</li>
                    <li>&nbsp;&nbsp;</li>
                    <li>&nbsp;&nbsp;</li>
                    <li>&nbsp;&nbsp;</li>
                    <li>&nbsp;&nbsp;</li>
                </ul>
            </div>
        </nav>

        <div id="page-wrapper" class="gray-bg dashbard-1">
            <div class="row border-bottom">
                <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                    <div class="navbar-header"><a class="navbar-minimalize minimalize-styl-2 btn btn-info " href="#"
                    <i class="icon-bar"></i>></a>
                    </div>
                    
                    <ul class="nav navbar-top-links navbar-right">
                    	  
                        	  <li class="dropdown">
                           		 <a class="dropdown-toggle count-info" data-toggle="" href="login.jsp" title="退出">
                            	  注销  <i class="fa fa-power-off"></i> <span class="label label-warning"></span>
                           		 </a>
                            	<ul class="dropdown-menu dropdown-messages" style="width: 100px;padding: 0px;">
                            	</ul>
                        	</li>
                       	 
                      	  
                    </ul>
                </nav>
            </div>
            <div class="row J_mainContent" id="content-main">
                <iframe id="J_iframe" width="100%" height="100%" src="welcome.jsp" frameborder="0" data-id="houtai.jsp" seamless></iframe>
            </div>
        </div>
        <!--右侧部分结束-->
    </div>

    <!-- 全局js -->
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.metisMenu.js"></script>
    <script src="js/jquery.slimscroll.min.js"></script>
    <script src="js/layer.min.js"></script>

    <!-- 自定义js -->
    <script src="js/hAdmin.js?v=4.1.0"></script>
    <script type="text/javascript" src="js/index.js"></script>
	<script type="text/javascript">
    	$(document).ready(function(){
    		var usersession=$("#usersession").val();
    		var dlsession=$("#dlsession").val();
			if(usersession==null|dlsession==null){
				window.location.href="login.jsp";
    		}
    	});
    </script>
    <!-- 第三方插件 -->
    <script src="js/plugins/pace/pace.min.js"></script>
	
</body>

</html>
