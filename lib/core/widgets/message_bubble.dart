import 'package:flutter/material.dart';
import 'package:hue/Pages/chat/message_model.dart';
import '../utils/app_colors.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final VoidCallback onLongPress;

  const MessageBubble({
    super.key,
    required this.message,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Align(
        alignment: message.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 300),
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: message.sentByMe ? AppColors.bubbleSelf : AppColors.bubbleOther,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message.replyTo != null)
                Text(
                  '↪ ${message.replyTo}',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 13,
                    color: message.sentByMe ? Colors.white70 : Colors.black54,
                  ),
                ),
              Text(
                message.text,
                style: TextStyle(
                  fontSize: 16,
                  color: message.sentByMe ? AppColors.textSelf : AppColors.textOther,
                ),
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  message.time,
                  style: TextStyle(
                    fontSize: 11,
                    color: message.sentByMe ? Colors.white60 : Colors.black45,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
