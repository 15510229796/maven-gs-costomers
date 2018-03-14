<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/21
  Time: 21:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form id="updRentalForm" style="padding-top: 30px">
    <input type="hidden" name="id" id="id"/>
    <center>
        <table>
            <tr>
                <td>发布人：</td>
                <td><input class="easyui-textbox" name="publisher" id="publisher"  style="width:180px;"></td>
            </tr>
            <tr>
                <td>房屋所在地：</td>
                <td><input class="easyui-textbox" name="homeAddress" id="homeAddress"  style="width:180px;"></td>
            </tr>
            <tr>
                <td>价格：</td>
                <td><input class="easyui-textbox" name="price" id="price"  style="width:180px;"></td>
            </tr>
            <tr>
                <td>交易类型：</td>
                <td>
                    <label><input type="radio" name="type" value="1">租</label>
                    <label><input type="radio" name="type" value="2">卖</label>
                </td>
            </tr>
            <tr>
                <td>促销语：</td>
                <td><input class="easyui-textbox" name="promotion" id="promotion"  style="width:180px;"></td>
            </tr>
            <tr>
                <td>房屋详情：</td>
                <td><input class="easyui-textbox" name="homeDescribe" id="homeDescribe"  style="width:180px;"></td>
            </tr>

        </table>
    </center>
</form>
<script>
    if($("#showRental").datagrid('getSelected')!=""){
        var rentals =  $("#showRental").datagrid('getSelected');
        $("#id").val(rentals.id);
        $("#publisher").val(rentals.publisher);
        $("#homeAddress").val(rentals.homeAddress);
        $("#price").val(rentals.price);
        $("input[name='type']").each(function(){
            if($(this).val()==rentals.type){
                $(this).attr("checked",true)
            }
        })
        $("#promotion").val(rentals.promotion);
        $("#homeDescribe").val(rentals.homeDescribe);
    }
</script>
</body>
</html>
