<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
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
			if(jqXHR.status === 403) {
				login();
				return false;
			} else if(jqXHR.status === 400) {
				alert("요청 처리가 실패 했습니다.");
				return false;
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}

//게시글 공감 여부
$(function(){
	$(".btnSendScheduleLike").click(function(){
		if(! confirm( "찜하기 할까요?"  )) {
			return false;
		}
		
		var url="${pageContext.request.contextPath}/schedule/insertScheduleLike";
		var num=$(this).attr("data-num");
		var query="num="+num;
		
		var fn = function(data){
			var state = data.state;
			if(state==="true") {
				
				var count = data.scheduleLikeCount;
				$("#scheduleLikeCount").text(count);
			} else if(state==="liked") {
				alert("이미 일정을 찜했습니다.");
			} else if(state==="false") {
				alert("요청 처리가 실패했습니다.");
			}
		};
		
		ajaxFun(url, "post", query, "json", fn);
	});
});
</script>


<style type="text/css">
.board {
	margin: 50px;
	width: 90%;
	vertical-align: center; 
	text-align: center; 
	padding-top: 60px; 
	margin: auto;
}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/fullcalendar5/lib/main.min.css">


<div class="board">
	<div class="title">
	    <h3> 일정관리 </h3>
	    <p style="color: grey;"> 영어 시험 일정을 확인하고 찜할 수 있습니다.  </p>
	    <hr>
	</div>
</div>	

<div class="container">
	<div class="body-container">			
		<div class="body-main">
			<div class="row">
				<div class="col px-2">
					<div id="calendar"></div>
				</div>
			</div>
			
			<div id='scheduleLoading' style="display: none;">loading...</div>
		</div>
	</div>
</div>



<!-- 일정 상세 보기 Modal -->
<div class="modal fade" id="myDialogModal" tabindex="-1" aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">일정 상세 보기</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body pt-1">
				<table class="table">
					<tr>
						<td colspan="2" class="text-center align-middle">
							<p class="form-control-plaintext view-subject"></p>
						</td>
					</tr>
					<tr>
						<td class="table-light col-2 align-middle">일정분류</td>
						<td>
							<p class="form-control-plaintext view-category"></p>
						</td>
					</tr>

					<tr>
						<td class="table-light col-2 align-middle">날 짜</td>
						<td>
							<p class="form-control-plaintext view-period"></p>
						</td>
					</tr>

					<tr>
						<td class="table-light col-2 align-middle">일정반복</td>
						<td>
							<p class="form-control-plaintext view-repeat"></p>
						</td>
					</tr>

 					<tr>
						<td class="table-light col-2 align-middle">등록일</td>
						<td>
							<p class="form-control-plaintext view-reg_date"></p>
						</td>
					</tr>

 					<tr>
						<td class="table-light col-2 align-middle">메모</td>
						<td>
							<p class="form-control-plaintext view-memo"></p>
						</td>
					</tr>
				</table>
				
				<table class="table table-borderless">
					<tr>
						<td class="text-end">
							<button type="button" class="btn btn-outline-secondary btnSendScheduleLike" title="찜하기"><i class="bi ${userLiked ? 'bi-hand-thumbs-up-fill':'bi-hand-thumbs-up' }"></i>&nbsp;&nbsp;<span id="scheduleLikeCount">${dto.scheduleLikeCount}</span></button>
						<!-- 
							<button type="button" class="btn btn-outline-primary btnScheduleUpdate">일정 수정</button>
			    			<button type="button" class="btn btn-outline-danger btnScheduleDelete">일정 삭제</button>
						 -->
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<div style="padding-bottom: 60px;"></div>

	
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/fullcalendar5/lib/main.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/vendor/fullcalendar5/lib/locales-all.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/dateUtil.js"></script>

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
			}
	    	
			console.log(jqXHR.responseText);
		}
	});
}
var calendar = null;
document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');

	calendar = new FullCalendar.Calendar(calendarEl, {
		headerToolbar: {
			left: 'prev,next today',
			center: 'title',
			right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
		},
		initialView: 'dayGridMonth', // 처음 화면에 출력할 뷰
		locale: 'ko',
		editable: true,
		navLinks: true,
		dayMaxEvents: true,
		events: function(info, successCallback, failureCallback) {
			//이벤트가 발생할 경우 호출
			var url = "${pageContext.request.contextPath}/schedule/month";
			var startDay=info.startStr.substr(0, 10);
			var endDay=info.endStr.substr(0, 10);
			var query = "start="+startDay+"&end="+endDay;
			
			var a = $(".category-list input:checkbox.category-item").length;
			var b = $(".category-list input:checkbox.category-item:checked").length;
			if(b != 0 && a != b) {
				$(".category-list input:checkbox.category-item:checked").each(function() {
					query += "&categorys=" + $(this).val();
				});
			}
			
			var fn = function(data) {
				successCallback(data.list);
			};
			ajaxFun(url, "get", query, "json", fn);
			
		},
		selectable: true,
		selectMirror: true,
		select: function(info) {
			// 날짜의 셀을 선택하거나 드래그하면 일정 추가 화면으로 이동
//			insertSchedule(info.startStr, info.endStr, info.allDay);
			calendar.unselect();
		},
		eventClick: function(info) {
			// 일정 제목을 선택할 경우
			viewSchedule(info.event);

		},
		eventDrop: function(info) {
			// 일정을 드래그 한 경우
			updateDrag(info.event);

		},
		eventResize: function(info) {
			// 일정의 크기를 변경 한 경우
			updateDrag(info.event);

		},
		loading: function(bool) {
			// document.getElementById('scheduleLoading').style.display = bool ? 'block' : 'none';
		}
	});

	calendar.render();
});

