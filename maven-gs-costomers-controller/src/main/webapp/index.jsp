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
    <link rel="stylesheet" type="text/css" href="/js/jquery-easyui-1.4.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/js/jquery-easyui-1.4.1/themes/icon.css">
    <script type="text/javascript" src="/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/js/jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" href="/js/zTree_v3/css/zTreeStyle/zTreeStyle.css" />
    <script src="/js/zTree_v3/js/jquery.ztree.all.js"></script>
    <script src="/js/echarts/echarts.js"></script>
</head>
<body>
<div id="cc" class="easyui-layout" data-options="fit:true">
    <div data-options="region:'north',title:'金科地产'" style="height:110px;">
        <center><font ><h1>欢迎来到金科地产后台管理系统</h1></font></center>
        <a id="btns" href="javascript:closed()">注销</a>
        <a id="btn" href="javascript:selLog()">登录日志</a>
    </div>
    <div data-options="region:'west',title:'菜单'" style="width:230px;">
        <ul id="mytree" class="ztree"></ul>
    </div>

    <div data-options="region:'center',title:'列表信息'" style="background:#eee;">
        <div id="tabs" class="easyui-tabs" data-options="fit:true">
            <div title="欢迎">
                <div id="cc1" class="easyui-layout" data-options="fit:true">
                    <div data-options="region:'east',iconCls:'icon-reload'" style="width:20%;">
                        <table id="log"></table>
                    </div>
                    <div data-options="region:'west'" style="width:80%;">
                        <div id="cc3" class="easyui-layout"  data-options="fit:true">
                            <div data-options="region:'north'" style="height:50%">
                                <div id="cc4" class="easyui-layout" data-options="fit:true">
                                    <div data-options="region:'east'" style="width:50%;padding-top: 105px">
                                        <center>
                                            <h1>维护中...</h1>
                                        </center>
                                    </div>
                                    <div data-options="region:'west'" style="width:50%;">
                                        <div id="weatherDiv" style="width: 400px;height: 230px"></div>
                                    </div>
                                </div>
                            </div>
                            <div data-options="region:'south'" style="height:50%;">
                                <div id="cc5" class="easyui-layout" data-options="fit:true">
                                    <div data-options="region:'east'" style="width:50%;">
                                        <div id="checkedNotice"></div>
                                        <table id="rentals"></table>
                                    </div>
                                    <div data-options="region:'west'" style="width:50%;padding-top: 105px">
                                        <center>
                                            <h1>维护中...</h1>
                                        </center>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </div>
            </div>
        </div>
</div>


