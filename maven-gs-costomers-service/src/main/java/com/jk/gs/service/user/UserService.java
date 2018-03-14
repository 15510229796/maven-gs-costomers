package com.jk.gs.service.user;

import com.jk.gs.model.user.*;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
public interface UserService {
    List<RoleBean> getRole();

    void addRole(RoleBean role);

    void updRole(RoleBean role);

    void delRole(String ids);

    List<TreeBean> getZtree();

    List<RoleTree> getPowerById(Integer rid);

    Boolean addRoleTree(Integer id, String ids);

    List<Power> getPower(Integer id);

    void addMenu(Power menu);

    void delMenu(Integer id);

    void updMenu(Power menu);

    void addTree(TreeBean tr);

    void updTree(TreeBean tr);

    void delTree(Integer id);

    List<TreeBean> getTreees(Integer id);

    boolean uploadPhotoFile(ArrayList<Photos> photos);

    List<Photos> getUserPhotos(Integer id);

    void removePhotoById(String id);

    List<Resources> getFileList(Integer userId, Integer id);

    boolean uploadPhotoFiles(ArrayList<Resources> resourse);

    List<HashMap> getFileLists(Integer userid, String idss);

    void addFolder(Resources resourse);

    List<Log> getLogByPage(Integer page, Integer rows);

    List<Log> getLog();

    List<Notice> getNoticeByPage(Integer page, Integer rows);

    List<Notice> getNotice();

    void addNotice(Notice notice);

    List<Clientele> getClientele();

    List<Clientele> getClienteleByPage(Integer page, Integer rows);

    void addClientele(Clientele clientele);

    void updClientele(Clientele clientele);

    void delClientele(String ids);

    List<Rental> getRental(Rental rental);

    List<Rental> getRentalByPage(Rental rental,Integer page, Integer rows);

    void addRental(Rental rental);

    List<Photos> getPhotos(String hid);

    List<Rental> getRentalByClientele(Integer id, Integer page, Integer rows);

    void delRental(String ids);

    void updRental(Rental rental);

    List<Rental> getRentals(Rental rental);

    List<Rental> getRentalByPages(Rental rental, Integer page, Integer rows);

    List<Clientele> getEmail();
}
