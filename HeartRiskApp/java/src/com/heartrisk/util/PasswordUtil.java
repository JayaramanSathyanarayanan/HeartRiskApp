package com.heartrisk.util;

import java.security.MessageDigest;

public class PasswordUtil {

    public static String hash(String paramString) {
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
            byte[] arrayOfByte = messageDigest.digest(paramString.getBytes("UTF-8"));

            StringBuilder stringBuilder = new StringBuilder();

            for (byte b : arrayOfByte) {
                stringBuilder.append(String.format("%02x", new Object[]{Byte.valueOf(b)}));
            }

            return stringBuilder.toString();

        } catch (Exception exception) {
            throw new RuntimeException("Error hashing password", exception);
        }
    }

    public static boolean verify(String paramString1, String paramString2) {
        return hash(paramString1).equals(paramString2);
    }
}