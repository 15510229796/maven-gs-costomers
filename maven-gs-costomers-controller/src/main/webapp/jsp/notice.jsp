<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/18
  Time: 22:22
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
    <div id="stubtn1s">
        <a id="addNotice" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">发布</a>
    </div>
 <div id="addNoticeDialog"></div>
 <div id="showNotice"></div>
<script>
    $("#showNotice").datagrid({
        url:"/user/getNotice.do",
        fit:true,
        columns:[[
            {field:'s',title:'全选',checkbox:true},
            {field:'id',title:'编号',width:'10%',align:'center'},
            {field:'title',title:'标题',width:'20%',align:'center'},
            {field:'content',width:'50%',title:'内容',align:'center'},
            {field:'time',width:'16%',title:'创建时间',align:'center'},
        ]],
        pagination:true,
        toolbar:"#stubtn1s",
        striped:true,
        pageNumber:1,
        pageSize:10,
        pageList:[10,15,25]

    });
    //新增
    $("#addNotice").click(function () {
        $("#addNoticeDialog").dialog({
            title:'发布公告',
            width:350,
            height:400,
            modal: true,
            href:'/user/toAddNotice.do',
            buttons:[{
                text:'提交',
                handler:function(){
                    $.ajax({
                        url:'/user/addNotice.do',
                        type:'post',
                        data:$("#addNoticeForm").serialize(),
                        dataType:'json',
                        success:function(data){
                            if(data.success){
                                $("#addNoticeDialog").dialog("close");
                                $("#showNotice").datagrid('reload');
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
    })
</script>
</body>
</html>
