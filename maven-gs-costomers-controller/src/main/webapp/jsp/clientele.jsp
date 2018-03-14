<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/19
  Time: 0:28
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
</head>
<body>
<div id="toolbarC">
       <div>
        <a id="addClientele" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</a>
        <a id="updClientele" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>
        <a id="delClientele" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>
       </div>
</div>
<div id="addClienteleDia"></div>
<div id="updClienteleDia"></div>
<div id="showClientele"></div>
<script>
    $("#showClientele").datagrid({
        url:"/user/getClientele.do",
        fit:true,
        columns:[[
            {field:'s',title:'全选',checkbox:true},
            {field:'id',title:'编号',width:'3%',align:'center'},
            {field:'clienteleName',title:'客户姓名',width:'5%',align:'center'},
            {field:'clienteleSex',width:'5%',title:'客户性别',align:'center',formatter: function(value,row,index){
             if(value==1){
                 return '男';
             }
             return '女';
             }},
            {field:'clienteleAge',width:'5%',title:'客户年龄',align:'center'},
            {field:'clienteleID',width:'12%',title:'客户身份证号',align:'center'},
            {field:'clientelePhone',width:'10%',title:'客户联系方式',align:'center'},
            {field:'clienteleNumber',width:'7%',title:'客户登陆账号',align:'center'},
            {field:'clientelePassword',width:'7%',title:'客户登陆密码',align:'center'},
            {field:'clienteleAdress',width:'20%',title:'客户住址',align:'center'},
            {field:'emergencyContact',width:'8%',title:'紧急联系人',align:'center'},
            {field:'emergencyContactPhone',width:'10%',title:'紧急联系人联系方式',align:'center'},
        ]],
        pagination:true,
        toolbar:"#toolbarC",
        striped:true,
        pageNumber:1,
        pageSize:10,
        pageList:[10,15,25]
    });

    /**
     * 新增
     */
    $("#addClientele").click(function(){
        $("#addClienteleDia").dialog({
            title:'新增客户信息',
            width:380,
            height:400,
            modal: true,
            href:"/user/toAddClientele.do",
            buttons:[{
                text:'提交',
                handler:function(){
                    $.ajax({
                        url:'/user/addClientele.do',
                        type:'post',
                        data:$("#addClienteleForm").serialize(),
                        dataType:'json',
                        success:function(data){
                            if(data.success){
                                $("#addClienteleDia").dialog("close");
                                $("#showClientele").datagrid('reload');
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
    /**
     * 修改客户信息
     */
    $("#updClientele").click(function(){
       var clientele= $("#showClientele").datagrid('getSelections');
       if(clientele.length==1){
           $("#updClienteleDia").dialog({
               title:'修改客户信息',
               width:380,
               height:400,
               modal: true,
               href:"/user/toUpdClientele.do",
               buttons:[{
                   text:'提交',
                   handler:function(){
                       $.ajax({
                           url:'/user/updClientele.do',
                           type:'post',
                           data:$("#updClienteleForm").serialize(),
                           dataType:'json',
                           success:function(data){
                               if(data.success){
                                   $("#updClienteleDia").dialog("close");
                                   $("#showClientele").datagrid('reload');
                               }else{
                                   alert("GG");
                               }
                           }
                       })
                   }
               }
               ]
           })
       }else if(clientele.length==""){
           $.messager.alert('警告',"请选择要修改的信息");
           return false;
       }else{
           $.messager.alert('警告',"每次修改只能修改一条数据");
           return false;
       }
    })

    $("#delClientele").click(function(){
        var ids="";
        var clientele= $("#showClientele").datagrid('getSelections');
        for(var i=0;i<clientele.length;i++){
            ids+=","+clientele[i].id;
        }
        ids=ids.substr(1);
        if($("#showClientele").datagrid('getSelections')==""){
            alert("请选择要删除的信息");
            return false;
        }
        $.ajax({
            url:"/user/delClientele.do",
            type:"post",
            data:{"ids":ids},
            dataType:"json",
            success:function (data) {
                if(data.success){
                    $("#showClientele").datagrid('reload');
                }else{
                    alert("GG");
                }
            }
        })
    })

</script>
</body>
</html>
