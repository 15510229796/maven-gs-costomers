package com.jk.gs.model.user;

import java.io.Serializable;

public class Clientele implements Serializable {
    private static final long serialVersionUID = 2883490049665298984L;

    private Integer id;

    private String  clienteleName;

    private Integer  clienteleSex;

    private String  clienteleAge;

    private String  clienteleID;

    private String  clientelePhone;

    private String  clienteleNumber;

    private String  clientelePassword;

    private String  clienteleAdress;

    private String  emergencyContact;
    private String  emergencyContactPhone;
    private String  theme;
    private String  recipients;
    private String  content;
    private String  photos;

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public String getRecipients() {
        return recipients;
    }

    public void setRecipients(String recipients) {
        this.recipients = recipients;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getPhotos() {
        return photos;
    }

    public void setPhotos(String photos) {
        this.photos = photos;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getClienteleName() {
        return clienteleName;
    }

    public void setClienteleName(String clienteleName) {
        this.clienteleName = clienteleName;
    }

    public Integer getClienteleSex() {
        return clienteleSex;
    }

    public void setClienteleSex(Integer clienteleSex) {
        this.clienteleSex = clienteleSex;
    }

    public String getClienteleAge() {
        return clienteleAge;
    }

    public void setClienteleAge(String clienteleAge) {
        this.clienteleAge = clienteleAge;
    }

    public String getClienteleID() {
        return clienteleID;
    }

    public void setClienteleID(String clienteleID) {
        this.clienteleID = clienteleID;
    }

    public String getClientelePhone() {
        return clientelePhone;
    }

    public void setClientelePhone(String clientelePhone) {
        this.clientelePhone = clientelePhone;
    }

    public String getClienteleNumber() {
        return clienteleNumber;
    }

    public void setClienteleNumber(String clienteleNumber) {
        this.clienteleNumber = clienteleNumber;
    }

    public String getClientelePassword() {
        return clientelePassword;
    }

    public void setClientelePassword(String clientelePassword) {
        this.clientelePassword = clientelePassword;
    }

    public String getClienteleAdress() {
        return clienteleAdress;
    }

    public void setClienteleAdress(String clienteleAdress) {
        this.clienteleAdress = clienteleAdress;
    }

    public String getEmergencyContact() {
        return emergencyContact;
    }

    public void setEmergencyContact(String emergencyContact) {
        this.emergencyContact = emergencyContact;
    }

    public String getEmergencyContactPhone() {
        return emergencyContactPhone;
    }

    public void setEmergencyContactPhone(String emergencyContactPhone) {
        this.emergencyContactPhone = emergencyContactPhone;
    }

    @Override
    public String toString() {
        return "Clientele{" +
                "id=" + id +
                ", clienteleName='" + clienteleName + '\'' +
                ", clienteleSex=" + clienteleSex +
                ", clienteleAge='" + clienteleAge + '\'' +
                ", clienteleID='" + clienteleID + '\'' +
                ", clientelePhone='" + clientelePhone + '\'' +
                ", clienteleNumber='" + clienteleNumber + '\'' +
                ", clientelePassword='" + clientelePassword + '\'' +
                ", clienteleAdress='" + clienteleAdress + '\'' +
                ", emergencyContact='" + emergencyContact + '\'' +
                ", emergencyContactPhone='" + emergencyContactPhone + '\'' +
                ", theme='" + theme + '\'' +
                ", recipients='" + recipients + '\'' +
                ", content='" + content + '\'' +
                ", photos='" + photos + '\'' +
                '}';
    }
}
