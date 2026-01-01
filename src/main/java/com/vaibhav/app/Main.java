package com.vaibhav.app;

public class Main {
    public static void main (String[] args) throws InterruptedException {
        System.out.println("Hello from maven + GitLab CI");

        // Keep the alive
        while(true) {
	    System.out.println("App is still running...");
            Thread.sleep(10000);
        }
    }
}
