<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/19
  Time: 10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <center>
        <form id="addClienteleForm" style="padding-top: 40px">
            <table>
                <tr>
                    <td>客户姓名:</td>
                    <td><input  class="easyui-textbox" name="clienteleName" data-options="required:true" style="width:180px"></td>
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
                    <td><input  class="easyui-textbox" name="clienteleAge"  style="width:180px"></td>
                </tr>
                <tr>
                    <td>客户身份证号:</td>
                    <td><input  class="easyui-textbox" name="clienteleID"  data-options="required:true" style="width:180px;"></td>
                </tr>
                <tr>
                    <td>客户联系方式:</td>
                    <td><input  class="easyui-textbox" name="clientelePhone" data-options="required:true" style="width:180px"></td>
                </tr>
                <tr>
                    <td>客户登陆账号:</td>
                    <td><input  class="easyui-textbox" name="clienteleNumber"  style="width:180px"></td>
                </tr>
                <tr>
                    <td>客户登录密码:</td>
                    <td><input  class="easyui-textbox" type="password" name="clientelePassword"  style="width:180px"></td>
                </tr>
                <tr>
                    <td>客户住址:</td>
                    <td><input  class="easyui-textbox" name="clienteleAdress" data-options="required:true" style="width:180px"></td>
                </tr>
                <tr>
                    <td>紧急联系人:</td>
                    <td><input  class="easyui-textbox" name="emergencyContact" data-options="required:true"  style="width:180px"></td>
                </tr>
                <tr>
                    <td>紧急联系人电话:</td>
                    <td><input  class="easyui-textbox" name="emergencyContactPhone" data-options="required:true"  style="width:180px"></td>
                </tr>
            </table>
        </form>
    </center>
</body>
</html>
