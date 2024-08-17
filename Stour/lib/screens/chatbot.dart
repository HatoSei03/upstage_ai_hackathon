import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stour/util/const.dart';
import 'package:stour/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stour/model/upstage.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class ChatbotSupportScreen extends StatefulWidget {
  const ChatbotSupportScreen({super.key});

  @override
  State<ChatbotSupportScreen> createState() => _ChatbotSupportScreenState();
}

class _ChatbotSupportScreenState extends State<ChatbotSupportScreen> {
  List<Message> messageList = [];
  bool _isThinking = false;
  final ScrollController _scrollController = ScrollController();

  Future<void> _sendMessage(String message) async {
    String msg = '';
    if (message != '') {
      setState(() {
        messageList.add(Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: message,
          time: DateFormat('hh:mm a').format(DateTime.now()),
          isMe: true,
        ));

        FirebaseFirestore.instance.collection('chat').add({
          'content': message,
          'time': DateTime.now(),
          'isMe': true,
        });
        msg = message;
      });
      _scrollToBottom();

      setState(() {
        _isThinking = true;
      });

      final response = await getUpstageAIResponse(getChatbotContent(), msg);
      setState(() {
        messageList.add(Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: response,
          time: DateFormat('hh:mm a').format(DateTime.now()),
          isMe: false,
        ));

        FirebaseFirestore.instance.collection('chat').add({
          'content': response,
          'time': DateTime.now(),
          'isMe': false,
        });
        _isThinking = false;
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.lightBG,
      appBar: AppBar(
        backgroundColor: Constants.header,
        title: Text('Chatbot Support',
            style: TextStyle(
              color: Constants.textColor,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: messageList[index].isMe
                        ? BubbleSpecialThree(
                            text: messageList[index].content,
                            color: const Color.fromARGB(255, 157, 220, 223),
                            tail: index == messageList.length - 1 ||
                                    messageList[index + 1].isMe !=
                                        messageList[index].isMe
                                ? true
                                : false,
                            textStyle: TextStyle(
                              color: Constants.textColor,
                              fontSize: 16,
                            ),
                          )
                        : BubbleSpecialThree(
                            text: messageList[index].content,
                            color: Constants.paletteBot,
                            tail: index == messageList.length - 1 ||
                                    messageList[index + 1].isMe !=
                                        messageList[index].isMe
                                ? true
                                : false,
                            isSender: false,
                            textStyle: TextStyle(
                              color: Constants.textColor,
                              fontSize: 16,
                            ),
                          ),
                  );
                },
              ),
            ),
            if (_isThinking)
              Padding(
                padding: const EdgeInsets.all(16),
                child: BubbleSpecialThree(
                  text: 'Thinking...',
                  color: Constants.paletteBot,
                  tail: true,
                  isSender: false,
                  textStyle: TextStyle(
                    color: Constants.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
            MessageBar(
              onSend: _sendMessage,
              actions: [
                InkWell(
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 24,
                  ),
                  onTap: () {},
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: InkWell(
                    child: Icon(
                      Icons.camera_alt,
                      color: Constants.icon,
                      size: 24,
                    ),
                    onTap: () {},
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
