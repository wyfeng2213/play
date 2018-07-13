$(function() {
	clearProcessBar();
	$("#_username").focus();
	$('input').bind('keyup', function(event) {
		if (event.keyCode == "13") {
			login();
		}
	});
});

function login() {
	var vu = $("#_username");
	var vp = $("#_password");
	var vmsg = $("#d_login_msg");

	var _username = vu.val();
	var _password = vp.val();

	if (_username == "") {
		vmsg.html("用户名为空，请输入。");
		clearProcessBar();
		vu.focus();
		return false;
	}
	if (_password == "") {
		vmsg.html("密码为空，请输入。");
		clearProcessBar();
		vp.focus();
		return false;
	}
	var user = {
		username : _username,
		password : _password
	};
	loginProcess();
	$.ajax({
		url : 'user/login',
		async : false,
		type : 'POST',
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify(user),
		dataType : 'JSON',
		timeout : 60000,
		error : function() {
			clearProcessBar();
			vmsg.html("加载失败，请刷新重新登录。。。");
		},
		success : function(result) {
			if (result.status == 'success') {
				$("#_formLogin").attr("action", "main").attr("method", "GET").submit();
				$("#d_login_msg").html("认证成功！");
				clearProcessBar();
			} else {
				clearProcessBar();
				$("#d_login_msg").html("用户名或密码错误，请重新输入。");
				//vu.val("");
				vp.val("");
				vp.focus();
			}
		}
	});
};
function loginProcess() {
	$("#d_login_process_bar").show();
}
function clearProcessBar() {
	$("#d_login_process_bar").hide();
}