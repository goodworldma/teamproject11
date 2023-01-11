<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="false"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>${empty pt.criteria? '게시글 목록 화면' : '검색 목록 화면'}</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
</head>
<body>
<div class="container-fluid">
	<jsp:include page="../part_header.jsp"/>
</div>



<div class="container">
	<div class="jumbotron">
			<h1 class="display-4">${empty pt.criteria? '게시글 목록 화면' : '검색 목록 화면'}</h1>
	</div>
	
	<a href="/board/insert" class="btn btn-primary my-3">글쓰기</a>

	<table class="table">
  		<thead>
		    <tr>
		      <th scope="col" class="text-center">글번호</th>
		      <th scope="col" class="text-center">제목</th>
		      <th scope="col" class="text-center">작성자</th>
		      <th scope="col" class="text-center">조회수</th>
		      <th scope="col" class="text-center">작성일</th>
		    </tr>
  		</thead>
  		<tbody>
  		<c:forEach items="${list}" var="dto">
  			<tr>
		      <td class="text-center">${dto.bno}</td>
		      <td><a href="/board/read/${dto.bno}/${pt.curpage}/${pt.criteria}${empty pt.keyword?'':'/'}${pt.keyword}">${dto.title}</a></td>
		      <td class="text-center">${dto.id}</td>
		      <td class="text-center">${dto.readcnt}</td>
		      <td class="text-center">${dto.regdate}</td>
		    </tr>
  		</c:forEach>
		
   
  		</tbody>
	</table>
	
	<jsp:include page="part_paging.jsp"/>
	
	<jsp:include page="part_search.jsp"/>
	
</div>


<script type="text/javascript">
	$(document).ready(function() {
		$("form").on("click", "#search_submit", function(event) {
			event.preventDefault();
			let criteria = $("select[name='criteria']").val();
			let keyword = $("input[name='keyword']").val();
			
			
			let uri = "/board/list/"+criteria+"/"+keyword;
			
			$("form").attr("action", uri);
			$("form").attr("method", "post");
			
			$("form").submit();
			
		});
	});
	
	
</script>



</body>
</html>