import 'dart:io';
import 'package:flutter/material.dart';
import '../../Pages/chat/message_model.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final VoidCallback? onLongPress;

  const MessageBubble({
    super.key,
    required this.message,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final isMe = message.sentByMe;
    final radius = const Radius.circular(12);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: onLongPress,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(12),
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          decoration: BoxDecoration(
            color: isMe ? Colors.blueAccent : Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: isMe ? radius : Radius.zero,
              topRight: isMe ? Radius.zero : radius,
              bottomLeft: radius,
              bottomRight: radius,
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (message.replyTo != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.blue[200] : Colors.grey[400],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    message.replyTo!,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ),
              if (message.imagePath != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(message.imagePath!),
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              if (message.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  message.time,
                  style: TextStyle(
                    fontSize: 12,
                    color: isMe ? Colors.white70 : Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
