<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table class="table mb-0">
	<thead>
		<tr>
			<td colspan="2" align="center">
				${dto.subject}
			</td>
		</tr>
	</thead>
	
	<tbody>
		<tr>
			<td width="50%">
				이름 :
				<c:choose>
					<c:when test="${sessionScope.member.membership > 50 }">${dto.userName}</c:when>
					<c:otherwise>관리자</c:otherwise>
				</c:choose>							
			</td>
			<td align="right">
				${dto.reg_date} | 조회 ${dto.hitCount}
			</td>
		</tr>
		
		<tr>
			<td colspan="2" valign="top" height="200">
				${dto.content}
			</td>
		</tr>
		
		<c:forEach var="vo" items="${listFile}">
			<tr>
				<td colspan="2">
					파&nbsp;&nbsp;일 :
					<a href="${pageContext.request.contextPath}/admin/noticeManage/download?fileNum=${vo.fileNum}">${vo.originalFilename}</a>
				</td>
			</tr>
		</c:forEach>
		
		<tr>
			<td colspan="2">
				이전글 :
				<c:if test="${not empty preReadDto}">
					<a href="javascript:articleBoard('${preReadDto.num}', '${pageNo}');">${preReadDto.subject}</a>
				</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				다음글 :
				<c:if test="${not empty nextReadDto}">
					<a href="javascript:articleBoard('${nextReadDto.num}', '${pageNo}');">${nextReadDto.subject}</a>
				</c:if>
			</td>
		</tr>
	</tbody>
</table>

<table class="table table-borderless">
	<tr>
		<td width="50%">
			<c:choose>
				<c:when test="${sessionScope.member.userId==dto.userId}">
					<button type="button" class="btn btn-light" onclick="updateForm('${dto.num}', '${pageNo}');">수정</button>
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-light" disabled="disabled">수정</button>
				</c:otherwise>
			</c:choose>
	    	
			<c:choose>
	    		<c:when test="${sessionScope.member.membership>50}">
	    			<button type="button" class="btn btn-light" onclick="deleteOk('${dto.num}', '${pageNo}');">삭제</button>
	    		</c:when>
	    		<c:otherwise>
	    			<button type="button" class="btn btn-light" disabled="disabled">삭제</button>
	    		</c:otherwise>
	    	</c:choose>
		</td>
		<td class="text-end">
			<button type="button" class="btn btn-light" onclick="listPage('${pageNo}');">리스트</button>
		</td>
	</tr>
</table>
