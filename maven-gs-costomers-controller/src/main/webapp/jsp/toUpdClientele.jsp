<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/19
  Time: 12:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form id="updClienteleForm" style="padding-top: 40px">
    <input type="hidden" id="id" name="id"/>
    <table>
        <tr>
            <td>客户姓名:</td>
            <td><input  class="easyui-textbox" id="clienteleName" name="clienteleName" data-options="required:true" style="width:180px"></td>
        </tr>
        <tr>
            <td>客户性别:</td>
            <td>
                <label><input type="radio" name="clienteleSex" value="1">男</label>
                <label><input type="radio" name="clienteleSex" value="2">女</label>
            </td>
        </tr>
        <tr>
            <td>客户年龄:</td>
            <td><input  class="easyui-textbox" id="clienteleAge" name="clienteleAge"  style="width:180px"></td>
        </tr>
        <tr>
            <td>客户身份证号:</td>
            <td><input  class="easyui-textbox" id="clienteleID" name="clienteleID"  data-options="required:true" style="width:180px;"></td>
        </tr>
        <tr>
            <td>客户联系方式:</td>
            <td><input  class="easyui-textbox" id="clientelePhone" name="clientelePhone" data-options="required:true" style="width:180px"></td>
        </tr>
        <tr>
            <td>客户登陆账号:</td>
            <td><input  class="easyui-textbox" id="clienteleNumber" name="clienteleNumber"  style="width:180px"></td>
        </tr>
        <tr>
            <td>客户登录密码:</td>
            <td><input  class="easyui-textbox" type="password" id="clientelePassword" name="clientelePassword"  style="width:180px"></td>
        </tr>
        <tr>
            <td>客户住址:</td>
            <td><input  class="easyui-textbox" id="clienteleAdress" name="clienteleAdress" data-options="required:true" style="width:180px"></td>
        </tr>
        <tr>
            <td>紧急联系人:</td>
            <td><input  class="easyui-textbox" id="emergencyContact" name="emergencyContact" data-options="required:true"  style="width:180px"></td>
        </tr>
        <tr>
            <td>紧急联系人电话:</td>
            <td><input  class="easyui-textbox" id="emergencyContactPhone" name="emergencyContactPhone" data-options="required:true"  style="width:180px"></td>
        </tr>
    </table>
</form>
</center>
<script>
    if($("#showClientele").datagrid('getSelected')!=""){
        var clienteles= $("#showClientele").datagrid('getSelected');
        $("#id").val(clienteles.id);
        $("#clienteleName").val(clienteles.clienteleName);
        $("input[name='clienteleSex']").each(function(){
            if($(this).val()==clienteles.clienteleSex){
                $(this).attr("checked",true)
            }
        })
        $("#clienteleAge").val(clienteles.clienteleAge);
        $("#clienteleID").val(clienteles.clienteleID);
        $("#clientelePhone").val(clienteles.clientelePhone);
        $("#clienteleNumber").val(clienteles.clienteleNumber);
        $("#clientelePassword").val(clienteles.clientelePassword);
        $("#clienteleAdress").val(clienteles.clienteleAdress);
        $("#emergencyContact").val(clienteles.emergencyContact);
        $("#emergencyContactPhone").val(clienteles.emergencyContactPhone);
    }
</script>
</body>
</html>
