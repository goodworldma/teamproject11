<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>회원 가입 화면</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
	crossorigin="anonymous"></script>
</head>
<body>

<div class="container-fluid">
	<jsp:include page="../part_header.jsp"/>
</div>

	<div class="container">
		<div class="jumbotron">
			<h1 class="display-4">회원 가입 화면</h1>
		</div>

		<form action="/member/insert" method="post">
			<div class="form-group row" id="dividp">
				<label for="id" class="col-sm-2 col-form-label text-right">아이디</label>
				<div class="col-sm-8">
					<input class="form-control" id="id" name="id" required>
				</div>
				<div class="col-sm-2 text-right">
					<button class="btn btn-info" id="checkid">ID 중복 검사</button>
				</div>
				
				<div id="divid" class="col-sm-10  offset-sm-2">
				
				</div>
			</div>

			<div class="form-group row">
				<label for="name" class="col-sm-2 col-form-label text-right">이름</label>
				<div class="col-sm-10">
					<input class="form-control" id="name" name="name" required>
				</div>
			</div>

			<div class="form-group row">
				<label for="pw1" class="col-sm-2 col-form-label text-right">비밀번호</label>
				<div class="col-sm-10">
					<input type="password" class="form-control" id="pw1" name="pw" required>
				</div>
			</div>

			<div class="form-group row">
				<label for="pw2" class="col-sm-2 col-form-label text-right">비밀번호(확인)</label>
				<div class="col-sm-10">
					<input type="password" class="form-control" id="pw2" required>
				</div>
			</div>


			<div class="form-group row">
				<label for="birth" class="col-sm-2 col-form-label text-right">생년월일</label>
				<div class="col-sm-10">
					<input class="form-control" id="birth" name="birth" type="date" required>
				</div>
			</div>

			<div class="form-group row">
				<label for="email" class="col-sm-2 col-form-label text-right">이메일</label>
				<div class="col-sm-10">
					<input class="form-control" id="email" name="email" type="email" required>
				</div>
			</div>


			<div class="form-group row">
				<label for="address" class="col-sm-2 col-form-label text-right">주소</label>
				<div class="col-sm-10">
					<input class="form-control" id="address" name="address" required>
				</div>
			</div>
		
			<div class="form-group row">
    			<div class="col-sm-10" id="divsubmitp">
      				<button type="submit" class="btn btn-primary">가입</button>
    			</div>
  			</div>
		
		</form>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			let checkId = false;
			
			
			$("#dividp").on("input", "#id", function() {
				/* $(this):이번트 소스를 가리킴 */
				checkId = false;
			});
			
			
			
			$("#dividp").on("click", "#checkid", function(event) {
				event.preventDefault();
				let id = $("#id").val();
				
				if(id == ''){
					$("#id").focus();
					return false;
				}
				
				$.ajax({
					url : "/member/checkid",
					type : 'post',
					data : {
						"id" : id
					},
					dataType : "text",
					success : function(result) {
						let msg = "";
						
						if(result == 1){
							msg = "사용 <span style='color:green;'>가능</span>한 아이디입니다.";
							checkId = true;
							
							
						} else {
							$("#id").val("");
							
							msg = "사용 <span style='color:red;'>불가능</span>한 아이디입니다.";
							
						}
						$("#divid").html(msg);
						
						
					}
				});
			});
			

			
			
			
			$("#divsubmitp").on("click","button[type='submit']" , function(event) {
				event.preventDefault();
				
				if(checkId){
					let id = $("#id").val();
					
					if(id == ""){
						$("#id").focus();
						return false;
					}
					
					let pw1 = $("#pw1").val();
					let pw2 = $("#pw2").val();
					
					if(pw1 == "" || pw2 == ""){
						$("#pw1").focus();
						return false;
					}
					
					if(pw1 != pw2){
						$("#pw2").val("");
						$("#pw1").select();
						$("#pw1").focus();
						return false;
					} 
					
					$("form").submit();
				} else{
					alert("아이디 중복 검사를 하세요.");
				}
			});
			
			
		});
	</script>
	
	
	
	
	
	
	
	
</body>
</html>