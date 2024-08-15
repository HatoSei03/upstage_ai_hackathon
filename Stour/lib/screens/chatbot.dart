import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stour/util/const.dart';
import 'package:stour/model/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stour/model/upstage.dart';

class ChatbotSupportScreen extends StatefulWidget {
  const ChatbotSupportScreen({super.key});

  @override
  State<ChatbotSupportScreen> createState() => _ChatbotSupportScreenState();
}

class _ChatbotSupportScreenState extends State<ChatbotSupportScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<Chat> messageList = [];
  bool _isThinking = false;
  final ScrollController _scrollController = ScrollController();

  Future<void> _sendMessage() async {
    String msg = '';
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messageList.add(Chat(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: _messageController.text,
          time: DateFormat('hh:mm a').format(DateTime.now()),
          isMe: true,
        ));

        FirebaseFirestore.instance.collection('chat').add({
          'content': _messageController.text,
          'time': DateTime.now(),
          'isMe': true,
        });
        msg = _messageController.text;
        _messageController.clear();
      });
      _scrollToBottom();

      setState(() {
        _isThinking = true;
      });

      final response = await getUpstageAIResponse(getChatbotContent(), msg);
      setState(() {
        messageList.add(Chat(
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
                controller: _scrollController,
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
            if (_isThinking)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Constants.paletteBot,
                      child: Icon(
                        Icons.account_circle,
                        size: 40,
                        color: Constants.paletteDark,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Assistant',
                          style: TextStyle(
                            fontSize: 12,
                            color: Constants.paletteDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          decoration: BoxDecoration(
                            color: Constants.paletteBot,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Row(
                              children: [
                                Text(
                                  'Thinking...',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Constants.paletteDark,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                CircularProgressIndicator(
                                  color: Constants.paletteDark,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
                    onPressed: _sendMessage,
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
