package com.jk.gs.service.login;

import com.jk.gs.model.user.Clientele;
import com.jk.gs.model.user.Log;
import com.jk.gs.model.user.UserBean;
import org.springframework.stereotype.Service;

@Service
public interface LoginService {
    

    void addLog(Log log);

    Clientele login(String clienteleNumber);
}
