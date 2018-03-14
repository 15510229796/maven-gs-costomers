package com.jk.gs.controller.test;

import com.fasterxml.jackson.databind.JsonNode;
import com.jk.gs.model.user.Clientele;
import com.jk.gs.model.user.RoleBean;
import com.jk.gs.model.user.TreeBean;
import com.jk.gs.service.test.TestService;
import com.jk.gs.utils.user.HttpClient;
import com.jk.gs.utils.user.JsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Controller
@RequestMapping(value = "test")
public class TestController {
    @Autowired
    private TestService testService;
    @Autowired
    private RedisTemplate redisTemplate;
    @RequestMapping(value = "getCount")
    public void getCount(){
        int count = testService.getCount();
        System.out.println(count);
    }
    //上菜单树
    @RequestMapping(value = "getZtree")
    @ResponseBody
    public List<Map<String,Object>> getTree(HttpServletRequest request){
        HttpSession session = request.getSession();
        Clientele clientele = (Clientele) session.getAttribute("clientele");
        List<TreeBean> list = testService.getZtree(clientele.getId());
        return treeStr(list,0);
    }
    @RequestMapping("treeStr")
    public List<Map<String,Object>> treeStr(List<TreeBean> list, Integer pid){
        List<Map<String,Object>> newlist = new ArrayList<Map<String,Object>>();
        for (int i = 0; i < list.size(); i++) {
            //获取单个tree对象
            TreeBean tree = list.get(i);
            Map<String,Object> map = null;
            //判断当前tree对象的pid是否和传过来的pid相等，相等的保存到map中
            if(tree.getPid() == pid){
                map = new HashMap<String, Object>();
                map.put("id", tree.getId());
                map.put("name", tree.getName());
                map.put("pathUrl", tree.getUrl());
                map.put("children", treeStr(list,tree.getId()));
            }
            if(map != null){
                List<Map<String,Object>> li = (List<Map<String, Object>>) map.get("children");
                if(li.size()<= 0){
                    map.remove("children");
                }
                newlist.add(map);
            }
        }
        return newlist;
    }
    //跳转Index.jsp
    @RequestMapping(value = "toIndex")
    public String toIndex(){
        return "index";
    }

    @RequestMapping(value = "toRole")
    public String toRole(){
        return "jsp/showRole";
    }

    @RequestMapping("getWeather")
    @ResponseBody
    public Map getWeather(){
        //总数据源
        HashMap<String, Object> map = new HashMap<String, Object>();
        //所有日期
        List<String> weekList = new ArrayList<String>();
        //所有温度
        List<String> temperatureList = new ArrayList<String>();
        //所有低温
        List<String> LowList = new ArrayList<String>();
        String url = "http://wthrcdn.etouch.cn/weather_mini";
        HashMap<String, Object> params = new HashMap<String, Object>();
        params.put("city", "北京");
        String s = HttpClient.get(url, params);
        //System.out.println(s);
        JsonNode jsonNode = null;
        try {
            jsonNode = JsonUtil.jsonToJsonNode(s);
            JsonNode data = jsonNode.get("data");
            JsonNode forecast = data.get("forecast");
            for (JsonNode node : forecast) {
                String qqq = node.get("high").asText().replace("℃","");
                String xxx = node.get("low").asText().replace("℃","");
                weekList.add(node.get("date").asText().substring(3));
                temperatureList.add(qqq.substring(3));
                LowList.add(xxx.substring(3));
        }
        } catch (IOException e) {
            e.printStackTrace();
        }
        map.put("weekList",weekList);
        map.put("temperatureList",temperatureList);
        map.put("LowList",LowList);
        if(map!=null){
            redisTemplate.opsForHash().putAll("数据",map);
            redisTemplate.expire("天气数据",60, TimeUnit.MINUTES);
        }
        return map;
    }

    @RequestMapping(value = "toPower")
    public String toPower(){
        return "/jsp/power";
    }

    @RequestMapping(value = "toMyFold")
    public String toMyFold(){
        return  "/jsp/myFold";
    }

    /**
     * 跳转我的Log日志页面
     * @return
     */
    @RequestMapping(value = "toLog")
    public String toLog(){
        return "/jsp/log";
    }

    /**
     * 跳转发布公告页面
     * @return
     */
    @RequestMapping(value = "toNotice")
    public String toNotice(){
        return "/jsp/notice";
    }

    /**
     * 跳转房屋信息页面
     * @return
     */
    @RequestMapping(value = "toClientele")
    public String toClientele(){
        return "/jsp/clientele";
    }

    /**
     * 跳转发布房源信息页面
     * @return
     */
    @RequestMapping(value = "toRental")
    public String toRental(){
        return "/jsp/showRental";
    }

    /**
     * 跳转我的发布房源信息页面
     * @return
     */
    @RequestMapping(value = "toMyRental")
    public String toMyClientele(){
        return "/jsp/showMyRental";
    }

    /**
     * 跳转我的租房页面
     */
    @RequestMapping(value = "toZRental")
    public String toZRental(){
        return "/jsp/toZRental";
    }

    @RequestMapping(value = "toSendEmail")
    public String toSendEmail(){
        return "/jsp/senEmail";
    }
}
