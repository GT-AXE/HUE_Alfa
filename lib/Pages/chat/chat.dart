import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:hue/core/widgets/message_bubble.dart';
import 'package:hue/core/widgets/input_area.dart';
import 'package:hue/core/widgets/reply_preview.dart';
import 'message_model.dart';
import 'package:hue/core/utils/app_colors.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final uuid = const Uuid();

  String? _replyToMessage;
  bool _isTyping = false;

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    final newMessage = Message(
      id: uuid.v4(),
      text: _controller.text.trim(),
      sentByMe: true,
      time: _getCurrentTime(),
      replyTo: _replyToMessage,
    );

    setState(() {
      _messages.add(newMessage);
      _replyToMessage = null;
      _isTyping = false;
    });

    _controller.clear();
    _focusNode.requestFocus();

    Future.delayed(const Duration(milliseconds: 200), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _deleteMessage(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Message"),
        content: const Text("Are you sure you want to delete this message?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              setState(() => _messages.removeAt(index));
              Navigator.pop(context);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _replyTo(String message) {
    setState(() => _replyToMessage = message);
    _focusNode.requestFocus();
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (_, index) => MessageBubble(
                message: _messages[index],
                onLongPress: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => Wrap(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.reply),
                          title: const Text("Reply"),
                          onTap: () {
                            Navigator.pop(context);
                            _replyTo(_messages[index].text);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.delete, color: Colors.red),
                          title: const Text("Delete", style: TextStyle(color: Colors.red)),
                          onTap: () {
                            Navigator.pop(context);
                            _deleteMessage(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          if (_replyToMessage != null)
            ReplyPreview(
              message: _replyToMessage!,
              onCancel: () => setState(() => _replyToMessage = null),
            ),
          InputArea(
            controller: _controller,
            focusNode: _focusNode,
            isTyping: _isTyping,
            onChanged: (text) => setState(() => _isTyping = text.isNotEmpty),
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}
