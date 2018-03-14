package com.jk.gs.model.user;

import java.io.Serializable;

public class RoleTree implements Serializable {
    private static final long serialVersionUID = -5036215382373387586L;

    private Integer id;

    private Integer rid;

    private Integer tid;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRid() {
        return rid;
    }

    public void setRid(Integer rid) {
        this.rid = rid;
    }

    public Integer getTid() {
        return tid;
    }

    public void setTid(Integer tid) {
        this.tid = tid;
    }
}
