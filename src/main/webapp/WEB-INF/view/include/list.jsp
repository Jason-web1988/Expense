<%@page import="Expense.service.ExpenseService"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resources/css/css.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
$(function(){
	document.getElementById("registration_date").value = new Date().toISOString().substring(0,10);	//현재 날짜를 기본값으로
	
	function numberFormat(inputNumber){		//천단위 ","해주기
        return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	var contextPath = "<%=request.getContextPath()%>";
	/* console.log(contextPath); */
	
	$.get(contextPath+"/api/list", function(json){
		var dataLength = json.length;
		//alert("list >> " + json);
		if(dataLength >= 1){
			var sCont = "";
			var totalUsePrice = 0;
			var totalApprovePrice = 0;	
			for(i=0; i<dataLength; i++){
				var popUp = "window.open(\'/update?id=" + json[i].expense_no + "\',\'_blank\',\'width=630\height=430\')";
				
				sCont += "<tr>";
				sCont += "<td>" + json[i].expense_no + "</td>";
				sCont += "<td>" + json[i].use_date + "</td>";
				/* sCont += "<td><a href='/update?id=" + json[i].expense_no + "'>" + json[i].name + "</a></td>"; */
				sCont += "<td><a href='javascript:void(0);' onclick=" + popUp + ">" + json[i].name + "</a></td>";
				sCont += "<td>" + numberFormat(json[i].use_price) + "</td>";
				sCont += "<td>" + numberFormat(json[i].approve_price) + "</td>";
				sCont += "<td>" + json[i].process_status + "</td>";
				sCont += "<td>" + json[i].registration_date + "</td>"
				/* sCont += "<td>" + json[i].receipt + "</td>";
				sCont += "<td>" + json[i].process_date + "</td>";
				sCont += "<td>" + json[i].remark + "</td>"; */
				sCont += "</tr>"; 
				totalUsePrice +=  json[i].use_price;
				totalApprovePrice += json[i].approve_price;
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
			$("#load:last-child").append(sCont);
		}
	});
	
	$('#excelDown').on('click',function(e){
		alert("엑셀다운로드");
		$.ajax({
			url : "/api/excelDown", 
			type : 'GET',
			contentType : "application/json; charset=utf-8",
			dataType : 'JSON',
			// processDate : false,
			//cache : false,
			//data : data, //JSON.stringify(data)
			success : function(res){
				alert("결과 값 >> " + res);
			},
			error : function(request, status, error){
				alert("code : " + request.status + "\n"+"message : " + request.responseText + "\n"+"error : " + error);
				 //window.location.href=contextPath + "/index";
			}
		});
	});
			
});


</script>
</head>
<body>


<br>

<div class="add_button">
			<button type="button" id="excelDown">엑셀다운로드</button>
			<input type="button" onclick="window.open('register', 'registerExpense', 'width = 430 height = 430')" value="등록">
</div>



<table border="1"> 
	<thead>
		<tr>
			<th>순번</th>
			<th>사용일</th>
			<th>사용내역</th>
			<th>사용금액</th>
			<th>승인금액</th>
			<th>처리상태</th>
			<th>등록일</th>
		</tr>
	</thead>
	<tbody id="load">
	</tbody>
</table>
</body>
</html>