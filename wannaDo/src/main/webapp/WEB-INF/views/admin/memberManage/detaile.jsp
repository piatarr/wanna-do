<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<h3 style="font-size: 15px; padding-top: 10px;"><i class="icofont-double-right"></i> 회원 정보</h3>
<table class="table border mx-auto my-10">
	<tr>
		<td class="wp-15 text-right pe-7 bg">회원번호</td>
		<td class="wp-35 text-start">${dto.memberIdx}</td>
		<td class="wp-15 text-right pe-7 bg">아이디</td>
		<td class="wp-35 text-start">${dto.userId}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">이름</td>
		<td class="text-start">${dto.userName}</td>
		<td class="text-right pe-7 bg">생년월일</td>
		<td class="text-start">${dto.birth}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">전화번호</td>
		<td class="text-start">${dto.tel}</td>
		<td class="text-right pe-7 bg">이메일</td>
		<td class="text-start">${dto.email}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">회원가입일</td>
		<td class="text-start">${dto.register_date}</td>
		<td class="text-right pe-7 bg">최근로그인</td>
		<td class="text-start">${dto.last_login}</td>
	</tr>
	
	<tr>
		<td class="text-right pe-7 bg">계정상태</td>
		<td colspan="3" class="text-start">
			${dto.enabled==1?"활성":"잠금"}
			<c:if test="${dto.enabled==0 && not empty memberState}">, ${memberState.memo}</c:if>
			&nbsp;<span class="btn" onclick="memberStateDetaileView();" style="cursor: pointer;">자세히</span>
		</td>
	</tr>
</table>

<form id="deteailedMemberForm" name="deteailedMemberForm" method="post">
	<h3 style="font-size: 15px; padding-top: 10px;"><i class="icofont-double-right"></i> 유저 상태 변경</h3>
	
	<table class="table border mx-auto my-2">
		<tr>
			<td class="wp-15 text-right pe-7 bg">계정상태</td>
			<td class="text-start">
				<select class="selectField" name="stateCode" id="stateCode" onchange="selectStateChange()">
					<option value="">::상태코드::</option>
					<c:if test="${dto.enabled==0}">
						<option value="0">잠금 해제</option>
					</c:if>
					<option value="2">불법적인 방법으로 로그인</option>
					<option value="3">불건전 게시물 등록</option>
					<option value="4">다른 유저 비방</option>
					<option value="5">타계정 도용</option>
					<option value="6">기타 약관 위반</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="text-right pe-7 bg">메모</td>
			<td class="text-start">
				<input type="text" name="memo" id="memo" class="boxTF" style="width: 90%;">
			</td>
		</tr>
	</table>
	
	<input type="hidden" name="memberIdx" value="${dto.memberIdx}">
	<input type="hidden" name="userId" value="${dto.userId}">
	<input type="hidden" name="registerId" value="${sessionScope.member.userId}">
</form>

<div id="memberStateDetaile" style="display: none;">
	<table class="table border mx-auto my-10">
		<tr class="bg text-center">
			<td>내용</td>
			<td width="130">변경아이디</td>
			<td width="200">등록일</td>
		</tr>
		
		<c:forEach var="vo" items="${listState}">
			<tr align="center">
				<td class="text-start">${vo.memo} (${vo.stateCode})</td>
				<td>${vo.registerId}</td>
				<td>${vo.reg_date}</td>
			</tr>
		</c:forEach>
  
		<c:if test="${listState.size()==0}">
			<tr align="center">
				<td colspan="3">등록된 정보가 없습니다.</td>
			</tr>  
		</c:if>
	</table>  
</div>
