import 'package:eurohang/app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'dart:math' as g;

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eurohang'),
        centerTitle: true,
        //  leading: const Image(image: AssetImage('assets/logo/logo.png')),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.settings,
              ),
              onPressed: () => context.go('/settings')),
        ],
      ),
      body: ListView(
        children: [
          ElevatedButton(
              onPressed: () async {
                final questionId = g.Random.secure().nextInt(10);
                final result = await HangmanRoute(questionId: questionId)
                    .push<bool>(context);
                if (!context.mounted) return;
                if (result ?? false) {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => const AlertDialog(
                            title: Text('Congrats, you got it!'),
                          ));
                } else {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => const AlertDialog(
                        title: Text('Sorry, you got it wrong!'),
                      ));
                }
              },
              child: const Text('Play Now!'))
        ],
      ),
    );
    ;
  }
}
