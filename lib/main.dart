import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import "/providers/admin_provider.dart";
import "/providers/complaint_provider.dart";
import "/screens/auth_screen.dart";
import "/screens/homepage_screen.dart";
import "/screens/splash_screen.dart";
import "constants/custom_theme.dart";
import "constants/routes.dart";
import "firebase_options.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ComplaintProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AdminProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin App',
        theme: customTheme,
        onGenerateRoute: (settings) => generateRoute(settings),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
            if (snapshot.hasData) {
              return const HomePageScreen();
            } else {
              return const AuthScreen();
            }
          },
        ),
      ),
    );
  }
}
