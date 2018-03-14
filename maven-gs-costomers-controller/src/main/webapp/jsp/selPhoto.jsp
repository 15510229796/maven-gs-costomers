<%--
  Created by IntelliJ IDEA.
  User: ACER
  Date: 2018/2/20
  Time: 15:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="/js/jquery-3.2.1/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="/js/uploadify/privateUpload/jquery.uploadify.js"></script>
    <link rel="stylesheet" type="text/css" href="/js/uploadify/privateUpload/uploadify.css"/>
    <link rel="stylesheet" type="text/css" href="/js/jquery-easyui-1.4.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/js/jquery-easyui-1.4.1/themes/icon.css">
    <script type="text/javascript" src="/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/js/jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" href="/js/zTree_v3/css/zTreeStyle/zTreeStyle.css" />
    <script src="/js/zTree_v3/js/jquery.ztree.all.js"></script>

    <link href="/js/FileUploadQT/css/iconfont.css" rel="stylesheet" type="text/css"/>
    <link href="/js/FileUploadQT/css/fileUpload.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="/js/FileUploadQT/js/fileUpload.js"></script>


    <link rel="stylesheet" type="text/css" href="/js/polaroid-gallery/polaroid-gallery.css"/>
    <script type="text/javascript" src="/js/polaroid-gallery/polaroid-gallery.js"></script>
</head>
<body>
<div >
    <div id="gallery" class="fullscreen"></div>
    <div id="nav" class="navbar">
        <button id="preview">&lt; 前一张</button>
        <button id="next">下一张 &gt;</button>
    </div>
</div>
</body>
<script>

         window.onload = function () {
             new polaroidGallery('/user/getPhotos.do?hid=4');
         }
</script>
</html>
