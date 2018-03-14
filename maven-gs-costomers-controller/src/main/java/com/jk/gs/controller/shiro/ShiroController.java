package com.jk.gs.controller.shiro;

import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class ShiroController {
    @RequestMapping(value = "login")
    public String loginDefail(HttpServletRequest request){
        //获取request中shiro登录失败的异常信息
        String exceptionClassName = (String) request.getAttribute("shiroLoginFailure");
        System.out.println(exceptionClassName);
        if(UnknownAccountException.class.getName().equals(exceptionClassName)){
            System.out.println("用户名不存在");
        }else if(IncorrectCredentialsException.class.getName().equals(exceptionClassName)){
            System.out.println("密码不正确");
        }
        return "test";
    }
}
