import 'package:flutter/material.dart';
import 'package:lab5/screens/home_screen.dart';
import 'package:lab5/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivationPage extends StatefulWidget {
  const ActivationPage({super.key});

  @override
  State<ActivationPage> createState() => _ActivationPageState();
}

class _ActivationPageState extends State<ActivationPage> {
  bool showOTP = false;
  final Uri _url = Uri.parse("https://www.youtube.com/watch?v=dQw4w9WgXcQ");

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Image.asset(
                'images/upm.png',
                height: 70,
              ),
            ),
            const Text(
              "Welcome!",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 40),
            ),
            showOTP
                ? const OTPCard()
                : PhoneNumberCard(
                    onGetActivationCodePressed: () {
                      setState(() {
                        showOTP = true;
                      });
                    },
                  ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _launchUrl,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Disclaimer | Privacy Statement",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      "Copyright UPM & Kejuruteraan Minyak Sawit CCS Sdn. Bhd.",
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhoneNumberCard extends StatefulWidget {
  const PhoneNumberCard({super.key, required this.onGetActivationCodePressed});
  final VoidCallback onGetActivationCodePressed;

  @override
  State<PhoneNumberCard> createState() => PhoneNumberCardState();
}

class PhoneNumberCardState extends State<PhoneNumberCard> {
  bool isAgree = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Enter your mobile number to activate your account.",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Image.asset("images/malaysia.png"),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("+60"),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      textAlignVertical: TextAlignVertical.top,
                      maxLength: 10,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        counter: SizedBox.shrink(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      value: isAgree,
                      onChanged: (bool? value) {
                        setState(() {
                          isAgree = value!;
                        });
                      }),
                  const Flexible(
                    child: Text(
                      "I agree to the terms & conditions",
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
            CustomButton(
              onPressed: () {
                if (isAgree) {
                  widget.onGetActivationCodePressed();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text("Please agree to the terms & conditions.")));
                }
              },
              padding: const EdgeInsets.all(15),
              label: const Text("Get Activation Code"),
            ),
          ],
        ),
      ),
    );
  }
}

class OTPCard extends StatefulWidget {
  const OTPCard({super.key});

  @override
  State<OTPCard> createState() => _OTPCardState();
}

class _OTPCardState extends State<OTPCard> {
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(6, (index) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Enter the activation code you received via SMS.",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.info_outline),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: 40,
                    child: TextField(
                      controller: controllers[index],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn't receive? "),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Tap here",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  padding: const EdgeInsets.all(15),
                  label: const Text("Activate")),
            ],
          ),
        ),
      ),
    );
  }
}
