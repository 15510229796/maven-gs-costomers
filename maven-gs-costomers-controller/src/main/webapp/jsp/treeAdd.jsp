<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/13
  Time: 18:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form id="treeForm" style="padding-top: 35px;padding-left: 30px">
    <input type="hidden" name="id" id="id" value="${id}"/>
    <table>
        <tr>
            <td>节点名称</td>
            <td><input class="easyui-textbox" name="name" id="name" style="width:180px"></td>
        </tr>
        <tr>
            <td> 路径名称</td>
            <td><input class="easyui-textbox" name="url" id="url" style="width:180px"></td>
        </tr>
    </table>
</form>
</body>
</html>
