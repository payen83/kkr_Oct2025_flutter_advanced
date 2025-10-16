import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_2025/app/constant/color.constant.dart';
import 'package:flutter_advanced_2025/app/widget/drawer.widget.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  final chatController = TextEditingController();

  final List<Map<String, String>> messages = [];
  late final GenerativeModel model;
  late final ChatSession chat;

  @override
  void initState() {
    super.initState();
    model = FirebaseAI.googleAI().generativeModel(model: 'gemini-2.5-flash');
    chat = model.startChat();
  }

  Future<void> sendMessage() async {
    final text = chatController.text;
    if(text.isEmpty) return;
    setState(() {
      messages.add({'sender': 'user', 'message': text});
      messages.add({'sender': 'AI', 'message': '..'});
    });
    chatController.clear();
    final response = await chat.sendMessage(Content.text(text));
    setState(() {
      messages.removeLast();
      messages.add({"sender": "AI", "message": response.text ?? ""});
    });
  }


  // final List<Map<String, String>> messages = [
  //   {"sender": "user", "message": "Hi there!"},
  //   {"sender": "AI", "message": "Hello! How can I help you today?"},
  //   {"sender": "user", "message": "Can you tell me a joke?"},
  //   { "sender": "AI", "message": "Sure! Why don't skeletons fight each other? They don't have the guts."},
  // ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: kShrineBrown900,
        backgroundColor: kShrinePink100,
        title: Text('AI Chatbot'),
      ),
      drawer: DrawerWidget(),
      body: Column(
        children: [
          //Message list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isUser = msg['sender'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Text(msg['message'] ?? "", style: TextStyle(color: Colors.white),),
                  ),
                );
              }
            )
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey))
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: chatController,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Type your message",
                      border: InputBorder.none
                    ),
                  )
                ),
                IconButton(onPressed: sendMessage, icon: Icon(Icons.send))
              ],
            ),
          )
        ],
      ),
    );
  }
}