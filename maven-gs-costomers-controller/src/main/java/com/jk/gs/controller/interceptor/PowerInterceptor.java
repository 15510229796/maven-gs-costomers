package com.jk.gs.controller.interceptor;

import com.jk.gs.model.user.Clientele;
import com.jk.gs.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.concurrent.TimeUnit;

//public class PowerInterceptor implements HandlerInterceptor{
  /*  @Autowired
    private RedisTemplate redisTemplate;
    @Autowired
    private UserService userService;*/
   /* public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        String uri = request.getRequestURI();
        String path=request.getContextPath();
        HttpSession session = request.getSession();
        Clientele attribute = (Clientele) session.getAttribute("clientele");
        if(uri.indexOf("/test/login.do") > -1|| uri.indexOf("/test/getXx.do")>-1||uri.indexOf("/test/toIndex.do")>-1||uri.indexOf("/test/getTree1.do")>-1){
            return  true;
        }else{
            String cachePower = newUser.getId() + "power";
            List rangeList = redisTemplate.opsForList().range(cachePower, 0, -1);
            if(rangeList==null||rangeList.size()<=0){
                List<String> urlList =userService.queryUserInfos(newUser.getId());
                for (String s : urlList) {
                    redisTemplate.opsForList().leftPush(cachePower,s);
                }
                    redisTemplate.expire(cachePower,1, TimeUnit.MINUTES);
                for (String s : urlList) {
                    if(s.indexOf(uri)>-1){
                        return true;
                    }
                }
            }else{
                for (Object o1 : rangeList) {
                    if(o1.toString().indexOf(uri)>-1){
                        return  true;
                    }
                }
            }
        }
        response.sendRedirect("/jsp/power.jsp");
        return false;
    }

    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}*/