<style type="text/css">
    .ztree * {font-size: 10pt;font-family:"Microsoft Yahei",Verdana,Simsun,"Segoe UI Web Light","Segoe UI Light","Segoe UI Web Regular","Segoe UI","Segoe UI Symbol","Helvetica Neue",Arial}
    .ztree li ul{ margin:0; padding:0}
    .ztree li {line-height:30px;}
    .ztree li a {width:200px;height:30px;padding-top: 0px;}
    .ztree li a:hover {text-decoration:none; background-color: #E7E7E7;}
    .ztree li a span.button.switch {visibility:hidden}
    .ztree.showIcon li a span.button.switch {visibility:visible}
    .ztree li a.curSelectedNode {background-color:#D4D4D4;border:0;height:30px;}
    .ztree li span {line-height:30px;}
    .ztree li span.button {margin-top: -7px;}
    .ztree li span.button.switch {width: 16px;height: 16px;}

    .ztree li a.level0 span {font-size: 150%;font-weight: bold;}
    .ztree li span.button {background-image:url("./left_menuForOutLook.png"); *background-image:url("./left_menuForOutLook.gif")}
    .ztree li span.button.switch.level0 {width: 20px; height:20px}
    .ztree li span.button.switch.level1 {width: 20px; height:20px}
    .ztree li span.button.noline_open {background-position: 0 0;}
    .ztree li span.button.noline_close {background-position: -18px 0;}
    .ztree li span.button.noline_open.level0 {background-position: 0 -18px;}
    .ztree li span.button.noline_close.level0 {background-position: -18px -18px;}
</style>
<script>
   function closed(){
       location.href="/user/toLogin.do";
   }

  function selLog(){
      $("#tabs").tabs('add', {
          title :"登陆日志",
          closable : true,
          //content : content,
          href:"/test/toLog.do",
      });
  }

    var curMenu = null, zTree_Menu = null;
    var setting = {
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeClick: beforeClick,
            onClick:tabss
        }
    };

    function tabss(event,treeId,treeNode){
        if ($("#tabs").tabs('exists', treeNode.name)) {
                $("#tabs").tabs('select', treeNode.name);
          } else {
                 var content = "<iframe frameborder='0' scrolling='auto' style='width:100%;height:100%' src="
                + treeNode.pathUrl + "></iframe>";
               //生成新的选项卡，
                $("#tabs").tabs('add', {
                     title : treeNode.name,
                       closable : true,
                       content : content,
                });
         }
    }

    function beforeClick(treeId, treeNode) {
        if (treeNode.level == 0 ) {
            var zTree = $.fn.zTree.getZTreeObj("mytree");
            zTree.expandNode(treeNode);
            return false;
        }
        return true;
    }

    $(document).ready(function(){
        $.ajax({
            url:"/test/getZtree.do",
            data:{},
            type:"post",
            dataType:"json",
            success:function(zNodes){
                var treeObj = $("#mytree");
                $.fn.zTree.init(treeObj, setting, zNodes);

    }
    })

    });
  $(function (){
      //气温
      $.ajax({
          url:"/test/getWeather.do",
          dataType:"json",
          success:function(data){
              var weekArray = data.weekList;
              var temperatureListArray = data.temperatureList;
              var LowListArray = data.LowList;
              var  option = {
                  title: {
                      text: '未来五天的天气'
                  },
                  tooltip: {
                      trigger: 'axis'
                  },
                  legend: {
                      data:['高温','低温']
                  },
                  xAxis: [
                      {
                          type: 'category',
                          data: weekArray
                      }
                  ],
                  yAxis: [
                      {
                          type: 'value',
                          name: '温度/℃',
                          min: -10,
                          max: 20,
                          interval: 50,
                          axisLabel: {
                              formatter: '{value} '
                          }
                      }
                  ],
                  series: [

                      {
                          name:'高温',
                          type:'line',
                          itemStyle: {
                              normal: {

                                  }
                          },
                          data:temperatureListArray
                      },
                      {
                          name:'低温',
                          type:'line',
                          itemStyle : {
                              normal : {
                              }
                          },
                          data:LowListArray
                      }
                  ]
              };
              // 基于准备好的dom，初始化echarts实例
              var weatherForecastChart = echarts.init(document.getElementById('weatherDiv'));
              // 使用刚指定的配置项和数据显示图表。
              weatherForecastChart.setOption(option);
          },
          error:function() {
              alert(2);
          }
      })
  })

    $("#log").datagrid({
        url:"/user/getLogs.do",
        fit:true,
        ctrlSelect:true,
        columns:[[
            {field:'username',title:'登陆人',width:'40%',align:'center'},
            {field:'newDate',width:'60%',title:'登录时间',align:'center'},
        ]],
        pagination:true,
        striped:true,
        pageNumber:1,
        pageSize:10,
        pageList:[10,15,25]
    });
   $("#rentals").datagrid({
        url:"/user/getNotice.do",
        fit:true,
        ctrlSelect:true,
        columns:[[
            {field:'title',title:'标题',width:'40%',align:'center'},
            {field:'xx',width:'60%',title:'详情',align:'center',formatter:function(value,index,rows){
                return '<a href="javascript:void()" onclick="chekcedAlls()">查看</a>';
            }},
        ]],
        pagination:true,
        striped:true,
        pageNumber:1,
        pageSize:10,
        pageList:[10,15,25]
    });

   function chekcedAlls() {
       $("#checkedNotice").dialog({
           title:'详细公告',
           width:350,
           height:400,
           modal: true,
           href:'/user/toSelNotice.do',
       })
   }

</SCRIPT>
</body>
</html>
