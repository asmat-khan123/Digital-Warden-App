import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;

  ChatScreen({required this.chatId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  late DatabaseReference _messagesRef;

  @override
  void initState() {
    super.initState();
    _messagesRef = FirebaseDatabase.instance.ref('Messages/${widget.chatId}');
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      _messagesRef.push().set({
        'sender': 'ADMIN',
        'text': _messageController.text,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });

      _messageController.clear();
    }
  }

  void _deleteMessage(String messageId) {
    _messagesRef.child(messageId).remove();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Message deleted')),
    );
  }

  void _editMessage(String messageId, String currentText) {
    final editController = TextEditingController(text: currentText);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Message'),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(hintText: 'Edit your message'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final updatedText = editController.text;
                if (updatedText.isNotEmpty) {
                  _messagesRef.child(messageId).update({'text': updatedText});
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Message updated')),
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showMessageOptions(String messageId, String currentText) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit, color: Colors.blue),
              title: Text('Edit'),
              onTap: () {
                Navigator.of(context).pop();
                _editMessage(messageId, currentText);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text('Delete'),
              onTap: () {
                Navigator.of(context).pop();
                _deleteMessage(messageId);
              },
            ),
          ],
        );
      },
    );
  }

  String _formatTimestamp(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
    final localDateTime = dateTime.toLocal();
    return DateFormat('hh:mm a').format(localDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Message',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.lightBlue,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _messagesRef.onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  final messagesMap = Map<String, dynamic>.from(
                      snapshot.data!.snapshot.value as Map);
                  final messages = messagesMap.entries.toList();
                  messages.sort((a, b) =>
                      a.value['timestamp'].compareTo(b.value['timestamp']));

                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final messageId = messages[index].key;
                      final message = messages[index].value;
                      final formattedTime =
                      _formatTimestamp(message['timestamp']);

                      return GestureDetector(
                        onLongPress: () => _showMessageOptions(
                            messageId, message['text']),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: message['sender'] == 'ADMIN'
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              if (message['sender'] != 'ADMIN')
                                CircleAvatar(
                                  backgroundImage:
                                  AssetImage('assets/images/logo.png'),
                                ),
                              SizedBox(width: 8),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  color: message['sender'] == 'ADMIN'
                                      ? Colors.lightBlue
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                  message['sender'] == 'ADMIN'
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: 250,
                                      ),
                                      child: Text(
                                        message['text'],
                                        style: TextStyle(
                                          color: message['sender'] == 'ADMIN'
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        overflow: TextOverflow.visible,
                                        softWrap: true,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      formattedTime,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: message['sender'] == 'ADMIN'
                                            ? Colors.white70
                                            : Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No messages yet'));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[200],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.lightBlue),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
