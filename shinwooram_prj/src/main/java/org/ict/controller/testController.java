package org.ict.controller;


import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/restapi/*")
public class testController {

	@RequestMapping("/success")
	public ResponseEntity<String> accessSuc() {
		
		return  new ResponseEntity<String>("SHINWOORAM SUCCESS", HttpStatus.OK);
		
	}
	@RequestMapping("/fail")
	public ResponseEntity<String> accessFail() {
		
		return  new ResponseEntity<String>("SHINWOORAM Fail", HttpStatus.BAD_REQUEST);
		
	}
}
