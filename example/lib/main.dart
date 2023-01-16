import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart' as pin_code;

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
                      obscureText: false,
                      keyBoardPinTheme: KeyBoardPinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        backgroundColor: Colors.green,
                        keysColor: Colors.white,
                        activeFillColor:
                            const Color(0xFFF7F8FF).withOpacity(0.13),
                      ),
                      pinTheme: pin_code.PinTheme(
                          shape: pin_code.PinCodeFieldShape.underline,
                          borderWidth: 2,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 50,
                          inactiveColor: Colors.grey.shade100,
                          activeColor: Colors.green,
                          selectedColor: Colors.greenAccent,
                          inactiveFillColor: Colors.grey.shade100,
                          activeFillColor: Colors.grey.shade100,
                          selectedFillColor: Colors.grey.shade100),
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
    TextEditingController textEditingController = TextEditingController();
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
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: TextField(
              controller: textEditingController,

              ///Remember to set the read only property of the readOnly
              /// textField to true to prevent the native keyboard from popping up
              readOnly: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w700,
                fontSize: 48,
              ),
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
          Expanded(
              child: CustomKeyBoard(
            controller: textEditingController,
            pinTheme:
                KeyBoardPinTheme(textColor: Colors.red, keysColor: Colors.blue),
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
