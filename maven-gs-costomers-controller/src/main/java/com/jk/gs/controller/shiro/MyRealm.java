package com.jk.gs.controller.shiro;

import com.jk.gs.model.user.Test;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import java.util.ArrayList;
import java.util.List;

public class MyRealm extends AuthorizingRealm {
    @Override
    public void setName(String name){
        super.setName("customRealm");
    }

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principal) {
      Test test = (Test) principal.getPrimaryPrincipal();
        //权限关键字
        //通过对象id查询出用户所拥有的权限关键字，并把权限放入权限集合中
        //shiro权限控制是使用aop实现的
        List<String> permissions = new ArrayList<String>();
        permissions.add("user:add");
        permissions.add("user:detele");
        permissions.add("user:update");
        SimpleAuthorizationInfo sai = new SimpleAuthorizationInfo();
        sai.addStringPermissions(permissions);
        return sai;
    }
    //认证
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        String username= (String) token.getPrincipal();
        System.out.println(username);
        //根据用户名查询出调用service层查询当前用户是否存在
        Test test= new Test();
        test.setUsername("zhangsan");
        test.setPassword("123456");
        if(test == null){
            throw new UnknownAccountException();
        }
        SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(test,test.getPassword(),this.getName());
        return simpleAuthenticationInfo;
    }
}
