<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="X-UA-Compatible" charset="UTF-8">
    <title>酒店管理系统</title>
    <meta name="keywords" content="全季酒店,全季酒店官网,全季酒店预订,全季酒店预定,汉庭全季酒店,全季酒店电话" />
    <meta name="description" content="全季酒店是华住(原汉庭)集团旗下中高端连锁商务酒店品牌。酒店坐落于国内一二线城市的商业中心区域。华住全季酒店官网提供全季酒店预订，酒店信息查询服务。到华住集团全季酒店官网预订全季酒店，享受最经济的价格。" />
    <meta name="renderer" content="webkit">
    <link rel="alternate" media="only screen and (max-width: 640px)" href="http://m.huazhu.com/brand/quanji">
    <link rel="canonical" href="http://www.huazhu.com/quanji" />
    <meta name="applicable-device" content="pc ">
    <link rel="stylesheet" href="css/calendar.css" />
    <link rel="stylesheet" href="css/rili.css" />
    <link href="css/lunbo.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="http://ws-www.hantinghotels.com/hworld/NewWeb/css/main-min.css?v=a835e8355d">
    <script src="http://ws-www.hantinghotels.com/hworld/NewWeb/lib/ndoo/ndoo_prep-min.js"></script>
    <script>ndoo.vars.HZStatic = "http://ws-www.hantinghotels.com/hworld/NewWeb";</script>
 <script src='http://sdk.appadhoc.com/ab.plus.js'></script>
 <script type="text/javascript" src="js/jquery.mintwo.js"></script>
<script type="text/javascript" src="js/date.js"></script>
<script>
	$(function(){
		$('#firstSelect').on('click',function () {
			$('.mask_calendar').show();
		});
		$('.mask_calendar').on('click',function (e) {
			if(e.target.className == "mask_calendar"){
				$('.calendar').slideUp(200);
				$('.mask_calendar').fadeOut(200);
			}
		})
		$('#firstSelect').calendarSwitch({
			selectors : {
				sections : ".calendar"
			},
			index : 4,      //展示的月份个数
			animateFunction : "slideToggle",        //动画效果
			controlDay:true,//知否控制在daysnumber天之内，这个数值的设置前提是总显示天数大于90天
			daysnumber : "90",     //控制天数
			comeColor : "#2EB6A8",       //入住颜色
			outColor : "#2EB6A8",      //离店颜色
			comeoutColor : "#E0F4F2",        //入住和离店之间的颜色
			callback :function(){//回调函数
				$('.mask_calendar').fadeOut(200);
				var startDate = $('#startDate').val();  //入住的天数
				var endDate = $('#endDate').val();      //离店的天数
				var NumDate = $('.NumDate').text();    //共多少晚
				console.log(startDate);
				console.log(endDate);
				console.log(NumDate);
			}  ,   
			comfireBtn:'.comfire'//确定按钮的class或者id
		});
		var b=new Date();
		var ye=b.getFullYear();
		var mo=b.getMonth()+1;
		mo = mo<10?"0"+mo:mo;
		var da=b.getDate();
		da = da<10?"0"+da:da;
		$('#startDate').val(ye+'-'+mo+'-'+da);
		b=new Date(b.getTime()+24*3600*1000);
		var ye=b.getFullYear();
		var mo=b.getMonth()+1;
		mo = mo<10?"0"+mo:mo;
		var da=b.getDate();
		da = da<10?"0"+da:da;
		$('#endDate').val(ye+'-'+mo+'-'+da);
	});
