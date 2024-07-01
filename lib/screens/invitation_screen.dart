import 'package:flutter/material.dart';
import 'package:lab5/models/factory.dart';
import 'package:lab5/widgets/custom_button.dart';

class InvitationPage extends StatefulWidget {
  final Factory factory;
  const InvitationPage({super.key, required this.factory});

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _addNewEngineer() {
    String name = _nameController.text.trim();
    String phone = _phoneController.text.trim();

    if (name.isNotEmpty && phone.isNotEmpty) {
      setState(() {
        widget.factory.engineers.add(Engineer(name: name, phone: phone));
        _nameController.clear();
        _phoneController.clear();
      });
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          widget.factory.factoryName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Invitation",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              const Text(
                "Invite users",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const Text(
                "Owner's Name",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: "Type here",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 44),
              const Text(
                "Owner's Phone Number",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Image.asset("images/malaysia.png"),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("+60"),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          hintText: "Enter your phone number",
                          border: OutlineInputBorder(),
                          counter: SizedBox.shrink(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                onPressed: _addNewEngineer,
                padding: const EdgeInsets.all(10),
                label: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
