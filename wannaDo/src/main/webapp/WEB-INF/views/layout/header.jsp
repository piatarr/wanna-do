﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

	<div class="container-fluid header-top">
		<div class="container px-5">
			<div class="row">
				<div class="col">
					<div class="p-2">
					</div>
				</div>
				<div class="col">
					<div class="d-flex justify-content-end">
						<c:choose>
							<c:when test="${empty sessionScope.member}">
								<div class="p-2">
									<a href="javascript:dialogLogin();" title="로그인"><i class="bi bi-lock"></i></a>
								</div>
								<div class="p-2">
									<a href="${pageContext.request.contextPath}/member/member" title="회원가입"><i class="bi bi-person-plus"></i></a>
								</div>	
							</c:when>
							<c:otherwise>
								<div class="p-2">
									<a href="${pageContext.request.contextPath}/member/logout" title="로그아웃"><i class="bi bi-unlock"></i></a>
								</div>					
								<div class="p-2">
									<a href="${pageContext.request.contextPath}/note/receive/list" title="쪽지">
										<i class="bi bi-envelope position-relative" id="note"></i>
									</a>
								</div>
								<c:if test="${sessionScope.member.membership>50}">
									<div class="p-2">
										<a href="${pageContext.request.contextPath}/admin" title="관리자"><i class="bi bi-gear"></i></a>
									</div>					
								</c:if>
								<c:if test="${sessionScope.member.membership>21 && sessionScope.member.membership<51 }">
									<div class="p-2">
										<a href="${pageContext.request.contextPath}/creator" title="크리에이터"><i class="bi bi-gear"></i></a>
									</div>					
								</c:if>
							</c:otherwise>
						</c:choose>
					</div>
					
				</div>
			</div>
		</div>
	</div>

    <nav class="navbar navbar-expand-lg navbar-dark" style="border-bottom: 2px red solid; padding-top:0; ">
         <div class="container px-5">
             <a class="navbar-brand text-danger" href="${pageContext.request.contextPath}/">Wanna Do</a>
             <button class="navbar-toggler bg-danger" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
             <div class="collapse navbar-collapse" id="navbarSupportedContent">
                 <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                     <li class="nav-item"><a class="nav-link text-danger" href="${pageContext.request.contextPath}/">홈</a></li>
                     <li class="nav-item"><a class="nav-link text-danger" href="${pageContext.request.contextPath}/about">소개</a></li>
                     <li class="nav-item dropdown">
                         <a class="nav-link dropdown-toggle text-danger" id="navbarDropdownBlog" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">강좌</a>
                         <ul class="dropdown-menu dropdown-menu-end text-danger" aria-labelledby="navbarDropdownBlog">
                             <li><a class="dropdown-item" href="${pageContext.request.contextPath}/course/list">강좌목록</a></li>
                             <li><a class="dropdown-item" href="${pageContext.request.contextPath}/calendar/list">시험일정</a></li>
                         </ul>
                     </li>
                     <li class="nav-item dropdown">
                         <a class="nav-link dropdown-toggle text-danger" id="navbarDropdownBlog" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">커뮤니티</a>
                         <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownBlog">
                             <li><a class="dropdown-item" href="${pageContext.request.contextPath}/study/list">스터디 룸</a></li>
                             <li><a class="dropdown-item" href="${pageContext.request.contextPath}/trade/list">중고거래</a></li>
                         </ul>
                     </li>
					 <c:if test="${empty sessionScope.member}">
	                     <li class="nav-item"><a class="nav-link text-danger" href="${pageContext.request.contextPath}/credit/buy">쿠키샵</a></li>
					 </c:if>
                     <li class="nav-item dropdown">
                         <a class="nav-link dropdown-toggle text-danger" id="navbarDropdownBlog" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">고객센터</a>
                         <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownBlog">
                             <li><a class="dropdown-item" href="${pageContext.request.contextPath}/notice/list">공지사항</a></li>
                             <li><a class="dropdown-item" href="${pageContext.request.contextPath}/faq">자주 묻는 질문</a></li>
                         </ul>
                     </li>
					<c:if test="${sessionScope.member.membership>0}">
	                     <li class="nav-item dropdown">
	                         <a class="nav-link dropdown-toggle text-danger" id="navbarDropdownBlog" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">마이페이지</a>
	                         <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownBlog">
	                             <li><a class="dropdown-item" href="${pageContext.request.contextPath}/myAccount/list">내 정보</a></li>
	                             <li><a class="dropdown-item" href="${pageContext.request.contextPath}/myCourse/list">나의 학습</a></li>
	   							 <c:if test="${sessionScope.member.membership>0 && sessionScope.member.membership<51 }">
									<li><a class="dropdown-item" href="${pageContext.request.contextPath}/credit/buy">쿠키샵</a></li>
									<hr>
									<li><a class="dropdown-item" href="${pageContext.request.contextPath}/member/pwd">내정보 수정</a></li>
									<li><a class="dropdown-item" href="${pageContext.request.contextPath}/member/change">크리에이터 전환</a></li>
	   							 </c:if>
	                         </ul>
	                     </li>	
					</c:if>             
                 </ul>
             </div>
         </div>
     </nav>

<script type="text/javascript">
	$(function(){
		var isLogin = "${not empty sessionScope.member ? 'true':'false'}";
		if(isLogin === "true") {
			newNoteCount();
		}

		function newNoteCount() {
			var url = "${pageContext.request.contextPath}/note/newNoteCount";
			$.ajax({
				type:"POST",
				url:url,
				data:null,
				dataType:"json",
				success:function(data) {
					var newNoteCount = data.newNoteCount;
					
					if(newNoteCount > 0) {
						$("#note").html("<span class='position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger' style='display:inline-block; height:15px; width:15px; text-align:center; font-size:1px; valign:bottom;'>"+newNoteCount+"<span class='visually-hidden'>읽지 않은 새 쪽지</span></span>");
					}
					
				}
			});
		}
	});
</script>
