package com.bn.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.log4j.Log4j;

@Log4j
public class LoginCheckInterceptor implements HandlerInterceptor{


	@Override
	public boolean preHandle(
        HttpServletRequest request,
        HttpServletResponse response,
        Object handler) throws Exception {
		
        HttpSession session = request.getSession(false);
        if(session != null) {
        	   Object userName = session.getAttribute("userName");
        	   if(userName !=null) {
        		   return true;
        	   }
        }
      	request.setAttribute("msg", "로그인해야 이용할 수 있습니다");
      	String loc=request.getContextPath()+"/login";
		request.setAttribute("loc", loc);
		RequestDispatcher disp=request.getRequestDispatcher("/WEB-INF/views/message.jsp");
		disp.forward(request, response);	
        return false;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		log.info("postHandle()...");
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		log.info("afterCompletion()...");
	}

}