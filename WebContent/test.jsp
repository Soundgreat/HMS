<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<input id="submit" type="submit" value="submit">

<script src="js/jquery.js"></script>
<script type="text/javascript">
$("#submit").click(function() {
	let values = {
			values: [
				"test",
		    	"2",
		    	"21",
		    	"300"
			]
	}
	$.ajax({
	    url: 'Test',
	    method: 'post',
	    data: {
	    	action: 'indert',
	    	table: '客房类型',
	    	primaykey: '类型',
	    	keyvalue: '',
	    	values: JSON.stringify(values)
	    },
	    success: (res) => {
	    	if (res.status == 200) alert('添加成功！');
	    	else alert('添加失败：' + res.status);
	    },
	    error: (req, sta, err) => {
	    	alert('可能遇到一些问题！请查询确认');
	    }
	});
});
</script>
</body>
</html>