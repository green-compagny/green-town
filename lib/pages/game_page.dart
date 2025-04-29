import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final CardSwiperController controllerTuto = CardSwiperController();

  List<Widget> cards = [];
  List<Widget> tutoCards = [];
  int ecology = 50;
  int localEconomy = 50;
  int money = 50;
  int society = 50;

  bool isTuto = true;

  int currentIndex = 0;

  void _onEnd() {
    currentIndex++;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Partie terminée'),
            content: Text(
              'Vous avez fini le jeu, bien joué ! Vous n\'avez pas perdu. Cliquez sur OK pour recommencer.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Ferme la boîte de dialogue
                  Navigator.pop(
                    context,
                  ); // Ferme la page actuelle et revient en arrière
                },
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  void loseGame() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Partie terminée'),
            content: Text(
              'Vous avez perdu ! Une des jauges est arrivée à zéro.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Ferme la boîte de dialogue
                  Navigator.pop(
                    context,
                  ); // Ferme la page actuelle et revient en arrière
                },
                child: Text('OK'),
              ),
            ],
          ),
    );
  }

  void _onEndtuto() {
    setState(() {
      isTuto = false;
    });
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
      gameIsLoos();
    });
    return true;
  }

  void gameIsLoos() {
    if (ecology == 0 || localEconomy == 0 || money == 0 || society == 0) {
      loseGame();
    }
  }

  bool _onSwipeTuto(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    if (direction == CardSwiperDirection.left) {
      setState(() {
        isTuto = false;
      });
    }
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
                        onPressed:
                            () => controller.swipe(CardSwiperDirection.left),
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
                        onPressed:
                            () => controller.swipe(CardSwiperDirection.right),
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
    tutoCards.add(
      Card(
        margin: const EdgeInsets.all(16),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Texte explicatif
              const Text(
                'Bienvenue, Maire de Green Town !\n\n'
                'Votre mission : prendre des décisions pour équilibrer écologie, économie locale, budget et société.\n\n'
                'Swipez à droite pour accepter une proposition ✅,\nSwipez à gauche pour la refuser ❌.\n\n'
                'Essayez maintenant de swiper à droite ou à gauche pour passer ce tutoriel.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Image.asset(
                'assets/images/personne1.png', // mets l'image ici
                height: 150,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
    tutoCards.add(
      Card(
        margin: const EdgeInsets.all(16),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Texte explicatif
              const Text(
                'Chaque décision que vous prenez influence 4 jauges :\n\n'
                '🌍 Écologie '
                '🏘️ Économie locale\n'
                '💸 Argent '
                '👥 Société\n\n'
                'Toutes commencent à 50. Si l’une tombe à 0, vous perdez.\n'
                'Si vous atteignez 100, c’est le maximum !\n\n'
                'La partie se termine après 40 décisions : vous serez alors jugé sur votre gestion.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Image.asset(
                'assets/images/point.png',
                height: 150,
                fit: BoxFit.contain,
              ),
              Image.asset(
                'assets/images/personne2.png',
                height: 150,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    buildCards();
    super.initState();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        // Simule un swipe à gauche
        controller.swipe(CardSwiperDirection.left);
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        // Simule un swipe à droite
        controller.swipe(CardSwiperDirection.right);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Green Town")),
        body: RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: _handleKeyEvent, // Écoute des événements clavier
          child:
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
                          isTuto
                              ? "Tutoriel"
                              : CardData.cards[currentIndex].question,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      isTuto
                          ? Expanded(
                            child: CardSwiper(
                              key: const ValueKey('tuto'),
                              isLoop: false,
                              controller: controllerTuto,
                              cardsCount: tutoCards.length,
                              onSwipe: _onSwipeTuto,
                              onEnd: _onEndtuto,
                              allowedSwipeDirection:
                                  const AllowedSwipeDirection.only(
                                    left: true,
                                    right: true,
                                    down: false,
                                    up: false,
                                  ),
                              numberOfCardsDisplayed: 1,
                              cardBuilder:
                                  (context, index, _, __) => tutoCards[index],
                            ),
                          )
                          : Expanded(
                            child: CardSwiper(
                              key: const ValueKey('jeu'),
                              isLoop: false,
                              controller: controller,
                              cardsCount: cards.length,
                              onSwipe: _onSwipe,
                              onEnd: _onEnd,
                              allowedSwipeDirection:
                                  const AllowedSwipeDirection.only(
                                    left: true,
                                    right: true,
                                    down: false,
                                    up: false,
                                  ),
                              numberOfCardsDisplayed: 4,
                              cardBuilder:
                                  (context, index, _, __) => cards[index],
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
