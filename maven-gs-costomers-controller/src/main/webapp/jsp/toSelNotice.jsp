<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/22
  Time: 17:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
 <center>
     <form style="padding-top: 30px">
     <table>
         <tr>
             <td>内容:</td>
             <td><input class="easyui-textbox" name="content" id="content"  style="width:180px;height: 50px"></td>
         </tr>
     </table>
     </form>
 </center>
<script>
    if($("#rentals").datagrid('getSelected')!=""){
        var rows =$("#rentals").datagrid('getSelected');
        $("#content").val(rows.content);
    }
</script>
</body>
</html>
