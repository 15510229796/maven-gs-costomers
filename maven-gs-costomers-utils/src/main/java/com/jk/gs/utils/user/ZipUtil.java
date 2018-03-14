package com.jk.gs.utils.user;

import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * zip压缩工具类
 */
public class ZipUtil {

    private static Logger logger = Logger.getLogger(ZipUtil.class);

    /**
     *
     * @param zipName 压缩后的文件名称
     * @param fileList 需要压缩的文件列表（hashMap存放两个key一个name(文件名称),一个path（文件路径））
     * @param request
     * @param response
     */
    public static void zip(String zipName, List<HashMap> fileList, HttpServletRequest request, HttpServletResponse response){
        //压缩后的文件保存地址
        String zipPath = request.getRealPath("/")+ UUID.randomUUID().toString()+".zip";
        try {
            //创建一个zip包
            ZipOutputStream zipOutputStream = new ZipOutputStream(new FileOutputStream(new File(zipPath)));
            //文件字节缓冲流
            byte[] buf = new byte[1024];
            HashMap<String, Integer> historyFileName = new HashMap<String, Integer>();
            for (int i = 0; i < fileList.size(); i++) {
                HashMap hashMap = fileList.get(i);
                //获取到文件名称
                String fileName = (String)hashMap.get("name");
                String originalName = fileName;
                //判断zip包里是否有过这个文件名
                if(historyFileName.containsKey(fileName)){
                    Integer fileCount = historyFileName.get(fileName);
                    fileName = fileName.split("\\.")[0]+"("+ ++fileCount+")"+"."+fileName.split("\\.")[1];
                    historyFileName.put(originalName,fileCount);
                }else{
                    historyFileName.put(fileName,0);
                }
                //获取到文件的物理路劲地址
                String filePath = (String)hashMap.get("path");
                //获取到文件
                File file = new File(filePath);
                //获取文件的io流
                FileInputStream inputStream = new FileInputStream(file);
                zipOutputStream.putNextEntry(new ZipEntry(fileName));
                //读取单个文件流 写入到压缩流里边
                int len;
                while ((len = inputStream.read(buf)) > 0) {
                    zipOutputStream.write(buf, 0, len);
                }
                //关流
                inputStream.close();
                zipOutputStream.closeEntry();
            }
            zipOutputStream.close();
            FileUtil.downloadFile(request,response,zipPath,zipName+".zip");
            new File(zipPath).delete();
        } catch (FileNotFoundException e) {
            logger.error("文件未发现异常={}",e);
        } catch (IOException e) {
            e.printStackTrace();
            logger.error("io流异常={}",e);
        }
    }
}
