package com.jk.gs.model.user;

import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Notice implements Serializable {
    private static final long serialVersionUID = 4655940433511755130L;
    private Integer id;

    private String  title;

    private String  content;

    @DateTimeFormat(pattern = ("yyyy-MM-dd HH:mm:ss"))
    private Date    time;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTime() {
        if (time==null){
            return null;
        }
        SimpleDateFormat sim = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sim.format(time);
    }

    public void setTime(Date time) {
        this.time = time;
    }
}
