package com.jk.gs.controller.interceptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.jk.gs.model.user.Clientele;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;


public class MyInterceptor implements HandlerInterceptor{

	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}


	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub
		
	}

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object arg2) throws Exception {
		//获取请求路径
		String uri = request.getRequestURI();
		//获取项目名称
	    String path=request.getContextPath();

		HttpSession session = request.getSession();
		Clientele attribute=(Clientele)session.getAttribute("clientele");
	    //判断所有被放过的请求
		if(uri.indexOf("/login/login.do") > -1||uri.indexOf("/test/getZtree.do")>-1||attribute!=null){
			return true;
	    }else{
		//验证登录状态
			response.sendRedirect(path+"/login.jsp");
			return false;
	}
}
}
