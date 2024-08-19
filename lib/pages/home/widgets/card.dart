import 'package:flutter/material.dart';
import '../../../theme/colortheme.dart';

class CardHome extends StatelessWidget {
  final String name;
  final String image;
  final String route;
  const CardHome(
      {super.key,
      required this.name,
      required this.image,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      width: double.infinity,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: Card(
          elevation: 30,
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    filterQuality: FilterQuality.high,
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(1),
                            Colors.black.withOpacity(0.9),
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.7),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.1),
                          ], // Gradient from h],
                          begin: Alignment.centerLeft),
                    ),
                    width: MediaQuery.of(context).size.width * 0.93,
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.bottomRight,
                    height: 50,
                    child: Text(
                      name,
                      style: ThemeColor.fontsTheme.displayMedium,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
