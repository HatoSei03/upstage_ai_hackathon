class Message {
  String id;
  final String content;
  final String time;
  final bool isMe;

  Message({
    required this.id,
    required this.content,
    required this.time,
    required this.isMe,
  });
}

List<Message> messageList = [
  Message(
    id: '1',
    content: 'Hello, how can I help you?',
    time: '10:00 AM',
    isMe: false,
  )
];
