<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.chart-container{
	background-color : #fff;
	display : inline-block;
	border : 1px solid #333;
	min-width: 500px;
	height: 500px;
}


.myCourseUl li{
	height: 60px;
	text-align:center;
	line-height: 60px;
    border-radius: 30px;
    margin : 10px 0;
    background: cornflowerblue;
    color:whitesmoke;
    box-shadow: 3px 3px 5px grey;
}

.myCourseUl li:hover{
	cursor: pointer;
	color: 
}

.dashboard{
	min-width: 500px;
	height: 600px;
	background-color: transparent;
	margin-bottom: 20px;
}

.body-container{
	width:90%;
	text-align: center;
}

h2{
	margin-bottom : 20px;
}

input{
	background: transparent;
	border: none;
	border-bottom: 1px solid gray;
	text-align: right;
	max-width:100px;
}

#bankAccount{
	text-align: left;
	max-width:170px;
	margin: 0 10px
}

.section-box p{
	margin : 10px 0;
	text-align: left;
}

.section-box{
	text-align: left;
	padding: 10px;
	background-color: white;
    box-shadow: 3px 3px 5px grey;
    height:150px;
    margin-bottom: 30px;
}

#accountNumber, #accountBank{
	border:none;
	text-align: left;
}

.star {
	font-size: 0;
	letter-spacing: -4px;
}

.star li {
	font-size: 22px;
	letter-spacing: 0;
	display: inline-block;
	margin-left: 3px;
	color: #cccccc;
	text-decoration: none;
	cursor: pointer;
	margin-bottom: 15px;
}

.star li:first-child {
	margin-left: 0;
}

.star li.on {
	color: #F2CB61;
}

.star-none {
	cursor: default;
	pointer-events: none;
}

.left-side{
	float:left;
	width:50%;
	height:100%;
	text-align: center;
}
.right-side{
	float:left;
	width:50%;
	height:100%;
	text-align: center;
}

.section-box .right-side p{
	text-align: center;
}
</style>

<script type="text/javascript">


	function calMoney(obj){
		var money = $('#money');
		var beforeRemainer = $('#beforeRemainer').val();
		var afterRemainer = $('#afterRemainer');
		
		var str_space = /\s/;  // ????????????
	    if(str_space.exec(obj.value)) { //?????? ?????? 
	    	obj.value = obj.value.replace(" ","");
	    }

	    obj.value = obj.value.replace(/[^0-9]/g, "");

		afterRemainer.val(beforeRemainer-obj.value);

		// ?????????????????? ??? ??? ?????? ???
		if($('#afterRemainer').val()<0){
			alert('?????? ????????? ????????? ??? ????????????.');
			obj.value=${myCookie};
			$('#afterRemainer').val(0);
		}
		money.val(obj.value*90);
	}

	function changeAccountNumber(){
		var num = $('#bankAccount').val();
		var cNum = $('#accountNumber');

		cNum.val(num);
		
		var bank = $('#selectBank').val();
		var cBank = $('#accountBank');
		cBank.val(bank);
		
        if (window.event.keyCode == 27) { 
 			$("#changeAccount-dialog").modal("hide");	
        }

		$('#changeAccount-dialog').dialog("destroy");
	}
	
	
	function changeOk(){
		$('#changeAccount-dialog').dialog({
			  modal: true,
			  height: 120,
			  width: 400,
			  title: '?????? ??????',
			  close: function(event, ui) {
				   $(this).dialog("destroy");
			  }
		  });		
	}
	
	function onlyNumber(){
	   if((event.keyCode > 47 && event.keyCode < 58 ) 
			      || event.keyCode == 8 //backspace
			      || event.keyCode == 37 || event.keyCode == 39 //????????? ???, ???
			      || event.keyCode == 46 //delete???
			      || event.keyCode == 3
			      || event.keyCode == 188){
	   }else{
	  	 event.returnValue=false;
	   }
	}

	function sendOk() {
		var f = document.withdrawForm;
		
		if(! f.amountCookie.value){
			alert("????????? ?????? ????????? ???????????????.");
			f.amountCookie.focus();
			return;
		}		
		if(! f.accountBank.value){
			alert("????????? ???????????????.");
			return;
		}
		if(! f.accountNumber.value){
			alert("??????????????? ???????????????.");
			f.accountNumber.focus();
			return;
		}


		f.action = "${pageContext.request.contextPath}/creator/main/complete";
		f.submit();
	}
