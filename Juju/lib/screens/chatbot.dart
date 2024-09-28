import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:juju/util/const.dart';
import 'package:juju/model/message.dart';
import 'package:juju/model/upstage.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

class ChatbotSupportScreen extends StatefulWidget {
  String context = '';
  ChatbotSupportScreen({this.context = '', super.key});

  @override
  State<ChatbotSupportScreen> createState() => _ChatbotSupportScreenState();
}

class _ChatbotSupportScreenState extends State<ChatbotSupportScreen> {
  List<Message> messageList = [];
  bool _isThinking = false;
  String chatbotContent = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    chatbotContent = widget.context == ''
        ? getChatbotContent()
        : getScheduleAdviceContent(widget.context);
    print(chatbotContent);
    _sendInitialBotMessage();
  }

  Future<void> _sendInitialBotMessage() async {
    setState(() {
      _isThinking = true;
    });

    try {
      final responseJson =
          await getUpstageAIResponse(chatbotContent, 'Introduce yourself');
      final Map<String, dynamic> responseData = jsonDecode(responseJson);
      final String response = responseData['answer'];

      setState(() {
        messageList.add(Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: response,
          time: DateFormat('hh:mm a').format(DateTime.now()),
          isMe: false,
        ));
        _isThinking = false;
      });
      _scrollToBottom();
    } catch (e) {
      setState(() {
        messageList.add(Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: 'Sorry, I encountered an error while introducing myself.',
          time: DateFormat('hh:mm a').format(DateTime.now()),
          isMe: false,
        ));
        _isThinking = false;
      });
      _scrollToBottom();
    }
  }

  Future<void> _sendMessage(String message) async {
    String msg = '';
    if (message.trim().isNotEmpty) {
      setState(() {
        messageList.add(Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          content: message,
          time: DateFormat('hh:mm a').format(DateTime.now()),
          isMe: true,
        ));
        msg = message;
      });
      _scrollToBottom();

      setState(() {
        _isThinking = true;
      });

      try {
        final responseJson = await getUpstageAIResponse(chatbotContent, msg);
        final Map<String, dynamic> responseData = jsonDecode(responseJson);
        final String response = responseData['answer'];
        setState(() {
          messageList.add(Message(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            content: response,
            time: DateFormat('hh:mm a').format(DateTime.now()),
            isMe: false,
          ));
          _isThinking = false;
        });
        _scrollToBottom();
      } catch (e) {
        setState(() {
          messageList.add(Message(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            content:
                'Sorry, I encountered an error while processing your message.',
            time: DateFormat('hh:mm a').format(DateTime.now()),
            isMe: false,
          ));
          _isThinking = false;
        });
        _scrollToBottom();
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      appBar: AppBar(
        backgroundColor: Constants.background,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Chatbot Support',
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0,
                ),
              ),
            ],
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
          child: IconButton(
            icon: Icon(
              CupertinoIcons.arrow_left,
              color: Constants.backArrow,
              size: 26,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messageList.length + (_isThinking ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < messageList.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: messageList[index].isMe
                          ? BubbleSpecialThree(
                              text: messageList[index].content,
                              color: const Color.fromARGB(255, 157, 220, 223),
                              tail: index == messageList.length - 1 ||
                                      (index < messageList.length - 1 &&
                                          messageList[index + 1].isMe !=
                                              messageList[index].isMe)
                                  ? true
                                  : false,
                              textStyle: GoogleFonts.rubik(
                                color: Constants.darkText,
                                fontSize: 16,
                              ),
                            )
                          : BubbleSpecialThree(
                              text: messageList[index].content,
                              color: Constants.paletteBot,
                              tail: index == messageList.length - 1 ||
                                      (index < messageList.length - 1 &&
                                          messageList[index + 1].isMe !=
                                              messageList[index].isMe)
                                  ? true
                                  : false,
                              isSender: false,
                              textStyle: GoogleFonts.rubik(
                                color: Constants.darkText,
                                fontSize: 16,
                              ),
                            ),
                    );
                  } else {
                    // Display "Thinking..." indicator
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: BubbleSpecialThree(
                        text: 'Thinking...',
                        color: Constants.paletteBot,
                        tail: true,
                        isSender: false,
                        textStyle: GoogleFonts.rubik(
                          color: Constants.darkText,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }
                },
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
                      color: Constants.header,
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
