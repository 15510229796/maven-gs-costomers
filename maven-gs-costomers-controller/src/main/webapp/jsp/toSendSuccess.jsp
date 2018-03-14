<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/27
  Time: 19:47
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
发送邮件成功！！！<a href="javascript:getBack()">返回</a>
<script>
    function getBack(){
        location.href="../test/toSendEmail.do";
    }
</script>
</body>
</html>