</script>

<main class=" bg-secondary bg-opacity-10" style="background-color: whitesmoke">
	<h1>Dashboard</h1>
	<div class="body-container">
		<div class="dashboard" style="float:left;">
			<h2>${name}?????? ??????</h2>
			<div class="section-box">
				<div class="left-side" style="padding-top: 10px">
					<b>?????? ?????? ??????</b>
					<ul class="star star-none p-0 m-0">
						<c:forEach var="n" begin="1" end="${avgRate}">
							<li class="on"><span>???</span></li>
						</c:forEach>
						<c:forEach var="n" begin="${avgRate+1}" end="5">
							<li><span>???</span></li>
						</c:forEach>
					</ul>
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/note/receive/list'">
						<i class="bi bi-envelope position-relative" id="note"></i> ?????????
					</button>	
				</div>
				<div class="right-side" style="padding-top: 10px">
					<b><p>?????????????????? ??? ???<br> <span style="color:#54a4fc;">${day} ???</span> ???</p></b>	
					<button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/member/pwd'">
						<i class="bi bi-pencil-square position-relative" id="note"></i> ??? ?????? ??????
					</button>	
				</div>
			</div>			
			<div class="section-box">
				<form name="withdrawForm" method="post">
					<p>
						<b>?????? ??????</b> <input id="beforeRemainer" name="beforeRemainer" readonly="readonly" value="${myCookie}" style="border-bottom:none;"> <b>???</b> | 
						<b>?????? ??? ?????? ??????</b> <input id="afterRemainer" name="afterRemainer" readonly="readonly" value="" style="border-bottom:none;"><b> ???</b> </p>
					<p>
						<b>??????  &nbsp; 
						<input id="amountCookie" name="amountCookie" placeholder="????????? ??????" onKeyup="calMoney(this);" onkeydown="return onlyNumber();"> ??? | 
						<input id="money" name="money" readonly="readonly" value="" style="border-bottom:none;"> ???</b> 
						<button type="button" class="btn" onclick="sendOk();">??????</button> (????????? 10% ??????)
					</p>
					<p>
						<b>?????? </b> &nbsp; 
						<button type="button" class="btn btn-sm btn-outline-dark btnWithdraw" onclick="changeOk()"> ??????</button>
						<input id="accountBank" name="accountBank" readonly="readonly" value="" style="max-width: 30px;"> 
						<input id="accountNumber" name="accountNumber" readonly="readonly" value=""> 
					</p>
				</form>
			</div>
		</div>

		<div class="dashboard" style="float:right; border:none; height:70%;">
				<h2>?????? ??????</h2>
				<ul class="myCourseUl">
					<c:forEach var="dto" items="${list}">
						<li class="myCourseLi " onclick="javascript:location.href='${pageContext.request.contextPath}/course/article?pageNo=1&num=${dto.num}'" >${dto.courseName}</li>	
					</c:forEach>
					<c:if test="${list.size()==0}">
						<li>????????? ????????? ????????????.</li>
					</c:if>
				 </ul>
				 <ul style="margin-top:10px; float:right;">
				 	<li><button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/creator/courseManage/write';">????????????</button></li>
				 </ul>
		</div>
	</div>
</main>
<div id="changeAccount-dialog" style="display:none">
	<div>
		<select name="selectBank" id="selectBank">
			<option value="">:: ?????? ::</option>
			<option value="??????">??????</option>
			<option value="??????">??????</option>
			<option value="??????">??????</option>
			<option value="??????">??????</option>
			<option value="??????">??????</option>
			<option value="??????">??????</option>
			<option value="??????">??????</option>
		</select>
		<input type="text" placeholder="????????? ??????" name="bankAccount" id="bankAccount" onkeydown="return onlyNumber();"> <button type="button" onclick="changeAccountNumber();">??????</button>
	</div>
</div>