</script>
<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/slider.js"></script>
<script type="text/javascript">
$(function() {
	var bannerSlider = new Slider($('#banner_tabs'), {
		time: 5000,
		delay: 400,
		event: 'hover',
		auto: true,
		mode: 'fade',
		controller: $('#bannerCtrl'),
		activeControllerCls: 'active'
	});
	$('#banner_tabs .flex-prev').click(function() {
		bannerSlider.prev()
	});
	$('#banner_tabs .flex-next').click(function() {
		bannerSlider.next()
	});
})
</script>
</head>
<body>
    <div class="container newIndex">
        <header class="Mheadindex Lposa">
            <div class="bg">
                 <div class="newIndexContainer">
                     <div class="top">
                        <div class="inner Lposr">
                            <div class="useenter">
                                        <span  id="loginBefore">
                                            <a rel="nofollow" href="login.jsp" class="login">登录</a>
                                            <a rel="nofollow" href="#" class="register">注册</a>
                                        </span>
                            </div>
                        </div>
                    </div>
                    <div class="nav">
                        <div class="inner Cwrap Ltac">
                            <nav class="navlinks">
                                <div class="navcont Lposr">
                                    <a href="hotelMain.jsp" class="nav-1 Ldib item">首页</a>
                                    <a href="#" class="nav-2 Ldib item">酒店简介</a>
                                    <a href="#" class="nav-2 Ldib item">房间搜索</a>
                                    <a href="#" class="nav-4 Ldib item">XXX</a>
                                    <a href="searchhotel.jsp" class="active nav-3 Ldib item brandIts">在线预订</a>
                                    <a href="#" class="nav-3 Ldib item">联系我们</a>        
                                </div>
                            </nav>
                        </div>
                    </div>
                 </div>
            </div>
            <div class="bg-second">
                <div class="newIndexContainer">
                    <div class="nav lmt0">
                        <div class="inner Cwrap Ltac">
                            <nav class="navlinks lml0 brand">
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!--首页轮播-->
        <div id="banner_tabs" class="flexslider">
     
	<ul class="slides">
		<li>
			<a title="" target="_blank" href="#">
				<img width="1520" height="482" alt="" style="background-image: url(http://ws-www.hantinghotels.com/hworld/NewWeb/img/brand_quanji.jpg);" src="images/alpha.png">
			</a>
		</li>
		<li>
			<a title="" href="#">
				<img width="1000" height="482" alt="" style="background: url(images/lunbo1.jpg) no-repeat center;" src="images/alpha.png">
			</a>
			<div class="banneltip"></div>
		</li>
		<li>
			<a title="" href="#">
				<img width="1920" height="482" alt="" style="background: url(images/lunbo2.jpg) no-repeat center;" src="images/alpha.png">
			</a>
		</li>
		<li>
			<a title="" href="#">
				<img width="1920" height="482" alt="" style="background: url(images/lunbo3.jpg) no-repeat center;" src="images/alpha.png">
			</a>
		</li>		
	</ul>
	<ul class="flex-direction-nav">
		<li><a class="flex-prev" href="javascript:;">Previous</a></li>
		<li><a class="flex-next" href="javascript:;">Next</a></li>
	</ul>
	<ol id="bannerCtrl" class="flex-control-nav flex-control-paging">
		<li><a>1</a></li>
		<li><a>2</a></li>
		<li><a>3</a></li>
		<li><a>4</a></li>
	</ol>
	
</div>

        <!-- 首页居中搜索框-->
       <!--  <div id="checkinout">
	<div id="firstSelect" style="width:100%;">
		<div class="Date_lr" style="float:left;">
			<P>入住</p>
				<input id="startDate" type="text" value=""style="" readonly>
			</div>
			<div class="Date_lr" style="float:right;">
				<p>离店</p>
				<input id="endDate" type="text" value="" style="" readonly>
							<span style="float:right;"><a id="searchHotel" href="searchhotel.jsp" class=""> 搜索房间</a></span>
			</div>
			<span class="span21">共<span class="NumDate">1</span>晚</span>
		</div>
	</div> --> 
<div class="mask_calendar">
	<div class="calendar"></div>
</div>
      <!-- 酒店介绍-->
    <div class="inner Lposr">
        <div class="box Lcfx Lposa">
            <div class="Lfll Lposr copywrite">
            </div>
            <div data-nblock-id="ui/photoSlider?auto=1&amp;type=zIndex" class="Lflr photo Lposr Lovh">
                <a href="javascript:;" data-step="-1" class="prev Lposa label"></a><a href="javascript:;" data-step="1" class="next Lposa label"></a>
                <ul class="sliders Lposr">
                    <li class="item Lposa active"><img src="http://ws-www.hantinghotels.com/hworld/NewWeb/img/brand_quanji_1.jpg"></li>
                    <li class="item Lposa"><img src="http://ws-www.hantinghotels.com/hworld/NewWeb/img/brand_quanji_2.jpg"></li>
                    <li class="item Lposa"><img src="http://ws-www.hantinghotels.com/hworld/NewWeb/img/brand_quanji_3.jpg"></li>
                    <li class="item Lposa"><img src="http://ws-www.hantinghotels.com/hworld/NewWeb/img/brand_quanji_4.jpg"></li>
                    <li class="item Lposa"><img src="http://ws-www.hantinghotels.com/hworld/NewWeb/img/brand_quanji_5.jpg"></li>
                    <li class="item Lposa"><img src="http://ws-www.hantinghotels.com/hworld/NewWeb/img/brand_quanji_6.jpg"></li>
                </ul>
            </div>
        </div>
    </div>

