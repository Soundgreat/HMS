  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>manager-setroomtype</title>
</head>
<body>
<div id="vue">
<form>
<table>
	<tr>
		<td>客房类型</td>
		<td><input type="text" name="roomtype" required></td>
	</tr>
	<tr>
		<td>客房容量</td>
		<td>
		<select name="capacity" required>
		<option v-for="num in capacityOptions" :value="num">{{num}}</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>客房价格</td>
		<td><input type="text" name="price" required></td>
	</tr>
	<tr>
		<td>客房余量</td>
		<td><input type="number" name="surplus" required></td>
	</tr>
	<tr>
		<td><input type="reset" value="重置"></td>
		<td><button id="submit" @click="submit">添加</button></td>
	</tr>
</table>
</form>
</div>
<script src="js/vue.js"></script>
<script src="js/jquery.js"></script>
<script>
new Vue({
	el: '#vue',
	data: function() {
		return {
			capacityOptions: 4
		}
	},
	methods: {
		submit: function() {
			if ($("input[name='roomtype']").val() != '' 
				&& $("input[name='capacity']").val() != ''
				&& $("input[name='surplus']").val() != '' 
				&& $("input[name='price']").val() != '')
			$.ajax({
			    url: 'SetRoomType',
			    method: 'post',
			    data: {
			    	roomtype: $("input[name='roomtype']").val(),
			    	capacity: $("select[name='capacity']").val(),
			    	surplus: $("input[name='surplus']").val(),
			    	price: $("input[name='price']").val()
			    },
			    success: (res) => {
			    	if (res.status == 200) alert('添加成功！');
			    	else alert('添加失败：' + res.status);
			    },
			    error: (req, sta, err) => {
			    	alert('可能遇到一些问题！请查询确认');
			    }
			});
		}
	}
});
</script>
</body>
</html>