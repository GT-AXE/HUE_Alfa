class Message {
  final String id;
  final String text;
  final String time;
  final bool sentByMe;
  final String? replyTo;
  final String? imagePath; // دعم الصور

  Message({
    required this.id,
    required this.text,
    required this.time,
    required this.sentByMe,
    this.replyTo,
    this.imagePath,
  });

  // لتحويل الرسالة إلى Map (مثالي للتخزين في Hive أو JSON)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'time': time,
      'sentByMe': sentByMe,
      'replyTo': replyTo,
      'imagePath': imagePath,
    };
  }

  // لإنشاء الرسالة من Map
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      text: map['text'],
      time: map['time'],
      sentByMe: map['sentByMe'],
      replyTo: map['replyTo'],
      imagePath: map['imagePath'],
    );
  }
}
