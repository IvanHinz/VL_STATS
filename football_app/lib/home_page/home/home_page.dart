import 'package:flutter/material.dart';
import 'grid_child.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(75.0),
          child: AppBar(
            toolbarHeight: kToolbarHeight + 50,
            centerTitle: true,
            title: Text(
              "VLStats",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).colorScheme.background,
            ),
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        'Choose league',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 25,
                    children: const [
                      GridChild(
                        description: 'Premier League',
                        imagePath: 'assets/premier_league.jpg',
                      ),
                      GridChild(
                        description: 'Bundesliga',
                        imagePath: 'assets/bundesliga.jpg',
                      ),
                      GridChild(
                        description: 'La Liga',
                        imagePath: 'assets/la_liga.png',
                      ),
                      GridChild(
                          imagePath: 'assets/Russian_Premier_League.png',
                          description: 'Russian Premier League')
                    ],
                  ),
                ),
              ],
            )));
  }
}