$(function() {
	$("body").on("click", ".btnCategorySearch", function(){
		var a = $(".category-list input:checkbox.category-item:checked").length;
		if( a === 0 ) {
			return false;
		}
		//모든 소스의 이벤트를 다시 가져와 화면에 다시 렌더링
		calendar.refetchEvents();
		
		$("#offcanvasExample").offcanvas('hide');
	});
});

// 일정 등록 폼
function insertSchedule(startStr, endStr, allDay) {
	var query;
	
	if(allDay) {
		query = "sday="+startStr;
		if(endStr) {
			endStr = daysLater(endStr, 0); // 종일 일정은 끝나는 날짜가 +1로 선택 되므로 -1
											// daysLater() : dateUtil.js에 존재 
			query += "&eday="+endStr;
		}
		query += "&all_day=1";
	} else {
		query = "&sday="+startStr.substr(0, 10);
		query += "&eday="+endStr.substr(0, 10);
		query += "&stime="+startStr.substr(11, 5);
		query += "&etime="+endStr.substr(11, 5);
		query += "&all_day=0";
	}
	
	location.href = "${pageContext.request.contextPath}/schedule/write?"+query;

}

// 일정 상세 보기
function viewSchedule(calEvent) {
	
	$("#myDialogModal").modal("show");
	
	var num = calEvent.id;
	var title = calEvent.title;
	var color = calEvent.backgroundColor;
	var start = calEvent.startStr;
	var end = calEvent.endStr;
	var allDay = calEvent.allDay;
	
	var categoryNum = calEvent.extendedProps.categoryNum;
	if(! categoryNum) categoryNum = 0;
	var category = calEvent.extendedProps.category;
	if(! category) category = "설정하지 않음";
	
	var sday = calEvent.extendedProps.sday;
	var eday = calEvent.extendedProps.eday;
	var stime = calEvent.extendedProps.stime;
	var etime = calEvent.extendedProps.etime;
	
	
	var memo = calEvent.extendedProps.memo;
	if(! memo) memo = "";
	var repeat = calEvent.extendedProps.repeat;
	var repeat_cycle = calEvent.extendedProps.repeat_cycle;

	var reg_date = calEvent.extendedProps.reg_date;
	
	$(".btnScheduleUpdate").attr("data-num", num);
	$(".btnScheduleDelete").attr("data-num", num);
	$(".btnSendScheduleLike").attr("data-num", num);
	
	var s;
	$(".view-subject").html(title);
	
	s = allDay ? "종일일정" : "시간일정";
	$(".view-category").html(category + "," + s);
	
	s = sday;
	if( stime ) {
		s += " " + stime;
	}
	if( eday && allDay ) {
		eday = daysLater(eday, 0);
		if(sday < eday) {
			s += " ~ " + eday;
		}
	} else if( eday ) {
		s += " ~ " + eday;
	}
	if( etime ) s += " " + etime;
	$(".view-period").html(s);
	
	$(".view-reg_date").html(reg_date);
	
	s = repeat != 0 && repeat_cycle != 0 ? "반복일정, 반복주기 " + repeat_cycle + "년" : "반복안함";
	$(".view-repeat").html(s);
	
	$(".view-memo").html(memo);
	
}

