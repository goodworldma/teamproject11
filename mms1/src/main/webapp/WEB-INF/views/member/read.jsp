<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>회원 정보 자세히 보기</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>

<style type="text/css">
	.addBorder{
		border: 1px solid green;
	}

</style>


</head>
<body>
<div class="container">

<div class="jumbotron">
  <h1 class="display-4">회원 정보 자세히 보기</h1>
</div>

<table class="table table-bordered ">
  <tbody>
    <tr>
      <th scope="col" class="col-sm-3 text-right">아이디</th>
      <td scope="col">${dto.id}</td>
    </tr>
  
    <tr>
      <th scope="col" class="col-sm-3 text-right">이름</th>
      <td scope="col">${dto.name}</td>
    </tr>
    
    <tr>
      <th scope="col" class="col-sm-3 text-right">회원 등급</th>
      <td scope="col">${dto.grade}</td>
    </tr>
    
    <tr>
      <th scope="col" class="col-sm-3 text-right">생년월일(나이)</th>
      <td scope="col">${dto.birth}(만 ${dto.age} 세)</td>
    </tr>
    
    <tr>
      <th scope="col" class="col-sm-3 text-right">이메일</th>
      <td scope="col">${dto.email}</td>
    </tr>
    
    <tr>
      <th scope="col" class="col-sm-3 text-right">주소</th>
      <td scope="col">${dto.address}</td>
    </tr>
  </tbody>
</table>

	<div class="menus text-center mt-5">
		<button type="button" class="btn btn-warning" id="mupdate">회원 정보 수정</button>
		<button type="button" class="btn btn-warning" id="pupdate">비밀번호 수정</button>
		<button type="button" class="btn btn-warning" id="mdelete">회원 탈퇴</button>
	</div>



		<div class="modal" tabindex="-1" id="mymodal">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">비밀번호 변경</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-group row text-center">
							<span id="failmsg" class="col-sm-12"></span>
						</div>


						<div class="form-group row">
							<label for="pw1" class="col-sm-2 col-form-label text-right">기존 비밀번호</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" id="pw" name="pw">
							</div>
						</div>
						
						<div class="form-group row">
							<label for="pw1" class="col-sm-2 col-form-label text-right">신규 비밀번호</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" id="npw" name="npw">
							</div>
						</div>
						
						<div class="form-group row">
							<label for="pw1" class="col-sm-2 col-form-label text-right">신규 비밀번호(확인)</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" id="npw2">
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"	data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-warning" id="changepw">비밀번호 변경</button>
					</div>
				</div>
			</div>
		</div>


	</div>


<script type="text/javascript">
	$(document).ready(function() {
		
		$("#mymodal").on("click", "button[data-dismiss='modal']", function() {
			defaultPwInput();
		});
		
	
		
		$("#changepw").click(function() {
			let pw = $("#pw").val();
			let npw = $("#npw").val();
			let npw2 = $("#npw2").val();
			
			if(pw == "" | npw == "" | npw2 == ""){
				return false;
			}
			
			if(npw != npw2){
				return false;
			}
			
			$.ajax({
				url : '/member/changepw',
				type : "post",
				data : {
					"pw" : pw,
					"npw" : npw,
					"id" : "${dto.id}"
				},
				dataType : "text",
				success : function(result){
					if(result > 0){
						defaultPwInput();
						
						$("#mymodal").modal("toggle");
					}else{
						$("#failmsg").text(" 비밀번호 변경 실패 ");
						$("#failmsg").css("color", "red");
						$("#failmsg").addClass("addBorder");
					}
					
					
				}
			});
			
			
			
		});
		
		$("#pupdate").click(function() {
			$("#mymodal").modal("toggle");
		});
		
		
		$("#mupdate").click(function() {
			location.assign("/member/update/${dto.id}");
		});
		
		
		function defaultPwInput() {
			$("#pw").val("");
			$("#npw").val("");
			$("#npw2").val("");
			$("#failmsg").text("");
			$("#failmsg").removeClass("addBorder");
		}
		
		
	});
</script>

</body>
</html>