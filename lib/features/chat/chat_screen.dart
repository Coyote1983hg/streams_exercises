import 'package:flutter/material.dart';
import 'package:streams_exercises/features/chat/chat_repository.dart';
import 'package:streams_exercises/features/chat/chat_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.chatRepository,
  }) : super(key: key);

  final ChatRepository chatRepository;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  bool _isStreaming = false;

  @override
  void initState() {
    super.initState();
    widget.chatRepository.messages.listen((message) {
      setState(() {
        _messages.add(message);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              onPressed: _toggleMessageStream,
              child: Text(_isStreaming ? 'Stop Chat' : 'Start Chat'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isMe = message.user == "Devil"; 
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) _buildAvatar(message.user),
          Container(
            decoration: BoxDecoration(
              color: isMe ? Colors.blue[100] : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isMe) Text(message.user, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(message.message),
              ],
            ),
          ),
          if (isMe) _buildAvatar(message.user),
        ],
      ),
    );
  }

  Widget _buildAvatar(String user) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: CircleAvatar(
        child: Text(user[0]),
      ),
    );
  }

  void _toggleMessageStream() {
    setState(() {
      _isStreaming = !_isStreaming;
      if (_isStreaming) {
        widget.chatRepository.startSendingMessages();
      } else {
        widget.chatRepository.stopSendingMessages();
      }
    });
  }

  @override
  void dispose() {
    widget.chatRepository.dispose();
    super.dispose();
  }
}
