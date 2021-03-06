<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
function submitOk(){
	var f= document.contactForm;
	
	var str;
	
	str = f.fullName.value;
	if(!str) {
		f.fullName.focus();
		$(".name").find(".invalid-feedback").show();
		return;
	} else{
		$(".name").find(".invalid-feedback").hide();		
	}

	str = f.email.value;
	if(!str) {
		f.email.focus();
		$(".email-required").show();
		return;
	} else{
		$(".email-required").hide();		
	}
	if(! email_check(str)){
		f.email.focus();
		$(".email-valid").show();
		return;		
	} else{
		$(".email-valid").hide();		
	}
	
	str = f.tel.value;
	if(!str) {
		f.tel.focus();
		$(".tel").find(".invalid-feedback").show();
		return;
	} else{
		$(".tel").find(".invalid-feedback").hide();		
	}
	
	str = f.message.value.trim();
	if(!str) {
		f.message.focus();
		$(".msg").find(".invalid-feedback").show();
		return;
	} else{
		$(".msg").find(".invalid-feedback").hide();
	}

	f.action= "${pageContext.request.contextPath}/contact/write";
	f.submit();

}

function email_check( email ) {    
    var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    return (email != '' && email != 'undefined' && regex.test(email)); 
}

function inputPhoneNumber(obj) {

    var number = obj.value.replace(/[^0-9]/g, "");
    var phone = "";

    if(number.length < 4) {
        return number;
    } else if(number.length < 7) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3);
    } else if(number.length < 11) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 3);
        phone += "-";
        phone += number.substr(6);
    } else {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 4);
        phone += "-";
        phone += number.substr(7);
    }
    obj.value = phone;
}

</script>
	<section class="py-5">
	    <div class="container px-5">
	        <!-- Contact form-->
	        <div class="bg-light rounded-3 py-5 px-4 px-md-5 mb-5">
	            <div class="text-center mb-5">
	                <div class="feature bg-danger bg-gradient text-white rounded-3 mb-3"><i class="bi bi-envelope"></i></div>
	                <h1 class="fw-bolder">Get in touch</h1>
	                <p class="lead fw-normal text-muted mb-0">We'd love to hear from you</p>
	            </div>
	            <div class="row gx-5 justify-content-center">
	                <div class="col-lg-8 col-xl-6">
	                    <form name="contactForm" method="post">
	                        <!-- Name input-->
	                        <div class="form-floating mb-3 name">
	                            <input class="form-control" name="fullName" id="fullName" type="text" placeholder="Enter your name..."/>
	                            <label for="fullName">Full name</label>
	                            <div class="name invalid-feedback">A name is required.</div>
	                        </div>
	                        <!-- Email address input-->
	                        <div class="form-floating mb-3 email">
	                            <input class="form-control" name="email" id="email" type="email" placeholder="name@example.com"/>
	                            <label for="email">Email address</label>
	                            <div class="invalid-feedback email-required">An email is required.</div>
	                            <div class="invalid-feedback email-valid">Email is not valid.</div>
	                        </div>
	                        <!-- Phone number input-->
	                        <div class="form-floating mb-3 tel">
	                            <input class="form-control" name="tel" id="tel" type="tel" placeholder="(123)456-7890" onKeyup="inputPhoneNumber(this);" maxlength="13"/>
	                            <label for="tel">Phone number</label>
	                            <div class="invalid-feedback">A phone number is required.</div>
	                        </div>
                            <!-- Message input-->
                            <div class="form-floating mb-3 msg">
                                <textarea class="form-control" name="message" id="message" type="text" style="resize:none; height:200px" placeholder="Enter your message here..." style="height: 10rem"></textarea>
                                <label for="message">Message</label>
                                <div class="invalid-feedback">A message is required.</div>
                            </div>
                            <!-- Submit success message-->
                            <!---->
                            <!-- This is what your users will see when the form-->
                            <!-- has successfully submitted-->
                            <div class="d-none">
                                <div class="text-center mb-3">
                                    <div class="fw-bolder">Form submission successful!</div>
                                </div>
                            </div>
                            <div class="d-none" id="submitErrorMessage"><div class="text-center text-danger mb-3">Error sending message!</div></div>
                            <!-- Submit Button-->
                            <div class="d-grid"><button class="btn btn-danger btn-lg" id="submitButton" type="button" onclick="submitOk();">Submit</button></div>
                        </form>
	                </div>
	            </div>
	        </div>
	        <!-- Contact cards-->
	        <div class="row gx-5 row-cols-2 row-cols-lg-4 py-5">
	            <div class="col">
	                <div class="feature bg-danger bg-gradient text-white rounded-3 mb-3"><i class="bi bi-chat-dots"></i></div>
	                <div class="h5 mb-2">Chat with us</div>
	                <p class="text-muted mb-0">Chat live with one of our support specialists.</p>
	            </div>
	            <div class="col">
	                <div class="feature bg-danger bg-gradient text-white rounded-3 mb-3"><i class="bi bi-people"></i></div>
	                <div class="h5">Ask the community</div>
	                <p class="text-muted mb-0">Explore our community forums and communicate with other users.</p>
	            </div>
	            <div class="col">
	                <div class="feature bg-danger bg-gradient text-white rounded-3 mb-3"><i class="bi bi-question-circle"></i></div>
	                <div class="h5">Support center</div>
	                <p class="text-muted mb-0">Browse FAQ's and support articles to find solutions.</p>
	            </div>
	            <div class="col">
	                <div class="feature bg-danger bg-gradient text-white rounded-3 mb-3"><i class="bi bi-telephone"></i></div>
	                <div class="h5">Call us</div>
	                <p class="text-muted mb-0">Call us during normal business hours at (000) 000-0000.</p>
	            </div>
	        </div>
	    </div>
	</section>
