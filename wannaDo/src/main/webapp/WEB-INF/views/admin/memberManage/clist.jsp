<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-main {
	max-width: 1200px;
}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board.css" type="text/css">

<style type="text/css">
.hover-tr:hover {
	cursor: pointer;
	background: #fffdfd;
}
</style>

<script type="text/javascript">

function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data){
			fn(data);
		},
		beforeSend : function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error : function(jqXHR) {
			if (jqXHR.status == 403) {
				location.href="${pageContext.request.contextPath}/member/login";
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패했습니다.");
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}

function searchList() {
	var f=document.searchForm;
	f.enabled.value=$("#selectEnabled").val();
	f.action="${pageContext.request.contextPath}/admin/memberManage/clist";
	f.submit();
}
	
function detailedMember(userId) {
	var dlg = $("#member-dialog").dialog({
		  autoOpen: false,
		  modal: true,
		  buttons: {
		       " 수정 " : function() {
		    	   updateOk(); 
		       },
		       " 삭제 " : function() {
		    	   deleteOk(userId);
			   },
		       " 닫기 " : function() {
		    	   $(this).dialog("close");
		       }
		  },
		  height: 520,
		  width: 800,
		  title: "회원상세정보",
		  close: function(event, ui) {
		  }
	});
	

	var url = "${pageContext.request.contextPath}/admin/memberManage/detail";
	var query = "userId="+userId;
	
	var fn = function(data){
		$('#member-dialog').html(data);
		dlg.dialog("open");
	};
	ajaxFun(url, "post", query, "html", fn);
}
	
function updateOk() {
	var f = document.deteailedMemberForm;
	
	if(! f.stateCode.value) {
		f.stateCode.focus();
		return;
	}
	if(! $.trim(f.memo.value)) {
		f.memo.focus();
		return;
	}
	
	var url = "${pageContext.request.contextPath}/admin/memberManage/updateMemberState";
	var query=$("#deteailedMemberForm").serialize();

	var fn = function(data){
		$("form input[name=page]").val("${page}");
		searchList();
	};
	ajaxFun(url, "post", query, "json", fn);
		
	$('#member-dialog').dialog("close");
}

function deleteOk(userId) {
	if(confirm("선택한 계정을 삭제 하시겠습니까 ?")) {

	}
	
	$('#member-dialog').dialog("close");
}

function memberStateDetaileView() {
	$('#memberStateDetaile').dialog({
		  modal: true,
		  minHeight: 100,
		  maxHeight: 450,
		  width: 750,
		  title: '계정상태 상세',
		  close: function(event, ui) {
			   $(this).dialog("destroy"); // 이전 대화상자가 남아 있으므로 필요
		  }
	  });	
}

function selectStateChange() {
	var f = document.deteailedMemberForm;
	
	var s = f.stateCode.value;
	var txt = f.stateCode.options[f.stateCode.selectedIndex].text;
	
	f.memo.value = "";	
	if(! s) {
		return;
	}

	if(s!="0" && s!="6") {
		f.memo.value = txt;
	}
	
	f.memo.focus();
}
</script>

<main>
	<h1>Admin Page</h1>
	
	<div class="body-container">
	    <div class="body-title">
			<h2><i class="icofont-users"></i> 크리에이터 관리 </h2>
	    </div>
	    
	    <div class="body-main ms-30">
				<table class="table">
					<tr>
						<td align="left" width="50%">
							${dataCount}개(${page}/${total_page} 페이지)
						</td>
						<td align="right">
							<select id="selectEnabled" class="selectField" onchange="searchList();">
								<option value="" ${enabled=="" ? "selected='selected'":""}>::계정상태::</option>
								<option value="0" ${enabled=="0" ? "selected='selected'":""}>잠금 계정</option>
								<option value="1" ${enabled=="1" ? "selected='selected'":""}>활성 계정</option>
							</select>
						</td>
					</tr>
				</table>
				<div class="container">
					<div class="row">
					<c:forEach var="dto" items="${list}">
					  <div class="col-5 justify-content-center m-auto">
						 <a onclick="detailedMember('${dto.userId}')">
						 	<img src="${pageContext.request.contextPath}/uploads/creatorinfo/${dto.imageFilename}" class="img-fluid">	
						 </a>
						  <p>${dto.creatorName}</p>
					  </div>
					  </c:forEach>
					</div>
				</div>
						 
				<div class="page-box">
					${dataCount == 0 ? "등록된 크리에이터가 없습니다." : paging}
				</div>
						
				<table class="table">
					<tr>
						<td align="left" width="100">
							<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/admin/memberManage/clist';">새로고침</button>
						</td>
						<td align="center">
							<form name="searchForm" action="${pageContext.request.contextPath}/admin/memberManage/clist" method="post">
								<select name="condition" class="selectField">
									<option value="userId"     ${condition=="userId" ? "selected='selected'":""}>아이디</option>
									<option value="userName"   ${condition=="userName" ? "selected='selected'":""}>이름</option>
									<option value="email"      ${condition=="email" ? "selected='selected'":""}>이메일</option>
									<option value="tel"        ${condition=="tel" ? "selected='selected'":""}>전화번호</option>
								</select>
								<input type="text" name="keyword" class="boxTF" value="${keyword}">
								<input type="hidden" name="enabled" value="${enabled}">
								<input type="hidden" name="page" value="1">
								<button type="button" class="btn" onclick="searchList()">검색</button>
							</form>
						</td>
						<td align="right" width="100">&nbsp;</td>
					</tr>
				</table>
			
			</div>
			
	    </div>
	<div id="member-dialog" style="display: none;"></div>
</main>