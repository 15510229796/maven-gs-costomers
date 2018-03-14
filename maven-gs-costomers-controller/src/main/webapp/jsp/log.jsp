<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/18
  Time: 21:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="/js/jquery-3.2.1/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/js/jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" type="text/css" href="/js/jquery-easyui-1.4.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/js/jquery-easyui-1.4.1/themes/icon.css">
</head>
<body>
<div id="showLog"></div>
<script>
    $("#showLog").datagrid({
        url:"/user/getLog.do",
        fit:true,
        columns:[[
            {field:'s',title:'全选',checkbox:true},
            {field:'id',title:'编号',width:'20%',align:'center'},
            {field:'username',title:'登录账号',width:'10%',align:'center'},
            {field:'newDate',width:'20%',title:'创建时间',align:'center'},
            {field:'ips',width:'20%',title:'Ip地址',align:'center'},
            {field:'flag',width:'10%',title:'登录状态',align:'center'},
            {field:'address',width:'15%',title:'Ip地址所在地',align:'center'},
        ]],
        pagination:true,
        toolbar:"#stubtn1",
        striped:true,
        pageNumber:1,
        pageSize:10,
        pageList:[10,15,25]

    });
</script>
</body>
</html>
