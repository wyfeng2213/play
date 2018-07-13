<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>后台管理系统登录</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" href="ico/fengyun.png">
<link href="css/main/login.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="js/json2.js"></script>
<script type="text/javascript" src="js/main/login.js"></script>
</head>
<!-- test submit -->
<body>
	<div class="content">
		<table border="0px" bordercolor="#0000FF" width="680px" height="390px"
			cellspacing="0" cellpadding="0" align='center'>
			<tr>
				<td align='center'>
					<div class="d_main">
						<table width="680px" height="500px" border="0px" bordercolor="#0000FF">
							<tr>
								<td><div class="top_left"></div></td>
								<td><div class="top_right"></div></td>
							</tr>
							<tr>
								<td align="center" colspan="2"><div class="top_center"></div></td>
							</tr>
							<tr>
								<td><div class="content_left"></div></td>
								<td>
									<div class="content_right" style="margin-top: 50%; margin-left:-53%;">
										<form id="_formLogin">
											<table border="0" width="340px" height="110px">
												<tr>
													<td align="left"><div class="d_txt account">账户:</div></td>
													<td><div class="d_val account">
															<input type="text" id="_username" tabindex="1" />
														</div></td>
												</tr>
												<tr>
													<td align="left"><div class="d_txt">密码:</div></td>
													<td><div class="d_val">
															<input type="password" id="_password" tabindex="2" />
														</div></td>
												</tr>
												<tr>
												
												</tr>
												<tr>
													<!-- <td><div class="d_txt"></div></td> -->
													<td colspan="2" align="center"><div class="d_val" style="width:300px;">
															<!-- <a tabindex="4"><img id="_login_img"
																src="images/btn_login.png" style="width:200px;height:60px;" onClick="javascript:login()" /></a> -->
																<a>
																  <div id="_login_img" class="d_login" onClick="javascript:login()">
																    <div class="txt_login">登录</div>
																</div>
																</a>
														</div>
													</td>
													<!-- modify by chencao -->
													<tr>
														<td colspan="2"><div id="d_login_process_bar"
																class="bottom_1">
																<img src='images/login_processbar.gif'></img>
															</div></td>
													</tr>
													<tr>
														<td colspan="2"><div id="d_login_msg" class="bottom_2"></div></td>
													</tr>
													<!-- end -->
												</tr>
											</table>
										</form>
									</div>
								</td>
							</tr>
							<!-- <tr>
								<td colspan="2"><div id="d_login_process_bar"
										class="bottom_1">
										<img src='images/login_processbar.gif'></img>
									</div></td>
							</tr>
							<tr>
								<td colspan="2"><div id="d_login_msg" class="bottom_2"></div></td>
							</tr> -->
						</table>
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
<script type="text/javascript">
  var type= navigator.userAgent;
     if(navigator.userAgent.indexOf("Firefox")>0){
		    var width=document.documentElement.clientWidth,
		        height=document.documentElement.clientHeight; 
		        size=width+"px "+height+"px";
		        $(".content").css("background-size",size);
		    	 
     }else if(navigator.userAgent.indexOf("Chrome")>0){
    	 $(".content_right").css({"margin-top":"50%"});
     }else{
    	// var width=document.documentElement.clientWidth,
	    //     height=document.documentElement.clientHeight; 
	    //    size=width+"px "+height+"px";
	       // $(".content").css("background-size",size);
     }
</script>
</html>