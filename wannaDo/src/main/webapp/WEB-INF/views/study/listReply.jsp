<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<div class='reply-info'>
	<span class='reply-count' style="color: red;">댓글 ${replyCount}개</span>
	<span>[목록, ${pageNo}/${total_page} 페이지]</span>
</div>

<table class='table table-borderless'>
	<c:forEach var="vo" items="${listReply}">
		<tr class='border bg-light'>
			<td width='50%'>
				<i class="bi bi-person-circle text-muted"></i> <span class="bold">${vo.userName}</span>
			</td>
			<td width='50%' align='right'>
				<span class="text-muted">${vo.reg_date}</span> |
				<c:choose>
					<c:when test="${sessionScope.member.userId==vo.userId || sessionScope.member.membership > 50 }">
						<span class='deleteReply' data-replyNum='${vo.replyNum}' data-pageNo='${pageNo}'>삭제</span>
					</c:when>
					<c:otherwise>
						<span class='notifyReply'>신고</span>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td colspan='2' valign='top'>${vo.content}</td>
		</tr>

		<tr>
			<td>
				<button type='button' class='btn btn-light btnReplyAnswerLayout' data-replyNum='${vo.replyNum}'>답글 <span id="answerCount${vo.replyNum}">${vo.answerCount}</span></button>
			</td>

	
	    <tr class='reply-answer'>
	        <td colspan='2' class="px-3">
	        	<div class="p-2 border">
		            <div id='listReplyAnswer${vo.replyNum}' class='p-2'></div>
		            <div class="row px-2">
		                <div class='col'><textarea class='form-control'></textarea></div>
		            </div>
		             <div class='row p-2'>
		             	<div class="col text-end">
		                	<button type='button' class='btn btn-light btnSendReplyAnswer' data-replyNum='${vo.replyNum}'>답글 등록</button>
		                </div>
		            </div>
				</div>
			</td>
	    </tr>
	</c:forEach>
</table>

<div class="page-box">
	${paging}
</div>							
