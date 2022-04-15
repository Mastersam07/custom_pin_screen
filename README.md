# 💬 custom pin screen

[![codecov](https://codecov.io/gh/Mastersam07/custom_pin_screen/branch/master/graph/badge.svg?token=cf4ny3Dz6B)](https://codecov.io/gh/Mastersam07/custom_pin_screen)
[![CI](https://github.com/mastersam07/custom_pin_screen/workflows/CI/badge.svg?style=flat-square)](https://github.com/mastersam07/custom_pin_screen/workflows/CI/badge.svg?style=flat-square)
[![license](https://img.shields.io/badge/license-MIT-success.svg?style=flat-square)](https://github.com/Mastersam07/livechat/blob/master/LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-success.svg?style=flat-square)](https://github.com/Mastersam07/custom_pin_screen/pulls)
![GitHub contributors](https://img.shields.io/github/contributors/mastersam07/custom_pin_screen?color=success&style=flat-square)
![GitHub last commit](https://img.shields.io/github/last-commit/mastersam07/custom_pin_screen?style=flat-square)

A flutter package to add screens with custom keyboards and pins to your mobile application.

## 🎖 Installing

```yaml
dependencies:
  custom_pin_screen: "^1.4.0"
```

### ⚡️ Import

```dart
import 'package:custom_pin_screen/custom_pin_screen.dart';
```

## 🎮 How To Use

### Dart Usage

- Pin Auth

```dart
onPressed: (){
    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PinAuthentication(
                      onChanged: (v) {
                        if (kDebugMode) {
                          print(v);
                        }
                      },
                      onSpecialKeyTap: () {},
                      specialKey: const SizedBox(),
                      useFingerprint: true,
                      onbuttonClick: () {},
                      submitLabel: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                );
    },
```

- Custom Keyboard

```dart
Column(
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
              child: CustomAppKeyBoard(
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
      )
```

For more info, please, refer to the [`main.dart`](https://github.com/Mastersam07/custom_pin_screen/blob/master/example/lib/main.dart) in the example.

## 📸 ScreenShots

| | |
|------|-------|
|<img src="https://github.com/Mastersam07/custom_pin_screen//raw/master/assets/1.png" width="250">|<img src="https://github.com/Mastersam07/custom_pin_screen//raw/master/assets/2.png" width="250">|

## 🐛 Bugs/Requests

If you encounter any problems feel free to open an issue. If you feel the library is
missing a feature, please raise a ticket on Github and I'll look into it.
Pull request are also welcome.

### ❗️ Note

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## 🤓 Developer(s)

[<img src="https://avatars3.githubusercontent.com/u/31275429?s=460&u=b935d608a06c1604bae1d971e69a731480a27d46&v=4" width="180" />](https://mastersam.tech)
#### **Abada Samuel Oghenero**
<p>
<a href="https://twitter.com/mastersam_"><img src="https://github.com/aritraroy/social-icons/blob/master/twitter-icon.png?raw=true" width="60"></a>
<a href="https://linkedin.com/in/abada-samuel/"><img src="https://github.com/aritraroy/social-icons/blob/master/linkedin-icon.png?raw=true" width="60"></a>
<a href="https://medium.com/@sammytech"><img src="https://github.com/aritraroy/social-icons/blob/master/medium-icon.png?raw=true" width="60"></a>
<a href="https://facebook.com/abada.samueloghenero"><img src="https://github.com/aritraroy/social-icons/blob/master/facebook-icon.png?raw=true" width="60"></a>
</p>

## ⭐️ License

#### <a href="https://github.com/Mastersam07/custom_pin_screen/blob/master/LICENSE">MIT LICENSE</a>