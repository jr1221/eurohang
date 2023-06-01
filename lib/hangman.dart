import 'package:bot_toast/bot_toast.dart';
import 'package:confetti/confetti.dart';
import 'package:eurohang/app.dart';
import 'package:eurohang/constants.dart';
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
    _audioPlayer.dispose();
  }

  void _updateDialogs() {
    if (_wrongLetters > 9) {
      _lostUI();
    } else if (_wrongLetters == 9) {
      _oneLeftUI();
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

  void _oneLeftUI() {
    _audioPlayer.setAsset('audio/oneLeft.wav');
    _audioPlayer.play();
  }

  void _incorrectLetterUI() {
    _audioPlayer.setAsset('audio/incorrectLetter.wav');
    _audioPlayer.play();
  }

  void _correctLetterUI() {
    _audioPlayer.setAsset('audio/correctLetter.wav');
    _audioPlayer.play();
  }

  void _winUI() {
    _audioPlayer.setAsset('audio/win.wav');
    _audioPlayer.play();
    _confettiController.play();
    endNotifUI(true);
  }

  void _lostUI() {
    _audioPlayer.setAsset('audio/lost.wav');
    _audioPlayer.play();
    endNotifUI(false);
  }

  void endNotifUI(bool win) {
    final Text endText;
    if (win) {
      endText = const Text('You Won!');
    } else {
      endText = const Text('You Lost!');
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: endText,
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

  String _imageAssetFromWrongGuesses(int wrongGuesses) {
    return switch (wrongGuesses) {
      <= 4 => '${ProjectConstants.imagesPath}$wrongGuesses.png',
      <= 9 =>
        '${ProjectConstants.imagesPath}${widget.question.id}-$wrongGuesses.png',
      _ => '${ProjectConstants.imagesPath}${widget.question.id}-9.png',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eurohang'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
              ),
              Text('$_wrongLetters wrong letters'),
              Image.asset(_imageAssetFromWrongGuesses(_wrongLetters)),
              SizedBox(
                width: 400,
                child: GridView.builder(
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
              ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 0.0,
                    childAspectRatio: 1.5),
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
                              _incorrectLetterUI();
                            } else {
                              _correctLetterUI();
                            }
                            _updateDialogs();
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
                          hintText: 'Enter your best guess',
                          labelText: 'Guess'),
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
                onPressed: () => context.pop(),
                child: const Text('Exit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
