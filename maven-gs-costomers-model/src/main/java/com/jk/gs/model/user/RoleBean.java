package com.jk.gs.model.user;

import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

public class RoleBean implements Serializable {
    private static final long serialVersionUID = -5758058985507956044L;

    private Integer id;

    private String  rname;

    private Integer uid;

    private String  remark;
    @DateTimeFormat(pattern = ("yyyy-MM-dd HH:mm:ss"))
    private Date    newtime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRname() {
        return rname;
    }

    public void setRname(String rname) {
        this.rname = rname;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getNewtime() {
        if(newtime==null){
            return null;
        }
        SimpleDateFormat sim = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sim.format(newtime);
    }

    public void setNewtime(Date newtime) {
        this.newtime = newtime;
    }
}
