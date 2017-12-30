<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/manager-addstaff.css" rel="stylesheet">
<title>移除员工</title>
</head>
<body>
<form id="removestaff">
<br/>
<br/>
<br/>
<table align="center">

	<tr>
		<td>员工号</td>
		<td><input type="number" name="staffid" required></td>
	</tr>
</table>
<br/><br/><br/><br/><br/>
<br/><br/>
<div class="BtmBtn">
<div class="btn_boxB floatR mag_l20"><button name="" type="reset">重置</button></div>
<div class="btn_box floatR"><button id="submitremovestaff" @click="submitremovestaff">移除</button>
</div>
</div>
</form>
</body>
</html>