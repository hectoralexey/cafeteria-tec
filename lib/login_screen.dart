
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'categorias_screen.dart';
import 'registro_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _matriculaController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _cargando = false;
  bool _ocultarPassword = true;

  @override
  void dispose() {
    _matriculaController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _mostrarMensaje(String mensaje) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }

  Future<void> _iniciarSesion() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _cargando = true);

    try {
      final supabase = Supabase.instance.client;

      final matricula = _matriculaController.text.trim();
      final password = _passwordController.text;

      // Buscar al estudiante en Supabase.
      final usuario = await supabase
          .from('usuarios')
          .select('matricula, nombre, rol')
          .eq('matricula', matricula)
          .eq('contrasena', password)
          .maybeSingle();

      if (!mounted) return;

      if (usuario == null) {
        _mostrarMensaje(
          'Matrícula o contraseña incorrectas.',
        );
        return;
      }

      final nombreUsuario =
          (usuario['nombre'] ?? 'Estudiante').toString();

      final rol =
          (usuario['rol'] ?? 'estudiante').toString().toLowerCase();

      if (rol == 'personal' || rol == 'empleado') {
        _mostrarMensaje(
          'Tus credenciales son válidas, pero el panel de personal '
          'todavía no está implementado.',
        );
        return;
      }

      // Abrir la pantalla de categorías.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CategoriasScreen(
            nombreUsuario: nombreUsuario,
          ),
        ),
      );
    } on PostgrestException catch (e) {
      debugPrint('Error de Supabase al iniciar sesión: ${e.message}');

      _mostrarMensaje(
        'No se pudo consultar la base de datos. '
        'Revisa los permisos de la tabla usuarios.',
      );
    } catch (e) {
      debugPrint('Error al iniciar sesión: $e');

      _mostrarMensaje(
        'Ocurrió un error al iniciar sesión. Intenta nuevamente.',
      );
    } finally {
      if (mounted) {
        setState(() => _cargando = false);
      }
    }
  }

  void _abrirRegistro() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegistroScreen(),
      ),
    );
  }

  Future<void> _probarConexion() async {
    setState(() => _cargando = true);

    try {
      await Supabase.instance.client
          .from('usuarios')
          .select('matricula')
          .limit(1);

      _mostrarMensaje(
        'Conexión correcta con Supabase.',
      );
    } catch (e) {
      debugPrint('Error al probar Supabase: $e');

      _mostrarMensaje(
        'No se pudo consultar usuarios: $e',
      );
    } finally {
      if (mounted) {
        setState(() => _cargando = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.local_cafe,
                        size: 75,
                        color: Color(0xFF6D4C41),
                      ),
                      const SizedBox(height: 12),

                      const Text(
                        'Cafeteria Tec',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6D4C41),
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Inicia sesión en tu cuenta',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 30),

                      TextFormField(
                        controller: _matriculaController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Matrícula',
                          hintText: 'Ingresa tu matrícula',
                          prefixIcon: Icon(Icons.badge_outlined),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Ingresa tu matrícula.';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      TextFormField(
                        controller: _passwordController,
                        obscureText: _ocultarPassword,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _iniciarSesion(),
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          hintText: 'Ingresa tu contraseña',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            tooltip: _ocultarPassword
                                ? 'Mostrar contraseña'
                                : 'Ocultar contraseña',
                            icon: Icon(
                              _ocultarPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _ocultarPassword = !_ocultarPassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa tu contraseña.';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),

                      ElevatedButton(
                        onPressed: _cargando ? null : _iniciarSesion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6D4C41),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _cargando
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Iniciar sesión',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),

                      const SizedBox(height: 12),

                      OutlinedButton.icon(
                        onPressed: _cargando ? null : _abrirRegistro,
                        icon: const Icon(Icons.person_add_alt_1),
                        label: const Text('Crear una cuenta'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF6D4C41),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          side: const BorderSide(
                            color: Color(0xFF6D4C41),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      TextButton(
                        onPressed: _cargando ? null : _probarConexion,
                        child: const Text(
                          'Probar conexión con Supabase',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
