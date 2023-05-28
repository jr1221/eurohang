import 'package:bot_toast/bot_toast.dart';
import 'package:confetti/confetti.dart';
import 'package:eurohang/app.dart';
import 'package:eurohang/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:url_launcher/url_launcher.dart';

const List<String> alphabet = [
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'i',
  'j',
  'k',
  'l',
  'm',
  'n',
  'o',
  'p',
  'q',
  'r',
  's',
  't',
  'u',
  'v',
  'w',
  'x',
  'y',
  'z'
];

class HangmanScreen extends StatefulWidget {
  const HangmanScreen({Key? key, required this.question}) : super(key: key);

  final Question question;

  @override
  State<HangmanScreen> createState() => _HangmanScreenState();
}

class _HangmanScreenState extends State<HangmanScreen> {
  final List<String> _lettersGuessed = [];
  int _wrongLetters = 0;
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 5));
  final AudioPlayer _audioPlayer = AudioPlayer();

  final TextEditingController _guessFormController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _guessFormController.dispose();
    _confettiController.dispose();
  }

  _showWinOrLooseDialog() {
    if (_wrongLetters > 6) {
      _audioPlayer.setAsset('audio/lost.wav');
      _audioPlayer.play();
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('You Lost!'),
          content: Text('The answer was ${widget.question.guess}'),
          actionsAlignment: MainAxisAlignment.center,
          actionsOverflowDirection: VerticalDirection.down,
          actionsOverflowAlignment: OverflowBarAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                const LoadHangmanRoute().pushReplacement(context);
              },
              child: const Text('Play Again'),
            ),
            TextButton(
              child: const Text('Learn More'),
              onPressed: () async {
                if (!await launchUrl(widget.question.moreInfo)) {
                  throw Exception(
                      'Could not launch ${widget.question.moreInfo}');
                }
              },
            ),
            TextButton(
              onPressed: () {
                const StartRoute().pushReplacement(context);
              },
              child: const Text('Go Home'),
            ),
          ],
        ),
      );
    } else if (_wrongLetters == 6) {
      _audioPlayer.setAsset('audio/oneLeft.wav');
      _audioPlayer.play();
    } else {
      final strList = widget.question.guess.split('');
      strList.removeWhere((element) => element == ' ');
      for (String char in strList) {
        if (!_lettersGuessed.contains(char.toLowerCase())) {
          return;
        }
      }
      _winUI();
    }
  }

  void _winUI() {
    _audioPlayer.setAsset('audio/win.wav');
    _audioPlayer.play();
    _confettiController.play();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('You Won!'),
        content: Text('The answer was ${widget.question.guess}'),
        actions: [
          ElevatedButton(
            onPressed: () {
              const LoadHangmanRoute().pushReplacement(context);
            },
            child: const Text('Play Again'),
          ),
          TextButton(
            child: const Text('Learn More'),
            onPressed: () async {
              if (!await launchUrl(widget.question.moreInfo)) {
                throw Exception('Could not launch ${widget.question.moreInfo}');
              }
            },
          ),
          TextButton(
            onPressed: () {
              const StartRoute().pushReplacement(context);
            },
            child: const Text('Go Home'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eurohang'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
            ),
            Text('$_wrongLetters wrong letters'),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 40, crossAxisSpacing: 2.5),
              scrollDirection: Axis.vertical,
              itemCount: widget.question.guess.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final letter = widget.question.guess[index].toLowerCase();
                if (_lettersGuessed.contains(letter)) {
                  return Text(
                    letter,
                    textScaleFactor: 1.5,
                    textAlign: TextAlign.center,
                  );
                } else {
                  if (letter == ' ') {
                    return const Text(
                      '      ',
                      textScaleFactor: 1.5,
                      textAlign: TextAlign.center,
                    );
                  }
                  return const Text(
                    '_',
                    textScaleFactor: 1.5,
                    textAlign: TextAlign.center,
                  );
                }
              },
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 0.0,
                  childAspectRatio: 5),
              itemCount: alphabet.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final letter = alphabet[index];
                if (_lettersGuessed.contains(letter)) {
                  return TextButton(
                    onPressed: null,
                    child: Text(
                      letter,
                      textScaleFactor: 1.5,
                    ),
                  );
                } else {
                  return TextButton(
                    onPressed: () {
                      setState(
                        () {
                          _lettersGuessed.add(letter);
                          if (!widget.question.guess
                              .toLowerCase()
                              .contains(letter)) {
                            _wrongLetters++;
                            _audioPlayer.setAsset('audio/incorrectLetter.wav');
                            _audioPlayer.play();
                          } else {
                            _audioPlayer.setAsset('audio/correctLetter.wav');
                            _audioPlayer.play();
                          }
                          _showWinOrLooseDialog();
                        },
                      );
                    },
                    child: Text(
                      letter,
                      textScaleFactor: 1.5,
                    ),
                  );
                }
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Enter your best guess', labelText: 'Guess'),
                    textCapitalization: TextCapitalization.none,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    enableSuggestions: false,
                    autocorrect: false,
                    textInputAction: TextInputAction.done,
                    maxLength: widget.question.guess.length,
                    controller: _guessFormController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (input) {
                      final cleanedInput = input?.split('')
                        ?..removeWhere((element) => element == ' ');
                      for (String char in cleanedInput ?? []) {
                        if (!alphabet.contains(char)) {
                          return 'Invalid character "$char"';
                        }
                      }
                      return null;
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (widget.question.guess.toLowerCase() ==
                        _guessFormController.text.toLowerCase()) {
                      _winUI();
                    } else {
                      BotToast.showText(
                          text:
                              '${_guessFormController.text.toLowerCase()} is an incorrect Guess');
                      _guessFormController.clear();
                    }
                  },
                  child: const Text('Check Guess'),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () => context.pop(false),
              child: const Text('Return'),
            )
          ],
        ),
      ),
    );
  }
}
