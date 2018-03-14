<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/13
  Time: 14:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form id="updRoleForm">
    <br>
    <input type="hidden" id="id" name="id"/>
    姓名:<input class="easyui-textbox" id="rname" name="rname"  style="width:250px"><br><br>
    备注:<input class="easyui-textbox" id="remark" name="remark"  style="width:250px"><br><br>
</form>
<script>
    if($("#showRole").datagrid('getSelected')!=""){
        var rows =$("#showRole").datagrid('getSelected');
        $("#id").val(rows.id);
        $("#rname").val(rows.rname);
        $("#remark").val(rows.remark);
    }

</script>
</body>
</html>
