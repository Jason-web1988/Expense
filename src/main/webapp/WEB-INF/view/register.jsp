<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../../resources/javascript/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
<%-- $(function(){
	var contextPath = "<%=request.getContextPath()%>
	";

		$('#add').on("click", function(e) {
			e.preventDefault();
			var data = {
				name : $('#name').val(),
				use_date : $('#use_date').val(),
				use_price : $('#use_price').val(),
				receipt : $('#receipt').val()
			};
			if (document.getElementById("name").value == 0) {
				alert("사용내역을 선택해주세요");
				document.getElementById("name").focus();
				return false;
			}
			if (document.getElementById("use_date").value == 0) {
				alert("사용일을 입력해주세요");
				document.getElementById("use_date").focus();
				return false;
			}
			if (document.getElementById("use_price").value == 0) {
				alert("금액을 입력해주세요");
				document.getElementById("use_price").focus();
				return false;
			}
			if (document.getElementById("receipt").value == 0) {
				alert("영수증을 첨부해주세요");
				document.getElementById("receipt").focus();
				return false;
			}

			$.ajax({
				url : "/api/newExpense/",
				//headers: { 
				//    'Accept': 'application/json',
				//    'Content-Type': 'application/json' 
				//}, 
				type : "POST",
				contenType : "application/json; charset=utf-8",
				dataType : 'JSON',
				cache : false,
				data : JSON.stringify(data),
				success : function(res) {
					console.log('Ajax submit success');
					//alert("추가 완료되었습니다." + res);
					//window.close();
					window.location.href = "index";
				},
				error : function(request, status, error) {
					console.log('Ajax submit error');
					//alert("code : " + request.status + "\n"+"message : " + request.responseText + "\n"+"error : " + error);
					/* console.dir(request.responseText); */
					/*  window.location.href=contextPath + "/index"; */
				}
			});
		});

		//파일선택 클릭시
		$('#receipt').on(
				"click",
				function(e) {
					$.ajax({
						url : "/api/upload/",
						enctype : 'multipart/form-data', // 필수
						/* 	headers: { 
						       'Accept': 'application/json',
						       'Content-Type': 'application/json' 
						   },  */
						type : "POST",
						contenType : false,
						//processData : false,
						//dataType : 'JSON',
						processData : false,
						contentType : false,
						cache : false,
						data : {
							file : $('#receipt').val()
						},
						beforeSend : function() {
							console.log('Ajax submit beforeSend' + data);
						},
						complete : function() {
							console.log('Ajax submit complete');
						},
						success : function(res) {
							alert("추가 완료되었습니다." + res);
							window.location.href = "index";
						},
						error : function(request, status, error) {
							alert("code : " + request.status + "\n"
									+ "message : " + request.responseText
									+ "\n" + "error : " + error);
							/* console.dir(request.responseText); */
							/*  window.location.href=contextPath + "/index"; */
						}
					});

				});

	});  --%>
	

$(function () {
	$('#closeBtn').on("click", function(e) {
		window.close();
	});
	
	$('#registBtn').on("click", function() {
		var formDataRaw = $('#fileUploadForm')[0];
		var data = new FormData(formDataRaw);
		if (document.getElementById("name").value == 0) {
			alert("사용내역을 선택해주세요");
			document.getElementById("name").focus();
			return false;
		}
		if (document.getElementById("use_date").value == 0) {
			alert("사용일을 입력해주세요");
			document.getElementById("use_date").focus();
			return false;
		}
		if (document.getElementById("use_price").value == 0) {
			alert("금액을 입력해주세요");
			document.getElementById("use_price").focus();
			return false;
		}
		if (document.getElementById("receipt").value == 0) {
			alert("영수증을 첨부해주세요");
			document.getElementById("receipt").focus();
			return false;
		}
		$.ajax({
	        type: "POST",
	        enctype: 'multipart/form-data',
	        url: "/api/newExpense",
	        processData: false, //prevent jQuery from automatically transforming the data into a query string
	        contentType: false,
	        cache: false,
	        data: data,
	        beforeSend : function() {
				console.log('Ajax beforeSend');
			},
			complete : function() {
				console.log('Ajax complete');
			},
	        success: function (data) {
	            $("#result").text(data);
	            console.log("SUCCESS : ", data);
	            $("#btnSubmit").prop("disabled", false);
	            window.close();
				alert("성공하였습니다."+data);
				window.location.href = "index";
				//window.location.reload(true);
	        },
	        error: function (e) {
	            $("#result").text(e.responseText);
	            console.log("ERROR : ", e);
	            $("#btnSubmit").prop("disabled", false);

	        }
	    });
		
	});
})
</script>

</head>
<body>
	<h2 class='add_container'>경비 등록 / 수정</h2>
	<form method="POST" id="fileUploadForm" enctype="multipart/form-data">
		<table class="add_table">
			<tr>
				<th>사용내역*</th>
				<td><select id="name" name="use_history" id="name">
						<option value="" selected>선택</option>
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
				<td><input name="use_date" type="date" id="use_date" /></td>
			</tr>
			<tr>
				<th>금액*</th>
				<td><input name="use_price" type="text" id="use_price" /></td>
			</tr>
			<tr>
				<th>영수증*</th>
				<td><input name="receipt" type="file" id="receipt"/></td>
			</tr>
		</table>
		<br />
		<div>
			<input type="button" value="닫기" id="closeBtn" /> 
			<input type="button" value="저장" id="registBtn" />
		</div>
	</form>

</body>
</html>