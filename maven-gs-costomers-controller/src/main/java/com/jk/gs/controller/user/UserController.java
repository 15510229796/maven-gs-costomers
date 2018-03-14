package com.jk.gs.controller.user;

import com.jk.gs.model.user.*;
import com.jk.gs.service.user.UserService;
import com.jk.gs.utils.user.EmaliUtil;
import com.jk.gs.utils.user.FileUtil;
import com.jk.gs.utils.user.PhotoTomcat;
import com.jk.gs.utils.user.ZipUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.*;

@Controller
@RequestMapping(value = "user")
public class UserController {
    @Autowired
    private UserService userService;

    /**
     * 查询角色信息
     * @return
     */
    @RequestMapping("getRole")
    @ResponseBody
    public List<RoleBean> getRole(){
        return userService.getRole();
    }

    /**
     * 跳转新增角色jsp页面
     * @return
     */
    @RequestMapping(value = "toAdd")
    public String toAdd(){
        return "/jsp/toAddRole";
    }

    /**
     * 新增角色信息
     * @param role
     * @return
     */
    @RequestMapping(value = "addRole")
    @ResponseBody
    public Map<String,Object> addRole(RoleBean role){
        Map<String,Object> map =new HashMap<String, Object>();
        try{
            userService.addRole(role);
            map.put("success",true);
        }catch (Exception e){
            e.printStackTrace();
            map.put("success",false);
        }
        return map;
    }

    /**
     * 跳转角色修改jsp页面
     * @return
     */
    @RequestMapping(value = "toUpdRole")
    public String toUpdRole(){
        return "/jsp/toUpdRole";
    }
    /**
     * 修改角色信息
     * @return
     */
    @RequestMapping(value = "updRole")
    @ResponseBody
    public Map<String,Object> updRole(RoleBean role){
        Map<String,Object> map =new HashMap<String, Object>();
        try{
            userService.updRole(role);
            map.put("success",true);
        }catch (Exception e){
            e.printStackTrace();
            map.put("success",false);
        }
        return map;
    }
    /**
     * 删除角色信息
     * @return
     */
    @RequestMapping(value = "delRole")
    @ResponseBody
    public Map<String,Object> delRole(String ids){
        Map<String,Object> map =new HashMap<String, Object>();
        try{
            userService.delRole(ids);
            map.put("success",true);
        }catch (Exception e){
            e.printStackTrace();
            map.put("success",false);
        }
        return map;
    }

    /**
     * 跳转树信息页面
     * @return
     */
    @RequestMapping(value = "toShowRoles")
    public String toShowQx(Integer id,Model model){
        model.addAttribute("id",id);
        return "/jsp/showTree";
    }

    /**
     * 查询树树信息页面
     * @return
     */
    @RequestMapping("getRoleTree")
    @ResponseBody
    public List<Map<String,Object>>  getRoleTree(Integer rid){
    List<RoleTree> rolePower = userService.getPowerById(rid);
        System.out.println(rolePower);
    List<TreeBean> tree = userService.getZtree();
        for (TreeBean treeList : tree) {
        for (RoleTree roleTree : rolePower) {
            if(roleTree.getTid()==treeList.getId()){
                treeList.setChecked(true);
            }
        }
    }
    List<Map<String, Object>> maps = treeStr1(tree, 0);
        return maps;
}

    public List<Map<String,Object>> treeStr1(List<TreeBean> list, Integer pid){
        List<Map<String,Object>> newlist = new ArrayList<Map<String,Object>>();
        for (int i = 0; i < list.size(); i++) {
            //获取单个tree对象
            TreeBean tree = list.get(i);
            Map<String,Object> map = null;
            //判断当前tree对象的pid是否和传过来的pid相等，相等的保存到map中
            if(tree.getPid() == pid){
                map = new HashMap<String, Object>();
                map.put("id", tree.getId());
                map.put("text", tree.getName());
                map.put("url", tree.getUrl());
                map.put("checked", tree.getChecked());
                map.put("children", treeStr1(list,tree.getId()));
            }
            if(map != null){
                List<Map<String,Object>> li = (List<Map<String, Object>>) map.get("children");
                if(li.size()<=0){
                    map.remove("children");
                }
                newlist.add(map);
            }
        }
        return newlist;
    }

    /**
     * 新增权限
     * @param id
     * @param ids
     * @return
     */
    @RequestMapping("addRoleTree")
    @ResponseBody
    public Boolean addRoleTree(Integer id,String ids){
        Boolean aBoolean = userService.addRoleTree(id, ids);
        return  aBoolean;
    }

