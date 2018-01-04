document.write("<script src='js/jquery.js'></script><script src='js/vue.js'></script>");

let server = 'LoginServlet';
$("#myTabContent div[class*='tab-pane']").find("button").click(() => {
	let type = $("li.active a").attr("href");
	let accountType = type.substring(1, type.length);
	let name = $("#myTabContent div[class*='active'] input[type='text']").val();
	let passwd = $("#myTabContent div[class*='active'] input[type='password']").val();
	$.ajax({
		url: server,
		method: 'post',
		data: {
			accounttype: accountType,
			name: name,
			passwd: passwd
		},
		success: (res) => {
			if (res.status == 0) alert("该账号不存在！");
			else if (res.status == -1) alert("密码错误！");
			else window.location = res.newpage;
		}
	});
});