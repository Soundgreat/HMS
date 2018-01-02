<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<!--[if IE 7]><html class="ie ie7 ltie9"><![endif]-->
<!--[if IE 8]><html class="ie ie8 ltie9"><![endif]-->
<!--[if gte IE 9]><html class="ie ie9"><![endif]-->
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="renderer" content="webkit">
    <meta name="description" content="会员登录；简单方便快捷登录酒店官网；提供酒店网上预订。" />
    <meta name="keywords" content="会员登录，简单方便快捷登录，酒店官网，酒店网上预订" />
    <title>欢迎注册</title>
    <style>
        .gt_holder.popup{z-index: 1000;}
        .gt_holder .gt_bottom{background-image:none !important;background-color:#f2ece1;-webkit-border-bottom-left-radius:15px;-webkit-border-bottom-right-radius:15px;-moz-border-radius-bottomleft:15px;-moz-border-radius-bottomright:15px;border-bottom-left-radius:15px;border-bottom-right-radius:15px;}
    </style>
    <link href="css/main.css" rel="stylesheet"/>
</head>
<body>
  

<header class="Mhead slim">
    <div class="inner Cwrap">
        <div class="mbox">
            <div class="content Lcfx Ltar">
                <div class="h3 pagename Lfll Lmt30 Lpl25">会员注册</div><span class="otherlink Ldib Lmt30 Lpr25"><a href="http://www.huazhu.com/AboutHZ">了解更多</a><i>|</i><a href="http://hwj.huazhu.com:8080/HQuestionCRM?qNo=F9C6BC63-B467-4104-B441-D853B576EDC9">反馈意见</a>
            </div>
        </div>
    </div>
</header>
<section class="US_signup">
    <div class="inner Cwrap">
        <div class="mbox Lcfx Lpb30">
            <div class="lbox Lmt30 Lfll">
                <div class="item Lcfx">
                    <span class="label Lfll Lfz14 Ltar"><i>*</i>姓 &nbsp;&nbsp;&nbsp; 名</span>
                    <div class="inputbox signUp_userName Lfll">
                        <input type="text" name="username" placeholder="请填写身份证中的姓名" class="input1" maxlength="25">
                    </div>
                    <div class="tips error Lfll Lfz12 Lpl5 Lpr5"><i class="Cicon small_error">&nbsp;</i><em>请填写您有效证件上的姓名</em></div>
                </div>
                <div class="item Lcfx">
                    <span class="label Lfll Lfz14 Ltar"><i>*</i>身 份 证 号 码</span>
                    <div class="inputbox signUp_userName Lfll">
                        <input type="number" name="idcard" placeholder="请填写身份证号码" class="input1" maxlength="25">
                    </div>
                    <div class="tips error Lfll Lfz12 Lpl5 Lpr5"><i class="Cicon small_error">&nbsp;</i><em>请填写您有效证件上的号码</em></div>
                </div>
                <div class="item Lcfx">
                    <span class="label Lfll Lfz14 Ltar"><i>*</i>手 机 号</span>
                    <div class="inputbox signUp_tel Lfll">
                        <input type="text" name="phone" placeholder="可作为登录名" class="input1" maxlength="11">
                    </div>
                    <div class="tips notice Lfll Lfz12 Lpl5 Lpr5"><i class="Cicon small_notice">&nbsp;</i><em>请填写手机号</em></div>
                </div>
                <div class="item Lcfx">
                    <span class="label Lfll Lfz14 Ltar"><i>*</i>密 &nbsp;&nbsp;&nbsp; 码</span>
                    <div class="inputbox signUp_psw Lfll">
                        <input type="password" name="passwd1" placeholder="6~16个字符，区分大小写" class="input1 notplaceholder" maxlength="18">
                    </div>
                    <div class="tips ok Lfll Lfz12 Lpl5 Lpr5"><i class="Cicon small_ok">&nbsp;</i><em></em></div>
                </div>
                <div class="item Lcfx">
                    <span class="label Lfll Lfz14 Ltar"><i>*</i>确认密码</span>
                    <div class="inputbox signUp_aPsw Lfll">
                        <input type="password" name="passwd2" placeholder="请再次填写密码" class="input1 notplaceholder" maxlength="18">
                    </div>
                    <div class="tips notice Lfll Lfz12 Lpl5 Lpr5"><i class="Cicon small_notice">&nbsp;</i><em>两次填写的密码不一致</em></div>
                </div>             

                <div class="item Lcfx">
                    <span class="label Lfll Lfz14 Ltar">&nbsp;</span>
                    <div class="agree Lpt5 Lfz14">

                    </div>
                </div>
                <div class="item Lcfx">
                    <span class="label Lfll Lfz14 Ltar">&nbsp;</span>
                    <div class="btnbox Lfll">
                        <button type="button" id="signUp_btn" class="Cbtn std_large Ldb">注册</button>
                    </div>
                </div>
            </div>
            <div class="rbox Lflr Lmt30">
                <div class="signin_tips  Lpr30 Lpl30 Lfz12 Lpl5 Lpr5 Lpt20 "><span class="Lfwb">已是会员，</span><a href="login.jsp" class="g_login Lfz14">直接登录</a></div>
            <div  class="union_signin">
                    <p>立即注册，享受我们的卓越礼遇</p>
                    <div class="cooper Lmt40 Lpt10 Lpr30 Lpl30 Lfz14 ">
                    	<img  src="images/memberHZ-01.png">
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
<script src="js/register.js"></script>
</body>
</html>