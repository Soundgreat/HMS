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

.detail {
 display: inline-block;
}

ul.pagination li a:hover:not(.active) {background-color: #ddd;}
</style>
<title>酒店查询</title>
<link rel="stylesheet" type="text/css" href="css/list.css"/>
<link rel="stylesheet" type="text/css" href="css/search.css"/>
<link rel="stylesheet" type="text/css" href="css/manhuaDate.1.0.css"/>
<link href="css/main.css" rel="stylesheet"/>
 <link rel="shortcut icon" href="http://ws-www.hantinghotels.com/newweb/hotels/img/favicon.c14a5d56.ico" type="image/x-icon" />

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
		isTime : true,//是否开启时间值默认为false
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
<div id="page">
<header class="Mhead slim">
    <div class="inner Cwrap">
        <div class="mbox">
            <div class="content Lcfx Ltar">
                <div class="h3 pagename Lfll Lmt30 Lpl25">预定房间</div><span class="otherlink Ldib Lmt30 Lpr25"><a href="http://www.huazhu.com/AboutHZ">了解更多</a><i>|</i><a href="http://hwj.huazhu.com:8080/HQuestionCRM?qNo=F9C6BC63-B467-4104-B441-D853B576EDC9">反馈意见</a>
            </div>
        </div>
    </div>
</header>
<br/>
<div style="width:980px;margin:20px auto 0 auto;">

	<div class="list-screen">
		
		<div class="screen-top" style="position:relative;">
			<span>入住日期<input type="text" v-model="checkinDate" name="checkindate" class="mh_date" readonly="true" /></span>
			<span>退房日期<input type="text" v-model="checkoutDate" name="checkoutdate" class="mh_date" readonly="true" /></span>
			<a href="#" id="submit-btn" @click="search">搜索</a>
		</div>
		
		<div style="padding:10px 30px 10px 10px;">
			<div class="screen-address">
			</div>
			
			<div class="screen-term">
				<div class="selectNumberScreen">
					<div id="selectList" class="screenBox screenBackground">
						<dl class="listIndex">
							<dt>房间类型</dt>
							<dd>
								<label v-for="type in roomTypes"><input name="checkbox2" type="checkbox" :value="type" checked/><a href="javascript:;">{{type}}</a></label>
							</dd>
						</dl>
					</div>
				</div>   
			</div>
		</div>
	
		<div class="hasBeenSelected clearfix">
			<span id="time-num" v-if="searching">为你找到{{availableRooms.length}}个房间</span>
			<div style="float:right;" class="eliminateCriteria">【清空全部】</div>
			<dl>
				<dt>已选条件：</dt>
				<dd style="display:none" class="clearDd">
					<div class="clearList"></div>
				</dd>
			</dl>
		</div>
	
	</div>
</div>
<div class="allroom">

</div>

<div v-for="(room, idx) in availableRooms" class="roombox" >
<template v-if="idx >= pageIdx*20 && idx < pageIdx*20 + 20">
<div class=""  @click="browseDetail(idx)">
<br/>
	<div class="img"> 
		<img src="http://ws-p.hantinghotels.com/f/m/6es4b1.jpg.190-160.jpg" width="190" height="160"/>
			<div class="detail" align="center">
	<h2>{{room.roomType}}</h2>
                <p class="">房间ID：{{room.roomId}}</p>
				<p class="">{{room.typeDesc}}</p>
				<p class="">{{room.roomDesc}}</p>
				<p class="">{{room.orientation}}</p>
				<p class="">{{room.capacity}}</p>
				<div >价格：{{room.price}}</div> 	
	</div>
	</div>                                                                                       
         
                                                                                                
         <div class="bookbtn"><a href="javascript:;" @click="bookRoom(idx)" class="Cbtn orderbtn" data-room-type="DR" data-activity-id="" data-isagents="0">预订</a>
         </div>
        


       </template>
</div>


                                        

 <div class="text-center" align="center">
    	<table class="table">
		<thead>
			<tr>
				<td>当前页 : {{pageIdx+1}}</td>
			</tr>
		</thead>
		<tbody>
			<tr  ng-repeat="data in datas">
				<td></td>
			</tr>
		</tbody>
	</table>
    <div class="text-center" align="center">
            <ul class="pagination">
                <li><a @click="switchPage('prev')" >&laquo;</a></li>
                <li>
                    <a @click="switchPage('next')">&raquo;</a>
                </li>
            </ul>
    </div>
</div>
<div class="hotellist_box Lvh">
</div>
<div id="popup-captcha"></div>
    <div class="Mfoot">
        <div class="inner Lpb25 Lpt25">
            <div class="links Ltac">
                <a href="#">酒店介绍</a>
                <a href="#">酒店加盟</a>
                <a href="#">职位招聘</a>
                <a href="#">意见反馈</a>
                <a href="#">联系我们</a>
            </div>
        </div>
    </div>
</div>
<script src="js/shaixuan.js"></script> 
<script src="js/vue.js"></script> 
<script src="js/searchRoom.js"></script>
</body>
</html>