package com.jk.gs.service.login;

import com.jk.gs.model.user.Log;

import java.util.UUID;

public class Logs implements Runnable {
    private LoginService loginService;
    private Log log;
    public void run() {
        log.setId(UUID.randomUUID().toString().replaceAll("-",""));
        loginService.addLog(log);
    }

    public Logs(LoginService loginService, Log log) {
        this.loginService = loginService;
        this.log = log;
    }

    public LoginService getLoginService() {
        return loginService;
    }

    public void setLoginService(LoginService loginService) {
        this.loginService = loginService;
    }

    public Log getLog() {
        return log;
    }

    public void setLog(Log log) {
        this.log = log;
    }
}
