<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>移除员工</title>
</head>
<body>
<form id="removestaff">
<table>
	<tr>
		<td>员工号</td>
		<td><input type="number" name="staffid" required></td>
	</tr>
	<tr>
		<td><input type="reset" value="重置"></td>
		<td><button id="submitremovestaff" @click="submitremovestaff">移除</button></td>
	</tr>
</table>
</form>
</body>
</html>