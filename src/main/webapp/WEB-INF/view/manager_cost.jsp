<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
$(function(){
	var contextPath = "<%=request.getContextPath()%>";
	
	$('#search').on("click", function(e){
		e.preventDefault();
		var data = {
				"date" : $('#registrationDate').val(),
				"name" : $('#name').val(),
				"processStatus" : $('#processStatus').val()
		};
		if(document.getElementById("registrationDate").value == 0) {
			alert("등록년월을 선택해주세요");
			document.getElementById("registrationDate").focus();
			return false;
		}
		if(document.getElementById("name").value == 0) {
			alert("사용내역을 선택해주세요");
			document.getElementById("name").focus();
			return false;
		}
		if(document.getElementById("processStatus").value == 0) {
			alert("처리상태를 선택해주세요");
			document.getElementById("processStatus").focus();
			return false;
		}
	alert("data > " + data.date + " " + data.name + " " + data.processStatus)

	$.ajax({
		/* url : contextPath + "/api/getList/{use_date, name, process_status}", */
		url : "/api/getList",
		type : 'GET',
		contentType : "application/json; charset=utf-8",
		dataType : 'JSON',
		cache : false,
		data : data,//JSON.stringify(data),
		success : function(res){
			alert(res);
			window.location.href=contextPath + "/index";
		},
		error : function(request, status, error){
			alert("code : " + request.status + "\n"+"message : " + request.responseText + "\n"+"error : " + error);
			/* window.location.href=contextPath + "/index"; */
		}
	});
	});
});

</script>
</head>
<body>
<div class="1">
<form action='search' method='get' id='index'>
	<a class="class1">등록년월:</a>
		<input name='registrationDate' type='date' id="registrationDate">
			
	<a class="class2">사용내역:</a>
			<select name="name" id="name">
		  		<option value="" selected> 선택</option>
    			<option value="식대(야근)">식대(야근)</option>
			    <option value="택시비(야근)">택시비(야근)</option>
			    <option value="택시비(회식)">택시비(회식)</option>
			    <option value="사무용품구매">사무용품구매</option>
    			<option value="교육비">교육비</option>
   			    <option value="접대비">접대비</option>
			</select>
	
	<a class="class3">처리상태:</a>
		<select name="processStatus" id="processStatus">
		  	<option value="" selected> 선택</option>
			<option value="접수">접수</option>
			<option value="승인">승인</option>
		    <option value="지급완료">지급완료</option>
    		<option value="반려">반려</option>
		</select>
	
	<input type="reset" value="초기화" style="margin-left: 120px;">
	<input type="button" value="검색" onclick="return false" id="search" >
</form>
</div>

<br>

<div class="2">
<jsp:include page="include/list.jsp"/>

</div>

</body>
</html>
