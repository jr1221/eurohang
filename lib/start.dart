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
        leading: const Image(image: AssetImage('assets/logo/logo.png')),
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
          ElevatedButton(onPressed: () {
            const RandHangmanRoute().push(context);
          }, child: const Text('Play Now!'))
        ],
      ),
    );
    ;
  }
}
