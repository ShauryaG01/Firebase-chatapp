import 'package:firebase_app/screens/auth_screen.dart';
import 'package:firebase_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Chat',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          backgroundColor: Colors.deepPurple,
          accentColor: Colors.redAccent,
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.deepPurple,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder(
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData){
              return ChatScreen();
            }
            return AuthScreen();
          },
          stream: FirebaseAuth.instance.authStateChanges(),
        )
        // AuthScreen(),
        );
  }
}
