import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:green_town/Model/CardData.dart';
import 'package:green_town/constants/images_path.dart';

import '../constants/Config.dart';

void main() {
  runApp(const GamePage());
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

  @override
  void initState() {
    buildCards();
    super.initState();
  }

  void buildCards() {
    cards = CardData.cards.map((cardData) {
      return Card(
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  '${ImagePaths.assetsPath}${cardData.img}',
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSwipeButton(Icons.close, Colors.red, () {
                    controller.swipe(CardSwiperDirection.left);
                  }),
                  _buildSwipeButton(Icons.check, Colors.green, () {
                    controller.swipe(CardSwiperDirection.right);
                  }),
                ],
              ),
            ],
          ),
        ),
      );
    }).toList();

    tutoCards = [
      _buildTutoCard(
        'Bienvenue, Maire de Green Town !\n\nVotre mission : prendre des décisions pour équilibrer écologie, économie locale, budget et société.\n\nSwipez à droite pour accepter ✅, à gauche pour refuser ❌.',
        'assets/images/personne1.png',
      ),
      _buildTutoCard(
        'Chaque décision influence 4 jauges :\n\n🌍 Écologie  🏘️ Économie locale\n💸 Argent  👥 Société\n\nSi une jauge tombe à 0, vous perdez.\nAprès ${Config.nbrCard} décisions, vous serez évalué.',
        'assets/images/point.png',
        extraImage: 'assets/images/personne2.png',
      ),
    ];
  }

  Widget _buildTutoCard(String text, String imagePath, {String? extraImage}) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                Image.asset(imagePath, height: 150, fit: BoxFit.contain),
                if (extraImage != null) ...[
                  const SizedBox(height: 12),
                  Image.asset(extraImage, height: 150, fit: BoxFit.contain),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwipeButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(14),
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }

  void _onEnd() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF1F8E9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Partie terminée',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: const Text(
          '🎉 Vous avez fini le jeu, bien joué !\n\nCliquez sur OK pour recommencer.',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void loseGame() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF1F8E9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Partie terminée',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          textAlign: TextAlign.center,
        ),
        content: const Text(
          '😢 Vous avez perdu !\nUne des jauges est tombée à zéro.',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  bool _onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    if (currentIndex == null) return true;

    setState(() {
      this.currentIndex = currentIndex;
      final impacts = direction == CardSwiperDirection.left
          ? CardData.cards[currentIndex].impacts.no
          : CardData.cards[currentIndex].impacts.yes;

      ecology = (ecology + impacts.ecology).clamp(0, 100);
      localEconomy = (localEconomy + impacts.localEconomy).clamp(0, 100);
      money = (money + impacts.money).clamp(0, 100);
      society = (society + impacts.society).clamp(0, 100);

      if ([ecology, localEconomy, money, society].any((e) => e == 0)) {
        loseGame();
      }
    });

    return true;
  }

  bool _onSwipeTuto(int prev, int? curr, CardSwiperDirection direction) {
    if (direction == CardSwiperDirection.left) {
      setState(() => isTuto = false);
    }
    return true;
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        controller.swipe(CardSwiperDirection.left);
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        controller.swipe(CardSwiperDirection.right);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Town',
      theme: ThemeData(fontFamily: 'Roboto'),
      home: Scaffold(
        backgroundColor: const Color(0xFFF1F8E9),
        body: RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: _handleKeyEvent,
          child: currentIndex < CardData.cards.length
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
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
                padding: const EdgeInsets.all(16),
                child: Text(
                  isTuto ? "Tutoriel" : CardData.cards[currentIndex].question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: CardSwiper(
                  key: ValueKey(isTuto ? 'tuto' : 'jeu'),
                  isLoop: false,
                  controller: isTuto ? controllerTuto : controller,
                  cardsCount: isTuto ? tutoCards.length : cards.length,
                  onSwipe: isTuto ? _onSwipeTuto : _onSwipe,
                  onEnd: isTuto ? () => setState(() => isTuto = false) : _onEnd,
                  allowedSwipeDirection: const AllowedSwipeDirection.only(
                    left: true,
                    right: true,
                    up: false,
                    down: false,
                  ),
                  numberOfCardsDisplayed: 2,
                  cardBuilder: (context, index, _, __) {
                    final card = isTuto ? tutoCards[index] : cards[index];
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, animation) => SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.2),
                          end: Offset.zero,
                        ).animate(animation),
                        child: FadeTransition(opacity: animation, child: child),
                      ),
                      child: card,
                    );
                  },
                ),
              ),
            ],
          )
              : const Center(child: Text("Merci ! Vous avez répondu à toutes les questions.")),
        ),
      ),
    );
  }

  Widget _buildCounter(String label, int value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color.withOpacity(0.1)),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: value / 100),
              duration: const Duration(milliseconds: 500),
              builder: (context, val, _) {
                return SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    value: val,
                    color: color,
                    backgroundColor: Colors.grey.shade300,
                    strokeWidth: 5,
                  ),
                );
              },
            ),
            Text("$value", style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
