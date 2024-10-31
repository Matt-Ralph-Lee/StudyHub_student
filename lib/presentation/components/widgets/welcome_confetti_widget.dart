import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../parts/button_for_profile_input_back.dart';
import '../parts/text_for_profile_completion_welcome.dart';

class WelcomeConfettiWidget extends HookWidget {
  final VoidCallback decrementProgressCounter;
  const WelcomeConfettiWidget({
    super.key,
    required this.decrementProgressCounter,
  });

  @override
  Widget build(BuildContext context) {
    final confettiController = useState(
      ConfettiController(duration: const Duration(seconds: 1)),
    );
    useEffect(() {
      confettiController.value.play();
      return confettiController.value.dispose;
    }, []);

    return Column(
      children: [
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              ConfettiWidget(
                confettiController: confettiController.value,
                blastDirectionality: BlastDirectionality.explosive,
                maxBlastForce: 20,
                numberOfParticles: 100,
                gravity: 0.05,
                shouldLoop: false,
              ),
              const TextForProfileCompletionWelcome(),
            ],
          ),
        ),
      ],
    );
  }
}
