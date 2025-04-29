import 'dart:convert';

import 'package:flutter/services.dart';

import 'Impact.dart';

Future<void> loadCards() async {
  final String jsonString = await rootBundle.loadString('assets/data.json');
  final List<dynamic> jsonList = jsonDecode(jsonString);

  List<CardData> allCards = jsonList.map((json) => CardData.fromJson(json)).toList();
  allCards.shuffle();
  CardData.cards = allCards.take(40).toList();
}


class CardData {
  final String question;
  final String img;
  final Impacts impacts;
  static List<CardData> cards = [];

  CardData({
    required this.question,
    required this.img,
    required this.impacts,
  });

  factory CardData.fromJson(Map<String, dynamic> json) {
    return CardData(
      question: json['question'],
      img: json['img'],
      impacts: Impacts.fromJson(json['impacts']),
    );
  }

  Map<String, dynamic> toJson() => {
    'question': question,
    'img': img,
    'impacts': impacts.toJson(),
  };
}