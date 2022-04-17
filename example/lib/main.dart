import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:custom_pin_screen/custom_pin_screen.dart';

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
                    builder: (context) => PinAuthentication(
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        backgroundColor: Colors.green,
                        keysColor: Colors.white,
                        activeFillColor:
                            const Color(0xFFF7F8FF).withOpacity(0.13),
                      ),
                      onChanged: (v) {
                        if (kDebugMode) {
                          print(v);
                        }
                      },
                      onCompleted: (v) {
                        if (kDebugMode) {
                          print('completed: $v');
                        }
                      },
                      maxLength: 4,
                      onSpecialKeyTap: () {
                        if (kDebugMode) {
                          print('fingerprint');
                        }
                      },
                      // specialKey: const SizedBox(),
                      useFingerprint: true,
                    ),
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

class WalletScreen extends StatelessWidget {
  const WalletScreen({
    Key? key,
  }) : super(key: key);

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
          Expanded(
              child: CustomKeyBoard(
            pinTheme: PinTheme(
                submitColor: Colors.green,
                textColor: Colors.red,
                keysColor: Colors.blue),
            onChanged: (v) {
              if (kDebugMode) {
                print(v);
              }
            },
            onbuttonClick: () {
              if (kDebugMode) {
                print('clicked');
              }
            },
            maxLength: 4,
            submitLabel: const Text(
              'Proceed',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            // ),
          ))
        ],
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).padding.bottom,
        color: Colors.green,
      ),
    );
  }
}
