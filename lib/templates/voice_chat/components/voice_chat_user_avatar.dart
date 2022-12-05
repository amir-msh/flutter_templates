import 'package:flutter/material.dart';

class VoiceChatUserAvatar extends StatelessWidget {
  final ImageProvider? imageProvider;
  final bool isSpeaking;
  final bool isMuted;
  final double speakingStrokeWidth;
  final String name;
  const VoiceChatUserAvatar({
    this.imageProvider,
    this.isSpeaking = false,
    this.isMuted = false,
    this.speakingStrokeWidth = 3.6,
    required this.name,
    super.key,
  });

  Widget _noProfileBuilder() {
    return FittedBox(
      fit: BoxFit.cover,
      child: Center(
        child: Transform.scale(
          scale: 1.39,
          child: Icon(
            Icons.account_circle,
            color: Colors.grey[200]!,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: AspectRatio(
            key: ValueKey(imageProvider.hashCode),
            aspectRatio: 1,
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: AnimatedContainer(
                    key: ValueKey(imageProvider.hashCode),
                    duration: const Duration(milliseconds: 360),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.all(
                      isSpeaking ? speakingStrokeWidth : 0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                        color: isSpeaking
                            ? Colors.lightBlue[300]!
                            : Colors.transparent,
                        width: isSpeaking ? speakingStrokeWidth : 1,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                      boxShadow: isSpeaking
                          ? [
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 3,
                                offset: const Offset(-2.5, -2.5),
                                color: Colors.lightBlue[400]!,
                              ),
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 3,
                                offset: const Offset(2.5, 2.5),
                                color: Colors.lightGreen[400]!,
                              ),
                            ]
                          : const [],
                    ),
                    child: imageProvider == null
                        ? _noProfileBuilder()
                        : Image(
                            image: imageProvider!,
                            fit: BoxFit.contain,
                            isAntiAlias: false,
                            errorBuilder: (context, error, stackTrace) {
                              return _noProfileBuilder();
                            },
                          ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 3,
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 360),
                    scale: isMuted ? 1 : 0,
                    curve: Curves.decelerate,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.lightBlue,
                          width: 1.75,
                        ),
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.mic_off_outlined,
                        size: 18.0,
                        color: Colors.grey[800]!,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 1.9),
        RepaintBoundary(
          key: key,
          child: Text(
            name,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              overflow: TextOverflow.fade,
              shadows: List.generate(
                7,
                (i) => Shadow(
                  color: Colors.lightBlue[900]!,
                  blurRadius: 1.3666,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
