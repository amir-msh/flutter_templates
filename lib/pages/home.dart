import 'package:flutter/material.dart';
import 'package:flutter_templates/templates/voice_chat/pages/voice_chat.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Templates List'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.record_voice_over_rounded),
            title: const Text('Voice chat template'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const VoiceChatPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
