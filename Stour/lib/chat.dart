// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:stour/model/chat.dart';
// // import 'package:stour/model/upstage.dart';
// import 'package:stour/util/const.dart';
// import 'package:grouped_list/grouped_list.dart';
// import 'package:chat_bubbles/chat_bubbles.dart';

// void main() {
//   // WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: Constants.appName,
//       home: const ChatbotSupportScreen(),
//     );
//   }
// }

// class ChatbotSupportScreen extends StatefulWidget {
//   const ChatbotSupportScreen({super.key});

//   @override
//   State<ChatbotSupportScreen> createState() => _ChatbotSupportScreenState();
// }

// class _ChatbotSupportScreenState extends State<ChatbotSupportScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   List<Chat> messageList = [];
//   final ScrollController _scrollController = ScrollController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Constants.lightBG,
//         appBar: AppBar(
//           backgroundColor: Constants.palette3,
//           title: Text('Chatbot Support',
//               style: TextStyle(
//                 color: Constants.paletteDark,
//               )),
//         ),
//         body: Column(children: [
//           Expanded(child: GroupedListView<Chat, DateTime>(
//             padding: const EdgeInsets.all(8)
//             elements: messageList,
//             groupBy: (element) => element.time,
//             itemBuilder: (context, Chat element) {
//               return ChatBubble(
//                 isMe: element.isMe,
//                 content: element.content,
//                 time: element.time,
//               );
//             },
//             order: GroupedListOrder.DESC,
//           )),
//           Container(
//               color: Colors.grey[200],
//               child: TextField(
//                 decoration: const InputDecoration(
//                   hintText: 'Type a message',
//                   contentPadding: EdgeInsets.all(16),
//                   border: InputBorder.none,
//                 ),
//               ))
//         ]));
//   }
// }
