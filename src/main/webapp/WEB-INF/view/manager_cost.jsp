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
	document.getElementById("registration_date").value = new Date().toISOString().substring(0,10);
	
	function numberFormat(inputNumber){		//천단위 ","해주기
        return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	var contextPath = "<%=request.getContextPath()%>";
	
	$('#search').on("click", function(e){
		e.preventDefault();
		
		var data = {
				registration_date : $('#registration_date').val(),
				name : $('#name').val(),
				process_status : $('#process_status').val()
		};
		if(document.getElementById("registration_date").value == 0) {
			alert("등록년월을 선택해주세요");
			document.getElementById("registration_date").focus();
			return false;
		}
		if(document.getElementById("name").value == 0) {
			alert("사용내역을 선택해주세요");
			document.getElementById("name").focus();
			return false;
		}
		if(document.getElementById("process_status").value == 0) {
			alert("처리상태를 선택해주세요");
			document.getElementById("process_status").focus();
			return false;
		}
		 alert("data > " + data.registration_date + ", " + data.name + ", " + data.process_status)
		//console.log("data > " + data.registration_date + " " + data.name + " " + data.process_status)
		
		$.ajax({
			url : "/api/getList", 
			type : 'GET',
			contentType : "application/json; charset=utf-8",
			dataType : 'JSON',
			// processDate : false,
			cache : false,
			data : data, //JSON.stringify(data)
			success : function(res){
				alert("결과 값 >> " + res);
				/* console.log("결과값 >>>> " + res); */
				
			/* 	window.location.href=contextPath + "/search"; */
							
				var dataLength = res.length;
				if(dataLength >= 1){
					console.log('dataLength >= 1');
					var totalUsePrice = 0;
					var totalApprovePrice = 0;	
					var sCont = "";
					for(i=0; i<dataLength; i++){
						var popUp = "window.open(\'/update?id=" + res[i].expense_no + "\',\'_blank\',\'width=630\height=430\')";
						
						sCont += "<tr>";
						sCont += "<td>" + res[i].expense_no + "</td>";
						sCont += "<td>" + res[i].use_date + "</td>";
						//sCont += "<td><a href='update?id" + res[i].expense_no + "'>" + res[i].name + "</a></td>";
						sCont += "<td><a href='javascript:void(0);' onclick=" + popUp + ">" + res[i].name + "</a></td>";
						sCont += "<td>" + numberFormat(res[i].use_price) + "</td>";
						sCont += "<td>" + numberFormat(res[i].approve_price) + "</td>";
						sCont += "<td>" + res[i].process_status + "</td>";
						sCont += "<td>" + res[i].registration_date + "</td>";
						/* sCont += "<td>" + json[i].receipt + "</td>";
						sCont += "<td>" + json[i].process_date + "</td>";
						sCont += "<td>" + json[i].remark + "</td>"; */
						sCont += "</tr>"; 
						
						totalUsePrice +=  res[i].use_price;
						totalApprovePrice += res[i].approve_price;
					}
					sCont += "<tr>";
					sCont += "<td><b>합계</b></td>";
					sCont += "<td></td>";
					sCont += "<td></td>";
					sCont += "<td>" + numberFormat(totalUsePrice) + "</td>";
					sCont += "<td>" + numberFormat(totalApprovePrice) + "</td>";
					sCont += "<td></td>";
					sCont += "<td></td>";
					sCont += "</tr>";
					
				} 
			 	else {
					console.log('dataLength == 0');
					var sCont = "";
					sCont += "<tr>";
					sCont += "<td></td>";
					sCont += "<td></td>";
					sCont += "<td></td>";
					sCont += "<td></td>";
					sCont += "<td></td>";
					sCont += "<td></td>";
					sCont += "<td></td>";
					/* sCont += "<td>" + json[i].receipt + "</td>";
					sCont += "<td>" + json[i].process_date + "</td>";
					sCont += "<td>" + json[i].remark + "</td>"; */
					sCont += "</tr>"; 
				} 
				$("#load").html(sCont);
			},
			error : function(request, status, error){
				alert("code : " + request.status + "\n"+"message : " + request.responseText + "\n"+"error : " + error);
				 window.location.href=contextPath + "/index";
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
		<input name='registration_date' type='date' id="registration_date">
			
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
		<select name="process_status" id="process_status">
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