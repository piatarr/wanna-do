<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<h3 style="font-size: 15px; padding-top: 10px;"><i class="icofont-double-right"></i> 요청 정보</h3>
<table class="table border mx-auto my-10">
	<tr>
		<td class="wp-15 text-right pe-7 bg">글번호</td>
		<td class="wp-35 text-start">${dto.num}</td>
		<td class="wp-15 text-right pe-7 bg">글상태</td>
		<td class="wp-35 text-start">${dto.type}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">아이디</td>
		<td class="text-start">${dto.userId}</td>
		<td class="text-right pe-7 bg">이름</td>
		<td class="text-start">${dto.userName}</td>
	</tr>
	<tr>
		<td class="text-right pe-7 bg">게시글 작성일</td>
		<td class="text-start">${dto.reg_date}</td>
		<td class="text-right pe-7 bg">제목</td>
		<td class="text-start">&${dto.subject}</td>
	</tr>
	
	<tr>
		<td class="text-right pe-7 bg align-middle">내용</td>
		<td colspan="3" class="text-start align-middle" style="height: 150px;">
			${dto.content}
		</td>
	</tr>
	</table>
	<table class="table border mx-auto my-10 text-center" style="margin-top: 50px;">
			<tr>
				<td class="col-1">댓글번호</td>
				<td class="col-2">작성자</td>
				<td class="col-4">내용</td>
				<td class="col-2">작성일</td>
				<td class="col-1">답글수</td>
			</tr>
		<c:forEach var="vo" items="${listReply}">
			<tr>
				<td class="col-1">${vo.replyNum}</td>
				<td class="col-2">${vo.userName}</td>
				<td class="col-4">${vo.content}</td>
				<td class="col-2">${vo.reg_date}</td>
				<td class="col-1">${vo.answer}</td>
			</tr>
		</c:forEach>
</table>
