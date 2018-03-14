<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/19
  Time: 22:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%--<script type="text/javascript" src="/js/jquery-3.2.1/jquery-3.2.1.js"></script>--%>
    <script src="/js/lbt/js/jquery-1.9.1.min.js"></script>
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
<div id="toolbarD">
    <div id="tabss" class="easyui-tabs" data-options="fit:true"></div>
    <div>
        <a id="addRental" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</a>
        <a id="updRental" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>
        <a id="delRental" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
        <form id="queryFrom">
            价格:<input class="easyui-textbox" name="priceMin" id="priceMin"  style="width:130px;">--<input class="easyui-textbox" name="priceMax" id="priceMax"  style="width:130px;">
            <a id="btn" href="javascript:queryWhere()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a>
        </form>
    </div>

</div>
<div id="addRentalDialog"></div>
<div id="selPhoto"></div>
<div id="updRentalDialog"></div>
<div id="rentalDialog"></div>
<div id="showRental"></div>

<script>
       $("#showRental").datagrid({
        url:"/user/getRental.do",
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
        toolbar:"#stubtn1",
        striped:true,
        pageNumber:1,
        pageSize:10,
        pageList:[10,15,25]

    });


    function queryWhere(){
        $("#showRental").datagrid('load',{
            priceMin:$("#priceMin").textbox('getValue'),
            priceMax:$("#priceMax").textbox('getValue'),
        });
    }

    //查看详情
    function chekcedAll(){
        var rental =  $("#showRental").datagrid('getSelected');
        $("#tabss").tabs('add', {
            title :'详情',
            closable : true,
            //content : content,
            href:"/user/toImgage.do",
        });

    }

    //新增
    $("#addRental").click(function(){
        $("#addRentalDialog").dialog({
            title:'新增房源信息',
            width:450,
            height:500,
            href:"/user/toAddRental.do",
            buttons:[{
                text:'提交',
                handler:function(){
                    $.ajax({
                        url:'/user/addRental.do',
                        type:'post',
                        data:$("#addRentalForm").serialize(),
                        dataType:'json',
                        success:function(data){
                            if(data.success){
                                $("#addRentalDialog").dialog("close");
                                $("#showRental").datagrid('reload');
                            }else{
                                alert("GG");
                            }
                        }
                    })
                }
            }
            ]
        })
    })

    function  chekcedAllPhoto(id){
        $("#selPhoto").dialog({
            title:'展示房屋图片信息',
            width:1000,
            height:500,
            href:"/user/toSelPhoto.do?hid="+id,
            onLoad:function(){
                new polaroidGallery('/user/getPhotos.do?hid='+id);
            }
        });
    }

    /**
     * 删除
     */
    $("#delRental").click(function(){
        var rentals =  $("#showRental").datagrid('getSelections');
        var ids="";
        for(var i=0;i<rentals.length;i++){
            ids+=","+rentals[i].id;
        }
        ids=ids.substr(1);
        if($("#showRental").datagrid('getSelections')==""){
            alert("请选择要删除的信息");
            return false;
        }
        $.ajax({
            url:"/user/delRental.do",
            type:"post",
            data:{"ids":ids},
            dataType:"json",
            success:function (data) {
                if(data.success){
                    $("#showRental").datagrid('reload');
                }else{
                    alert("GG");
                }
            }
        })
    })

    //修改
    $("#updRental").click(function () {
        var rows =$("#showRental").datagrid('getSelections');
        if($("#showRental").datagrid('getSelections').length<1){
            alert("请选择要修改的数据");
        }else if($("#showRental").datagrid('getSelections').length==1){
            $("#updRentalDialog").dialog({
                title:'修改房源信息',
                width: 370,
                height: 450,
                closed: false,
                modal: true,
                href:'/user/toUpdRental.do',
                buttons:[{
                    text:'提交',
                    handler:function(){
                        $.ajax({
                            url:'/user/updRental.do',
                            type:'post',
                            data:$("#updRentalForm").serialize(),
                            dataType:'json',
                            success:function(data){
                                if(data.success){
                                    $("#updRentalDialog").dialog("close");
                                    $("#showRental").datagrid('reload');
                                }else{
                                    alert("GG");
                                }
                            }
                        })
                    }
                },{
                    text:'重置',
                    handler:function(){}
                }]
            })
        }else{
            alert("每次只能修改一条数据");
        }
    })

</script>
</body>
</html>
