<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/manager-addstaff.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
<form id="removeuser">
<br/>
<br/>
<br/>
<table align="center">
	<tr>
		<td>用户ID</td>
		<td><input type="number" name="idcard" required></td>
	</tr>
</table>
<br/><br/><br/><br/><br/>
<br/><br/>
<div class="BtmBtn">
<div class="btn_boxB floatR mag_l20"><button name="" type="reset">重置</button></div>
<div class="btn_box floatR"><button id="submitremoveuser" @click="submitremoveuser">注销</button></div>
</div>
</form>
</body>
</html>