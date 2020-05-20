<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");

	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>style test</title>

<script language="JavaScript" type="text/JavaScript">
	var xhrObject; //XMLHttpRequest 객체를 저장할 변수를 전역변수로 선언

	function createXHR() //XMLHttpRequest 객체를 생성하는 메소드
	{
		if(window.ActiveXObject) //웹 브라우저 IE5.0, IE6.0인 경우
		{
			xhrObject = new ActiveXObject("Microsoft.XMLHTTP");//XMLHttpRequest 객체 생성 
		}else if(window.XMLHttpRequest) //웹 브라우저가 IE7.0, 파이어폭스, 사파리, 오페라
		{
			xhrObject = new XMLHttpRequest(); //XMLHttpRequest 객체 생성
		}
	}

	function getData(){

		var form_name = "form_main";
		var user_id = document.forms[form_name].elements["txt_user_id"].value;

		createXHR(); //createXHR() 메소드 호출

		//var url = ""; //요청 URL설정
		
		var url = "./testDB.jsp" //요청 URL 설정
		var reqparam = "user_id=" + user_id;
		xhrObject.onreadystatechange = resGetData; //응답결과를 처리메소드인 resultProcess() 메소드 설정
		xhrObject.open("Post",url,"true"); //서버의 요청설정 - url변수에 설정된 리소르를 요청할 준비
		xhrObject.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=UTF-8"); //POST방식의 경우 반드시 설정

		xhrObject.send(reqparam);//서버로 요청을 보냄
		}

	function resGetData(){
		if(xhrObject.readyState == 4){
			if(xhrObject.status == 200){
				var result = xhrObject.responseText;
				var objRes = eval("("+result+")");    //eval은 텍스트 형태의 내용을 JSON으로 바꿔줌
				var num = objRes.datas.length;
				var res = "<table cellpadding='3' cellspacing='0' border='1' width='980'>";
				var resDiv = document.getElementById("div_res");

				if(num < 1){
					res += "<tr><td width='980' height='100' align='center' style='font-size:50;'>검색 결과가 없습니다.</td></tr>";
				} else {
					for (var i = 0; i< num; i++){
						var user_id = objRes.datas[i].ID;
						var user_name = objRes.datas[i].NAME;
						var user_phone = objRes.datas[i].PHONE;

						res += "<tr>";
						res += "<td width='980' height='100' align='center' style='font-size:50' bgcolor='#D0E6FC'>" + user_id + "</td>";
						res += "</tr>";
						
						res += "<tr>"
						res += "<td width='980' align='center' style='font-size:50' bgcolor='#FFFFCC'><br>" + user_name + "<br></td>";
						res += "</tr>";

						res += "<tr>"
							
						res += "</tr>";
						
						res += "<td width='980' align='center' style='font-size:50' bgcolor='#FFFFCC'><br>" + user_phone + "<br></td>";	
						res += "</tr>";
						}
					}
					res +="</table>";
					resDiv.innerHTML=res;
				}	
			}
		}

		function searchData(){
			var form_name = "form_main";
			var user_id = document.forms[form_name].elements["txt_user_id"].value;

			//if(user_id ==""){
				//alert("user_id를 입력해주세요");
				//document.forms[form_name].elements["txt_user_id"].focus();
				//return;
			//} else{
				getData();
			//}
		}
</script>

</head>

<body>
	<div id='div_main' width ='980' height='300' style="visibility:visible; position:absoulte; left:0px; top:115px; z-index:1;">
		<table border='0' width='980 cellpadding='0' cellspacing='0'>
			<form name="form_main" onSubmit="javascript : return false;">
				<tr>
					<td width='245'></td>
					<td width='245' align='right'><input type='text' name='txt_user_id' size='10' value='' maxlength='10' style='width:240px; font-size:50; text-align:left;'></td>
					<td width='245'><img src='./img/search.gif' width='245' height='100' onClick='javascript:searchData();'></td>
					<td width='245'></td>
				</tr>
			</form>
		</table>
	</div>

	<div id='div_res' width ='980' style="visibility:visible; position : absoulte; left:0px; top:215px; z-index:1;">
		<table border='1' width='980 cellpadding='10' cellspacing='0'>
			<tr>
				<td align='center' style='width: 950px; font-size:50' bgcolor='#FFFFCC'>결과물</td>
			</tr>
		</table>
	</div>		
</body>
</html>