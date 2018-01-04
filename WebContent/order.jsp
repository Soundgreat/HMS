<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!--[if IE 8]><html class="ie ie8 ltie9"><![endif]-->
<!--[if gte IE 9]><html class="ie ie9"><![endif]-->
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge; IE=8">
    <link href="css/order.css" rel="stylesheet"/>
    <script src="js/top.js"></script>

    <meta name="description" content="酒店集团是国内连锁酒店集团,在全国有超过2000家连锁酒店。酒店集团官网提供酒店预订,酒店会员服务,酒店电话,以及其他酒店信息查询等服务。
" />
    <meta name="keywords" content="酒店预订,酒店预定,酒店电话,酒店官网" />
    <title>预订酒店；请填写预订信息 | 酒店官网</title>
</head>

<body>
    <div class="Mhead slim Lpt5 Lpb5">
        <div class="inner Cwrap">
            <div class="mbox"> 
             >
                <div class="contNav Lovh Lcfx Lfz14 Lflr">
                            <div class="fillIn chooseActive"><a href="hotelMain.jsp" class="Ldb">返回首页</a></div>
                            <!-- <div class="choosePay"><a href="javascript:;" class="Ldb">2.确认订单</a></div> -->
                            <!-- <div class="completed"><a href="javascript:;" class="Ldb">3.完成预订</a></div> -->
                </div>
            </div>
        </div>
    </div>
    


