import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stour/util/const.dart';
import 'package:stour/model/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatbotSupportScreen extends StatefulWidget {
  const ChatbotSupportScreen({super.key});

  @override
  State<ChatbotSupportScreen> createState() => _ChatbotSupportScreenState();
}

class _ChatbotSupportScreenState extends State<ChatbotSupportScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.lightBG,
      appBar: AppBar(
        backgroundColor: Constants.palette3,
        title: Text('Chatbot Support',
            style: TextStyle(
              color: Constants.paletteDark,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: messageList[index].isMe
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (!messageList[index].isMe)
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Constants.paletteBot,
                            child: Icon(
                              Icons.account_circle,
                              size: 40,
                              color: Constants.paletteDark,
                            ),
                          ),
                        if (!messageList[index].isMe) const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: messageList[index].isMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              messageList[index].isMe ? 'Me' : 'Assistant',
                              style: TextStyle(
                                fontSize: 12,
                                color: Constants.paletteDark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              decoration: BoxDecoration(
                                color: messageList[index].isMe
                                    ? const Color(0xFFBEDBBB)
                                    : Constants.paletteBot,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                  messageList[index].content,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Constants.paletteDark,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (messageList[index].isMe) const SizedBox(width: 8),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      // prefixIcon: Icon(
                      //   Icons.chat_bubble_outline,
                      //   color: Constants.paletteDark,
                      // ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 50,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_messageController.text.isNotEmpty) {
                        setState(() {
                          messageList.add(Chat(
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            content: _messageController.text,
                            time: DateFormat('hh:mm a').format(DateTime.now()),
                            isMe: true,
                          ));

                          FirebaseFirestore.instance.collection('chat').add({
                            'content': _messageController.text,
                            'time': DateTime.now(),
                            'isMe': true,
                          });
                          _messageController.clear();
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.palette3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(4),
                    ),
                    child: Icon(
                      Icons.send,
                      color: Constants.paletteDark,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
