<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/18
  Time: 10:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="/js/jquery-easyui-1.4.1/themes/default/easyui.css"/>
    <link rel="stylesheet" href="/js/jquery-easyui-1.4.1/themes/icon.css"/>
    <script src="/js/jquery-easyui-1.4.1/jquery.min.js"></script>
    <script src="/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
    <script src="/js/jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>

    <link href="/js/FileUploadQT/css/iconfont.css" rel="stylesheet" type="text/css"/>
    <link href="/js/FileUploadQT/css/fileUpload.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="/js/FileUploadQT/js/fileUpload.js"></script>

</head>
<body>
<div id="toolbar">
    <div>
        <a id="createFolderBut" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新建文件夹</a>
        <a id="uploadFileBut" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true">上传</a>
        <a id="downFileBut" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">下载</a>
    </div>
    当前位置：<span id="link"><a id="0" href="javascript:loadFileList(0);">/</a></span>
</div>
<table id="fileList"></table>
<div id="photoDialogs" class="easyui-dialog" style="width: 700px;height: 500px" data-options="closed:true,modal:true">
    <div id="fileUploadContents" class="fileUploadContent">
    </div>
</div>

<!-- 创建修改文件夹 -->
<div id="floderDialog" class="easyui-dialog" data-options="title:'创建文件夹',iconCls:'icon-add',resizable:true,modal:true,closed:true,
		buttons:[
			{
				text:'保存',
				iconCls:'icon-ok',
				handler:function(){
					saveFolder();
				}
			}]" style="width:400px;height:200px;" >
    <form id="floderForm" method="post">
        <input type="hidden" name="pid" id="foldId" value="0"/>
        <table style="margin: 44px;">
            <tr>
                <td>名称：</td>
                <td><input type="text" class="easyui-textbox" name="name"/></td>
            </tr>
        </table>
    </form>
</div>

