<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 
<style type="text/css">
.body-container {
}

.board {
	margin: 50px;
	width: 60%;
	vertical-align: center; 
	text-align: center; 
	padding-top: 60px; 
	margin: auto;
}
.body {
}

.num {
	width: 70px;
	text-align: center;
}

.name {
	width: 120px;
	text-align: center;
	
}

.regdate {
	width: 200px;
	text-align: center;
}

.hitcount {
	width: 80px;
	text-align: center;
}

a.linkoption:link {
	color: black;
	text-decoration: none;
}
a.linkoption:visited {
	color: black;
	text-decoration: none;
}
a.linkoption:hover {
	color: black;
	text-decoration: underline;
	font: bold;
}
a.linkoption:active {
    text-decoration: none;
}



.trade-form {
	width: 60%;	
	border: 1px solid #BDBDBD;
	padding: 50px;
	border-radius: 5px;
	border-spacing: 10px;
	vertical-align: center; 
	margin: auto;
}

.cent-align {
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
	vertical-align: middle; 
	text-align: middle; 
	margin: auto;
}
	
.hrtag {
	width: 60%;
	vertical-align: center; 
	text-align: middle; 
	margin: auto;
}


	


</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boot-board.css" type="text/css">

<div class="board">
	<div class="title">
	    <h3> 공지사항 </h3>
	    <p style="color: grey;"> 사이트 공지사항을 확인해주세요! </p>
	</div>
</div>
		
<div class="body-main content-frame">
</div>

<form name="searchForm" action="" method="post">
	<input type="hidden" name="condition" value="all">
    <input type="hidden" name="keyword" value="">
</form>


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
	    	} else if(jqXHR.status === 410) {
	    		alert("삭제된 게시물입니다.");
	    		return false;
	    	}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

function ajaxFileFun(url, method, query, dataType, fn) {
	$.ajax({
		type:method,
		url:url,
		processData: false,  // file 전송시 필수. 서버로전송할 데이터를 쿼리문자열로 변환여부
		contentType: false,  // file 전송시 필수. 서버에전송할 데이터의 Content-Type. 기본:application/x-www-urlencoded
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
	    	} else if(jqXHR.status === 410) {
	    		alert("삭제된 게시물입니다.");
	    		return false;
	    	}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

$(function(){
	listPage(1);
});

// 글리스트
function listPage(page) {
	var url = "${pageContext.request.contextPath}/notice/list";
	var query = "pageNo="+page;
	var search = $('form[name=searchForm]').serialize();
	query = query+"&"+search;
	var selector = ".content-frame";
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

// 새로고침
function reloadBoard() {
	var f = document.searchForm;
	f.condition.value = "all";
	f.keyword.value = "";
	
	listPage(1);
}

function searchList() {
	var f=document.searchForm;
	
	f.condition.value=$("#condition").val();
	f.keyword.value=$.trim($("#keyword").val());
	listPage(1);
}

// 게시글 보기
function articleBoard(num, page) {
	var url = "${pageContext.request.contextPath}/notice/article";
	var query = "num="+num;
	var search = $('form[name=searchForm]').serialize();
	query = query+"&pageNo="+page+"&"+search;
	var selector = ".content-frame";
	
	var fn = function(data){
		$(selector).html(data);
	};
	ajaxFun(url, "get", query, "html", fn);
}

<c:if test="${sessionScope.member.membership>50}">
	// 글쓰기 폼
	function insertForm() {
		var url = "${pageContext.request.contextPath}/notice/write";
		var query = "tmp="+new Date().getTime();
		var selector = ".content-frame";
		
		var fn = function(data){
			$(selector).html(data);
		};
		ajaxFun(url, "get", query, "html", fn);
	}

	// 글 수정폼
	function updateForm(num, page) {
		var url = "${pageContext.request.contextPath}/notice/update";
		var query = "num="+num+"&pageNo="+page;

		var selector = ".content-frame";
		var fn = function(data){
			$(selector).html(data);
		};
		ajaxFun(url, "get", query, "html", fn);
	}

	// 등록 완료, 수정 완료
	function sendOk(mode, page) {
	    var f = document.noticeForm;
	    var str;
	    
		str = f.subject.value;
	    if(!str) {
	        alert("제목을 입력하세요. ");
	        f.subject.focus();
	        return;
	    }
	
		str = f.content.value;
	    if(!str) {
	        alert("내용을 입력하세요. ");
	        f.content.focus();
	        return;
	    }
	    
	    var url ="${pageContext.request.contextPath}/notice/"+mode;
	    var query = new FormData(f); // IE는 10이상에서만 가능
	    
		var fn = function(data){
			var state = data.state;
	        if(state === "false") {
	            alert("게시물을 추가(수정)하지 못했습니다. !!!");
	            return false;
	        }
	        
	    	if(! page) {
	    		page="1";
	    	}
	    	
	    	if(mode === "write") {
	    		reloadBoard()
	    	} else {
	    		listPage(page);
	    	}
		};
		
		ajaxFileFun(url, "post", query, "json", fn);
	}
	
	// 글쓰기 취소, 수정 취소
	function sendCancel(page) {
		if( ! page ) {
			page = "1";
		}
		
		listPage(page);
	}
	
	// 글 삭제
	function deleteOk(num, page) {
		var url = "${pageContext.request.contextPath}/notice/delete";
		var query = "num="+num;
		
		if(! confirm("위 게시물을 삭제 하시 겠습니까 ? ")) {
			  return;
		}
		
		var fn = function(data){
			listPage(page);
		};
		ajaxFun(url, "post", query, "json", fn);
	}
	
	function deleteFile(fileNum) {
		var url="${pageContext.request.contextPath}/notice/deleteFile";
		$.post(url, {fileNum:fileNum}, function(data){
			$("#f"+fileNum).remove();
		}, "json");
	}	
</c:if>
</script>

