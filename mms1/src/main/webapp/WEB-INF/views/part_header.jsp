<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<header style="height: 30px;">
	<div class="float-right">
	<c:choose>
		<c:when test="${empty login}">
			<a href="/member/login">로그인</a> | <a href="/member/insert">회원가입</a>	
		</c:when>
		<c:otherwise>
			${login.id}님, 환영합니다. 
			<a href="/member/logout">로그아웃</a> | 
			<a href="/member/update/${login.id}">회원 정보 변경</a> | 
			<a href="/member/updatepwui/${login.id}">비밀번호 변경</a>
		</c:otherwise>
	</c:choose>
	</div>
	<hr class="clearfix">
</header>