$(function(){
	//일정 수정 화면
	
	$(".btnScheduleLike").click(function(){
		if(! confirm("이 일정을 찜할까요? ")) {
			return false;
		}
		
	});
	
	$(".btnScheduleUpdate").click(function(){
		var num = $(this).attr("data-num");
		location.href = "${pageContext.request.contextPath}/schedule/update?num="+num;
	});
	
	$(".btnScheduleDelete").click(function(){
		if(! confirm('일정을 삭제하시겠습니까? ')) {
			return false;
		}
		
		var fn = function(data) {
			var event = calendar.getEventById(num);
			event.remove();
			$("#myDialogModal").modal("hide");
		};
		var num = $(this).attr("data-num");
		var url = "${pageContext.request.contextPath}/schedule/delete";
		var query = "num="+num;
		
		ajaxFun(url, "post", query, "json", fn);
	});
});

// 일정을 드래그한 경우 일정 수정
function updateDrag(calEvent) {
	var num = calEvent.id;
	var title = calEvent.title;
	var color = calEvent.backgroundColor;
	var start = calEvent.startStr;
	var end = calEvent.endStr;
	var allDay = calEvent.allDay;
	
	var categoryNum = calEvent.extendedProps.categoryNum;
	if(! categoryNum) categoryNum = 0;
	
	var memo = calEvent.extendedProps.memo;
	if(! memo) memo = "";
	var repeat = calEvent.extendedProps.repeat;
	var repeat_cycle = calEvent.extendedProps.repeat_cycle;
	
	var startDate="", endDate="", startTime="", endTime="", all_day="";
	if(allDay) {
		startDate = start;
		endDate = end;
		all_day = "1";
	} else {
		startDate = start.substr(0, 10);
		endDate = end.substr(0, 10);
		startTime = start.substr(11, 5);
		endTime = end.substr(11, 5);
	}
	
	var query = "num="+num+"&subject="+title
			+ "&categoryNum="+categoryNum+"&color="+color
			+ "&all_day="+all_day
			+ "&sday="+startDate+"&eday="+endDate
			+ "&stime="+startTime+"&etime="+endTime
			+ "&repeat="+repeat+"&repeat_cycle="+repeat_cycle;
			+ "&memo="+memo
	
	var url = "${pageContext.request.contextPath}/schedule/updateDrag";

	var fn = function(data) {
		// 모든 소스의 이벤트를 다시 가져와 화면에 다시 렌더링
		calendar.refetchEvents();
	};
	ajaxFun(url, "post", query, "json", fn);
}

$(function(){
	// 카테고리 추가
	$(".btnCategoryAddOk").click(function(){
		var category = $("#category-input").val().trim();
		if(! category) {
			return false;
		}
		
		category = encodeURIComponent(category);
		var query = "category="+category;
		var url="${pageContext.request.contextPath}/schedule/categoryAdd";
		
		var fn = function(data) {
			if(data.state === "true") {
				$("#category-input").val("");
			
				$(".category-list").empty();
				
				var out = "";
				for(var idx = 0; idx < data.listCategory.length; idx++) {
					var item = data.listCategory[idx];
					out += "<div class='row p-2 border category-row'>";
					out += "  <div class='col-auto'>";
					out += "    <input class='form-check-input me-1 category-item' type='checkbox' value='"+item.categoryNum+"' checked='checked'>";
					out += "  </div>";
					out += "  <div class='col ps-0'>"+item.category+"</div>";
					out += "  <div class='col-auto text-end invisible category-item-minus'>";
					out += "    <a href='#'><i class='bi bi-dash-square category-item-delete' data-categoryNum='"+item.categoryNum+"'></i></a>";
					out += "  </div>";
					out += "</div>";
				}

				$(".category-list").html(out);
			};
		};
		ajaxFun(url, "post", query, "json", fn);
	});
	
	$(".btnDeleteIcon").click(function(){
		$(".category-item-minus").toggleClass("invisible");
	});
	
	$("body").on("click", ".category-item-delete", function(){
		if(! confirm("카테고리를 삭제 하시겠습니까 ? ")) {
			return false;
		}
		
		var $i = $(this);
		var query = "categoryNum="+$(this).attr("data-categoryNum");
		var url="${pageContext.request.contextPath}/schedule/categorydelete";
		var fn = function(data) {
			if(data.state === "true") {
				$i.closest(".category-row").remove();
				
				calendar.refetchEvents();
			}
		};
		ajaxFun(url, "post", query, "json", fn);
	});
});
</script>
