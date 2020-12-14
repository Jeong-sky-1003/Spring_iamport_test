<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<c:import url="./template/bootstrap.jsp"></c:import>
	</head>
	<body>
	
		<!-- ${pageContext.request.contextPath } -->
		<c:import url="./template/header.jsp"></c:import>
		<div class="container">	
			<h1>index page</h1>
			<p>Spring boot study example file</p>
			<button id="iamport">Iamport</button>
			<button id="getPayInfo">get Pay Info</button>
		</div>
		
		<!-- jQuery -->
		<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
		<!-- iamport.payment.js -->
		<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
		
		<script type="text/javascript">

			$("#iamport").click(function(){
				payfunction();
			});

			$("#getPayInfo").click(function(){
				$.ajax({
					url:"./payment/payInfo",
					method:"POST",
					success:function(data){
						alert(data);
					}
				});
			})

			function payfunction(){

				var IMP = window.IMP;
				IMP.init("imp35382026");
				// IMP.request_pay(param, callback) 호출
				IMP.request_pay({ // param
					
					pg: "kakao",
				    pay_method: "kakao",
				    merchant_uid: "OR0353355",
				    name: "노르웨이 회전 의자",
				    amount: 200,
				    buyer_email: "test@test.com",
				    buyer_name: "test",
				    buyer_tel: "010-4242-4242",
				    buyer_addr: "서울특별시 강남구 신사동",
				    buyer_postcode: "01181"
					    
				}, function (rsp) { // callback
					
				    if (rsp.success) {
					    
				      alert("rsp success");
				      
				      jQuery.ajax({
				          url: "./payment/pay", // 가맹점 서버 https://www.myservice.com/payments/complete
				          method: "POST",
				          data: {
				              imp_uid: rsp.imp_uid,
				              merchant_uid: rsp.merchant_uid
				          }
				      }).done(function (data) {
				        // 가맹점 서버 결제 API 성공시 로직
				      });
				        
				    } else {
				        // 결제 실패 시 로직,
				    	alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
				    }
				    
				});
				
			}
			
		</script>
		
	</body>
</html>