import 'package:flutter/material.dart';
import 'package:lab5/models/factory.dart';
import 'package:responsive_framework/responsive_framework.dart';

class FactoryCarousel extends StatefulWidget {
  final List<Factory> factories;
  final int selectedIndex;
  final Function(int) onSelectFactory;

  const FactoryCarousel({
    super.key,
    required this.factories,
    required this.selectedIndex,
    required this.onSelectFactory,
  });

  @override
  State<FactoryCarousel> createState() => _FactoryCarouselState();
}

class _FactoryCarouselState extends State<FactoryCarousel> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final double carouselHeight = screenHeight * 0.2;

    return Container(
      margin: const EdgeInsets.all(20),
      height: carouselHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: factories.length,
        itemBuilder: (BuildContext context, int index) {
          return FactoryCard(
            title: factories[index].factoryName,
            index: index,
            color: factories[index].color,
            onTap: () {
              setState(() {
                for (var factory in widget.factories) {
                  factory.color = Colors.white;
                }
                widget.factories[index].color = Colors.amber;
              });
              widget.onSelectFactory(index);
            },
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          );
        },
      ),
    );
  }
}

class FactoryCard extends StatelessWidget {
  final String title;
  final int index;
  final Color color;
  final VoidCallback onTap;
  final double screenWidth;
  final double screenHeight;

  const FactoryCard({
    super.key,
    required this.title,
    required this.index,
    required this.color,
    required this.onTap,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    final double cardWidth = screenWidth * 0.2;
    final double cardHeight = screenHeight * 0.15;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: cardWidth * 0.1,
            vertical: cardHeight * 0.2,
          ),
          child: SizedBox(
            width: cardWidth,
            height: cardHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.factory,
                  size: ResponsiveValue(
                    context,
                    defaultValue: 32.0,
                    conditionalValues: const [
                      Condition.smallerThan(
                        name: MOBILE,
                        value: 18.0,
                      ),
                      Condition.equals(
                        name: TABLET,
                        value: 38.0,
                      ),
                      Condition.equals(
                        name: DESKTOP,
                        value: 42.0,
                      ),
                      Condition.largerThan(
                        name: DESKTOP,
                        value: 60.0,
                      ),
                    ],
                  ).value,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: ResponsiveValue(
                      context,
                      defaultValue: 14.0,
                      conditionalValues: const [
                        Condition.smallerThan(
                          name: MOBILE,
                          value: 10.0,
                        ),
                        Condition.equals(
                          name: TABLET,
                          value: 16.0,
                        ),
                        Condition.equals(
                          name: DESKTOP,
                          value: 18.0,
                        ),
                        Condition.largerThan(
                          name: DESKTOP,
                          value: 28.0,
                        ),
                      ],
                    ).value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
