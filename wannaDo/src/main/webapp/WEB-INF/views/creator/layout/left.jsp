﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<nav>
	<header>
		<span></span>
		관리자
		<a href="${pageContext.request.contextPath}/"></a>
	</header>

	<ul>
		<li><span>Navigation</span></li>
		<li><a class="active">Home</a></li>
		<li><a>회원관리</a></li>
		<li><a>지역명소관리</a></li>
		<li><a>커뮤니티관리</a></li>
		<li><a>스터디관리</a></li>
		<li><a>고객센터관리</a></li>
		<li><span>Other</span></li>
		<c:choose>
			<c:when test="${sessionScope.member.membership >= 90 }">
				<li><a>사원관리</a></li>
			</c:when>
			<c:otherwise>
				<li style="display: none;">사원관리</li>
			</c:otherwise>
		</c:choose>		
		<li><a>Search</a></li>
		<li><a>Settings</a></li>
		<li><a href="${pageContext.request.contextPath}/member/logout">Logout</a></li>
	</ul>
</nav>
