import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../theme/colortheme.dart';

class Tutor extends StatefulWidget {
  const Tutor({super.key});

  @override
  State<Tutor> createState() => _TutorState();
}

class _TutorState extends State<Tutor> {
  static const List<Map<String, dynamic>> teste = [
    {'text': 'vacinas'},
    {'text': 'cuidados'},
    {'text': 'cuidados'},
    {'text': 'cuidados'},
    {'text': 'cuidados'},
    {'text': 'cuidados'},
    {'text': 'cuidados'},
    {'text': 'cuidados'},
  ];
  List<Widget> list = teste.map((e) {
    return Card(
      elevation: 20,
      color: Colors.lightBlue,
      child: Container(
          alignment: Alignment.center,
          child: Text(
            e['text'],
          )),
    );
  }).toList();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 100,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.pets,
                size: 50,
                color: Theme.of(context).colorScheme.primary,
              ).animate().fade().slideX(),
              SizedBox(
                width: 250,
                child: Text(
                  "Aqui você encontra  dicas para cuidar do seu pet",
                  textAlign: TextAlign.center,
                  style: ThemeColor.fontsTheme.headlineLarge,
                ).animate(delay: 0.2.ms).fade().slideX(),
              )
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: GridView.count(
              childAspectRatio: 1.2,
              crossAxisCount: 2,
              padding: const EdgeInsets.all(10),
              mainAxisSpacing: 2,
              children: list.animate().fade().slideX(),
            ),
          ),
        ),
      ],
    );
  }
}
