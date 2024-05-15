import 'package:flutter/material.dart';
import 'package:lab5/models/factory.dart';
import 'package:lab5/screens/dashboard_screen.dart';
import 'package:lab5/screens/engineer_screen.dart';
import 'package:lab5/screens/settings_screen.dart';
import 'package:lab5/widgets/factory_carousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 1;
  int factoryIndex = 0;

  void updateFactory(int index) {
    setState(() {
      factoryIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      EngineerPage(factoryIndex: factoryIndex),
      Dashboard(factoryIndex: factoryIndex),
      SettingsPage(factoryIndex: factoryIndex)
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          factories[factoryIndex].factoryName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          screens[currentIndex],
          FactoryCarousel(
            factories: factories,
            selectedIndex: factoryIndex,
            onSelectFactory: updateFactory,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            key: Key("User"),
            icon: Icon(Icons.person),
            label: "User",
          ),
          BottomNavigationBarItem(
            key: Key("Home"),
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            key: Key("Settings"),
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
