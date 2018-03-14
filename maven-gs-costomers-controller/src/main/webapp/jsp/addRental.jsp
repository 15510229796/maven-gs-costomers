<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/20
  Time: 12:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<center>
<form id="addRentalForm" style="padding-top: 30px">
     <input type="hidden" name="id" id="homr_pk"/>
     <table>
             <tr>
                 <td>发布人：</td>
                 <td><input class="easyui-textbox" name="publisher"   style="width:180px;"></td>
             </tr>
             <tr>
                 <td>房屋所在地：</td>
                 <td><input class="easyui-textbox" name="homeAddress"  style="width:180px;"></td>
             </tr>
             <tr>
                 <td>价格：</td>
                 <td><input class="easyui-textbox" name="price"   style="width:180px;"></td>
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
                 <td><input class="easyui-textbox" name="promotion"   style="width:180px;"></td>
             </tr>
             <tr>
                 <td>房屋详情：</td>
                 <td><input class="easyui-textbox" name="homeDescribe"   style="width:180px;height: 70px"></td>
             </tr>
             <tr>
                 <td>新增图片</td>
                 <td>
                     <div id="fileUploadContent" class="fileUploadContent"></div>
                 </td>
             </tr>
         </table>
 </form>
 </center>
<script>
    $("#fileUploadContent").initUpload({

        "uploadUrl":"/user/uploadPhotoFilese.do",//上传文件信息地址
        //"progressUrl":"#",//获取进度信息地址，可选，注意需要返回的data格式如下（{bytesRead: 102516060, contentLength: 102516060, items: 1, percent: 100, startTime: 1489223136317, useTime: 2767}）
        showSummerProgress:false,//总进度条，默认限制
        //"size":350,//文件大小限制，单位kb,默认不限制
        //"maxFileNumber":3,//文件个数限制，为整数
        //"filelSavePath":" ",//文件上传地址，后台设置的根目录
        //"beforeUpload":beforeUploadFun,//在上传前执行的函数
        onUpload:onUploadFun,//在上传后执行的函数
        autoCommit:true,//文件是否自动上传
        //"fileType":['png','jpg','docx','doc']，//文件类型限制，默认不限制，注意写的是文件后缀
    })

    function beforeUploadFun(opt){
        opt.otherData =[{"name":"你要上传的参数","value":"你要上传的值"}];
    }
    function onUploadFun(opt,data){
        if(data == ("GG")){
           alert("上传失败");
        }
        alert(data)

        $("#homr_pk").val(data);
        // uploadTools.uploadError(opt);//显示上传错误
    }
</script>
</body>
</html>
