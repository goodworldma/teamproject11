package kr.co.member.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.member.domain.MemberDTO;
import kr.co.member.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberService mService;
	
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout() {
		return "redirect:/";
	}
	

	@RequestMapping(value = "/loginPost", method = RequestMethod.POST)
	public void login(MemberDTO login, Model model) {
		
		login = mService.login(login);
		
		model.addAttribute("login", login);
		
		//return "redirect:/board/list";
		
	}
	
	
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		
		return "member/login";
	}
	
	
	

	@RequestMapping(value = "/checkid", method = RequestMethod.POST)
	@ResponseBody 
	public String checkId(@RequestParam  Map<String, Object> map) {
		MemberDTO dto = mService.checkId(map);
		int result = 0;
		
		if(dto == null) {
			result = 1;
		}
		
		
		return result+"";
		
	}
	
	@RequestMapping(value = "/changepw", method = RequestMethod.POST)
	@ResponseBody 
	public String changePw(@RequestParam  Map<String, Object> map) {
		int result = mService.changePw(map);
		
		
		return result+"";
		
	}
	
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(MemberDTO dto, Model model) {
		dto = mService.update(dto);
		model.addAttribute("dto", dto);
		
		return "redirect:/member/read/"+dto.getId();
		
	}
	
	@RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
	public String update(@PathVariable("id") String id, Model model) {
		MemberDTO dto = mService.updateui(id);
		model.addAttribute("dto", dto);
		
		return "member/update";
	}
	
	@RequestMapping(value = "/read/{id}", method = RequestMethod.GET)
	public String read(@PathVariable("id") String id, Model model) {
		
		MemberDTO dto = mService.read(id);
		model.addAttribute("dto", dto);
		
		
		return "member/read";
	}
	
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(MemberDTO dto) {
		
		mService.insert(dto);

		
		return "redirect:/member/read/"+dto.getId();
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insert() {
		
		
		return "member/insert";
	}
	

}
