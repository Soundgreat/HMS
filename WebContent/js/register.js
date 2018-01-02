document.write("<script src='js/jquery.js'> </script><script src='js/vue.js'></script>");

let server = 'Register';
$("#signUp_btn").click(() => {
	let username = $("input[name='username']").val();
	let idcard = $("input[name='idcard']").val();
	let phone = $("input[name='phone']").val();
	let passwd1 = $("input[name='passwd1']").val();
	let passwd2 = $("input[name='passwd2']").val();
	console.log(username);
	console.log(idcard);
	console.log(phone);
	console.log(passwd1);
	if (passwd1 != passwd2) {
		alert('两次密码不一致！');
	} else {
		$.ajax({
			url: server,
			method: 'post',
			data: {
				accounttype: 'private',
				alias: username,
				id: idcard,
				phone: phone,
				passwd: passwd1
			},
			success: (res) => {
				if (res.status == 1) {
					window.location = res.newpage;
				} else if (res.status == 0) {
					alert('注册失败！请稍后再试！');
				} else if (res.status == -1) {
					alert('该身份证号已被注册！')
				} 
			}
		});
	}
 });