<%@page import="org.springframework.http.MediaType"%>
<%@page import="kr.co.common.utils.UploadFileUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>게시글 자세히 보기</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="/resources/js/templateform.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
	crossorigin="anonymous"></script>
	
<style type="text/css">
	#uploaded_list li {
		list-style-type: none;
		display: inline-block;
	}	


</style>
	
</head>
<body>
<div class="container-fluid">
	<jsp:include page="../part_header.jsp"/>
</div>

	<div class="container">
		<div class="jumbotron">
			<h1 class="display-4">게시글 자세히 보기</h1>
		</div>


			<div class="form-group row">
				<label for="id">작성자</label> 
				<input class="form-control" value="${dto.id}" readonly>
			</div>
			
			<div class="form-group row">
				<label for="readcnt">조회수</label> 
				<input class="form-control" value="${dto.readcnt}" readonly>
			</div>
			
			<div class="form-group row">
				<label for="regdate">작성일</label> 
				<input class="form-control" value="${dto.regdate}" type="date" readonly>
			</div>
			
			<div class="form-group row">
				<label for="updatedate">수정일</label> 
				<input id="updatedate" class="form-control" value="${dto.updatedate}" type="date" readonly>
			</div>


			<div class="form-group row">
				<label for="title">제목</label> 
				<input id="title" class="form-control" value="${dto.title}" readonly>
			</div>
			


			<div class="form-group row">
				<label for="content">내용</label>
				<textarea id="content" class="form-control" readonly>${dto.content}</textarea>
			</div>
			
			
			
			
		<div class="form-group">

			<ul id="uploaded_list" class=" text-center row">
				
			

			</ul>

		</div>
			
			
			
			<div class="form-group row">
				<a href="/board/list/${curpage}/${criteria}${empty keyword?'':'/'}${keyword}" class="btn btn-light">목록</a>
				
				<c:if test="${dto.id == login.id}"> 
				<a class="btn btn-light" id="read_btn_updateui">수정</a> 
				<a class="btn btn-light" id="read_btn_delete">삭제</a>
				</c:if> 
				
				<c:if test="${not empty login}">
				<a class="btn btn-light" id="read_btn_replyui">댓글</a>
				</c:if>
			</div>



	
		<div class="collapse" id="mycollapse">
			<div class="form-group row">
				<label for="read_input_col_id">작성자</label> 
				<input class="form-control" id="read_input_col_id" value="${login.id}">
			</div>
			
			<div class="form-group row">
				<label for="read_input_col_pw">비밀번호</label> 
				<input type="password" class="form-control" id="read_input_col_pw">
			</div>

			<div class="form-group row">
				<label for="read_input_col_content">내용</label> 
				<input class="form-control" id="read_input_col_content">

			</div>

			<div class="form-group row">
      			<button type="submit" class="btn btn-primary reply_insert_submit">댓글 저장</button>
  			</div>
		
		</div>

		
		
		<div class="modal" tabindex="-1" id="read_div_replyui_update_modal" data-backdrop="static">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">댓글 수정 화면</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="form-group row">
							<label for="read_input_replyui_update_modal_pw">비밀번호</label> 
							<input type="password" class="form-control" id="read_input_replyui_update_modal_pw">
						</div>
					
						<div class="form-group row">
							<label for="read_input_replyui_update_modal_reply">내용</label> 
							<input class="form-control" id="read_input_replyui_update_modal_reply">
						</div>

						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
						<button data-rno="" id="read_btn_replyui_update_modal_submit" type="button" class="btn btn-primary">수정 완료</button>
					</div>
				</div>
			</div>
		</div>

	
		<div id="reply_list">
			
			
			
			
			
		</div>
	


	</div>
	
	<script type="text/javascript">
		let bno = "${dto.bno}";	
	
		$(document).ready(function() {
			
			$.getJSON("/board/getFilenames?bno="+bno, function(result) {
				for(let i=0; i<result.length;i++){
					let filename = result[i];
					let tag = ufshowform(result, filename);
					$("#uploaded_list").append(tag);
				}
				
				
				
			});
			
			
			
			
			
			
			
			
			getReplyAll(bno, $("#reply_list"));
			
			
			
			$("#reply_list").on("click", ".read_btn_replyui_delete", function() {
				let rno = $(this).parent().attr("data-rno");
				let pw = prompt("비밀번호를 입력하세요.");
				
				if(pw == ''){
					return;
				}
				
				$.ajax({
					url : "/replies",
					type : "delete",
					headers : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "delete"
					},
					data : JSON.stringify({
						rno : rno,
						pw : pw
					}),
					dataType : "text",
					success : function(result) {
						if(result == "DELETE_SUCCESS"){
							getReplyAll(bno, $("#reply_list"));
						}
					}
				});
			});
			
			
			
			
			$("#read_btn_replyui_update_modal_submit").click(function() {
				let rno = $(this).attr("data-rno");
				let pw = $("#read_input_replyui_update_modal_pw").val();
				let reply = $("#read_input_replyui_update_modal_reply").val();
				
				if(pw == '' || reply == ''){
					return;
				}
				
				$.ajax({
					url : "/replies",
					type : "put",
					headers : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "PUT"
					},
					data : JSON.stringify({
						rno : rno,
						pw : pw,
						reply : reply
					}),
					dataType : "text",
					success : function(result) {
						if(result == "UPDATE_SUCCESS"){
							$("#read_div_replyui_update_modal").modal("toggle");
							getReplyAll(bno, $("#reply_list"));
						}
					}
					
				});
				
			
			});
			
			
			$("#reply_list").on("click", ".read_btn_replyui_update", function() {
				let rno = $(this).parent().attr("data-rno");
				let reply = $(this).prev().text();
				
				$("#read_div_replyui_update_modal").modal("toggle");
				
				$("#read_input_replyui_update_modal_reply").val(reply);
				
				$("#read_btn_replyui_update_modal_submit").attr("data-rno", rno);
				
				
			});
			
			
			
			$(".reply_insert_submit").click(function() {
				let id = $("#read_input_col_id").val();
				let pw= $("#read_input_col_pw").val();
				let reply = $("#read_input_col_content").val();
				
				$.ajax({
					url : "/replies",
					type : "post",
					headers : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "POST"
					},
					data : JSON.stringify({
						"bno" : bno,
						"id" : id,
						"pw" : pw,
						"reply" : reply
					}),
					dataType : "text",
					success : function(result) {
						alert(result);
						replyui_clear();
						$("#mycollapse").collapse("toggle");
						getReplyAll(bno, $("#reply_list"));
					}
					
				});
				
			});	
		
			
			
			
			
			$("#read_btn_replyui").click(function() {
				replyui_clear();
				
				$("#mycollapse").collapse("toggle");
			});
			
			
			
			
			
			$("#read_btn_delete").click(function() {
				let pw = prompt("비밀번호를 입력하세요.");
				
				$.ajax({
					url : "/board/delete/"+bno,
					type : "post",
					data : {
						"pw" : pw
					},
					dataType : "text",
					success : function(result) {
						if(result > 0){
							alert("삭제 성공");
							location.assign("/board/list/${curpage}/${criteria}${empty keyword?'':'/'}${keyword}");
						} else{
							alert("삭제 실패");
						}
					}
				});
			});
			
			$("#read_btn_modal_submit").click(function() {
				let title = $("#read_input_modal_title").val();
				let content = $("#read_ta_modal_content").val();
				let pw = $("#read_input_modal_pw").val();
				
				
				$.ajax({
					url : '/board/update',
					type : 'post',
					data : {
						"bno" : bno,
						"pw" : pw,
						"title" : title,
						"content" : content
					},
					dataType : "text",
					success : function(result) {
						if(result > 0){
							$("#title").val(title);
							$("#content").val(content);
							
							let today = new Date();
							let year = today.getFullYear();
							let month = today.getMonth() + 1;
							let date = today.getDate();
							month = month >= 10 ? month : '0'+month;
							date = date >= 10 ? date : '0'+date;
							
							today = year+"-"+month+"-"+date;
							$("#updatedate").val(today);
							
							$("#read_div_modal").modal("toggle");
							
						}else{
							alert("비밀번호를 확인하세요.");
							$("#read_input_modal_pw").focus();
							$("#read_input_modal_pw").select();
						}
					}
				});
				
			});
			
			
			
			$("#read_btn_updateui").click(function() {
				location.assign("/board/updateui/${curpage}/${criteria}${empty keyword?'':'/'}${keyword}${empty keyword?'':'/'}"+bno);
			});
			
			
			
			function replyui_clear() {
				$("#read_input_col_id").val("");
				$("#read_input_col_pw").val("");
				$("#read_input_col_content").val("");
			}
			
		});
	</script>
	
	
	
	
	
	
	
	
</body>
</html>