<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/28
  Time: 11:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

</head>
<body>
 <div id="showEmail"></div>
 <script>
     $("#showEmail").datagrid({
         url:"/user/getEmail.do",
         fit:true,
         striped:true,
         singleSelect:true,
         columns:[[
             {field:'s',title:'全选',checkbox:true},
             {field:'clienteleName',title:'客户名称',width:'37%',align:'center'},
             {field:'recipients',title:'邮箱',width:'60%',align:'center'},
         ]],
         pagination:true,
     });
 </script>
</body>
</html>
