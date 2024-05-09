import 'package:flutter/material.dart';
import 'package:lab5/models/factory.dart';

class FactoryCarousel extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: factories.length,
        itemBuilder: (BuildContext context, int index) {
          return FactoryCard(
            title: factories[index].factoryName,
            index: index,
            onTap: () => onSelectFactory(index),
          );
        },
      ),
    );
  }
}

class FactoryCard extends StatelessWidget {
  final String title;
  final int index;
  final VoidCallback onTap;

  const FactoryCard(
      {super.key,
      required this.title,
      required this.index,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.factory),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
