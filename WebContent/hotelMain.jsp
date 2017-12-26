<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge; IE=8;charset=UTF-8">
    <title>酒店管理系统</title>
    <meta name="keywords" content="全季酒店,全季酒店官网,全季酒店预订,全季酒店预定,汉庭全季酒店,全季酒店电话" />
    <meta name="description" content="全季酒店是华住(原汉庭)集团旗下中高端连锁商务酒店品牌。酒店坐落于国内一二线城市的商业中心区域。华住全季酒店官网提供全季酒店预订，酒店信息查询服务。到华住集团全季酒店官网预订全季酒店，享受最经济的价格。" />
    <meta name="renderer" content="webkit">
    <link rel="alternate" media="only screen and (max-width: 640px)" href="http://m.huazhu.com/brand/quanji">
    <link rel="canonical" href="http://www.huazhu.com/quanji" />
    <meta name="applicable-device" content="pc ">
    <link rel="stylesheet" href="http://ws-www.hantinghotels.com/hworld/NewWeb/css/main-min.css?v=a835e8355d">
    <script src="http://ws-www.hantinghotels.com/hworld/NewWeb/lib/ndoo/ndoo_prep-min.js"></script>
    <script>ndoo.vars.HZStatic = "http://ws-www.hantinghotels.com/hworld/NewWeb";</script>
        <script src='http://sdk.appadhoc.com/ab.plus.js'></script>
    <script type="text/javascript">
        //初始化
        try {
            adhoc('init', { appKey: 'ADHOC_12acff09-b17b-4cfe-b905-2abb4d8f47ca' });
        } catch (e) {
        }
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
                                    <a href="#" class="nav-2 Ldib item">XXX</a>
                                    <a href="#" class="nav-2 Ldib item">XXX</a>
                                    <a href="#" class="nav-4 Ldib item">XXX</a>
                                    <a href="#" class="active nav-3 Ldib item brandIts">XXX</a>
                                    <a href="#" class="nav-3 Ldib item">XXX</a>
                                    
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
        <!--酒店介绍变量-->
        <!--酒店概念变量-->
        <!--推荐酒店-->
        <div class="Mbannel Lposr quanji">
            <div class="mask Ldn"></div>
            <div class="bannelitem active">
                <div style="background-image: url(http://ws-www.hantinghotels.com/hworld/NewWeb/img/brand_quanji.jpg)" class="img"></div>
            </div>
            <div class="banneltip"><h3 class="Ldn">全季酒店 - 爱自己 住全季</h3></div>
                <div class="bannelgradient Lposa">
                </div>
        </div>
        <!-- 首页居中搜索框-->
        <div class="quanji Msearch Cwrap Ltac home">
            <div class="inner">
                <ul data-nblock-id="ui/searchBar?query=HotelStyleList" class="condition Lcfx">
                    <li data-nblock-id="ui/checkinDate?brand=quanji" class="date Lfll">
                        <div class="checkInDate Lposa">
                            <span class="placeholder Lposa">10</span><i class="triangle"></i>
                            <div class="tip">入住日期</div>
                            <div class="day">
                                <input type="hidden" data-date="2017-12-10" value="2017-12-10" class="checkindate">
                            </div>
                            <div class="month">12月</div>
                        </div>
                        <div class="checkOutDate Lposa">
                            <span class="placeholder Lposa">11</span><i class="triangle"></i>
                            <div class="tip">离店日期</div>
                            <div class="day">
                                <input type="hidden" value="2017-12-11" class="checkoutdate">
                            </div>
                            <div class="month">12月</div>
                        </div>
                        <div class="split"></div>
                    </li>
                    <li class="search Lfll Lposr">
                                <a id="btnSearchHotel" href="searchhotel.jsp" class="Cbtn btnSearch">
                                    <div class="title">
                                        <i class="icon-newsearch"></i>
                                        搜索房间
                                    </div>
                                </a>

                        
                    </li>
                </ul>
            </div>
        </div>
        

      <!-- 酒店介绍-->
<div class="quanji Mhoteldesc Cwrap">
    <div class="inner Lposr">
        <div class="box Lcfx Lposa">
            <div class="Lfll Lposr copywrite">
                <div class="copywritecont">
                    <span class="Lposa bookmark"></span>
                    <h1 class="logo zh">
                        XX酒店
                       
                    </h1>
                    <h2 class="logo en"> Hotel</h2>
                    <div class="desc">......................酒店简介</div>
                </div>
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
                        <a href="javascript:;">XXXXX</a>
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
                        <a href="javascript:;">XXXXXX</a>
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
                        <a href="javascript:;">XXXXX</a>
                        <div class="bg"></div>
                    </h2>
                    <div class="hotelpic"><img data-src="http://ws-www.hantinghotels.com/hworld/NewWeb/img/quanji_xiandayanta.jpg"></div>
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
    
    <script type="text/javascript" src="http://ws-www.hantinghotels.com/wa/site/huazhu_track.js">
</script>


</body>
</html>
