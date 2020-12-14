package com.jsky.sb7.iamport;

import static org.junit.Assert.assertNotNull;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.AccessToken;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;
import com.siot.IamportRestClient.response.PaymentBalance;

@Controller
@RequestMapping(value = "/payment/**")
public class IamportController {
	// https://github.com/iamport/iamport-rest-client-java/blob/master/src/test/java/com/siot/IamportRestClient/IamportRestTest.java
	IamportClient client;
	
	public IamportController() {
		this.client = this.getTestClient();
	}
	
	// API key와 API Secret Key를 활용해 IamportClient 생성
	IamportClient getTestClient() {
		String test_api_key = 'test_api_key';
		String test_api_secret
							= 'test_api_secret';
		return new IamportClient(test_api_key, test_api_secret);
	}
	
	// 토큰 값 가져오기
	void getToken() {
		
		try {
			
			IamportResponse<AccessToken> auth_response = client.getAuth();
			assertNotNull(auth_response.getResponse());
			assertNotNull(auth_response.getResponse().getToken());
			System.out.println("get token str: " + auth_response.getResponse().getToken());
			
		} catch (IamportResponseException e) {
			
			System.out.println(e.getMessage());

			switch (e.getHttpStatusCode()) {
			case 401:
				System.out.println("http status code 401");
				break;

			case 500:
				System.out.println("http status code 500");
				break;
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	@PostMapping("pay")
	public void getPay(String merchant_uid) {
		System.out.println("merchant_uid: " + merchant_uid);
		this.getToken();
	}
	
	@PostMapping("payInfo")
	@ResponseBody
	public String getPayInfo() {
		
		String test_Imp_uid = "imp_559298214977";
		
		try {
			
			/*
			   	payment_response의 경우 PAYCO와 KCP만 지원
			   	고로 카카오페이의 경우 pay_response를 활용할 것
			   	IamportResponse<PaymentBalance> payment_response = client.paymentBalanceByImpUid(test_Imp_uid);
			 */

			IamportResponse<Payment> pay_response = client.paymentByImpUid(test_Imp_uid);
			System.out.println(pay_response.getResponse().getBuyerAddr());
			System.out.println(pay_response.getResponse().getAmount());
			System.out.println(pay_response.getResponse().getStatus());
			
		} catch (IamportResponseException e) {
			System.out.println(e.getMessage());
			
			switch(e.getHttpStatusCode()) {
			case 401 :
				//TODO
				break;
			case 500 :
				//TODO
				break;
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "success";
		
	}

}
