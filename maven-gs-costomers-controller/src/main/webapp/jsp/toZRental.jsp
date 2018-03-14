<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/22
  Time: 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="/js/jquery-3.2.1/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/js/jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" type="text/css" href="/js/jquery-easyui-1.4.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/js/jquery-easyui-1.4.1/themes/icon.css">
    <link href="/js/FileUploadQT/css/iconfont.css" rel="stylesheet" type="text/css"/>
    <link href="/js/FileUploadQT/css/fileUpload.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="/js/FileUploadQT/js/fileUpload.js"></script>
    <link rel="stylesheet" type="text/css" href="/js/polaroid-gallery/polaroid-gallery.css"/>
    <script type="text/javascript" src="/js/polaroid-gallery/polaroid-gallery.js"></script>
</head>
<body>
<div id="toolbarE">
    <div>
        <form id="queryFrom">
            价格:<input class="easyui-textbox" name="priceMin" id="priceMin"  style="width:130px;">--<input class="easyui-textbox" name="priceMax" id="priceMax"  style="width:130px;">&nbsp;&nbsp;&nbsp;
            交易方式:<select id="type" name="type" class="easyui-combobox" style="width:100px;">
            <option value="">请选择</option>
            <option value="1">租房</option>
            <option value="2">卖房</option>
        </select>
            <a id="btn" href="javascript:queryWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a>
        </form>
    </div>
</div>
<div id="showRental"></div>
<div id="selPhotoes"></div>
<div id="rentalDialoges"></div>
</body>
<script>
    $("#showRental").datagrid({
        url:"/user/getRentals.do",
        fit:true,
        ctrlSelect:true,
        columns:[[
            {field:'s',title:'全选',checkbox:true},
            {field:'publisher',title:'发布人',width:'10%',align:'center'},
            {field:'homeAddress',width:'12%',title:'发布人地址',align:'center'},
            {field:'price',width:'10%',title:'价格',align:'center'},
            {field:'type',width:'8%',title:'类型',align:'center',formatter:function(value,index,rows){
                if(value==1){
                    return '租';
                }
                return '卖';
            }},
            {field:'promotion',width:'15%',title:'促销语',align:'center'},
            {field:'homeDescribe',width:'26%',title:'房屋描述',align:'center'},
            {field:'xx',width:'6%',title:'详情',align:'center',formatter:function(value,index,rows){
                return '<a href="javascript:void()" onclick="chekcedAll()">查看</a>';
            }},
            {field:'xxx',width:'6%',title:'房屋照片',align:'center',formatter:function(value,row,index){
                return "<a href='javascript:void()' onclick='chekcedAllPhoto(\""+row.id+"\")'>查看</a>";
            }},
        ]],
        pagination:true,
        toolbar:"#toolbarE",
        striped:true,
        pageNumber:1,
        pageSize:10,
        pageList:[10,15,25]

    });


    function queryWhere(){
        $("#showRental").datagrid('load',{
            priceMin:$("#priceMin").textbox('getValue'),
            priceMax:$("#priceMax").textbox('getValue'),
            type:$("#type").combobox('getValue')
        });
    }

    //查看详情
    function chekcedAll(){
        var rental =  $("#showRental").datagrid('getSelected');
        $("#rentalDialoges").dialog({
            title:'详情',
            width:370,
            height:450,
            href:"/user/toShowRental.do",
        })
    }

    function  chekcedAllPhoto(id){
        $("#selPhotoes").dialog({
            title:'展示房屋图片信息',
            width:1000,
            height:500,
            href:"/user/toSelPhoto.do?hid="+id,
            onLoad:function(){
                new polaroidGallery('/user/getPhotos.do?hid='+id);
            }
        });
    }
</script>
</html>
