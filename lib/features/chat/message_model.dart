class Message {
  final String id;
  final String text;
  final bool sentByMe;
  final String time;
  final String? replyTo;

  Message({
    required this.id,
    required this.text,
    required this.sentByMe,
    required this.time,
    this.replyTo,
  });
}
