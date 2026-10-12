import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'categorias_screen.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Aquí pegamos tu URL real y tu llave Anon Key
  await Supabase.initialize(
    url: 'https://ctfzcjyfsrbimqwkggb.supabase.co',
    anonKey: 'sb_publishable_zByT5mxebwxyFk1AzErifg_hv2P513X',
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
      home: const CategoriasScreen(nombreUsuario: 'Héctor Alexey'),
    );
  }
}