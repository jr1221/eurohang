import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:eurohang/app.dart';
import 'package:eurohang/question.dart';
import 'package:flutter/material.dart';
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
  List<String> _lettersGuessed = [];
  int _wrongGuesses = 0;
  final ConfettiController _controller =
      ConfettiController(duration: const Duration(seconds: 5));
  final AudioPlayer _audioPlayer = AudioPlayer();

  _showWinOrLooseDialog() {
    if (_wrongGuesses > 6) {
      _audioPlayer.setAsset('audio/lost.wav');
      _audioPlayer.play();
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('You Lost!'),
                content: Text('The answer was ${widget.question.guess}'),
                actions: [
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Play Again')),
                  TextButton(
                      child: const Text('Learn More'),
                      onPressed: () async {
                        if (!await launchUrl(widget.question.moreInfo)) {
                          throw Exception(
                              'Could not launch ${widget.question.moreInfo}');
                        }
                      })
                ],
              ));
    } else if (_wrongGuesses == 6) {
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
      _audioPlayer.setAsset('audio/win.wav');
      _audioPlayer.play();
      _controller.play();
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('You Won!'),
                content: Text('The answer was ${widget.question.guess}'),
                actions: [
                  TextButton(
                      child: const Text('Learn More'),
                      onPressed: () async {
                        if (!await launchUrl(widget.question.moreInfo)) {
                          throw Exception(
                              'Could not launch ${widget.question.moreInfo}');
                        }
                      })
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Eurohang'),
          centerTitle: true,
        ),
        body: Column(mainAxisSize: MainAxisSize.min, children: [
          ConfettiWidget(
            confettiController: _controller,
            blastDirectionality: BlastDirectionality.explosive,
          ),
          Text('$_wrongGuesses wrong guesses'),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.question.guess.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final letter = widget.question.guess[index].toLowerCase();
                    if (_lettersGuessed.contains(letter)) {
                      return Text(' $letter ');
                    } else {
                      if (letter == ' ') return const Text('      ');
                      return const Text(' _ ');
                    }
                  })),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: alphabet.length,
                  shrinkWrap: true,
                  //    physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final letter = alphabet[index];
                    if (_lettersGuessed.contains(letter)) {
                      return TextButton(
                        onPressed: null,
                        child: Text(' $letter '),
                      );
                    } else {
                      return TextButton(
                        onPressed: () {
                          setState(() {
                            _lettersGuessed.add(letter);
                            if (!widget.question.guess
                                .toLowerCase()
                                .contains(letter)) {
                              _wrongGuesses++;
                              _audioPlayer
                                  .setAsset('audio/incorrectLetter.wav');
                              _audioPlayer.play();
                            } else {
                              _audioPlayer.setAsset('audio/correctLetter.wav');
                              _audioPlayer.play();
                            }
                            _showWinOrLooseDialog();
                          });
                        },
                        child: Text(' $letter '),
                      );
                    }
                  })),
          ElevatedButton(
              onPressed: () => context.pop(false), child: const Text('Return'))
        ]));
  }
}
