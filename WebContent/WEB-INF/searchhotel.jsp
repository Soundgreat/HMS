<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
ul.pagination {
    display: inline-block;
    padding: 0;
    margin: 0;
}

ul.pagination li {display: inline;}

ul.pagination li a {
    color: black;
    float: left;
    padding: 8px 16px;
    text-decoration: none;
}

ul.pagination li a.active {
    background-color: #4CAF50;
    color: white;
}

ul.pagination li a:hover:not(.active) {background-color: #ddd;}
</style>
<title>酒店查询</title>
<link rel="stylesheet" type="text/css" href="css/list.css"/>
<link rel="stylesheet" type="text/css" href="css/manhuaDate.1.0.css"/>
<link href="css/main.css" rel="stylesheet"/>

<script type="text/javascript" src="js/jquery-1.5.1.js"></script><!--日期控件，JS库版本不能过高否则tab会失效-->

<script type="text/javascript" src="js/ui.tab.js"></script>
<script type="text/javascript">
<!--选项卡切换-->
$(document).ready(function(){
	var tab = new $.fn.tab({
		tabList:"#demo1 .ui-tab-container .ui-tab-list li",
		contentList:"#demo1 .ui-tab-container .ui-tab-content"
	});
	var tab = new $.fn.tab({
		tabList:"#demo1 .ui-tab-container .ui-tab-list2 li",
		contentList:"#demo1 .ui-tab-container .ui-tab-content2"
	});		
});	
</script>

<script type="text/javascript" src="js/datejs.js"></script>
<script type="text/javascript">
<!--日历选择器-->
$(function (){
	$("input.mh_date").datejs({					       
		Event : "click",//可选				       
		Left : 0,//弹出时间停靠的左边位置
		Top : -16,//弹出时间停靠的顶部边位置
		fuhao : "-",//日期连接符默认为-
		isTime : false,//是否开启时间值默认为false
		beginY : 2017,//年份的开始默认为2017
		endY :2020//年份的结束默认为2020
	});
});
</script>

<script type="text/javascript">
<!--点击更多-->
$(document).ready(function(e){
	$("#selectList").find(".more").toggle(function(){
		$(this).addClass("more_bg");
		$(".more-none").show()
	},function(){
		$(this).removeClass("more_bg");
		$(".more-none").hide();
	});
});
</script>

</head>

<body>
<header class="Mhead slim">
    <div class="inner Cwrap">
        <div class="mbox">
            <div class="content Lcfx Ltar">
                <div class="h3 pagename Lfll Lmt30 Lpl25"></div><span class="otherlink Ldib Lmt30 Lpr25"><a href="http://www.huazhu.com/AboutHZ">了解更多</a><i>|</i><a href="http://hwj.huazhu.com:8080/HQuestionCRM?qNo=F9C6BC63-B467-4104-B441-D853B576EDC9">反馈意见</a>
            </div>
        </div>
    </div>
</header>
<br/>
<div style="width:980px;margin:20px auto 0 auto;">

	<div class="list-screen">
		
		<div class="screen-top" style="position:relative;">
			<span>入住日期<input type="text" class="mh_date" readonly="true" id="ruzhu"/></span>
			<span>退房日期<input type="text" class="mh_date" readonly="true" id="tuifang"/></span>
			<!--  <span>酒店位置<input type="text" class="ju-adress"  /></span>
			<span>酒店名称<input type="text" class="ju-name" /></span>-->
			<a href="#" id="submit-btn">搜索</a>
		</div>
		
		<div style="padding:10px 30px 10px 10px;">
			<div class="screen-address">
			</div>
			
			<div class="screen-term">
				<div class="selectNumberScreen">
					<div id="selectList" class="screenBox screenBackground">
						<dl class="listIndex">
							<dt>房间价格</dt>
							<dd>
								<label><a href="javascript:;" attrval="不限">不限</a></label>
								<label><input name="radio2" type="radio" value="" /><a href="javascript:;" values2="99" values1="1" attrval="1-99">100元以下</a></label>
								<label><input name="radio2" type="radio" value="" /><a href="javascript:;" values2="300" values1="100" attrval="100-300">100-300元 </a></label>
								<label><input name="radio2" type="radio" value="" /><a href="javascript:;" values2="600" values1="300" attrval="300-600">300-600元</a></label>
								<label><input name="radio2" type="radio" value="" /><a href="javascript:;" values2="1500" values1="600" attrval="5000以上">600-1500元</a></label>
								<div class="custom"><span>自定义</span>&nbsp;<input name="" type="text" id="custext1"/>&nbsp;-&nbsp;<input name="" type="text" id="custext2"/><input name="" type="button" id="cusbtn"/></div>
							</dd>
						</dl>
						<dl class="listIndex">
							<dt>房间类型</dt>
							<dd>
								<label><a href="javascript:;" attrval="不限">不限</a> </label>
								<label><input name="checkbox2" type="checkbox" value="" /><a href="javascript:;"> 大床房</a></label>
								<label><input name="checkbox2" type="checkbox" value="" /><a href="javascript:;">双人床房</a></label>
								<label><input name="checkbox2" type="checkbox" value="" /><a href="javascript:;">单人床房</a></label>
							</dd>
						</dl>
						<!--  <dl class="listIndex">
						<dt>主题风格</dt>
							<dd>
								<label><a href="javascript:;" attrval="不限">不限</a></label>
								<label><input name="checkbox2" type="checkbox" value="" /><a href="javascript:;">客栈</a></label>
								<label><input name="checkbox2" type="checkbox" value="" /><a href="javascript:;">精品酒店</a> </label>
								<label><input name="checkbox2" type="checkbox" value="" /><a href="javascript:;">情侣酒店</a> </label>
								<label><input name="checkbox2" type="checkbox" value="" /><a href="javascript:;">园林庭院</a></label>
								<span class="more"><em class="open"></em>更多</span>
							</dd> 
						</dl>-->
					</div>
				</div>   
			</div>
		</div>
	
		<div class="hasBeenSelected clearfix">
			<span id="time-num">为你找到<font>XX</font>个房间</span>
			<div style="float:right;" class="eliminateCriteria">【清空全部】</div>
			<dl>
				<dt>已选条件：</dt>
				<dd style="display:none" class="clearDd">
					<div class="clearList"></div>
				</dd>
			</dl>
		</div>
		
		<script type="text/javascript" src="js/shaixuan.js"></script> 
	
	</div>
</div>
<div class="allroom">

</div>

<div class="hotelbox">
	<div class="img">
		<img src="http://ws-p.hantinghotels.com/f/m/6es4b1.jpg.190-160.jpg" width="190" height="160"/></div>
	<div class="desc">
		<div class="hotelname hasChildTag hasTaxBedge">
			<a class="name" title="桔子精选上海静安酒店 + " href="" target="_blank">
				<h2>桔子精选上海静安酒店</h2>
            </a>
            <span class="child_bedge bedge_16"><i class="arrow"></i></span>                                                                 <span class="tax_bedge tax_bedge_1" title="离店时可立即开具增值税专用发票，用于6%的进项抵\n扣，为企业节省差旅成本！\nPS：当您此次住宿为出差性质，且出差报销企业是一般\n纳税人的企业，酒店才可开具增值税专用发票。">&lt;i&gt;专票抵扣&lt;/i&gt;&lt;i class=&quot;percent&quot;&gt;6%&lt;/i&gt;</span>
         </div>
         <div class="address">上海静安区余姚路417号</div>                                                                                                   <div class="coming"><i class="Cicon hourglass"></i>即将开放预订</div>
         <div class="lastorder"></div>
         <div class="commentseg hasLabel"></div>
         <div class="service">
         		<i class="Cicon small_wifi" title="客房Wifi覆盖"></i>
         		<i class="Cicon small_park" title="停车场"></i>
                <i class="Cicon small_breakfast" title="餐厅"></i>
                <span class="favor_count"><!--<i class="Cicon small_favor"></i>20132--></span>
         </div>
     </div>
                                                <div class="rarea">
                                                    <div class="score Ltar">
                                                        <span class="Ldib Lpl5">5<i>/5分</i></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

  "WebContent/hotelMain.jsp"  <div class="text-center" align="center">
    	<table class="table">
		<thead>
			<tr>
				<td>序号</td>
				<td>模块</td>
				<td>信息</td>
				<td>时间</td>
			</tr>
		</thead>
		<tbody>
			<tr  ng-repeat="data in datas">
				<td>{{data.order}}</td>
				<td>{{data.module}}</td>
				<td>{{data.message}}</td>
				<td>{{data.time}}</td>
			</tr>
		</tbody>
	</table>
            <ul class="pagination">
                <li><a href="<c:url value="/list?page=1"/>" >首页</a></li>
                <li><a href="<c:url value="/list?page=${page-1>1?page-1:1}"/>" >&laquo;</a></li>

                <c:forEach begin="1" end="${totalPages}" varStatus="loop">
                    <c:set var="active" value="${loop.index==page?'active':''}"/>
                    <li class="${active}"><a
                            href="<c:url value="/list?page=${loop.index}"/>">${loop.index}</a>
                    </li>
                </c:forEach>
                <li>
                    <a href="<c:url value="/list?page=${page+1<totalPages?page+1:totalPages}"/>">&raquo;</a>
                </li>
                <li><a href="<c:url value="/list?page=${totalPages}"/>">尾页</a></li>
            </ul>
    </div>
<div class="hotellist_box Lvh">
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


</body>
</html>