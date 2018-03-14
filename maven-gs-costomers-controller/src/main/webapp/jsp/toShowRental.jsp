<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/20
  Time: 11:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>

<link type="text/css" rel="stylesheet" href="js/lbt/css/css.css">
<script src="js/lbt/js/jquery-1.9.1.min.js"></script>
<script src="js/lbt/js/index.js"></script>
<body>

    <form style="padding-top: 30px">
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
    <div class="box">
        <!-- 存放大图的容器-->
        <div class="all">
            <div class="top-img">
                <div class="activeimg">
                    <img src="http://127.0.0.1:8090/c2fb9d88-852d-40b7-b2f6-00c17a68862a.jpg">
                    <img src="http://127.0.0.1:8090/d301c3d4-6778-40b3-9119-fde029938ef9.jpg">
                    <img src="/js/lbt/img/3.jpg">
                    <img src="/js/lbt/img/4.jpg">
                    <img src="/js/lbt/img/5.jpg">
                </div>
                <div class="left"><img src="/js/lbt/img/left.png"></div>
                <div class="right"><img src="/js/lbt/img/right.png"></div>
            </div>
            <!-- 存放缩略图的容器-->
            <div class="bot-img">
                <ul>
                    <li class="active"><img src="/js/lbt/img/1.jpg"></li>
                    <li><img src="http://127.0.0.1:8090/c2fb9d88-852d-40b7-b2f6-00c17a68862a.jpg"></li>
                    <li><img src="/js/lbt/img/3.jpg"></li>
                    <li><img src="/js/lbt/img/4.jpg"></li>
                    <li><img src="/js/lbt/img/5.jpg"></li>
                </ul>
            </div>
        </div>
    </div>
<script>
    if($("#showRental").datagrid('getSelected')!=""){
      var rentals =  $("#showRental").datagrid('getSelected');
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
