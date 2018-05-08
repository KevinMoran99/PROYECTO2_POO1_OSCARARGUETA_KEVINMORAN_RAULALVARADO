/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sv.udb.utilities;
import com.sv.udb.models.Call;
import com.sv.udb.models.User;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
/**
 *
 * @author kevin
 */
public class Mailer {
    
    public static void sendMail(Call call, User user) {
      // Recipient's email ID needs to be mentioned.
      String to = user.getEmail();

      // Sender's email ID needs to be mentioned
      String from = "expoxvi@gmail.com";
      
      // Get system properties
      Properties properties = System.getProperties();

      // Setup mail server
      properties.setProperty("mail.smtp.host", "smtp.mailtrap.io");
      properties.setProperty("mail.smtp.user", "b0558e807c64c2");
      properties.setProperty("mail.smtp.password", "748ca1e246dcf8");
      properties.setProperty("mail.smtp.auth", "true");

      // Get the default Session object.
      Session session = Session.getDefaultInstance(properties,
              new javax.mail.Authenticator(){
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(
                        "b0558e807c64c2", "748ca1e246dcf8");// Specify the Username and the PassWord
                    }
              });

      try {
         // Create a default MimeMessage object.
         MimeMessage message = new MimeMessage(session);

         // Set From: header field of the header.
         message.setFrom(new InternetAddress(from));

         // Set To: header field of the header.
         message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

         // Set Subject: header field
         message.setSubject("Nueva denuncia anónima");

         String content = "<style>\n" +
"                                body {\n" +
"                                    background: linear-gradient(mediumspringgreen, skyblue);\n" +
"                                    font-family: sans-serif;\n" +
"                                }\n" +
"                                h3 {\n" +
"                                    color: white;\n" +
"                                    background-color: steelblue;\n" +
"                                    padding: 2px;\n" +
"                                    border-radius: 5px;\n" +
"                                }\n" +
"                                div {\n" +
"                                    background-color: white;\n" +
"                                    padding: 5px;\n" +
"                                    border-radius: 3px;\n" +
"                                }\n" +
"                                b {\n" +
"                                    color: steelblue;\n" +
"                                    text-align: center;\n" +
"                                }\n" +
"                              </style>\n" +
"                              <h3>MINED - Sistema de denuncias</h3>\n" +
"                              <div>\n" +
"                                   Se ha registrado una nueva denuncia anónima. Sus detalles son los siguientes:" +
"                                   <ul>" +  
"                                       <li><b>Escuela desde la que se reporta:</b> " + call.getSchool().getName() + "</li>" + 
"                                       <li><b>Tipo de denuncia:</b> " + call.getComplaint_type().getName() + "</li>" + 
"                                       <li><b>Descripción:</b> " + call.getDescription() + "</li>" + 
"                                   </ul>" +  
"                                   Por favor revisar con la mayor brevedad posible." + 
"                              </div>";
         
         // Send the actual HTML message, as big as you like
         message.setContent(content, "text/html");

         // Send message
         Transport.send(message);
         System.out.println("Sent message successfully....");
      } catch (MessagingException mex) {
         mex.printStackTrace();
      }
   }
    
}
