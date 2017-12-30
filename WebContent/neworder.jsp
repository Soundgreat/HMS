<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>new order</title>
</head>
<body>
<div v-if="roomDialog.open" class="dialog">
	<h5>添加住客</h5>
	<table  align="center">
		<tr>
			<td>身份证号</td>
			<td><input type="number" name="idcard" required></td>
		</tr>
		<tr>
			<td>姓名</td>
			<td><input name="name" type="text" required></td>
		</tr>
		<tr>
			<td>性别</td>
			<td>
			<label>男</label>
			<input type="radio" name="gender" value="male" checked>
			<label>女</label>
			<input type="radio" name="gender" value="female">
			</td>
		</tr>
		<tr>
			<td>年龄</td>
			<td><input name="age" type="number"></td>
		</tr>
		<tr>
			<td><button id="submit">添加</button></td>
			<td><button id="cancel">取消</button></td>
		</tr>
	</table>
	<span class="warning">{{submitHint}}</span>
	</div>
<script src="js/jquery.js"></script>
<script> 
let uesername = '';
$.ajax({
	url: 'PushOrder',
	method: 'get',
	success: (res) => {
		username = res.username;
		console.log(res.username);
	},
	error: (req, sta, err) => {
		alert("fail");
	}
});
let lodgers = [];
$("#submit").click(() => {
	let lodger = {
			idcard: $("input[name='idcard']").val(),
			name: $("input[name='name']").val(),
			gender: $("input[name='gender']:checked").val(),
			age: $("input[name='age']").val()
	}
	lodgers.push(lodger);
	$.ajax({
		url: 'PushOrder',
		method: 'post',
		data: {
			username: username, 
			lodgers: JSON.stringify(lodgers),
			roomType: '',
			checkindate: '',
			checkoutdate: ''
		}
	});
});
</script>
</body>
</html>