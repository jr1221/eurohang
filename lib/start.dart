import 'package:eurohang/app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eurohang'),
        leading: Image.asset('assets/logo/logo.png'),
        centerTitle: true,
        //  leading: const Image(image: AssetImage('assets/logo/logo.png')),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
            ),
            onPressed: () => context.go('/settings'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                const LoadHangmanRoute().push(context);
              },
              child: const Text(
                'Play Now!',
                textScaleFactor: 1.5,
              ),
            ),
            const SizedBox(height: 15),
            const Text('-or-'),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                const BrowseQuestionsRoute().push(context);
              },
              child: const Text(
                'See questions',
                textScaleFactor: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
