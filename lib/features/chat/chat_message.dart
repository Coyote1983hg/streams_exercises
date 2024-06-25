class ChatMessage {
  final String user;
  final String message;

  ChatMessage({required this.user, required this.message});
}

List<ChatMessage> mockMessages = [
  ChatMessage(user: "Devil", message: "Hallo, wie geht's?"),
  ChatMessage(user: "Angel", message: "Mir geht's gut, und dir?"),
  ChatMessage(user: "Devil", message: "Nicht so gut, danke!"),
  ChatMessage(user: "Angel", message: "Schön, das zu hören!"),
  ChatMessage(user: "Devil", message: "Ja, nicht wahr?"),
  ChatMessage(user: "Angel", message: "Ja, das ist es!"),
];
