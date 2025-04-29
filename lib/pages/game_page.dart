import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

void main() {
  runApp(GamePage());
}

class QuestionData {
  final String question;
  final String img;
  final Map<String, Map<String, int>> impacts;

  QuestionData({required this.question, required this.img, required this.impacts});

  factory QuestionData.fromJson(Map<String, dynamic> json) {
    return QuestionData(
      question: json['question'],
      img: json['img'],
      impacts: Map<String, Map<String, int>>.from(json['impacts'].map(
            (key, value) => MapEntry(key, Map<String, int>.from(value)),
      )),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final CardSwiperController controller = CardSwiperController();
  List<QuestionData> questions = [
    QuestionData.fromJson({
      "question": "Lancer un marché hebdomadaire 100% producteurs locaux ?",
      "img": "img.png",
      "impacts": {
        "yes": {"ecology": 5, "localEconomy": 7, "money": -3, "society": 4},
        "no": {"ecology": -4, "localEconomy": -6, "money": 2, "society": -3}
      }
    }),
    QuestionData.fromJson({
      "question": "Question 2 ?",
      "img": "img.png",
      "impacts": {
        "yes": {"ecology": 5, "localEconomy": 7, "money": -3, "society": 4},
        "no": {"ecology": -4, "localEconomy": -6, "money": 2, "society": -3}
      }
    }),
  ];

  int ecology = 50;
  int localEconomy = 50;
  int money = 50;
  int society = 50;

  int currentIndex = 0;

  void applyImpact(String answer) {
    var impact = questions[currentIndex].impacts[answer]!;
    setState(() {
      ecology = (ecology + impact['ecology']!).clamp(0, 100);
      localEconomy = (localEconomy + impact['localEconomy']!).clamp(0, 100);
      money = (money + impact['money']!).clamp(0, 100);
      society = (society + impact['society']!).clamp(0, 100);
      currentIndex++;
    });
  }

  bool _onSwipe(
      int previousIndex,
      int? currentIndex,
      CardSwiperDirection direction,
      ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Green Town")),
        body: currentIndex < questions.length
            ? Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCounter("Écologie", ecology, Colors.green),
                  _buildCounter("Économie locale", localEconomy, Colors.orange),
                  _buildCounter("Argent", money, Colors.blue),
                  _buildCounter("Société", society, Colors.purple),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                questions[currentIndex].question,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: CardSwiper(
                isLoop: false,
                controller: controller,
                cardsCount: 2,
                onSwipe: _onSwipe,
                cardBuilder: (context, index, horizontalThresholdPercentage, verticalThresholdPercentage) => Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Image.asset('assets/${questions[currentIndex].img}',
                      //     fit: BoxFit.cover, height: 200),
                      SizedBox(height: 10),
                      Center(child: Text('← non  •  oui →')),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
            : Center(child: Text("Merci ! Vous avez répondu à toutes les questions.")),
      ),
    );
  }

  Widget _buildCounter(String label, int value, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text("$value", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
