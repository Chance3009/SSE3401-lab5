import 'package:flutter/material.dart';
import 'package:lab5/models/factory.dart';
import 'package:lab5/screens/invitation_screen.dart';

class EngineerPage extends StatefulWidget {
  final int factoryIndex;

  const EngineerPage({super.key, required this.factoryIndex});

  @override
  State<EngineerPage> createState() => _EngineerPageState();
}

class _EngineerPageState extends State<EngineerPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: EngineerPanel(
          factory: factories[widget.factoryIndex],
          onRefresh: () {
            setState(() {});
          }),
    );
  }
}

class EngineerPanel extends StatelessWidget {
  final Factory factory;
  final Function() onRefresh;

  const EngineerPanel(
      {super.key, required this.factory, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final List<Engineer> engineers = factory.engineers;

    return Card(
      margin: const EdgeInsets.all(10),
      child: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: engineers.length,
            itemBuilder: (BuildContext context, int index) {
              return EngineerDetail(
                name: engineers[index].name,
                phone: engineers[index].phone,
              );
            },
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            InvitationPage(factory: factory)));
                if (result) {
                  onRefresh();
                }
              },
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}

class EngineerDetail extends StatelessWidget {
  final String name;
  final String phone;

  const EngineerDetail({super.key, required this.name, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.circle,
                  size: 10,
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  phone,
                  style: const TextStyle(fontSize: 16),
                ),
              ])
            ],
          )),
    );
  }
}
