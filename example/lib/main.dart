import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:custom_pin_screen/custom_pin_screen.dart';

import 'pin_code_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pin Screens Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Pin Screens'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PinAuthScreen(),
                  ),
                );
              },
              icon: const Text('Pin Auth'),
              label: const Icon(Icons.lock),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WalletScreen(),
                  ),
                );
              },
              icon: const Text('Custom Keyboard'),
              label: const Icon(Icons.keyboard),
            ),
          ],
        ),
      ),
    );
  }
}

class WalletScreen extends StatefulWidget {
  const WalletScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.removeListener(() {
      setState(() {});
    });
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          "Fund wallet",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 35.0,
              vertical: 35.0,
            ),
            child: Text(
              "How much do you want to fund your wallet with",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          Text(
            "₦${controller.text}",
            key: const Key('amtKey'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w700,
              fontSize: 48,
            ),
          ),
          const SizedBox(height: 80),
          Expanded(
            child: CustomKeyBoard(
              padding: 0,
              controller: controller,
              pinTheme: PinTheme(
                textColor: Colors.red,
                keysColor: Colors.blue,
              ),
              maxLength: 4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 50,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    "Proceed",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }
}

class PinAuthScreen extends StatefulWidget {
  const PinAuthScreen({Key? key}) : super(key: key);

  @override
  State<PinAuthScreen> createState() => _PinAuthScreenState();
}

class _PinAuthScreenState extends State<PinAuthScreen> {
  TextEditingController controller = TextEditingController();
  PinTheme pinTheme = PinTheme(
    keysColor: Colors.white,
  );
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.removeListener(() {
      setState(() {});
    });
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 35.0,
                vertical: 35.0,
              ),
              child: Text(
                "Enter PIN",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  // color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Please enter your pin to continue",
              style: TextStyle(
                // color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 4; i++)
                  PinCodeField(
                    key: Key('pinField$i'),
                    pin: controller.text,
                    pinCodeFieldIndex: i,
                    theme: pinTheme,
                  ),
              ],
            ),
            const SizedBox(height: 80),
            Expanded(
              child: CustomKeyBoard(
                controller: controller,
                pinTheme: pinTheme,
                specialKey: Icon(
                  Icons.fingerprint,
                  key: const Key('fingerprint'),
                  color: pinTheme.keysColor,
                  size: 50,
                ),
                specialKeyOnTap: () {
                  if (kDebugMode) {
                    print('fingerprint');
                  }
                },
                maxLength: 4,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  controller.clear();
                });
              },
              child: const Text('Clear Pin'),
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }
}
