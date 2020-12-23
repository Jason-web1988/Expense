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
	
	$('#add').on("click", function(e){
		e.preventDefault();
		var data = {
				name : $('#name').val(),
				use_date : $('#use_date').val(),
				use_price : $('#use_price').val(),
				receipt : $('#receipt').val()
		};
		if(document.getElementById("name").value == 0) {
			alert("사용내역을 선택해주세요");
			document.getElementById("name").focus();
			return false;
		}
		if(document.getElementById("use_date").value == 0) {
			alert("사용일을 입력해주세요");
			document.getElementById("use_date").focus();
			return false;
		}
		if(document.getElementById("use_price").value == 0) {
			alert("금액을 입력해주세요");
			document.getElementById("use_price").focus();
			return false;
		}
		if(document.getElementById("receipt").value == 0) {
			alert("영수증을 첨부해주세요");
			document.getElementById("receipt").focus();
			return false;
		}
		$.ajax({
			url : contextPath + "/api/newExpense/",
			type : "POST",
			contenType : "application/json; charset=utf-8",
			dataType : 'JSON',
			cache : false,
			data : JSON.stringify(data), 
			success : function(res){
				alert(res);
				window.location.href="index";
			},
			error : function(request, status, error){
				alert("code : " + request.status + "\n"+"message : " + request.responseText + "\n"+"error : " + error);
				/*  window.location.href=contextPath + "/index"; */
			}
		});
	});
});
</script>
</head>
<body>
<form action='../expense/add.do' method='post' enctype='multipart/form-data' target="list.do">

<h2 class='add'>경비 등록  / 수정</h2>
<table class="add">
    <tr>
       <th>사용내역*</th>
       <td><select id="name">
    <option value="" selected> 선택</option>
    <option value="식대(야근)">식대(야근)</option>
    <option value="택시비(야근)">택시비(야근)</option>
    <option value="택시비(회식)">택시비(회식)</option>
    <option value="사무용품구매">사무용품구매</option>
    <option value="교육비">교육비</option>
    <option value="접대비">접대비</option>
    </select></td> 
   </tr>
    <tr>
       <th>사용일*</th>
       <td><input name="use_date" type="date" id="use_date"></td>
   </tr>
    <tr>
       <th>금액*</th>
       <td><input name="use_price" type="text" id="use_price"></td>
   </tr>
    <tr>
       	<th>영수증*</th>
    	<td><input name="receipt" type="file" id="receipt"></td>
  </tr>

</table>
  <input name="registrationDate" type="date" style="display: none" id="currentDate">
    <script>
</script> 
<div class='button'>
<input type="button" onclick="window.close()" value="닫기"/>
<input type="button" value="저장" onclick="return false" id="add"/>
</div>
</form>
</body>
</html>