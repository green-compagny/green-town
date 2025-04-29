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

  List<Widget> cards = [];
  int ecology = 50;
  int localEconomy = 50;
  int money = 50;
  int society = 50;

  int currentIndex = 0;

  void _onEnd() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Partie terminée'),
        content: Text('Une jauge est tombée à zéro.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }


  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    if (currentIndex == null) return true;
    setState(() {
      this.currentIndex = currentIndex;
      if (direction == CardSwiperDirection.left) {
        ecology += CardData.cards[currentIndex].impacts.no.ecology;
        localEconomy += CardData.cards[currentIndex].impacts.no.localEconomy;
        money += CardData.cards[currentIndex].impacts.no.money;
        society += CardData.cards[currentIndex].impacts.no.society;
      } else if (direction == CardSwiperDirection.right) {
        ecology += CardData.cards[currentIndex].impacts.yes.ecology;
        localEconomy += CardData.cards[currentIndex].impacts.yes.localEconomy;
        money += CardData.cards[currentIndex].impacts.yes.money;
        society += CardData.cards[currentIndex].impacts.yes.society;
      }
      ecology = ecology.clamp(0, 100);
      localEconomy = localEconomy.clamp(0, 100);
      money = money.clamp(0, 100);
      society = society.clamp(0, 100);
    });
    return true;
  }

  void buildCards() {
    for (int i = 0; i < CardData.cards.length; i++) {
      cards.add(
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                '${ImagePaths.assetsPath}${CardData.cards[i].img}',
                fit: BoxFit.cover,
                height: 200,
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Bouton rouge (refus)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => controller.swipe(CardSwiperDirection.left),
                      ),
                    ),

                    // Bouton vert (validation)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.check, color: Colors.white),
                        onPressed: () => controller.swipe(CardSwiperDirection.right),
                      ),
                    ),
                  ],
                ),

              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    buildCards();
    super.initState();
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
                        onEnd: _onEnd,
                        allowedSwipeDirection: AllowedSwipeDirection.only(left: true,right: true,down: false,up: false),
                        numberOfCardsDisplayed: 4,
                        cardBuilder:
                            (
                              context,
                              index,
                              horizontalThresholdPercentage,
                              verticalThresholdPercentage,
                            ) => cards[currentIndex],
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
