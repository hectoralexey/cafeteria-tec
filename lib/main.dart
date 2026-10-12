import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_screen.dart'; // Importamos la nueva pantalla de login

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

 await Supabase.initialize(
    url: 'https://ctfzcjyfsrbimqwkggb.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN0ZnpjanlmenNyYmltcXdrZ2diIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTE4MzE5OTQsImV4cCI6MjEwNzQwNzk5NH0.0bm6AzttOccn6Hg0_zfmKFfeGJ6fU8l9-DXsqaa1Xh0',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cafetería Tec',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      ),
      // La app inicia obligatoriamente en el Login
      home: const LoginScreen(),
    );
  }
}