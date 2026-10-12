import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'categorias_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usuarioController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _iniciarSesion() async {
    setState(() => _isLoading = true);
    try {
      final inputUsuario = _usuarioController.text.trim();
      final inputPassword = _passwordController.text.trim();

      // Validación temporal de respaldo para entorno Web (evita bloqueos CORS)
      if (inputUsuario == '20260001' && inputPassword == '123456') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CategoriasScreen(nombreUsuario: 'Héctor Alexey'),
          ),
        );
        return;
      }

      // Intento de consulta real a Supabase
      final response = await Supabase.instance.client
          .from('usuarios')
          .select()
          .eq('matricula', inputUsuario)
          .eq('contrasena', inputPassword)
          .maybeSingle();

      if (response != null) {
        String nombreUsuario = response['nombre'];
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CategoriasScreen(nombreUsuario: nombreUsuario),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciales incorrectas. Verifica tus datos.')),
        );
      }
    } catch (e) {
      // Si ocurre un error de red/CORS en el navegador, permitimos el acceso con las credenciales de prueba
      if (_usuarioController.text.trim() == '20260001' && _passwordController.text.trim() == '123456') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CategoriasScreen(nombreUsuario: 'Héctor Alexey'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error de conexión con la nube. Usa tu matrícula y contraseña de prueba.')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F2C59),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.local_cafe, size: 70, color: Colors.white),
                const SizedBox(height: 16),
                const Text(
                  'Cafetería Tec',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Tu comida, más cerca',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 48),
                TextField(
                  controller: _usuarioController,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    hintText: 'Usuario (matrícula)',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : ElevatedButton(
                        onPressed: _iniciarSesion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B3C73),
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
                          'Ingresar',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿No tienes cuenta? ',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Regístrate',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}