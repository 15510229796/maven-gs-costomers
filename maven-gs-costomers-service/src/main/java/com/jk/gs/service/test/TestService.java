package com.jk.gs.service.test;

import com.jk.gs.model.user.TreeBean;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface TestService {
    public int getCount();

    List<TreeBean> getZtree(Integer cid);
}
