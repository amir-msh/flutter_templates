import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_templates/templates/voice_chat/components/voice_chat_user_avatar.dart';

class VoiceChatPage extends StatefulWidget {
  const VoiceChatPage({super.key});

  @override
  State<VoiceChatPage> createState() => VoiceChatPageState();
}

class VoiceChatPageState extends State<VoiceChatPage> {
  Timer? _refreshTimer;
  final _micNotifier = ValueNotifier<bool>(true);
  var names = [
    for (int i = 0; i < 10; i++) ...[
      'Amber',
      'Ariana',
      'John',
      'Morgan',
      'Gloria',
      'Andy',
      'Mary',
      'George',
      'Emma',
      'Fredrick',
      'Chris',
      'Christopher',
      'Rick',
      'Morty',
      'Jonathan',
      'Liam',
      'Noah',
      'Amelia',
      'Isabella',
      'Henry',
      'Theodore',
      'Liam',
      'Elijah',
      'Henry',
      'Theodore',
      'Lucas',
      'Henry',
      'Elijah',
      'Eliam',
      'Onyx',
      'Koen',
    ],
  ];

  @override
  void initState() {
    _refreshTimer = Timer.periodic(
      const Duration(milliseconds: 2500),
      (t) {
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _micNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Chat'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        clipBehavior: Clip.none,
        itemCount: 30,
        itemBuilder: (context, index) {
          final isSpeaking = Random().nextBool();
          final imageAddress = 'assets/user_images/$index.jfif';
          return VoiceChatUserAvatar(
            key: Key(imageAddress),
            name: names[index],
            imageProvider: AssetImage(imageAddress),
            isSpeaking: isSpeaking,
            isMuted: isSpeaking ? false : Random().nextBool(),
          );
        },
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 120,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _micNotifier.value = !_micNotifier.value;
        },
        child: ValueListenableBuilder(
          valueListenable: _micNotifier,
          builder: (context, value, child) {
            return AnimatedCrossFade(
              duration: const Duration(milliseconds: 250),
              reverseDuration: const Duration(milliseconds: 250),
              sizeCurve: Curves.easeInOut,
              firstCurve: Curves.easeInOut,
              secondCurve: Curves.easeInOut,
              crossFadeState:
                  value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              firstChild: child!,
              secondChild: const Icon(
                Icons.mic_off_rounded,
              ),
            );
          },
          child: const Icon(Icons.mic_rounded),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12.5),
        ),
        child: BottomAppBar(
          notchMargin: 3,
          shape: const CircularNotchedRectangle(),
          clipBehavior: Clip.hardEdge,
          height: 42,
          color: Theme.of(context).primaryColor,
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 12.5, right: 30),
              child: Text(
                'Amir Mohammad',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