<div class="quanji Mhotelconcept Cwrap">
    <div class="inner">
        <div class="box">
            <ul class="conceptlist Lcfx">
                <li class="item item-life"><span class="Cicon"><!-- [if gte IE7] ><b class="before"></b><![endif] --></span><span class="tip"><strong>适度生活</strong>行走与生活中的舍得哲学 <br /> 适度 平衡</span></li>
                <li class="item item-nature"><span class="Cicon"><!-- [if gte IE7] ><b class="before"></b><![endif] --></span><span class="tip"><strong>本色 自然</strong>城市中心的竹木系简约空间<br />本色 自然</span></li>
                <li class="item item-free"><span class="Cicon"><!-- [if gte IE7] ><b class="before"></b><![endif] --></span><span class="tip"><strong>自在</strong>我们将旅途的钥匙交还到宾客手中<br />自在，全凭自己</span></li>
            </ul>
        </div>
    </div>
</div>
<div class="quanji Mhotelrecommend">
    <div class="inner Cwrap">
        <p class="title">推荐房间</p>
        <div class="mask"></div>
        <div class="box Lposr">
            <ul class="recommendlist Lcfx Lposr">
                <li class="item Lposr Lfll">
                    <h2 class="hotelname Lposa">
                        <a href="javascript:;">双人房</a>
                        <div class="bg"></div>
                    </h2>
                    <div class="hotelpic"><img data-src="http://ws-www.hantinghotels.com/hworld/NewWeb/img/quanji_tianjin.jpg"></div>
                    <div class="words">
                        <p class="hotelsummary">....................</p>
                        <p class="hoteldetail"><a target="_blank" href="http://hotels.huazhu.com//Hotel/Detail/2003362">查看房间<i class="arrowright"></i></a></p>
                    </div>
                </li>
                <li class="item Lposr Lfll">
                    <h2 class="hotelname Lposa">
                        <a href="javascript:;">家庭套房</a>
                        <div class="bg"></div>
                    </h2>
                    <div class="hotelpic"><img data-src="http://ws-www.hantinghotels.com/hworld/NewWeb/img/quanji_beijingtiantan.jpg"></div>
                    <div class="words">
                        <p class="hotelsummary">.............</p>
                        <p class="hoteldetail"><a target="_blank" href="http://hotels.huazhu.com//Hotel/Detail/1000051">查看房间<i class="arrowright"></i></a></p>
                    </div>
                </li>
                <li class="item Lposr Lfll">
                    <h2 class="hotelname Lposa">
                        <a href="javascript:;">大床房</a>
                        <div class="bg"></div>
                    </h2>
                    <div class="hotelpic"><img src="images/memberHZ-01.png"></div>
                    <div class="words">
                        <p class="hotelsummary">。。。。。。。。。。。。</p>
                        <p class="hoteldetail"><a target="_blank" href="http://hotels.huazhu.com//Hotel/Detail/3100063">查看房间<i class="arrowright"></i></a></p>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>

        <div class="footpatch"></div>
    </div>
    <div id="scriptArea" data-page-id="home/brand?brand=quanji" class="Ldn">
        <!--[if lte IE 9]><div data-nblock-id="ui/wideScreen"></div><![endif]-->
        <script src="http://ws-www.hantinghotels.com/hworld/NewWeb/js/main-min.js?v=6d0299f489"></script>
        <script src="http://ws-www.hantinghotels.com/hworld/NewWeb/js/lazyload.js"></script>
        <script src="http://ws-www.hantinghotels.com/hworld/Scripts/plugins/jquery.cookie.js"></script>
        <script type="text/javascript">

    function getCookie(sName) {
        var sReg = "(?:;)?" + sName + "=([^;]*);?";
        var oReg = new RegExp(sReg);

        if (oReg.test(document.cookie)) {
            return decodeURIComponent(RegExp["$1"]);
        }
        return "";
    };


    ndoo.vars.oldjuziLink = "";
        ndoo.vars.getCityListOption = {"data":{"HotelStyleList":2}};
            ndoo.vars.getCityListUrl = "/Basic/QueryCityViewByBrand?citySouce=0";
            ndoo.vars.getOverseaCityListUrl = "/Basic/QueryCityViewByBrand?citySource=1";
    ndoo.vars.HotelListUrl = "http://hotels.huazhu.com/";
            ndoo.vars.HotelOverseaListUrl = "http://hotels.huazhu.com/IntHotel";
            ndoo.vars.ImgUrlPrefix = "http://ws-www.hantinghotels.com/hworld/NewWeb/img/";
            ndoo.init();
            $(function () {
                $('.recommendlist .hotelname').on('click', function () {

                    window.open($(this).parent().find('.hoteldetail a').attr('href'));
                    
                })
            })
        </script>
    </div>
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
    <script type="text/javascript" src="http://ws-www.hantinghotels.com/wa/site/huazhu_track.js">
</script>


</body>
</html>
