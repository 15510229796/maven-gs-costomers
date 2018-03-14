<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/27
  Time: 15:24
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
    <script type="text/javascript" charset="utf-8" src="/js/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/js/ueditor/ueditor.all.js"></script>

    <script type="text/javascript" charset="utf-8" src="/js/ueditor/lang/zh-cn/zh-cn.js"></script>

    <%--webuploader--%>
    <link rel="stylesheet" type="text/css" href="/js/webuploader-dist-v0.1.3/webuploader.css">
    <script type="text/javascript" src="/js/webuploader-dist-v0.1.3/webuploader.js"></script>
</head>
<body>
 <div id="EmailDia"></div>
  <form id="addform">
      <input type="hidden" id="photos" name="photos">
     <table>
         <tr>

         <td>
             收件人:<input class="easyui-textbox" id="recipients" name="recipients" style="width:180px">
             <a id="btn" href="javascript:showGetEmail()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">选择收件人</a>
         </td>
         </tr>
         <tr>
             <td>标&nbsp;&nbsp;&nbsp;题:<input class="easyui-textbox" name="theme"  id="theme" style="width:182px"></td>
         </tr>
         <tr>
             <td>内&nbsp;&nbsp;&nbsp;容:<script id="editor" type="text/plain" name="content"></script></td>
         </tr>
         <tr>
         <td>附件:<!--dom结构部分-->
             <%--<input id="imgs" type="hidden" name="headimg">--%>
             <div id="img" ></div>
             <div id="uploader-demo">
                 <!--用来存放item-->
                 <div id="fileList" class="uploader-list" ></div>
                 <div id="filePicker">选择图片</div>
             </div></td>
         </tr>

         <tr align="center">
             <td>
                 <a href="javascript:add()" id="save" class="easyui-linkbutton" iconCls="icon-save">发送</a>
             </td>
         </tr>

     </table>
  </form>
<script>

    //弹框
    function showGetEmail(){
        $("#EmailDia").dialog({
            title:'邮箱列表',
            width: 350,
            height: 300,
            closed: false,
            modal: true,
            href:"/user/toGetClientle.do",
            buttons:[{
                text:'提交',
                handler:function() {
                   var node =$("#showEmail").datagrid('getSelected');
                   alert(node.recipients);
                    $("#recipients").textbox('setValue',node.recipients);
                    $("#EmailDia").dialog('close');
                }
            }]
        })
    }
    //保存
    function add() {
        $.ajax({
            url:"../user/sendEmail.do",
            type:"post",
            data:$("#addform").serialize(),
            dataType:"text",
            success:function () {
               location.href="/user/toSendSuccess.do";
            },
            error:function () {
                alert("新增失败");
            }
        })
    }

    /*富文本*/
    var ue = UE.getEditor('editor');
     var url="";
    // 初始化Web Uploader
    var uploader = WebUploader.create({
        // 选完文件后，是否自动上传。
        auto: true,

        // swf文件路径
        swf: '<%=request.getContextPath()%>/js/webuploader-0.1.5/jekyll/js/Uploader.swf',

        // 文件接收服务端。
        server: '/user/fileupload.do',

        // 选择文件的按钮。可选。
        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
        pick: '#filePicker',

        // 只允许选择图片文件。
        accept: {
            title: 'Images',
            extensions: 'gif,jpg,jpeg,bmp,png',
            mimeTypes: 'image/*'
        }
    });

    // 当有文件添加进来的时候
    uploader.on( 'fileQueued', function( file ) {
        var $li = $(
            '<div id="' + file.id + '" class="file-item thumbnail">' +
            '<img>' +
            '<div class="info">' + file.name + '</div>' +
            '</div>'
            ),
            $img = $li.find('img');


        // $list为容器jQuery实例
        $("#fileList").append( $li );



        // 创建缩略图
        // 如果为非图片文件，可以不用调用此方法。
        // thumbnailWidth x thumbnailHeight 为 100 x 100
        uploader.makeThumb( file, function( error, src ) {
            if ( error ) {
                $img.replaceWith('<span>不能预览</span>');
                return;
            }

            $img.attr( 'src', src );
        }/*, thumbnailWidth, thumbnailHeight */);
    });

    // 文件上传过程中创建进度条实时显示。
    uploader.on( 'uploadProgress', function( file, percentage ) {
        var $li = $( '#'+file.id ),
            $percent = $li.find('.progress span');

        // 避免重复创建
        if ( !$percent.length ) {
            $percent = $('<p class="progress"><span></span></p>')
                .appendTo( $li )
                .find('span');
        }

        $percent.css( 'width', percentage * 100 + '%' );
    });

    // 文件上传成功，给item添加成功class, 用样式标记上传成功。
    uploader.on( 'uploadSuccess', function( file , response) {
        var photos = response._raw; //上传图片的路径
        url+=","+photos;
        var str = '<input type="hidden"  value="'+photos+'">';
        $("#photos").val(url.substring(1));
        $("#img").html(str);
        //$("#imgs").val(photos);
        $( '#'+file.id ).addClass('upload-state-done');
    });

    // 文件上传失败，显示上传出错。
    uploader.on( 'uploadError', function( file ) {
        var $li = $( '#'+file.id ),
            $error = $li.find('div.error');

        // 避免重复创建
        if ( !$error.length ) {
            $error = $('<div class="error"></div>').appendTo( $li );
        }

        $error.text('上传失败');
    });

    // 完成上传完了，成功或者失败，先删除进度条。
    uploader.on( 'uploadComplete', function( file ) {
        //  alert(file.name);
        $( '#'+file.id ).find('.progress').remove();

    });

</script>

</body>
</html>
