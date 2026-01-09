import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  late final GenerativeModel _model;
  late final ChatSession _chatSession;

  final String _apiKey = "AIzaSyB05Mo6tGyyGIHCnCHh7YsH3KmKSqAtvyQ";

  final ChatUser _currentUser = ChatUser(
    id: "1",
    firstName: "Priyanshu",
    lastName: "Negi",
  );

  final ChatUser _geminiUser = ChatUser(
    id: "2",
    firstName: "Gemini",
    lastName: "AI",
  );

  final List<ChatMessage> _messages = <ChatMessage>[];

  @override
  void initState() {
    super.initState();

    _model = GenerativeModel(
      model: 'gemini-2.5-flash-lite',
      apiKey: _apiKey,
      systemInstruction: Content.system(
        "You are a helpful medical assistant for a health app. "
        "Answer the user's health questions clearly. "
        "IMPORTANT: You must always end your answer with this exact disclaimer: "
        "'\n\n⚠️ Disclaimer: I am an AI, not a doctor. My advice may be inaccurate. "
        "If your symptoms are serious or an emergency, please visit a real doctor immediately.'",
      ),
    );
    _chatSession = _model.startChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Health AI")),
      body: DashChat(
        messageOptions: const MessageOptions(
          currentUserContainerColor: Colors.black,
          containerColor: Color.fromRGBO(0, 166, 126, 1),
          textColor: Colors.white,
        ),
        currentUser: _currentUser,
        onSend: (ChatMessage m) {
          getChatResponse(m);
        },
        messages: _messages,
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
    });

    try {
      final response = await _chatSession.sendMessage(Content.text(m.text));

      if (response.text != null) {
        setState(() {
          _messages.insert(
            0,
            ChatMessage(
              user: _geminiUser,
              createdAt: DateTime.now(),
              text: response.text!,
            ),
          );
        });
      }
    } catch (e) {
      // Handle errors (like no internet)
      print("Error: $e");
      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            user: _geminiUser,
            createdAt: DateTime.now(),
            text: "Error: Unable to connect to Gemini. Check your internet.",
          ),
        );
      });
    }
  }
}
