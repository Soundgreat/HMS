<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>登录;会员登录| 酒店管理系统</title>
    <link href="css/nav.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <link href="css/main.css" rel="stylesheet"/>
	<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<header class="Mhead slim">
    <div class="inner Cwrap">
        <div class="mbox">
            <div class="content Lcfx Ltar">
                <div class="h3 pagename Lfll Lmt30 Lpl25">会员登录</div><span class="otherlink Ldib Lmt30 Lpr25"><a href="http://www.huazhu.com/AboutHZ">了解更多</a><i>|</i><a href="http://hwj.huazhu.com:8080/HQuestionCRM?qNo=F9C6BC63-B467-4104-B441-D853B576EDC9">反馈意见</a>
            </div>
        </div>
    </div>
</header>
<section class="US_signup">
    <div class="inner Cwrap">
        <div class="mbox Lcfx Lpb30">
        <div style="margin-left:96%"><a href="hotelMain.jsp" >返回首页</a></div>
            <div class="lbox Lmt30 Lfll" style="width:440px">
<ul id="myTab" class="nav nav-tabs">
			<li class="active">
				<a href="#private" data-toggle="tab"> 个人登录</a>
			</li>
			<li>
				<a href="#company" data-toggle="tab">公司卡号登录</a>
			</li>
		</ul>                
		<div id="myTabContent" class="tab-content">
			<div class="tab-pane fade in active" id="private">
				<div class="">
					<div class="">
                        	<br/>
                            <i class="">&nbsp;</i>用户名：
                            <input name="username" type="text" placeholder="会员手机号/邮箱" class="input1" maxlength="20">
                            <br/><br/> <br/>        
                    </div>
                        <div class="">
                            <i class="">&nbsp;</i>密　码：
                                <input type="password" placeholder="请输入密码"  class="input1" maxlength="20">
                        </div> 
                 </div>
                    <br/><br/>
                     <div class="item Lcfx container">
                    
                    <div class="btnbox Lfll">
                        <button type="button" id="signUp_btn" class="Cbtn std_large ">登录</button>
                    </div>
                </div>
                    <br/>
                    <div class="">
                        <span class="Lfll">享更多特权，</span>
                        <a href="register.jsp" class="Lfll">立即注册</a>
                        <a href="#" class="Lflr">忘记密码？</a>
                    </div>
            </div>
            <div class="tab-pane fade" id="company">
            	<div class="">
            		<br/>
            		<span class=""><i class="">&nbsp;</i>用户名：</span>
                            <input type="text" placeholder="公司卡号" class="input1" maxlength="20">
                 </div>
                 	<br/><br/>
                    <div class="">
                        <span class=""><i class="">&nbsp;</i>密　码：</span>
                            <input type="password" placeholder="请输入密码" class="input1" maxlength="20" autocomplete="off">
                    </div>
                    <br/><br/>
                     <div class="item Lcfx container">
                    
                    <div class="btnbox Lfll">
                        <button type="button" id="signUp_btn" class="Cbtn std_large ">登录</button>
                    </div>
                </div>
                    <br/>
                    <div class=""><span class="Lfll">享更多特权，</span><a href="register.jsp" class="Lfll">公司卡注册</a><a href="#" class="Lflr">忘记密码？</a>
                    </div>
	</div>
</div>                
</div>
<div class=" Lflr " style="min-height:280px;margin-top: 10px;margin-right: 20%;">
            <div  class="union_signin">
                    <p>立即登录，享受我们的卓越礼遇</p>
                    <div class="cooper Lmt40 Lpt10 Lpr30 Lpl30 Lfz14 ">
                    	<img  src="images/login.png">
                    </div>    
        	</div>
    </div>
    </div>
</section>
<div class="J-popupsGreen">
    <i class="lay-wrap"></i>
</div>
<div class="J-popups">
    <i class="lay-wrap"></i>
    <div class="popus-cont">
        <a href="javascript:;" class="close"></a>
        <div class="c-cont">
            <p><em class="error_img"></em><span class="error_intro">系统错误，请稍后哦～</span></p>
        </div>
    </div>
</div>

<!-- 弹出极验验证 -->
<div id="popup-captcha"></div>
    <div class="Mfoot">
        <div class="inner Lpb25 Lpt25">
            <div class="links Ltac">
                <a href="http://www.huazhu.com/MemberHkh">酒店介绍</a>
                <a href="http://www.huazhu.com/Affiliate">酒店加盟</a>
                <a href="http://huazhu.zhiye.com/home/">职位招聘</a>
                <a href="http://hwj.huazhu.com:8080/HQuestionCRM?qNo=F9C6BC63-B467-4104-B441-D853B576EDC9">意见反馈</a>
                <a href="http://www.huazhu.com/AboutHZ?type=concat">联系我们</a>
            </div>
        </div>
    </div>
<div id="scriptArea" data-page-id="home/signup">
    <!-- 引入封装了failback的接口--initGeetest -->
    
        <script type="text/javascript" src="https://static.geetest.com/static/tools/gt.js"></script>
    <script type="text/javascript" data-track-script="true" src="https://wshantinghotels.huazhu.com/wa/site/huazhu_track.js"></script>
    <script src="https://ws-staticresource.huazhu.com/passportStatic/content/js/library.js"></script>
    <script src="/content/js/gtcode.js"></script>
<script src="/Scripts/tLt3hVNpbTQQ82j5crQP2KAIPGbFg7fV8ekI6U4jGwDzH9ezCF017XqAAaFRVk85PWuTuQakng967m0GDc237FNbQB77EED7n7Bv=1.2.6137.17955"></script>
    <!--[if lte IE 9]><script src="/Content/js/jquery.placeholder.min.js"></script>
        <script>$('input:not(".notplaceholder"), textarea').placeholder();</script><![endif]-->
</div>
<!-- 头部背景 -->

<script src="js/login.js"></script>         
</body>
</html>