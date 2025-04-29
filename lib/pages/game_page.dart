import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:green_town/Model/CardData.dart';
import 'package:green_town/constants/images_path.dart';

void main() {
  runApp(GamePage());
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final CardSwiperController controller = CardSwiperController();

  int ecology = 50;
  int localEconomy = 50;
  int money = 50;
  int society = 50;

  int currentIndex = 0;

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    // Update score
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Green Town")),
        body:
            currentIndex < CardData.cards.length
                ? Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildCounter("Écologie", ecology, Colors.green),
                          _buildCounter(
                            "Économie locale",
                            localEconomy,
                            Colors.orange,
                          ),
                          _buildCounter("Argent", money, Colors.blue),
                          _buildCounter("Société", society, Colors.purple),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        CardData.cards[currentIndex].question,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: CardSwiper(
                        isLoop: false,
                        controller: controller,
                        cardsCount: CardData.cards.length,
                        onSwipe: _onSwipe,
                        cardBuilder:
                            (
                              context,
                              index,
                              horizontalThresholdPercentage,
                              verticalThresholdPercentage,
                            ) => Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset(
                                    '${ImagePaths.assetsPath}${CardData.cards[currentIndex].img}',
                                    fit: BoxFit.cover,
                                    height: 200,
                                  ),
                                  SizedBox(height: 10),
                                  Center(child: Text('← non  •  oui →')),
                                ],
                              ),
                            ),
                      ),
                    ),
                  ],
                )
                : Center(
                  child: Text(
                    "Merci ! Vous avez répondu à toutes les questions.",
                  ),
                ),
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
          child: Text(
            "$value",
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
