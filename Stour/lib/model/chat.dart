class Chat {
  String id;
  final String content;
  final String time;
  final bool isMe;

  Chat({
    required this.id,
    required this.content,
    required this.time,
    required this.isMe,
  });
}

List<Chat> messageList = [
  Chat(
    id: '1',
    content: 'Hello, how can I help you?',
    time: '10:00 AM',
    isMe: false,
  )
];
