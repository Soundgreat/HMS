<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客房详情</title>
  	<link rel="stylesheet" href="css/zerogrid.css">
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="css/menu.css">
	<link rel="stylesheet" href="css/responsiveslides.css">
	<!-- Custom Fonts -->
    <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
</head>
<style>
.outlinedA {
    position: relative;
    letter-spacing: .07em;
    font-size: 3em;
    font-weight: normal;
    margin: 0 auto;
    color: #7f1f59;
}
</style>
<body>
<header >
	<div class="zerogrid">
		<div style="margin-left:94%"><a href="hotelMain.jsp" >返回首页</a></div>
		<div class="wrap-header" style="background:#F1F1E6">
		</div>
	</div>
</header>
	<section>
		<div class="wrap-container clearfix" id="container">
			<div id="main-content">
				<div class="wrap-content">
					<div class="zerogrid" style="box-shadow: 0 4px 8px 0 rgba(0, 1, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);">
						<article>
							<div class="art-content t-center">
									<h4 class="outlinedA">{{roomType}}</h4>
								</div>
							<div class="col-1-2">
								<div class="art-header">
									<img src="images/12.jpg"/>
								</div>
							</div>	
					
								<div class="art-content" style="margin-left:54%">
									<ul>
									<li><h5 >推荐指数：★★★★★</h5></li>
									<li><h6>面积：{{price/10}}</h6></li>
									<li><h6>窗户：有</h6></li>
									<li><h6>入住人数：{{capacity}}人(可加床)</h6></li>
									<li><h6>￥{{price}}起</h6></li>
									<br/>
									<li><h5>我们还将为您提供：</h5>
									<p>&ensp;&ensp;&ensp;&ensp;24hours wifi &ensp; 独立卫生间</p></li>
									</ul>
									<br/><br/><br/><br/>
									<p>{{typeDesc}}</p>
								</div>
													
						</article>
					</div>
				</div>
			</div>
		</div>
	</section>
	
<script src="js/vue.js"></script>	
<script src="js/jquery.js"></script>
<script>
new Vue({
	el: '#container',
	data: function() {
		return {
			roomType: '',
			capacity: 0 ,
			price: 0 ,
			typeDesc: ''
		}
	},
	mounted: function() {
		$.ajax({
			url: 'RoomDetailServlet',
			method: 'get',
			success: (res) => {
				this.roomType = res.room.roomType;
				this.capacity = res.room.capacity;
				this.price = res.room.price;
				this.roomTypeDesc = res.room.typeDesc;
			}
		});
	}
});
</script>
</body>
</html>