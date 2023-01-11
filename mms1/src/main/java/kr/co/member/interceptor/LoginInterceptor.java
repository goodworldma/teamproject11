package kr.co.member.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		
		return true;
	}
	
	

	@Override
	public void postHandle(HttpServletRequest request, 
							HttpServletResponse response, 
							Object handler,
							ModelAndView modelAndView) throws Exception {
		
		HttpSession session = request.getSession();
		
		Map<String, Object> map = modelAndView.getModel();
		
		Object login = map.get("login");
		
		if(login != null) {
			session.setAttribute("login", login);
			response.sendRedirect("/");
		}
		
		
	}
	
	

}
