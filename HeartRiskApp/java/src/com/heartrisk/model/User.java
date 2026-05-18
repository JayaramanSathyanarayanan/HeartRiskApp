package com.heartrisk.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class User implements Serializable {

    private static final long serialVersionUID = 1L;
    private int id;
    private String username;
    private String passwordHash;
    private String fullName;
    private String email;
    private Timestamp createdAt;

    public User() {}

    public User(int paramInt, String paramString1, String paramString2, String paramString3, Timestamp paramTimestamp) {
        this.id = paramInt;
        this.username = paramString1;
        this.fullName = paramString2;
        this.email = paramString3;
        this.createdAt = paramTimestamp;
    }

    public int getId() { return this.id; }
    public void setId(int paramInt) { this.id = paramInt; }

    public String getUsername() { return this.username; }
    public void setUsername(String paramString) { this.username = paramString; }

    public String getPasswordHash() { return this.passwordHash; }
    public void setPasswordHash(String paramString) { this.passwordHash = paramString; }

    public String getFullName() { return this.fullName; }
    public void setFullName(String paramString) { this.fullName = paramString; }

    public String getEmail() { return this.email; }
    public void setEmail(String paramString) { this.email = paramString; }

    public Timestamp getCreatedAt() { return this.createdAt; }
    public void setCreatedAt(Timestamp paramTimestamp) { this.createdAt = paramTimestamp; }

    public String toString() {
        return "User{id=" + this.id + ", username='" + this.username + "', fullName='" + this.fullName + "'}";
    }
}