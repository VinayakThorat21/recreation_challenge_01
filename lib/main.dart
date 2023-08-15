import 'package:flutter/material.dart';
import 'package:recreation_challenge_01/screens/connect_with.dart';
import 'package:recreation_challenge_01/screens/welcome_screen.dart';
import 'package:recreation_challenge_01/screens/login_screen.dart';
import 'package:recreation_challenge_01/screens/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const FlashChat(),
  );
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        ConnectWith.id: (context) => const ConnectWith(),
      },
    );
  }
}
