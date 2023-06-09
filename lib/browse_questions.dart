import 'dart:convert';

import 'package:eurohang/app.dart';
import 'package:eurohang/constants.dart';
import 'package:eurohang/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';

class BrowseQuestionsScreen extends StatelessWidget {
  const BrowseQuestionsScreen({Key? key}) : super(key: key);

  Future<List<Question>> _fetchQuestions() async {
    List<Question> questions = [];

    for (int i = 1; i <= ProjectConstants.numberOfQuestions; i++) {
      questions.add(Question.fromJson(
        jsonDecode(
          await rootBundle
              .loadString('${ProjectConstants.definitionsPath}$i.json'),
        ),
      ));
    }
    return questions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All questions pre-loaded'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Question>>(
        future: _fetchQuestions(),
        builder: (context, AsyncSnapshot<List<Question>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
            case ConnectionState.none:
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final question = snapshot.data![index];
                    return Card(
                      child: Container(
                        width: 200,
                        height: 35,
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const ClampingScrollPhysics(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                child: Text('${question.id.toString()} -->  '),
                                onPressed: () {
                                  LoadHangmanRoute(questionId: question.id)
                                      .push(context);
                                },
                              ),
                              Text(question.guess),
                              TextButton(
                                child: Text(
                                  question.moreInfo.toString(),
                                ),
                                onPressed: () async {
                                  if (!await launchUrl(question.moreInfo)) {
                                    throw Exception(
                                        'Could not launch ${question.moreInfo}');
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error ${snapshot.error}');
              } else {
                return const Text('Unknown Error (no questions loaded)');
              }
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
          }
        },
        initialData: [
          Question(moreInfo: Uri.parse('http://google.com'), guess: 'a', id: 0)
        ],
      ),
    );
  }
}
