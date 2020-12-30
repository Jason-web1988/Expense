<%@page import="Expense.service.ExpenseService"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../../resources/javascript/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
$(function(){ var dt = new Date();

/* 	var Year = dt.getFullYear();
		var Month = "" + (dt.getMonth() + 1);
		var Day = "" + dt.getDate();

		if (Month.length < 2)
			Month = "0" + Month;
		if (Day.length < 2)
			Day = "0" + Day;

		var Today = Year.toString() + Month + Day; 
		document.getElementById("process_date").value = Today;	
		*/

		

		var contextPath = "<%=request.getContextPath()%>";
		
	var id=${param.id}
	alert("id >> " + id);
	
	$.get(contextPath + "/api/getNo/" + id, function(json){
		alert(json.name + ", " + json.use_date+ ", "+ json.use_price + ", "+ json.receipt + ", " + json.process_status + ", " +json.process_date+", "+ json.approve_price + ", " + json.remark)
		console.log(json)
		
		//처리상태 = '승인'일 때, 버튼숨김기능
		if(json.process_status == "승인"){
			$('#update').hide();
			$('#delete').hide();
		} 
		
		var name = "";
			name = json.name
			$('#name').val(name);
			console.log("name >>"+ name);
			
		var	use_date = "";
			use_date = json.use_date;
			$('#use_date').val(use_date);
			console.log("use_date >>"+ use_date);
			
 		var	process_date = "";
			process_date = json.process_date;
			if(process_date == null){
				document.getElementById("process_date").value = new Date().toISOString().substring(0,10);
			}else{
			$('#process_date').val(process_date);
			}
			console.log("process_date >>"+ process_date);

		var	use_price = "";
			use_price = json.use_price;
			$('#use_price').val(use_price);
			console.log("use_price >>"+ use_price);
			
			
		var	receipText = "";
			receipText = json.receipt;
			$('#receipText').val(receipText);
			console.log("receipText >>"+ receipText); 
		
		var	process_status = "";
			process_status = json.process_status;
			$('#process_status').val(process_status);
			console.log("process_status >>"+ process_status);
		
		var	approve_price = "";
			approve_price = json.approve_price;
			$('#approve_price').val(approve_price);
			console.log("approve_price >>"+ approve_price);
		
		var	remark = "";
			remark = json.remark;
			$('#remark').val(remark);
			
		//console.log("hskk : "+ results);	
		var receiptImgObj = $('#receiptImg');	
		var bytes, blob; 
		bytes = new Uint8Array(json.receipt); 
		blob = new Blob([bytes], {type:'image/jpg'}); 
		//data['imgSrc'] = URL.createObjectURL(blob);
		
		receiptImgObj.attr("src", "data:image/jpg; base64," + json.receipt);//URL.createObjectURL(blob));
		
		
		//var receiptImg = "";
		//	receiptImg = json.receipt;
		//	$('#receiptImg').attr("src", receiptImg);
		//	console.log("receiptImg >>"+ receiptImg); 
			
 		/* document.getElementById("process_date").value = new Date().toISOString().substring(0,10);	//현재 날짜를 기본값으로 */	
 	});
	
	$('#update').on("click", function(e){
		e.preventDefault();
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
	/* 	if(document.getElementById("receipt").value == 0) {
			alert("영수증을 첨부해주세요");
			document.getElementById("receipt").focus();
			return false;
		} */
		if(document.getElementById("process_status").value == 0) {
			alert("처리상태를 입력해주세요");
			document.getElementById("process_status").focus();
			return false;
		}
		if(document.getElementById("approve_price").value == 0) {
			alert("승인급액을 입력해주세요");
			document.getElementById("approve_price").focus();
			return false;
		}
		
		var data = {
				expense_no : id,
				name : $('#name').val(),
				use_date : $('#use_date').val(),
				use_price : $('#use_price').val(),				
				process_status : $('#process_status').val(),
				approve_price : $('#approve_price').val(),
				process_date : $('#process_date').val(),
				remark : $('#remark').val()
				//receipt : $('#use_price').val(),
				/* registration_date :  */
				
		}
		
		alert("data >> " + ", " + data.name + ", " + data.use_date + ", " + data.use_price + ", "+ data.receipt + ", " + data.process_status + ", " + data.approve_price + ", " + data.process_date + ", " + data.remark)
		console.log(data);
		$.ajax({
			url : contextPath + "/api/update/" + id,
			headers: { 
		        'Accept': 'application/json',
		        'Content-Type': 'application/json' 
		    },
			type : "PUT",
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			data : JSON.stringify(data),
			success : function(data){
				window.close();
				alert("수정이 완료되었습니다." + data);
				window.location.href="index";
			},
			error : function(request, status, error){
				alert("code : " + request.status + "\n"+"message : " + request.responseText + "\n"+"error : " + error);
			}
		});
	});
	
	$('#delete').on('click', function(){
		$.ajax({
			url : contextPath + "/api/delete/" + id,
			type: "DELETE",
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			/* data : JSON.stringify(data), */
			success : function(data){
				alert(data);
				window.location.href="index";
				alert("삭제가 완료되었습니다.");
			},
			error : function(request, status, error){
				alert("code : " + request.status + "\n"+"message : " + request.responseText + "\n"+"error : " + error);
			}
		});
	});
});

</script>
</head>
<body>

	<!-- 업데이트 -->
	<form action='' method='post'>
		<input name="expenseNo" type="hidden">
		<h3>사용내역</h3>
		<table class="update" style="float: left;">
			<tr>
				<th>사용내역</th>
				<td><select name="name" id="name">
						<option value=""></option>
						<option value="식대(야근)">식대(야근)</option>
						<option value="택시비(야근)">택시비(야근)</option>
						<option value="택시비(회식)">택시비(회식)</option>
						<option value="사무용품구매">사무용품구매</option>
						<option value="교육비">교육비</option>
						<option value="접대비">접대비</option>
				</select></td>
			</tr>
			<tr>
				<th>사용일</th>
				<td><input name="use_date" type="date" id="use_date"></td>
			</tr>
			<tr>
				<th>금액</th>
				<td><input name="use_price" type="text" id="use_price"></td>
			</tr>
			<tr>
				<th>영수증</th>
				<td><input name="receipt" type="file" id="receipt"></td>
			</tr>
		</table>

		<div class="update_image">
			<h3>영수증</h3>
			<img id='receiptImg' style="height: 300px;" />
		</div>
		<br>

		<h3>청구내역</h3>
		<table class="update">
			<tr>
				<th>처리상태</th>
				<td><select id="process_status" name="process_status">
						<option value=""></option>
						<option value="접수">접수</option>
						<option value="승인">승인</option>
						<option value="지급완료">지급완료</option>
						<option value="반려">반려</option>
				</select></td>
			</tr>
			<tr>
				<th>처리일시</th>
				<td><input name="process_date" type="date" id="process_date"></td>
			</tr>
			<tr>
				<th>금액</th>
				<td><input name="approve_price" type="text" id="approve_price"></td>
			</tr>
			<tr>
				<th>영수증</th>
				<td><input name="receipText" type="text" id="receipText"></td>
			</tr>
		</table>
		<br><br>
		<div id="show_button()">
			<input type="button" value="저장" onclick="return false" id="update" />
			<input type="button" value="삭제" id="delete"> 
			<input type="button" onclick="window.close()" value="닫기">
		</div>
	</form>


</body>
</html>