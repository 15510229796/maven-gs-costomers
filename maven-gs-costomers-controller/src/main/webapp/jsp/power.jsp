<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/13
  Time: 16:53
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
<div id="cca" class="easyui-layout" data-options="fit:true">
    <div data-options="region:'west',title:'menu'" style="width:180px;">
        <div title="Title1" data-options="iconCls:'icon-save'" style="overflow:auto;padding:0px;">
            <div id="showTree"></div>
        </div>
    </div>
    <div data-options="region:'center'" style="padding:5px;background:#eee;">
        <div id="cca1" class="easyui-layout" data-options="fit:true">
            <div data-options="region:'north',title:'新增权限',split:true" style="height:150px;">
                <form id="addTreeForm" style="padding-top:10px;padding-left: 30px">
                    <input type="hidden" id="id1" name="tid">
                    <input type="hidden" id="id" name="id">
                    <table>
                        <tr>
                            <td>
                                绑定权限:<input class="easyui-textbox" id="text1" style="width:150px"><br>
                                节点名称:<input class="easyui-textbox" id="text" name="text" style="width:150px"><br>
                                路径名称:<input class="easyui-textbox" id="url" name="url" style="width:150px">
                            </td>
                            <td>
                                备注:<input class="easyui-textbox" id="remark" name="remark" style="width:150px;height: 50px">
                                <a id="btn" href="javascript:addMenu()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">保存</a>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div data-options="region:'center',title:'权限列表'" style="padding:5px;background:#eee;">
                <table id="menuList"></table>
            </div>
        </div>
    </div>
</div>
<div id="mm" class="easyui-menu" style="width:120px;">
    <div onclick="append()" data-options="iconCls:'icon-add'">追加</div>
    <div onclick="remove()" data-options="iconCls:'icon-remove'">移除</div>
    <div onclick="upd()" data-options="iconCls:'icon-edit'">编辑</div>
</div>
<div id="addTree"></div>
<div id="updDiv"></div>
</body>
<script>
    $("#showTree").tree({
        url:"/user/getTree.do",
        onClick: function(node){
            $("#text1").textbox("setValue",node.text);
            $("#id1").val(node.id);
                $("#menuList").datagrid({
                url:"/user/getPower.do?id="+node.id,
                fit:true,
                columns:[[
                    {field:'s',title:'全选',checkbox:true},
                    {field:'id',title:'编号',width:140,align:'center'},
                    {field:'text',title:'节点名称',width:140,align:'center'},
                    {field:'url',width:180,title:'跳转路径',align:'center'},
                    {field:'tid',width:140,title:'左树',align:'center'},
                    {field:'remark',title:'备注',width:210,align:'center'},
                    {field:'XX',title:'操作',width:140,align:'center',formatter:function(){
                        return '<a id="btn" href="javascript:delMenu()" class="easyui-linkbutton">删除</a>';
            }}
                ]],
                pagination:true,
                striped:true,
                onDblClickRow:function(index,row){
                    $("#text").textbox("setValue",row.text);
                    $("#id").val(row.id);
                    $("#url").textbox("setValue",row.url);
                    $("#remark").textbox("setValue",row.remark);
                }
            });
        },
        onContextMenu: function(e, node){
            e.preventDefault();
            // 查找节点
            $('#showTree').tree('select', node.target);
            // 显示快捷菜单
            $('#mm').menu('show', {
                left: e.pageX,
                top: e.pageY
            });
        }
    })

    //菜单详情新增
    function addMenu(){
        if($("#id").val()!=""){
            $.ajax({
                url:"/user/updMenu.do",
                type:"post",
                data:$("#addTreeForm").serialize(),
                dataType:"json",
                success:function (data) {
                    if(data.success){
                        $("#menuList").datagrid("reload");
                        $("#id").val("");
                        $("#text").textbox("setValue","");
                        $("#url").textbox("setValue","");
                        $("#remark").textbox("setValue","");
                    }else{
                        alert("GG");
                    }
                }
            })
        }else{
            if($("#id1").val()==""){
                alert("请选择要新增权限的节点");
                return ;
            }else {
                $.ajax({
                    url: "/user/addMenu.do",
                    type:"post",
                    data:$("#addTreeForm").serialize(),
                    dataType:"json",
                    success:function (data) {
                        if(data.success){
                            $("#menuList").datagrid("reload");
                            $("#text").textbox("setValue","");
                            $("#url").textbox("setValue","");
                            $("#remark").textbox("setValue","");
                        }else{
                            alert("GG");
                        }
                    }
                })
            }
        }
    }

    function delMenu(){
        var del= $("#menuList").datagrid('getSelected');
        if(del==null){
            alert("请选择选中要删除的信息");
            return ;
        }else{
            $.ajax({
                url:"/user/delMenu.do?id="+del.id,
                type:"post",
                dataType:"json",
                success:function(data){
                    if(data.success){
                        $("#menuList").datagrid("reload");
                    }else{
                        alert("GG");
                    }
                }
            })
        }
    }

    function  append() {
        var row = $("#showTree").tree('getSelected');
        $("#addTree").dialog({
            title:'新增子节点',
            width: 350,
            height: 200,
            closed: false,
            href:'/user/toAddTree.do?id='+row.id,
            buttons:[{
                text:'提交',
                handler:function(){
                    $.ajax({
                        url:'/user/addTree.do',
                        type:'post',
                        data:$("#treeForm").serialize(),
                        dataType:'json',
                        success:function(data){
                            if(data.success){
                                $("#addTree").dialog("close");
                                $("#showTree").tree('reload');
                            }else{
                                alert("GG");
                            }
                        }
                    })
                }
            }]
        })
    }

    function  upd() {
        var row = $("#showTree").tree('getSelected');
        $("#updDiv").dialog({
            title:'修改子节点',
            width: 350,
            height: 200,
            closed: false,
            href:'/user/toUpdTree.do?id='+row.id,
            buttons:[{
                text:'提交',
                handler:function(){
                    $.ajax({
                        url:'/user/updTree.do',
                        type:'post',
                        data:$("#treeForm1").serialize(),
                        dataType:'json',
                        success:function(data){
                            if(data.success){
                                $("#updDiv").dialog("close");
                                $("#showTree").tree('reload');
                            }else{
                                alert("GG");
                            }
                        }
                    })
                }
            }]
        })
    }
    //ss删除
    function remove(){
        var row = $("#showTree").tree('getSelected');
        $.ajax({
            url:"/user/delTree.do",
            type:"post",
            data:{"id":row.id},
            dataType:"json",
            success:function(data){
                if(data.success){
                    $("#showTree").tree('reload');
                }else{
                    alert("GG");
                }
            }
        });
    }

</script>
</html>
