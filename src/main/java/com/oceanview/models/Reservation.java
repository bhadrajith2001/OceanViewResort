package com.oceanview.models;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class Reservation {
    private int id;
    private String guestName;
    private String roomType;
    private String checkIn;
    private String checkOut;
    private String contact;
    private String status;


    private double dailyRate;

    public Reservation(int id, String guestName, String roomType, String checkIn, String checkOut, String contact, double dailyRate) {
        this.id = id;
        this.guestName = guestName;
        this.roomType = roomType;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.contact = contact;
        this.status = "Confirmed";
        this.dailyRate = dailyRate;
    }

    // Getters & Setters
    public int getId() { return id; }
    public String getGuestName() { return guestName; }
    public String getRoomType() { return roomType; }
    public String getCheckIn() { return checkIn; }
    public String getCheckOut() { return checkOut; }
    public String getContact() { return contact; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public double getDailyRate() { return dailyRate; }
    public void setDailyRate(double dailyRate) { this.dailyRate = dailyRate; }

    //Total Bill Calculation
    public double getTotalBill() {
        long days = 0;
        try {
            LocalDate start = LocalDate.parse(checkIn);
            LocalDate end = LocalDate.parse(checkOut);
            days = ChronoUnit.DAYS.between(start, end);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (days <= 0) days = 1;


        double total = days * dailyRate;
        double tax = total * 0.10; // 10% Tax
        return total + tax;
    }
}