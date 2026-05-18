package com.heartrisk.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Assessment implements Serializable {

    private static final long serialVersionUID = 1L;
    private int id;
    private int userId;
    private int age;
    private int gender;
    private double heightCm;
    private double weightKg;
    private double bmi;
    private int systolicBp;
    private int diastolicBp;
    private int cholesterol;
    private int glucose;
    private int smoking;
    private int alcohol;
    private int active;
    private double riskScore;
    private String riskLevel;
    private Timestamp assessedAt;

    public int getId() { return this.id; }
    public void setId(int paramInt) { this.id = paramInt; }

    public int getUserId() { return this.userId; }
    public void setUserId(int paramInt) { this.userId = paramInt; }

    public int getAge() { return this.age; }
    public void setAge(int paramInt) { this.age = paramInt; }

    public int getGender() { return this.gender; }
    public void setGender(int paramInt) { this.gender = paramInt; }

    public String getGenderLabel() {
        return (this.gender == 1) ? "Male" : "Female";
    }

    public double getHeightCm() { return this.heightCm; }
    public void setHeightCm(double paramDouble) { this.heightCm = paramDouble; }

    public double getWeightKg() { return this.weightKg; }
    public void setWeightKg(double paramDouble) { this.weightKg = paramDouble; }

    public double getBmi() { return this.bmi; }
    public void setBmi(double paramDouble) { this.bmi = paramDouble; }

    public String getBmiCategory() {
        if (this.bmi < 18.5D) return "Underweight";
        if (this.bmi < 25.0D) return "Normal";
        if (this.bmi < 30.0D) return "Overweight";
        return "Obese";
    }

    public int getSystolicBp() { return this.systolicBp; }
    public void setSystolicBp(int paramInt) { this.systolicBp = paramInt; }

    public int getDiastolicBp() { return this.diastolicBp; }
    public void setDiastolicBp(int paramInt) { this.diastolicBp = paramInt; }

    public int getCholesterol() { return this.cholesterol; }
    public void setCholesterol(int paramInt) { this.cholesterol = paramInt; }

    public String getCholesterolLabel() {
        return (this.cholesterol == 1) ? "Normal" : ((this.cholesterol == 2) ? "Low" : "High");
    }

    public int getGlucose() { return this.glucose; }
    public void setGlucose(int paramInt) { this.glucose = paramInt; }

    public String getGlucoseLabel() {
        return (this.glucose == 1) ? "Normal" : ((this.glucose == 2) ? "Low" : "High");
    }

    public int getSmoking() { return this.smoking; }
    public void setSmoking(int paramInt) { this.smoking = paramInt; }

    public String getSmokingLabel() {
        return (this.smoking == 1) ? "Smoker" : "Non-Smoker";
    }

    public int getAlcohol() { return this.alcohol; }
    public void setAlcohol(int paramInt) { this.alcohol = paramInt; }

    public String getAlcoholLabel() {
        return (this.alcohol == 1) ? "Yes" : "No";
    }

    public int getActive() { return this.active; }
    public void setActive(int paramInt) { this.active = paramInt; }

    public String getActiveLabel() {
        return (this.active == 1) ? "Active" : "Sedentary";
    }

    public double getRiskScore() { return this.riskScore; }
    public void setRiskScore(double paramDouble) { this.riskScore = paramDouble; }

    public int getRiskPercent() {
        return (int) Math.round(this.riskScore * 100.0D);
    }

    public String getRiskLevel() { return this.riskLevel; }
    public void setRiskLevel(String paramString) { this.riskLevel = paramString; }

    public Timestamp getAssessedAt() { return this.assessedAt; }
    public void setAssessedAt(Timestamp paramTimestamp) { this.assessedAt = paramTimestamp; }
}