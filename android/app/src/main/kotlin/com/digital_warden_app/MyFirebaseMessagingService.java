package com.digital_warden_app;  // Replace with your actual package name

public class MyFirebaseMessagingService extends FirebaseMessagingService {

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        // Handle incoming messages
        if (remoteMessage.getNotification() != null) {
            // Log or show notifications
            Log.d("FCM", "Message Notification Body: " + remoteMessage.getNotification().getBody());
        }
    }

    @Override
    public void onNewToken(String token) {
        // Handle token generation or update
        Log.d("FCM", "New Token: " + token);
    }
}
