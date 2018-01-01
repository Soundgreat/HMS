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
<link rel="stylesheet" type="text/css" href="css/search.css"/>
<link rel="stylesheet" type="text/css" href="css/manhuaDate.1.0.css"/>
<link href="css/main.css" rel="stylesheet"/>
 <link rel="shortcut icon" href="http://ws-www.hantinghotels.com/newweb/hotels/img/favicon.c14a5d56.ico" type="image/x-icon" />

<script type="text/javascript" src="js/jquery-1.5.1.js" charset="utf-8"></script><!--日期控件，JS库版本不能过高否则tab会失效-->
<script src="http://cdn.static.runoob.com/libs/angular.js/1.4.6/angular.min.js"></script>
<script type="text/javascript" src="js/ui.tab.js" charset="utf-8"></script>
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

<script type="text/javascript" src="js/datejs.js" charset="GBK"></script>
<script type="text/javascript" charset="GBK">
<!--日历选择器-->
$(function (){
	$("input.mh_date").datejs({					       
		Event : "click",//可选				       
		Left : 0,//弹出时间停靠的左边位置
		Top : -16,//弹出时间停靠的顶部边位置
		fuhao : "-",//日期连接符默认为-
		isTime : false,//是否开启时间值默认为false
		beginY : 2018,//年份的开始默认为2018
		endY :2020//年份的结束默认为2020
	});
});
</script>
        <script>
            var app = angular.module("tableApp",[]);
            app.controller("tableCon",function($scope){
                $scope.datas = [
                    {type:"双人间",describe:"...."},
                    {type:"大床房",describe:"22"},
                    {type:"家庭套房",describe:"21"},
                    {type:"总统套房",describe:"24"},
                    {type:"五月",describe:"25"}
                ]
            });
        </script>
</head>

<body>
<header class="Mhead slim">
    <div class="inner Cwrap">
        <div class="mbox">
            <div class="content Lcfx Ltar">
                <div class="h3 pagename Lfll Lmt30 Lpl25">预定房间</div><span class="otherlink Ldib Lmt30 Lpr25"><a href="http://www.huazhu.com/AboutHZ">了解更多</a><i>|</i><a href="http://hwj.huazhu.com:8080/HQuestionCRM?qNo=F9C6BC63-B467-4104-B441-D853B576EDC9">反馈意见</a>
            </div>
        </div>
    </div>
</header>
<div style="margin-left:93%"><a href="hotelMain.jsp" >返回首页</a></div>
<div style="width:980px;margin:20px auto 0 auto;">

	<div class="list-screen">
		<form action="SearchServlet.do" method="post"><!-- 提交数据 -->
		<div class="screen-top" style="position:relative;">
			<span>入住日期<input type="text" class="mh_date" readonly="true" id="ruzhu"/></span>
			<span>退房日期<input type="text" class="mh_date" readonly="true" id="tuifang"/></span>
			<input type="submit" id="submit-btn" value="搜索"/>
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
					</div>
				</div>   
			</div>
		</div>
	</form>
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

<br/>
<div class="roombox" ng-app="tableApp">
<div class="table-area" ng-controller="tableCon">
    <!--  <table class="search-table">
    <tr >
	<td class="search-td">
		<img src="images/banner-img3.jpg"  /></td>
	<td class="search-td">
		<img src="images/banner-img3.jpg" /></td>
	<td class="search-td">
	<img src="images/banner-img3.jpg"/></td>
	</tr>
	<tr>
	<td class="search-td">
		<p class="roomtitle">XXXXX（房间类型1）</p></td>
	<td class="search-td">	<p class="roomtitle">XXXXX（房间类型2）</p></td>
	<td class="search-td">	<p class="roomtitle">XXXXX（房间类型3）</p></td>
	</tr>
	<tr>
	<td class="search-td">
		<div class="address">XXXXXXXXXX（房间介绍1）</div> </td>
	<td class="search-td">	<div class="address">XXXXXXXXXX（房间介绍2）</div> </td>
	<td class="search-td">	<div class="address">XXXXXXXXXX（房间介绍3）</div> </td>
	</tr>
	<tr>
	<td class="search-td">
			<a href="order.jsp" class="Cbtn orderbtn" data-room-type="DR" data-activity-id="" data-isagents="0">预订</a>
	</td>
	<td class="search-td">
			<a href="order.jsp" class="Cbtn orderbtn" data-room-type="DR" data-activity-id="" data-isagents="0">预订</a>
	</td>
	<td class="search-td">
			<a href="order.jsp" class="Cbtn orderbtn" data-room-type="DR" data-activity-id="" data-isagents="0">预订</a>
	</td>		
	</tr>
</table> -->
<table class="search-table" ng-repeat="data in datas" > <!-- 循环 输出房间-->
    <tr >
	<td class="search-td">
		<img src="images/banner-img3.jpg"  /></td> <!-- 这里从数据库获取数据！！！再决定调用哪张图片！！！ -->
	
	
	<td class="search-td">
		<p class="roomtitle">{{data.type}}XXXXX（房间类型4）</p></td>
	
	
	<td class="search-td">
		<div class="address">{{data.describe}}XXXXXXXXXX（房间介绍4）</div> </td>
	<td class="search-td">
		<div class="address"></div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
	<td class="search-td">
			<div class="yuding"><br/><br/><a class="viewroomtype"    style="color: #7f1f59;" href="javascript:;"><span>展开全部房型</span><i class="arrow"></i></a></div>
			<!--  <div class="yuding"><a href="order.jsp" class="Cbtn orderbtn" data-room-type="DR" data-activity-id="" data-isagents="0">展开查看房间</a></div>-->
			<!--  <div class="yuding"><a href="order.jsp" class="Cbtn orderbtn" data-room-type="DR" data-activity-id="" data-isagents="0">预订</a></div>-->
	</td>		
	</tr>			
</table>
<!--  <table class="search-table" ng-repeat="data in datas" >
    <tr >
	<td class="search-td">
		<img src="images/banner-img3.jpg"  /></td>
	<td class="search-td">
		<img src="images/banner-img4.jpg" /></td>
	<td class="search-td">
	<img src="images/banner-img2.jpg"/></td>
	</tr>
	<tr>
	<td class="search-td">
		<p class="roomtitle">{{data.type}}XXXXX（房间类型4）</p></td>
	<td class="search-td">	<p class="roomtitle">XXXXX（房间类型5）</p></td>
	<td class="search-td">	<p class="roomtitle">XXXXX（房间类型6）</p></td>
	</tr>
	<tr>
	<td class="search-td">
		<div class="address">{{data.describe}}XXXXXXXXXX（房间介绍4）</div> </td>
	<td class="search-td">	<div class="address">XXXXXXXXXX（房间介绍5）</div> </td>
	<td class="search-td">	<div class="address">XXXXXXXXXX（房间介绍6）</div> </td>
	</tr>
	<tr>
	<td class="search-td">
			<a href="order.jsp" class="Cbtn orderbtn" data-room-type="DR" data-activity-id="" data-isagents="0">预订</a>
	</td>
	<td class="search-td">
			<a href="order.jsp" class="Cbtn orderbtn" data-room-type="DR" data-activity-id="" data-isagents="0">预订</a>
	</td>
	<td class="search-td">
			<a href="order.jsp" class="Cbtn orderbtn" data-room-type="DR" data-activity-id="" data-isagents="0">预订</a>
	</td>		
	</tr>	
</table>
-->
</div>
</div>
                                        

 <div class="text-center" align="center">
    	<!--  <table class="table">
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
	</table>-->
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
<%@include file="/bottom.jsp" %>
</body>
</html>