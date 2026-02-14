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


    public Reservation(int id, String guestName, String roomType, String checkIn, String checkOut, String contact) {
        this.id = id;
        this.guestName = guestName;
        this.roomType = roomType;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.contact = contact;
        this.status = "Confiremed";
    }

    // Getters
    public int getId() { return id; }
    public String getGuestName() { return guestName; }
    public String getRoomType() { return roomType; }
    public String getCheckIn() { return checkIn; }
    public String getCheckOut() { return checkOut; }
    public String getContact() { return contact; }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

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

        double rate = 0;
        switch (roomType) {
            case "Single": rate = 10000; break;
            case "Double": rate = 18000; break;
            case "Deluxe": rate = 30000; break;
            case "Suite": rate = 50000; break;
            default: rate = 15000; // Standard rate
        }


        double total = days * rate;
        double tax = total * 0.10;
        return total + tax;
    }
}