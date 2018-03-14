<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/13
  Time: 19:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form id="treeForm1" style="padding-top: 10px;padding-left: 5px">
    <input type="hidden" name="id" id="id" />
    <input type="hidden" name="pid" id="pid" />
    节点名称:<input class="easyui-textbox" name="name" id="name1"  style="width:180px;height: 50px"><br>
    路径名称:<input class="easyui-textbox" name="url" id="url1"  style="width:180px;height: 50px">
</form>
<script>
    if( $("#showTree").tree('getSelected')!=null){
        var node = $("#showTree").tree('getSelected');
        $("#name1").val(node.text);
        $("#url1").val(node.url);
    }
</script>
</body>
</html>