<!-- 主体-->
<div class="Porder_main" id="order">
    <section class="m_wp Lovh">
        <!-- 左侧主体-->
        <section class="left_wp Lfll">
            <div class="cont">
                <!-- 预订信息-->
                <h1 class="cont_top Lpl10 Lfz14">预订信息</h1>
                <div class="cont_mid Lpt20 Lpl20 Lposr">
                <div class="cont_mid Lpl10 guestCheckIn">
                    <div class="LoginGuest">
                        <p class="roomNum Lfwb Lfz12 repadl">
                            <label class="sWidth Ltar Ldib"><span class="guestIcon Lfz12 Ldib">*</span><span class="Ltar">入住人：</span></label><span class="guestCheckInName">
                                <input v-model="name" type="text" maxlength="50" class="reWidth">
                            </span><span class="inputPrompt">请确认与入住时所持身份证姓名保持一致</span>
                        </p>
                                                <p class="roomNum Lfwb Lfz12 repadl">
                            <label class="sWidth Ltar Ldib"><span class="guestIcon Lfz12 Ldib">*</span><span class="Ltar">身份证：</span></label><span class="guestCheckInName">
                                <input v-model="id" type="number" maxlength="50" class="reWidth">
                            </span><span class="inputPrompt">请确认与入住时所持身份证号码保持一致</span>
                        </p>
                        <p class="roomNum Lfwb Lfz12 repadl">
                            <label class="sWidth Ltar Ldib"><span class="guestIcon Lfz12 Ldib">*</span><span class="Ltar">手机号码：</span></label><span class="guestCheckInTel">
                                <input v-model="phone" type="number" maxlength="11" class="reWidth">
                            </span><span class="inputPrompt">请确认是否是您的有效手机号，以便我们联系您</span>
                        </p>
                                                <p class="roomNum Lfwb Lfz12 repadl">
                            <label class="sWidth Ltar Ldib"><span class="guestIcon Lfz12 Ldib"></span><span class="Ltar">入住日期：</span></label><span class="guestCheckInName">
                                <input v-model="checkDate[0]" type="text" maxlength="50" class="reWidth" readonly>
                            </span>
                        </p>
                                                <p class="roomNum Lfwb Lfz12 repadl">
                            <label class="sWidth Ltar Ldib"><span class="guestIcon Lfz12 Ldib"></span><span class="Ltar">退房日期：</span></label><span class="guestCheckInName">
                                <input v-model="checkDate[1]" type="text" maxlength="50" class="reWidth" readonly>
                            </span>
                        <!-- </p>
                                                <p class="roomNum Lfwb Lfz12 repadl">
                            <label class="sWidth Ltar Ldib"><span class="guestIcon Lfz12 Ldib"></span><span class="Ltar">其他要求：</span></label><span class="guestCheckInName">
                                <input type="text" maxlength="50" class="reWidth">
                            </span>
                        </p> -->
                    </div>
                    </div>
                </div>

                </div>
                <div class="cont_mid Lpt20 Lpb40 hzCharacteristic">
                <!-- 提交订单-->
                <div class="orderSubmit Lovh Lcfx">
                    <p class="Ltar allCount"><span class="Lfz14 Lpr5"> 订单总价</span><em class="Lfz14">¥100</em><i></i></p>               
                    <a href="javascript:;" @click="submit" class="Lfz16 Ltac Ldb Lmt5 Lmb10 submitOrderBtn"> 提交订单</a>
                </div>
                
            </div>
        </section>
        <!-- 右侧主体-->
        <aside class="right_wp Lflr">
            <div class="cont">
                    <!-- 酒店地址-->
 				<div class="asideTitle pt15">
 				<h2 class="Lfz16">酒店地址</h2>
 				<p class="Lfz12">上海市杨浦区军工路XX号</p>
 				</div>
                    <!-- 酒店床型-->
                <div class="asideTitle pt15">
                    <h2 class="Lfz16">房间类型</h2>
                    <p class="Lfz12 bedType">床型：<span>无          </span></p>
                    <p class="Lfz12 area">面积：<span>无  </span></p>
                    <p class="Lfz12 hasWindow">窗户：<span>有            </span></p>
                    <p class="Lfz12 floor">楼层：<span>无  </span></p>
                    <p class="Lfz12 personNum">入住人数：<span>无  </span></p>
                    <p class="Lfz12 isWuYan">是否无烟：<span>无  </span></p>
                </div>
                <!-- 酒店公告-->
                <div class="asideTitle pt15 hotelannouncements">
                    <h2 class="Lfz16">酒店公告</h2>
                    <p class="Lfz12 noticeMore"></p>
                    <p class="Lfz12 hotelTelphone">酒店电话：<span>无  </span></p>
                    <p class="Lfz12 notice_all">客服电话：4008-121-121</p>
                </div>
                <div class="asideTitle pt15 clearBorder smallTips">
                    <!-- 温馨提示-->
                    <h2 class="Lfz16">温馨提示</h2>
                    <p class="Lfz12">酒店提供免费班车接送地铁站服务 送站时间：周一至周六早上7点至晚上23点结束 周日上午7店点至下午19点结束 接站时间：周一至周六早上7点至晚上23点结束 周日上午7店点至下午19点结束，电话致电前台随时接到酒店。</p>
                </div>
                <!-- 订单政策-->
                <div class="asideTitle pt15 hotelorderpolicy">
                    <h2 class="Lfz16">订单政策</h2>
                    <p class="Lfz12 orderpolicytitle">免费取消 全额退款</p>
                        <p class="Lfz12">请于入住日中午12:00后办理入住，如提前到店，视酒店空房情况安排。</p>
                   
                </div>
            </div>
        </aside>
    </section>
</div>






    <footer class="Mfoot">
        <div class="inner Cwrap Lpb25 Lpt25">
            <div class="links Ltac">
                <a href="#">酒店介绍</a><a href="#" target="_blank">酒店加盟</a><a href="#" target="_blank">职位招聘</a><a href="#">意见反馈</a><a href="http://www.huazhu.com/Contact">联系我们</a>
            </div>
            <p class="copyright Ltac Lmt20">     
            </p>
        </div>
    </footer>
</body>

<script src="js/vue.js"></script>
<script src="js/jquery.js"></script>
<script>
new Vue({
	el: '#order',
	data: function() {
		return {
			checkDate: [],
			id: '',
			name: '',
			phone: '',
			server: 'OrderServlet'
		}
	},
	
	mounted: function() {
		$.ajax({
			url: this.server,
			method: 'get',
			success: (res) => {
				this.checkDate = res.checkdate;
			}
		});
	},
	
	methods: {
		submit: function() {
			$.post(this.server,{
				id: this.id,
				name: this.name,
				phone: this.phone
			}, (res) => {
				alert("预定成功！ 订单号是：" + res.orderid);
			});
		}
	}
});
</script>
</html>
