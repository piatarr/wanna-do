<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
.body-container {
	max-width: 800px;
}

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
	$("#tab-list").addClass("active");
	
    $("button[role='tab']").on("click", function(e){
		var tab = $(this).attr("data-tab");
		
		if(tab == "list") {
			listPage(1);
		} else {
			 buyPage();
		}
    });
});
</script>

<div class="container px-5 py-5">
	<div class="body-container">	
		<div class="body-title mb-3">
			<h3>내쿠키</h3>
		</div>
		<div class="body-main">
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="tab-list" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" role="tab" aria-controls="list" aria-selected="true" data-tab="list">구매내역</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="tab-buy" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" role="tab" aria-controls="buy" aria-selected="true" data-tab="buy">쿠키샵</button>
				</li>
			</ul>
			<div class="body-main content-frame">
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
function login() {
	location.href="${pageContext.request.contextPath}/member/login";
}

function ajaxFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		data:query,
		dataType:dataType,
		success:function(data) {
			fn(data);
		},
		beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error:function(jqXHR) {
	    	if(jqXHR.status===403) {
	    		login();
	    		return false;
	    	} else if(jqXHR.status === 402) {
	    		alert("권한이 없습니다.");
	    		return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패 했습니다.");
				return false;
	    	}
			console.log(jqXHR.responseText);
		}
	});
}
$(function(){
	listPage(1);
});
function listPage(page) {
	var url = "${pageContext.request.contextPath}/credit/list";
	var query = "pageNo="+page;
	var selector = ".content-frame";
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

function buyPage() {
	var url = "${pageContext.request.contextPath}/credit/buy";
	var query = null;
	var selector = ".content-frame";
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}
</script>