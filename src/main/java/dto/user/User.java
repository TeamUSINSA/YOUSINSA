package dto.user;

import java.sql.Date;

public class User {
    private String userId;
    private String password;
    private String checkpassword;
    private String name;
    private String phoneNum;
    private String email;
    private Date birth;
    private boolean deleted;
    private Date joinDate;
    private String withdrawalReason;
    private String withdrawalDetail;
    private boolean isSeller;
    private String fcmToken;
    private String address1;
    private String address1Detail;
    private String address2;
    private String address2Detail;
    private String address3;
    private String address3Detail;

    public User() {
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCheckpassword() {
        return checkpassword;
    }

    public void setCheckpassword(String checkpassword) {
        this.checkpassword = checkpassword;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getBirth() {
        return birth;
    }

    public void setBirth(Date birth) {
        this.birth = birth;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public Date getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(Date joinDate) {
        this.joinDate = joinDate;
    }

    public String getWithdrawalReason() {
        return withdrawalReason;
    }

    public void setWithdrawalReason(String withdrawalReason) {
        this.withdrawalReason = withdrawalReason;
    }

    public String getWithdrawalDetail() {
        return withdrawalDetail;
    }

    public void setWithdrawalDetail(String withdrawalDetail) {
        this.withdrawalDetail = withdrawalDetail;
    }

    public boolean isSeller() {
        return isSeller;
    }

    public void setSeller(boolean seller) {
        isSeller = seller;
    }

    public String getFcmToken() {
        return fcmToken;
    }

    public void setFcmToken(String fcmToken) {
        this.fcmToken = fcmToken;
    }

    public String getAddress1() {
        return address1;
    }

    public void setAddress1(String address1) {
        this.address1 = address1;
    }

    public String getAddress1Detail() {
        return address1Detail;
    }

    public void setAddress1Detail(String address1Detail) {
        this.address1Detail = address1Detail;
    }

    public String getAddress2() {
        return address2;
    }

    public void setAddress2(String address2) {
        this.address2 = address2;
    }

    public String getAddress2Detail() {
        return address2Detail;
    }

    public void setAddress2Detail(String address2Detail) {
        this.address2Detail = address2Detail;
    }

    public String getAddress3() {
        return address3;
    }

    public void setAddress3(String address3) {
        this.address3 = address3;
    }

    public String getAddress3Detail() {
        return address3Detail;
    }

    public void setAddress3Detail(String address3Detail) {
        this.address3Detail = address3Detail;
    }
}