<script>
    //新增弹框
    $("#createFolderBut").click(function(){
        //图片上传方法
        $('#floderDialog').dialog({
            title:'新建文件夹',
            iconCls:'icon-add',
            closed: false,
            onClose:function(){
                $('#floderForm').form('reset');
            }
        })
    });
    //新增提交FORM表单方法
    function saveFolder(){
        $('#floderForm').form('submit',{
            url:'/user/addFolder.do',
            success:function(dataddFoldera){
                $('#floderDialog').dialog('close');
                $('#floderForm').form('reset');
                $('#fileList').datagrid('reload');
            }
        })
    }
    //列表查询
    $('#fileList').datagrid({
        url:'/user/getFileList.do?pid='+$("#foldId").val(),
        toolbar:'#toolbar',
        pageNumber:1,
        pageSize:10,
        fit:true,
        pageList:[10,20,50,100],
        pagination:true,
        loadMsg:'数据加载中...',
        rownumbers:true,
        columns:[[
            {field:'id',title:'ID',width:'8%',align:'center',checkbox:true},
            {field:'name',title:'名称',width:'30%',formatter:function(value,row,index){
                if(row.type == null || row.type == ''){
                    return '<img width="20px" height="20px" src="/js/images/folder (1).png"/> '+value;
                }else if(row.type == 'jpg' || row.type == 'png' || row.type == 'gif' || row.type == 'ico'){
                    return '<img width="20px" height="20px" src="/js/images/file-picture-icon.png"/> '+value;
                }else if(row.type == 'txt'){
                    return '<img width="20px" height="20px" src="/js/images/txt_files.png"/> '+value;
                }else if(row.type == 'exe'){
                    return '<img width="20px" height="20px" src="/js/images/font-409.png"/> '+value;
                }else if(row.type == 'doc' || row.type == 'docx'){
                    return '<img width="20px" height="20px" src="/js/images/file-word-icon.png"/> '+value;
                }else if(row.type == 'xls' || row.type == 'xlsx'){
                    return '<img width="20px" height="20px" src="/js/images/file-excel-icon.png"/> '+value;
                }else if(row.type == 'zip' || row.type == 'rar'){
                    return '<img width="20px" height="20px" src="/js/images/Package.png"/> '+value;
                }else if(row.type == 'js'){
                    return '<img width="20px" height="20px" src="/js/images/js_file.png"/> '+value;
                }else if(row.type == 'css'){
                    return '<img width="20px" height="20px" src="/js/images/File_CSS_Stylesheet.png"/> '+value;
                }else if(row.type == 'java'){
                    return '<img width="20px" height="20px" src="/js/images/java-icon.png"/> '+value;
                }else if(row.type == 'html'){
                    return '<img width="20px" height="20px" src="/js/images/file_html.png"/> '+value;
                }else{
                    return '<img width="20px" height="20px" src="/js/images/text_file.png"/> '+value;
                }
            }},
            {field:'type',title:'类型',width:'30%',align:'center',formatter:function(value,row,index){
                if(value == null || value == ''){
                    return "文件夹";
                }else{
                    return value;
                }
            }},
            {field:'time',title:'上传时间',width:'35%',align:'center'}
        ]],
        onDblClickRow:function(index,row){
            if(row.type == null || row.type == ''){
                $('#foldId').val(row.id);
                $('#fileFloderId').val(row.id);
                $('#link').append('<a  style="margin-left:10px" id='+row.id+' href="javascript:loadFileList(\''+row.id+'\');">'+row.name+'</a>');
                $('#fileList').datagrid('reload',{
                    'id':row.id
                });
            }else{
                alert("该文件下没有文件");
                return false;
            }
        }
    });

    //下一层
    function loadFileList(id){
        $('#foldId').val(id);
        $('#fileFloderId').val(id);
        $('#'+id+'').nextAll().remove();
        $('#fileList').datagrid('reload',{
            'id':id
        });
    }
    //图片上传弹框
    $("#uploadFileBut").click(function(){
        $("#fileUploadContents").initUpload({

            "uploadUrl":"/user/uploadPhotoFiles.do?pid="+$("#foldId").val(),//上传文件信息地址
            //"progressUrl":"#",//获取进度信息地址，可选，注意需要返回的data格式如下（{bytesRead: 102516060, contentLength: 102516060, items: 1, percent: 100, startTime: 1489223136317, useTime: 2767}）
            showSummerProgress:false,//总进度条，默认限制
            //"size":350,//文件大小限制，单位kb,默认不限制
            //"maxFileNumber":3,//文件个数限制，为整数
            //"filelSavePath":"",//文件上传地址，后台设置的根目录
            "beforeUpload":beforeUploadFun,//在上传前执行的函数
            onUpload:onUploadFun,//在上传后执行的函数
            autoCommit:true,//文件是否自动上传
            //"fileType":['png','jpg','docx','doc']，//文件类型限制，默认不限制，注意写的是文件后缀
        })
        $("#photoDialogs").dialog({
            title:'相册上传',
            closed:false,
        })
    })


    function beforeUploadFun(opt){
        opt.otherData =[{"name":"你要上传的参数","value":"你要上传的值"}];
    }
    function onUploadFun(opt,data){
        if(data==true){
            $("#photoDialogs").dialog('close');
            $('#fileList').datagrid('reload');
        }
        // uploadTools.uploadError(opt);//显示上传错误
    }
    //下载压缩文件
    $("#downFileBut").click(function (){
        var resourceIds="";
        var fold = $('#fileList').datagrid('getSelections');

        for(var i=0;i<fold.length;i++){
            resourceIds+=","+fold[i].id;
        }
        resourceIds=resourceIds.substring(1);
        if(fold==""){
            alert("请选择要下载的文件");
            return false;
        }
        location.href="/user/downFold.do?idss="+resourceIds;
    })

</script>
</body>
</html>
