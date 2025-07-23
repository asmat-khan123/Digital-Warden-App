import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class ChatScreen2 extends StatefulWidget {
  final String chatId;  // Add a chatId variable

  // Constructor to accept chatId
  const ChatScreen2({Key? key, required this.chatId}) : super(key: key);

  static Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    print('Handling background message: ${message.notification?.title}');
  }

  @override
  State<ChatScreen2> createState() => _ChatScreen2State();
}

class _ChatScreen2State extends State<ChatScreen2> {
  late DatabaseReference _messagesRef;
  late FirebaseMessaging _firebaseMessaging;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging = FirebaseMessaging.instance;

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _configureLocalNotifications();

    _messagesRef = FirebaseDatabase.instance.ref('Messages/${widget.chatId}');

    // Request for notification permission (on iOS)
    _firebaseMessaging.requestPermission();

    // Get the FCM token to send notifications
    _firebaseMessaging.getToken().then((token) {
      print("FCM Token: $token");
      // You can save the token to Firebase or use it for targeted notifications
    });

    // Handle foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message: ${message.notification?.title}');
      _showNotification(message.notification?.title, message.notification?.body);
    });

    // Handle background notifications
    FirebaseMessaging.onBackgroundMessage(ChatScreen2._backgroundMessageHandler);
  }

  // Configure local notifications
  void _configureLocalNotifications() {
    final initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Show a local notification
  Future<void> _showNotification(String? title, String? body) async {
    const androidDetails = AndroidNotificationDetails(
      'chat_channel', 'Chat Notifications',
      channelDescription: 'Important Message for any type of Alert',
      importance: Importance.max,
      priority: Priority.high,
    );
    const platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformDetails,
      payload: 'new_message',
    );
  }

  // Format timestamp for message time display
  String _formatTimestamp(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
    final localDateTime = dateTime.toLocal();
    return DateFormat('hh:mm a').format(localDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Message', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          // Message List
          Expanded(
            child: StreamBuilder(
              stream: _messagesRef.onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  final messagesMap = Map<String, dynamic>.from(
                      snapshot.data!.snapshot.value as Map);
                  final messages = messagesMap.entries.toList();

                  // Sort the messages by timestamp, checking for null values
                  messages.sort((a, b) {
                    final timestampA = a.value['timestamp'];
                    final timestampB = b.value['timestamp'];

                    // If either timestamp is null, set them to 0 (default value)
                    final validTimestampA = timestampA ?? 0;
                    final validTimestampB = timestampB ?? 0;

                    return validTimestampA.compareTo(validTimestampB);
                  });

                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final messageId = messages[index].key;
                      final message = messages[index].value;
                      final formattedTime = _formatTimestamp(message['timestamp'] ?? 0);

                      // Null check for message text
                      final messageText = message['text'] ?? 'No message content';  // Provide a default message if null

                      // Assuming 'sender' is a field to distinguish between admin and user
                      final sender = message['sender'] ?? 'User';  // Default to 'User' if not found

                      // Choose light gray color for message background
                      Color messageColor = Colors.lightBlue;  // Light gray color

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start, // Align to the left side
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                color: messageColor, // Light gray for all messages
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,  // Align text to the left
                                children: [
                                  Text(
                                    messageText,  // Use messageText here
                                    style: TextStyle(
                                      color: Colors.white,  // Text color is black for readability
                                    ),
                                    overflow: TextOverflow.ellipsis, // Prevent long text from overflowing
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    formattedTime,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,  // Slightly lighter color for timestamp
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No messages yet.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
