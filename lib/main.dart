import 'package:flutter/material.dart';
import 'categorias_screen.dart';
import 'registro_screen.dart';
import 'personal_screen.dart';

void main() => runApp(MiCafeteriaApp());

class MiCafeteriaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usuarioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F2537),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Container(
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_cafe, size: 70, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  'Cafetería Tec',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Tu comida, más cerca',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 40),
                TextField(
                  controller: _usuarioController,
                  decoration: InputDecoration(
                    hintText: 'Usuario (matrícula)',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1B3B5B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      String nombre = _usuarioController.text.trim();
                      if (nombre.isEmpty) {
                        nombre = 'Estudiante';
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoriasScreen(nombreUsuario: nombre),
                        ),
                      );
                    },
                    child: Text(
                      'Ingresar',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Botón de Registro
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistroScreen()),
                    );
                  },
                  child: Text(
                    '¿No tienes cuenta? Regístrate',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
                SizedBox(height: 5),
                // Botón de Acceso Personal de Cafetería
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PersonalScreen()),
                    );
                  },
                  child: Text(
                    'Acceso Personal de Cafetería',
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}