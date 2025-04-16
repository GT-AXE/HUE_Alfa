import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class InputArea extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isTyping;
  final ValueChanged<String> onChanged;
  final VoidCallback onSend;

  const InputArea({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.isTyping,
    required this.onChanged,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                fillColor: Colors.grey.shade200,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: isTyping
                    ? IconButton(
                        icon: const Icon(Icons.send, color: AppColors.primary),
                        onPressed: onSend,
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
