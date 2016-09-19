package com.iqiyi.util;
import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import freemarker.template.Template;

public class TemplateEmail {
	private JavaMailSender sender;    
    private FreeMarkerConfigurer freeMarkerConfigurer=null;//FreeMarker的技术类    
	static Logger logger = LogManager.getLogger(TemplateEmail.class.getName());
        
    public void setFreeMarkerConfigurer(FreeMarkerConfigurer freeMarkerConfigurer) {    
        this.freeMarkerConfigurer = freeMarkerConfigurer;    
    }    
        
    public void setSender(JavaMailSender sender) {    
        this.sender = sender;    
    }    
      
    /** 
     * 生成html模板字符串 
     * @param root 存储动态数据的map 
     * @return 
     */  
    private String getMailText(Map<String,Object> root,String templateName){  
         String htmlText="";    
            try {    
                //通过指定模板名获取FreeMarker模板实例    
                Template tpl= freeMarkerConfigurer.getConfiguration().getTemplate(templateName);    
                htmlText=FreeMarkerTemplateUtils.processTemplateIntoString(tpl,root);    
            } catch (Exception e) {    
            	logger.error("失败发送模板邮件", e); 
            }    
            return htmlText;    
    }  
      
    /** 
     * 发送邮件 
     * @param root 存储动态数据的map 
     * @param fromEmail 发送地址 
     * @param toEmail 接收地址 
     * @param ccEmail 抄送地址 
     * @param subject 邮件主题 
     * @param templateName 邮件模板 
     * @return 
     */  
    public boolean sendTemplateMail(Map<String,Object> root,String personal,String fromEmail,String toEmail,String ccEmail,String subject,String templateName){    
        try {  
            MimeMessage msg=sender.createMimeMessage();    
            MimeMessageHelper helper=new MimeMessageHelper(msg,false,"utf-8");//由于是html邮件，不是mulitpart类型 
            try {
				helper.setFrom(fromEmail,personal);
			} catch (UnsupportedEncodingException e) {
				helper.setFrom(fromEmail);
			}    
            helper.setTo(toEmail.split(";"));    
            helper.setCc(ccEmail.split(";"));
            helper.setSubject(subject);    
            String htmlText=getMailText(root,templateName);//使用模板生成html邮件内容    
            helper.setText(htmlText, true);    
            sender.send(msg);  
            //System.out.println("成功发送模板邮件");    
            return true;  
        } catch (MailException e) {  
           // System.out.println("失败发送模板邮件");  
        	logger.error("失败发送模板邮件", e); 
            return false;  
        } catch (MessagingException e) {  
        //  System.out.println("失败发送模板邮件");   
        	logger.error("失败发送模板邮件", e); 
            return false;  
        }    
         
    }    
}
