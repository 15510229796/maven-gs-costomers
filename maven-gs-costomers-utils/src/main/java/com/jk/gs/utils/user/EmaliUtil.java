package com.jk.gs.utils.user;

import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

/**
 * 邮件工具类
 */
public class EmaliUtil {

    private static JavaMailSenderImpl mailSender = createMailSender();
    /**
     * 邮件发送器
     *
     * @return 配置好的工具
     */
    private static JavaMailSenderImpl createMailSender() {
        JavaMailSenderImpl sender = new JavaMailSenderImpl();
        sender.setHost(Email.HOST);
        sender.setPort(Email.PORT);
        sender.setUsername(Email.USERNAME);
        sender.setPassword(Email.PASSWORD);
        sender.setDefaultEncoding("Utf-8");
        Properties p = new Properties();
        p.setProperty("mail.smtp.timeout", "25000");
        p.setProperty("mail.smtp.auth", "true");
        sender.setJavaMailProperties(p);
        return sender;
    }
    /**
     * 发送邮件
     *
     * @param to 接受人
     * @param subject 主题
     * @param html 发送内容
     * @throws MessagingException 异常
     * @throws UnsupportedEncodingException 异常
     */
    public static void sendHtmlMail(String to, String subject, String html, List<File> files) throws MessagingException,UnsupportedEncodingException {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        // 设置utf-8或GBK编码，否则邮件会有乱码
        MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
        try {
            messageHelper.setFrom(Email.EMAILFORM, Email.USERNAME);
            messageHelper.setTo(to);
            messageHelper.setSubject(subject);
            messageHelper.setText(html,true);
            for (File file : files) {
                messageHelper.addAttachment(file.getName(),file);
            }

            mailSender.send(mimeMessage);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

    }

    public static void main(String[] args) {
        try {
            ArrayList<File> files = new ArrayList<File>();
            for (int i = 0; i < 2; i++) {
                files.add(new File("G:\\photo\\1.jpg"));
            }
            EmaliUtil.sendHtmlMail("axz_dome001@126.com","测试ing","<h1>呜呜呜</h1>",files);
        } catch (MessagingException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }

}
