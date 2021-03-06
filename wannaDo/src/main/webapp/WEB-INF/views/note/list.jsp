<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">

.table .ellipsis {
	position: relative;
	min-width: 200px;
}
.table .ellipsis span {
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
	position: absolute;
	left: 9px;
	right: 9px;
	cursor: pointer;
}
.table .ellipsis:before {
	content: '';
	display: inline-block;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">

<script type="text/javascript">
$(function(){
	var menu = "${menuItem}";
	$("#tab-"+menu).addClass("active");
	
    $("button[role='tab']").on("click", function(e){
		var tab = $(this).attr("data-tab");
		var url = "${pageContext.request.contextPath}/note/"+tab+"/list";
		location.href=url;
    });
});

function searchList() {
	var f = document.searchForm;
	f.submit();
}

$(function() {
    $("#chkAll").click(function() {
	   if($(this).is(":checked")) {
		   $("input[name=nums]").prop("checked", true);
        } else {
		   $("input[name=nums]").prop("checked", false);
        }
    });
 
    $(".btnDelete").click(function(){
		var cnt = $("input[name=nums]:checked").length;

		if (cnt == 0) {
			alert("삭제 할 쪽지를 먼저 선택하세요.");
			return;
		}
         
		if(confirm("선택한 쪽지를 삭제하시겠습니까?")) {
			var f = document.listForm;
			f.action = "${pageContext.request.contextPath}/note/${menuItem}/delete";
			f.submit();
		}
	});
});
</script>

<div class="container px-5 py-5">
	<div class="body-container">	
		<div class="body-title mb-3">
			<h3>쪽지함</h3>
		</div>
		
		<div class="body-main">

			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="tab-receive" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" role="tab" aria-controls="receive" aria-selected="true" data-tab="receive">받은 쪽지함</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="tab-send" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" role="tab" aria-controls="send" aria-selected="true" data-tab="send">보낸 쪽지함</button>
				</li>
			</ul>
			
			<div class="tab-content pt-2" id="nav-tabContent">
				<div class="tab-pane fade show active mt-3" id="nav-content" role="tabpanel" aria-labelledby="nav-tab-content">
				
					<table class="table table-borderless mb-0">
						<tr>
							<td align="left" width="50%">
								<button type="button" class="btn btnDelete p-1" title="삭제"><i class="bi bi-trash"></i></button>
							</td>
							<td align="right">
								<button type="button" class="btn btn-light" onclick="javascript:location.href='${pageContext.request.contextPath}/note/write';">쪽지 쓰기</button>
							</td>
						</tr>
					</table>
					
					<form name="listForm" method="post">
						<table class="table table-hover board-list">
							<thead class="table-light">
								<tr>
									<th class="bw-40"><input type="checkbox" name="chkAll" id="chkAll" class="form-check-input"></th>
									<th class="bw-100">제목</th>
									<th class="bw-100">${menuItem=="receive"?"보낸사람":"받는사람"}</th>
									<th class="bw-250">${menuItem=="receive"?"받은날짜":"보낸날짜"}</th>
									<th class="bw-250">읽은날짜</th>
								</tr>
							</thead>
							
							<tbody>
								<c:forEach var="dto" items="${list}">
									<tr>
										<td><input type="checkbox" name="nums" value="${dto.noteNum}" class="form-check-input"></td>
										<td class="left ellipsis" style="text-align:center;">
											<span>
												<a href="${articleUrl}&noteNum=${dto.noteNum}" class="text-reset" style="text-decoration-line:none;">${dto.subject}</a>
											</span>
										</td>
										<td style="text-align:center;">${menuItem=="receive"?dto.sendName:dto.receiveName}</td>
										<td style="text-align:center;">${dto.sendDay}</td>
										<td style="text-align:center;">${dto.readDay}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						
						<input type="hidden" name="page" value="${page}">
						<input type="hidden" name="condition" value="${page}">
						<input type="hidden" name="keyword" value="${page}">						
					</form>
				
					<c:choose>
						<c:when test="${dataCount==0}">
							<div class="page-box" style="height:130px; text-align: center">
							쪽지함이 비어있습니다.
							</div>
						</c:when>
						<c:otherwise>
							<div class="page-box">
								${paging}
							</div>
						</c:otherwise>
					</c:choose>
				
					<div class="row board-list-footer mb-5">
						<div class="col">
							<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/note/${menuItem}/list';"><i class="bi bi-arrow-counterclockwise"></i></button>
						</div>
						<div class="col-4 text-center">
							<form class="row" name="searchForm" action="${pageContext.request.contextPath}/note/${menuItem}/list" method="post">
								<div class="col-auto p-1">
									<select name="condition" class="form-select">
										<option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
										<c:choose>
											<c:when test="${menuItem=='receive'}">
												<option value="sendName" ${condition=="sendName"?"selected='selected'":""}>보낸사람</option>
												<option value="sendId" ${condition=="sendName"?"selected='selected'":""}>아이디</option>
												<option value="sendDay" ${condition=="created"?"selected='selected'":""}>받은날짜</option>
											</c:when>
											<c:otherwise>
												<option value="receiveName" ${condition=="receiveName"?"selected='selected'":""}>받는사람</option>
												<option value="receiveId" ${condition=="receiveId"?"selected='selected'":""}>아이디</option>
												<option value="sendDay" ${condition=="created"?"selected='selected'":""}>보낸날짜</option>
											</c:otherwise>
										</c:choose>
									</select>
								</div>
								<div class="col-auto p-1">
									<input type="text" name="keyword" value="${keyword}" class="form-control">
								</div>
								<div class="col-auto p-1">
									<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
								</div>
							</form>
						</div>
						<div class="col text-end">
							&nbsp;
						</div>
					</div>
				
				</div>
			</div>

		</div>
	</div>
</div>