    //上菜单树
    @RequestMapping(value = "getTree")
    @ResponseBody
    public List<Map<String,Object>> getTree(){
        List<TreeBean> list = userService.getZtree();
        return treeStr(list,-1);
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
                map.put("text", tree.getName());
                map.put("url", tree.getUrl());
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

    /**
     * 查询详细菜单
     * @param id
     * @return
     */
    @RequestMapping(value = "getPower")
    @ResponseBody
    public List<Power> getPower(Integer id){
        return userService.getPower(id);
    }

    /***
     * 新增详细菜单信息
     * @param menu
     * @return
     */
    @RequestMapping("addMenu")
    @ResponseBody
    public Map<String,Object> addMenu(Power menu){
        Map<String,Object> map=new HashMap<String,Object>();
        try {
            userService.addMenu(menu);
            map.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
        }
        return map;
    }

    /***
     * 删除详细菜单信息
     * @param id
     * @return
     */
    @RequestMapping("delMenu")
    @ResponseBody
    public Map<String,Object> delMenu(Integer id){
        Map<String,Object> map=new HashMap<String,Object>();
        try {
            userService.delMenu(id);
            map.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
        }
        return map;
    }

    /***
     * 修改详细菜单信息
     * @param menu
     * @return
     */
    @RequestMapping("updMenu")
    @ResponseBody
    public Map<String,Object> updMenu(Power menu){
        Map<String,Object> map=new HashMap<String,Object>();
        try {
            userService.updMenu(menu);
            map.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
        }
        return map;
    }

    /**
     * 跳转新增树jsp页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("toAddTree")
    public String toAddTree(Integer id,Model model){
        model.addAttribute("id",id);
        return "/jsp/treeAdd";
    }

    /**
     * 新增树信息
     * @param tr
     * @return
     */
    @RequestMapping("addTree")
    @ResponseBody
    public Map<String,Object> addTree(TreeBean tr){
        Map<String,Object> map=new HashMap<String,Object>();
        try {
            userService.addTree(tr);
            map.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
        }
        return map;
    }

    /**
     * 跳转修改树页面
     * @param
     * @param
     * @return
     */
    @RequestMapping("toUpdTree")
    public String toUpdTree(){
        return "/jsp/updTrees";
    }

    /**
     * 修改树页面
     * @param tr
     *
     * @return
     */
    @RequestMapping("updTree")
    @ResponseBody
    public Map<String,Object> updTree(TreeBean tr) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            userService.updTree(tr);
            map.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
        }
        return map;
    }

    /**
     * 删除树
     * @param id
     * @return
     */
    @RequestMapping("delTree")
    @ResponseBody
    public Map<String,Object> delTree(Integer id){
        Map<String,Object> map=new HashMap<String,Object>();
        try {
            userService.delTree(id);
            map.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
        }
        return map;
    }

    /**
     * 上传
     * @param file
     * @param request
     * @return
     */

    //文件上传
    @RequestMapping("uploadPhotoFiles")
    @ResponseBody
    public Boolean uploadPhotoFiles(@RequestParam MultipartFile[] file,Integer pid,HttpServletRequest request) {
        HttpSession session = request.getSession();
        Clientele clientele=(Clientele)session.getAttribute("clientele");
        ArrayList<Resources> resourse = new ArrayList<Resources>();
        for (int i = 0; i < file.length; i++) {
            String upFileName = FileUtil.upFile(file[i], PhotoTomcat.PHOTO_PATH);
            Resources resources = new Resources();
            resources.setUserId(clientele.getId());
            resources.setName(file[i].getOriginalFilename().split("\\.")[0]);
            resources.setType(file[i].getOriginalFilename().split("\\.")[1]);
            resources.setPid(pid);
            resources.setTime(new Date());
            resources.setPath(PhotoTomcat.PHOTO_PATH + upFileName);
            resourse.add(resources);
        }
        boolean uploadTests = userService.uploadPhotoFiles(resourse);
        return uploadTests;
    }

    //查询资源
    @RequestMapping("getFileList")
    @ResponseBody
    public List<Resources> getFileList(HttpServletRequest request,Integer id){
        HttpSession session = request.getSession();
        Clientele clientele=(Clientele)session.getAttribute("clientele");
        if(id==null){
            id=0;
        }
        return userService.getFileList(clientele.getId(),id);
    }

    @RequestMapping(value = "downFold")
    @ResponseBody
    public void downFold(HttpServletRequest request, HttpServletResponse response, String idss){
        HttpSession session = request.getSession();
        Clientele clientele=(Clientele)session.getAttribute("clientele");
        List<HashMap> resourceBeans = userService.getFileLists(clientele.getId(),idss);
        if(resourceBeans == null){
            request.getSession().setAttribute("bbb","您选中的文件夹里面没有任何文件");
        }else {
            ZipUtil.zip(clientele.getClienteleName(),resourceBeans,request,response);
        }
    }

    @RequestMapping("addFolder")
    @ResponseBody
    public Map<String,Object> addFolder(HttpServletRequest request,Resources resourse){
        Map<String,Object> map=new HashMap<String,Object>();
        try {
            HttpSession session = request.getSession();
            Clientele clientele=(Clientele)session.getAttribute("clientele");
            resourse.setUserId(clientele.getId());
            resourse.setTime(new Date());
            userService.addFolder(resourse);
            map.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
        }
        return map;
    }

    /**
     * 查询日志
     * @param page
     * @param rows
     * @return
     */
    @RequestMapping(value = "getLog")
    @ResponseBody
    public Map<String,Object> getLog(Integer page,Integer rows){
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("total", userService.getLog().size());
        map.put("rows", userService.getLogByPage(page,rows));
        return map;
    }

    /**
     * 查询公告
     * @param page
     * @param rows
     * @return
     */
    @RequestMapping(value = "getNotice")
    @ResponseBody
    public Map<String,Object> getNotice(Integer page,Integer rows){
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("total", userService.getNotice().size());
        map.put("rows", userService.getNoticeByPage(page,rows));
        return map;
    }

    /**
     * 跳转发布公告页面
     * @return
     */
    @RequestMapping(value = "toAddNotice")
    public String toAddNotice(){
        return "/jsp/toAddNotice";
    }

    /**
     * 新增树信息
     * @param notice
     * @return
     */
    @RequestMapping("addNotice")
    @ResponseBody
    public Map<String,Object> addNotice(Notice notice){
        Map<String,Object> map=new HashMap<String,Object>();
        try {
            userService.addNotice(notice);
            map.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
        }
        return map;
    }

    /**
     * 查询客户信息
     * @param page
     * @param rows
     * @return
     */
    @RequestMapping(value = "getClientele")
    @ResponseBody
    public Map<String,Object> getClientele(Integer page,Integer rows){
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("total", userService.getClientele().size());
        map.put("rows", userService.getClienteleByPage(page,rows));
        return map;
    }

    /**
     * 跳转新增客户页面
     * @return
     */
    @RequestMapping(value = "toAddClientele")
    public String toAddClientele(){
        return "/jsp/toAddClientele";
    }

    /**
     * 跳转修改客户页面
     * @return
     */
    @RequestMapping(value = "toUpdClientele")
    public String toUpdClientele(){
        return "/jsp/toUpdClientele";
    }

    /**
     * 新增客户信息
     * @param clientele
     * @return
     */
    @RequestMapping(value = "addClientele")
    @ResponseBody
    public Map<String,Object> addClientele(Clientele clientele){
        Map<String,Object> map=new HashMap<String,Object>();
        try {
            userService.addClientele(clientele);
            map.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
        }
        return map;
    }
    /**
     * 修改客户信息
     * @param clientele
     * @return
     */
    @RequestMapping(value = "updClientele")
    @ResponseBody
    public Map<String,Object> updClientele(Clientele clientele){
        Map<String,Object> map=new HashMap<String,Object>();
        try {
            userService.updClientele(clientele);
            map.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
        }
        return map;
    }

    /**
     * 删除客户信息
     * @param ids
     * @return
     */
    @RequestMapping(value = "delClientele")
    @ResponseBody
    public Map<String,Object> delClientele(String ids){
        Map<String,Object> map=new HashMap<String,Object>();
        try {
            userService.delClientele(ids);
            map.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
        }
        return map;
    }

    /**
     * 查询发布房源信息
     * @param page
     * @param rows
     * @return
     */
    @RequestMapping(value = "getRental")
    @ResponseBody
    public Map<String,Object> getRental(Rental rental,Integer page,Integer rows){
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("total", userService.getRental(rental).size());
        map.put("rows", userService.getRentalByPage(rental,page,rows));
        return map;
    }

    @RequestMapping(value = "getRentals")
    @ResponseBody
    public Map<String,Object> getRentals(Rental rental,Integer page,Integer rows){
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("total", userService.getRentals(rental).size());
        map.put("rows", userService.getRentalByPages(rental,page,rows));
        return map;
    }

    /**
     * 跳转展示详情页面
     * @return
     */
    @RequestMapping(value = "toShowRental")
    public String toShowRental(){
        return "/jsp/toShowRental";
    }

    /**
     * 跳转新增房源信息页面
     * @return
     */
    @RequestMapping(value = "toAddRental")
    public String toAddRental(){
        return "/jsp/addRental";
    }


    /**
     * 新增客户信息
     * @param rental
     * @return
     */
    @RequestMapping(value = "addRental")
    @ResponseBody
    public Map<String,Object> addRental(Rental rental,HttpServletRequest request){
        Map<String,Object> map=new HashMap<String,Object>();
        try {
            HttpSession session = request.getSession();
            Clientele clientele=(Clientele)session.getAttribute("clientele");
            rental.setCid(clientele.getId());
            userService.addRental(rental);
            map.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
        }
        return map;
    }

    //新增 上传图片
    @RequestMapping(value = "uploadPhotoFilese")
    @ResponseBody
    public String uploadPhotoFilese(@RequestParam MultipartFile[] file,HttpServletRequest request){
        ArrayList<Photos> photos = new ArrayList<Photos>();
        String aa= UUID.randomUUID().toString().replaceAll("-","");
        for (int i = 0; i < file.length; i++) {
            String upFileName = FileUtil.upFile(file[i], PhotoTomcat.PHOTO_PATH);
            Photos photo = new Photos();
            photo.setHid(aa);
            photo.setName(file[i].getOriginalFilename().split("\\.")[0]);
            photo.setType(file[i].getOriginalFilename().split("\\.")[1]);
            photo.setUrl(PhotoTomcat.PHOTO_URL+upFileName);
            photo.setPath(PhotoTomcat.PHOTO_PATH+upFileName );
            photos.add(photo);
        }
        boolean uploadTest= userService.uploadPhotoFile(photos);
        if(uploadTest){
            return aa;
        }
        return "GG";
    }

    @RequestMapping(value = "toSelPhoto")
    public String toSelPhoto(String hid,Model model){
        model.addAttribute("hid",hid);
        return "/jsp/selPhoto";
    }

    @RequestMapping("getPhotos")
    @ResponseBody
    public  List<Photos> getPhotos(String hid){
        List<Photos> userPhotos = userService.getPhotos(hid);
        return userPhotos;
    }

    @RequestMapping(value = "getRentalByClientele")
    @ResponseBody
    public Map<String,Object> getRentalByClientele(Rental rental,Integer page,Integer rows,HttpServletRequest request){
        Map<String,Object> map=new HashMap<String,Object>();
        HttpSession session = request.getSession();
        Clientele clientele=(Clientele)session.getAttribute("clientele");
        map.put("total", userService.getRental(rental).size());
        map.put("rows", userService.getRentalByClientele(clientele.getId(),page,rows));
        return map;
    }
    @RequestMapping(value = "getLogs")
    @ResponseBody
    public Map<String,Object> getLogs(Integer page,Integer rows,HttpServletRequest request){
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("total", userService.getLog().size());
        map.put("rows", userService.getLogByPage(page,rows));
        return map;
    }

    /**
     * 删除房源信息信息
     * @param ids
     * @return
     */
    @RequestMapping(value = "delRental")
    @ResponseBody
    public Map<String,Object> delRental(String ids){
        Map<String,Object> map=new HashMap<String,Object>();
        try {
            userService.delRental(ids);
            map.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
        }
        return map;
    }
    @RequestMapping(value = "toUpdRental")
    public String toUpdRental(){
        return "/jsp/toUpdRental";
    }

    @RequestMapping(value = "updRental")
    @ResponseBody
    public Map<String,Object> updRental(Rental rental){
        Map<String,Object> map=new HashMap<String,Object>();
        try {
            userService.updRental(rental);
            map.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", false);
        }
        return map;
    }

    @RequestMapping(value = "toImgage")
    public String toImgage(){
        return "images";
    }

    @RequestMapping(value = "toLogin")
    public String toLogin(HttpServletRequest request){
        if( request.getSession()!=null){
            request.getSession().removeAttribute("clientele");
        }
      return  "login";
    }

    @RequestMapping(value = "toSelNotice")
    public String toSelNotice(){
        return "/jsp/toSelNotice";
    }


    @RequestMapping("fileupload")
    @ResponseBody
    public String fileupload(@RequestParam MultipartFile file){
        String upFile = FileUtil.upFile(file, PhotoTomcat.PHOTO_PATH);
        return  PhotoTomcat.PHOTO_PATH+upFile;
    }
    @RequestMapping("sendEmail")
    @ResponseBody
    public void sendEmail(Clientele clientele){
        try {
            String[] files = clientele.getPhotos().split(",");
            System.out.println(clientele);
            ArrayList<File> files1 = new ArrayList<File>();
            for (int i = 0; i < files.length; i++) {
                files1.add(new File(files[i]));
            }
            EmaliUtil.sendHtmlMail(clientele.getRecipients(),clientele.getTheme(),clientele.getContent(),files1);
        } catch (MessagingException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }
    @RequestMapping(value = "toSendSuccess")
    public String toSendSuccess(){
        return "/jsp/toSendSuccess";
    }

    @RequestMapping(value = "toGetClientle")
    public String toGetClientle(){
        return  "/jsp/toGetClientle";
    }

    @RequestMapping(value = "getEmail")
    @ResponseBody
    public List<Clientele> getEmail(){
      return  userService.getEmail();
    }

}
