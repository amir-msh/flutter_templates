import 'package:flutter/material.dart';

class VoiceChatUserAvatar extends StatelessWidget {
  final ImageProvider? imageProvider;
  final bool isSpeaking;
  final bool isMuted;
  final double speakingStrokeWidth;
  const VoiceChatUserAvatar({
    this.imageProvider,
    this.isSpeaking = false,
    this.isMuted = false,
    this.speakingStrokeWidth = 5,
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
      children: [
        AspectRatio(
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
                  margin: EdgeInsets.all(isSpeaking ? speakingStrokeWidth : 0),
                  clipBehavior: isSpeaking ? Clip.antiAlias : Clip.hardEdge,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                    border: Border.all(
                      color: isSpeaking
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      width: isSpeaking ? speakingStrokeWidth : 1,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    boxShadow: isSpeaking
                        ? [
                            BoxShadow(
                              blurRadius: 12,
                              spreadRadius: 1,
                              color: Theme.of(context).colorScheme.shadow,
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
                        color: Theme.of(context).primaryColor,
                        width: 3,
                      ),
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.mic_off_outlined,
                      size: 18.5,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
