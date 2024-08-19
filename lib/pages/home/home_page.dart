import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vet_app/pages/cats/cats.dart';
import 'package:vet_app/pages/dogs/dogs.dart';
import '../../models/asset_model.dart';
import '../../routes/routes.dart';
import '../../theme/colortheme.dart';
import '../tutor/tutor.dart';
import 'widgets/card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  static const homePageRoute = Routes.homePage;

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Widget> list = [];

  List<AssetModel> imagesList = [
    AssetModel("assets/ivye.jpeg", "Gatos", Cats.catsPageRoute, 'cat'),
    AssetModel("assets/kathy.jpeg", "Cachorros", Dogs.dogsPageRoute, "dog")
  ];

  @override
  Widget build(BuildContext context) {
    list = imagesList
        .map(
          (element) => Hero(
            tag: element.getTag,
            child: CardHome(
              name: element.getName,
              image: element.getImage,
              route: element.getRoute,
            ),
          ),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: ThemeColor.fontsTheme.titleLarge),
      ),
      body: _currentIndex == 0
          ? SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
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
                            "Aqui é possível conhecer diversas raças de pets",
                            textAlign: TextAlign.center,
                            style: ThemeColor.fontsTheme.headlineLarge,
                            overflow: TextOverflow.fade,
                          ).animate(delay: 0.2.ms).fade().slideX(),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 1.4,
                        crossAxisCount: 1,
                        padding: const EdgeInsets.all(10),
                        mainAxisSpacing: 2,
                        children: AnimateList(
                            children: list,
                            effects: [
                              SlideEffect(
                                delay: 300.ms,
                                begin: Offset.fromDirection(22),
                              ),
                              const FadeEffect(curve: Curves.easeIn)
                            ],
                            interval: 400.ms),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Tutor(),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 18,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        iconSize: 30,
        elevation: 40,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: const Icon(
              Icons.home_filled,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: "Tutor",
            backgroundColor: Theme.of(context).colorScheme.primary,
          )
        ],
      ),
    );
  }
}
