package com.jk.gs.controller.login;

import com.jk.gs.controller.login.readDat.IPSeeker;
import com.jk.gs.model.user.Clientele;
import com.jk.gs.model.user.Log;
import com.jk.gs.model.user.UserBean;
import com.jk.gs.service.login.LoginService;
import com.jk.gs.service.login.Logs;
import com.jk.gs.utils.user.IPUtil;
import com.jk.gs.utils.user.ThreadPool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value = "login")
    public class LoginController {
    @Autowired
    private LoginService loginService;
    @Autowired
    private MongoTemplate mongoTemplate;
    @RequestMapping(value = "login")
    @ResponseBody
    public Map<String,Object> login(Clientele clientele, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        //判断前台传过来的对象是否为空
        if (clientele != null) {
            Clientele clienteles = loginService.login(clientele.getClienteleNumber());
            if (clienteles != null) {
                if (clienteles.getClientelePassword().equals(clientele.getClientelePassword())) {
                    map.put("success", true);
                    HttpSession session = request.getSession();
                    session.setAttribute("clientele", clienteles);
                    String ipAddr = IPUtil.getIpAddr(request);
                    System.out.println(ipAddr);
                    IPSeeker instance = IPSeeker.getInstance();
                    String address = instance.getAddress(ipAddr);
                    System.out.println(address);
                    Log log = new Log();
                    log.setUsername(clientele.getClienteleNumber());
                    log.setNewDate(new Date());
                    log.setAddress(address);
                    log.setFlag("登陆成功");
                    log.setIps(ipAddr);
                    ThreadPool.executeFixedThread(new Logs(loginService,log));
                    mongoTemplate.insert(log,"ggs");
                } else {
                    map.put("success", false);
                    map.put("mag", "密码错误");
                }
            } else {
                map.put("success", false);
                map.put("mag", "用户名不存在");
            }
            return map;
        }
        return null;
    }



}
