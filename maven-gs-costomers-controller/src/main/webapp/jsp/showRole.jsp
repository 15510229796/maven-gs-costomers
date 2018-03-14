<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/11
  Time: 22:20
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
<div id="stubtn1">
    <a href="javascript:toAdd()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</a>
    <a href="javascript:toEdit()" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>
    <a href="javascript:todel()" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
</div>
<div id="addRole"></div>
<div id="updRole"></div>
<div id="addRoles"></div>
<div id="showRole"></div>
</body>
<script>
    $("#showRole").datagrid({
        url:"/user/getRole.do",
        fit:true,
        columns:[[
            {field:'s',title:'全选',checkbox:true},
            {field:'id',title:'编号',width:190,align:'center'},
            {field:'rname',title:'角色姓名',width:235,align:'center'},
            {field:'newtime',width:225,title:'创建时间',align:'center'},
            {field:'remark',width:240,title:'备注',align:'center'},
            {field:'xx',width:175,title:'操作',align:'center',formatter:function(value,row,index){
                return '<a type="button" href="javascript:setRole('+row.id+')">权限绑定</a>';
            }}
        ]],
        pagination:true,
        toolbar:"#stubtn1",
    });

    //新增
    function  toAdd() {
        $("#addRole").dialog({
            title:'用户信息',
            width: 350,
            height: 300,
            closed: false,
            modal: true,
            href:'/user/toAdd.do',
            buttons:[{
                text:'提交',
                handler:function(){
                    $.ajax({
                        url:'/user/addRole.do',
                        type:'post',
                        data:$("#addRoleForm").serialize(),
                        dataType:'json',
                        success:function(data){
                            if(data.success){
                                $("#addRole").dialog("close");
                                $("#showRole").datagrid('reload');
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

    }
    //修改权限
    function toEdit(){
        var rows =$("#showRole").datagrid('getSelections');
        if($("#showRole").datagrid('getSelections').length<1){
            alert("请选择要修改的数据");
        }else if($("#showRole").datagrid('getSelections').length==1){
            $("#updRole").dialog({
                title:'修改用户信息',
                width: 350,
                height: 400,
                closed: false,
                modal: true,
                href:'/user/toUpdRole.do',
                buttons:[{
                    text:'提交',
                    handler:function(){
                        $.ajax({
                            url:'/user/updRole.do',
                            type:'post',
                            data:$("#updRoleForm").serialize(),
                            dataType:'json',
                            success:function(data){
                                if(data.success){
                                    $("#updRole").dialog("close");
                                    $("#showRole").datagrid('reload');
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
    }
    //删除角色信息
    function todel(){
        var ids="";
        var ops=$("#showRole").datagrid('getSelections');
        for(var i=0;i<ops.length;i++){
            ids+=","+ops[i].id;
        }
        ids=ids.substr(1);
        if($("#showRole").datagrid('getSelections')==""){
            alert("请选择要删除的信息");
            return false;
        }
        $.ajax({
            url:"/user/delRole.do",
            type:"post",
            data:{"ids":ids},
            dataType:"json",
            success:function (data) {
                if(data.success){
                    $("#showRole").datagrid('reload');
                }else{
                    alert("GG");
                }
            }
        })
    }

    //新增权限
    function setRole(id) {

        $("#addRoles").dialog({
            title:'用户信息',
            width: 350,
            height: 400,
            closed: false,
            modal: true,
            href:'/user/toShowRoles.do?id='+id,
            buttons:[{
                text:'提交',
                handler:function(){
                    var aa="";
                    var node= $("#showTree").tree('getChecked');
                    for(var i=0;i<node.length;i++){
                        aa+=","+node[i].id;
                    }
                    aa=aa.substr(1);
                    alert(aa);
                    $.ajax({
                        url:'/user/addRoleTree.do',
                        type:'post',
                        data:{"id":id,"ids":aa},
                        dataType:'json',
                        success:function(data){
                            if(data==true){
                                $("#addRoles").dialog("close");
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
    }
</script>
</html>
