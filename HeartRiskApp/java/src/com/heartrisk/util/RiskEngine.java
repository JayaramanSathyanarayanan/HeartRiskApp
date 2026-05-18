package com.heartrisk.util;

public class RiskEngine {

    public static double predict(int paramInt1, int paramInt2, double paramDouble1, double paramDouble2,
                                  int paramInt3, int paramInt4, int paramInt5, int paramInt6,
                                  int paramInt7, int paramInt8, int paramInt9) {

        double d1 = 0.0D;

        if (paramInt1 >= 65) {
            d1 += 3.5D;
        } else if (paramInt1 >= 55) {
            d1 += 2.5D;
        } else if (paramInt1 >= 45) {
            d1 += 1.5D;
        } else if (paramInt1 >= 35) {
            d1 += 0.5D;
        }

        if (paramInt2 == 1) d1 += 0.8D;

        double d2 = paramDouble2 / paramDouble1 / 100.0D * paramDouble1 / 100.0D;

        if (d2 >= 35.0D) {
            d1 += 3.0D;
        } else if (d2 >= 30.0D) {
            d1 += 2.0D;
        } else if (d2 >= 25.0D) {
            d1++;
        } else if (d2 < 18.5D) {
            d1 += 0.5D;
        }

        if (paramInt3 >= 180 || paramInt4 >= 110) {
            d1 += 4.5D;
        } else if (paramInt3 >= 160 || paramInt4 >= 100) {
            d1 += 3.5D;
        } else if (paramInt3 >= 140 || paramInt4 >= 90) {
            d1 += 2.5D;
        } else if (paramInt3 >= 130 || paramInt4 >= 85) {
            d1 += 1.5D;
        } else if (paramInt3 >= 120) {
            d1 += 0.5D;
        }

        if (paramInt5 == 3) {
            d1 += 3.0D;
        } else if (paramInt5 == 2) {
            d1 += 0.5D;
        }

        if (paramInt6 == 3) {
            d1 += 2.5D;
        } else if (paramInt6 == 2) {
            d1 += 0.5D;
        }

        if (paramInt7 == 1) d1 += 2.5D;
        if (paramInt8 == 1) d1++;
        if (paramInt9 == 0) d1 += 1.5D;

        double d4 = d1 - 8.0D;
        double d5 = 1.0D / (1.0D + Math.exp(-d4 * 0.4D));

        return Math.min(Math.max(d5, 0.0D), 1.0D);
    }

    public static String riskLevel(double paramDouble) {
        if (paramDouble < 0.25D) return "Low";
        if (paramDouble < 0.5D) return "Moderate";
        if (paramDouble < 0.75D) return "High";
        return "Very High";
    }
}