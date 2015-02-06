package com.omg.company;

import java.util.*;

import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import com.omg.dto.*;
import com.omg.service.*;

@Controller
@RequestMapping("dashboard")
public class DashboardController {
	@Autowired
	private DashboardService dashService;
	
	// 근하신년 페이지
	@RequestMapping("/hello")
	public String helloView(){
		return "hello";
	}
	
	// 최근 공지사항 갯수
	
	
	// 자신이 신청한 메시지 갯수
	
	
	// 자신이 받은 최근 메시지 겟수
	@RequestMapping("msgLatelyByDate")
	public @ResponseBody List<Messages> msgLatelyByDate(HttpSession session){
		Employees user = (Employees)session.getAttribute("user");
		List<Messages> list = dashService.msgLatelyByDate(user.getEmployeeId());
		return list;
	}
	
}
