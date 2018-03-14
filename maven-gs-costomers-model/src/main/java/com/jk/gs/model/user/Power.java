package com.jk.gs.model.user;

import java.io.Serializable;

public class Power implements Serializable {
    private static final long serialVersionUID = -4955093298255608403L;

    private Integer id;

    private String  text;

    private String  url;

    private Integer tid;

    private String  remark;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getTid() {
        return tid;
    }

    public void setTid(Integer tid) {
        this.tid = tid;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
