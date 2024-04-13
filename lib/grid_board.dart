import 'package:boss_app/black_mage_screen.dart';
import 'package:boss_app/gloom_screen.dart';
import 'package:boss_app/kalos_screen.dart';
import 'package:boss_app/verus_hilla_screen.dart';
import 'package:flutter/material.dart';

class GridItem {
  final String title;
  final String image;
  final Widget screen;

  GridItem({required this.title, required this.image, required this.screen});
}

class GridBoard extends StatelessWidget {

  GridItem grid1 = GridItem(
      title: 'Black Mage',
      image: 'assets/images/black_mage.png',
      screen: const BlackMageScreen());
  GridItem grid2 = GridItem(
      title: 'Gloom', image: 'assets/images/gloom.jpg', screen: const GloomScreen());
  GridItem grid3 = GridItem(
      title: 'Kalos', image: 'assets/images/kalosnotwhite.jpg', screen: const KalosScreen());
  GridItem grid4 = GridItem(
      title: 'Verus Hilla',
      image: 'assets/images/verus_hilla.jpg',
      screen: const VerusHillaScreen());

  @override
  Widget build(BuildContext context) {
    List<GridItem> gridList = [grid1, grid2, grid3, grid4];
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        children: gridList.map((data) {
          return InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return data.screen;
              }));
            },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset(
                  data.image,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover
                ),
                Positioned(
                  bottom: 20,
                  
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
