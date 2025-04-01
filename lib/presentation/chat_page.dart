import 'package:ai_chatbot/presentation/chat_bubble.dart';
import 'package:ai_chatbot/presentation/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>{
  final _controller = TextEditingController();
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // TOP SECTION: Chat messages
            Expanded(
              child: Consumer<ChatProvider>(
                builder:(context, chatProvider, child){
                  // empty..
                  if(chatProvider.messages.isEmpty){
                    return const Center(
                      child: Text("Start a convo.."),
                    );
                  }
        
                  // chat messages
                  return ListView.builder(
                    itemCount: chatProvider.messages.length,
                    itemBuilder: (context, index){
                      // get each message
                      final message = chatProvider.messages[index];
        
                      // return message
                      return ChatBubble(message: message);
                    },
                  );
                }
              ),
            ),

            // Loading Incidator
            Consumer<ChatProvider>(
              builder: (context, chatProvider, child){
                if(chatProvider.isLoading){
                  return const CircularProgressIndicator();
                }
                return const SizedBox();
              }
            ),
        
            // USER INPUT BOX
            Row(
              children: [
                // LEFT -> Text Box
                  Expanded(
                    child: TextField(controller: _controller),
                ),
                // Right -> Send Button
                IconButton(
                  onPressed: (){
                    if (_controller.text.isNotEmpty){
                      final chatProvider = context.read<ChatProvider>();
                      chatProvider.sendMessage(_controller.text);
                      _controller.clear();
                    }
                  }, 
                  icon: const Icon(Icons.send),
                )
              ],
            )
        
          ],
        ),
      ),
    );
  }
}
