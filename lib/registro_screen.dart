
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _matriculaController = TextEditingController();
  final _correoController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmarPasswordController = TextEditingController();

  bool _cargando = false;
  bool _ocultarPassword = true;
  bool _ocultarConfirmacion = true;

  @override
  void dispose() {
    _nombreController.dispose();
    _matriculaController.dispose();
    _correoController.dispose();
    _passwordController.dispose();
    _confirmarPasswordController.dispose();
    super.dispose();
  }

  void _mostrarMensaje(String mensaje) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }

  Future<void> _crearCuenta() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _cargando = true);

    try {
      final supabase = Supabase.instance.client;

      final nombre = _nombreController.text.trim();
      final matricula = _matriculaController.text.trim();
      final correo = _correoController.text.trim().toLowerCase();
      final password = _passwordController.text;

      // Comprobar si la matrícula ya existe.
      final existente = await supabase
          .from('usuarios')
          .select('matricula')
          .eq('matricula', matricula)
          .maybeSingle();

      if (existente != null) {
        _mostrarMensaje(
          'Esta matrícula ya está registrada.',
        );
        return;
      }

      // Comprobar si el correo ya existe.
      final correoExistente = await supabase
          .from('usuarios')
          .select('correo')
          .eq('correo', correo)
          .maybeSingle();

      if (correoExistente != null) {
        _mostrarMensaje(
          'Este correo ya está registrado.',
        );
        return;
      }

      // Guardar los datos en Supabase.
      await supabase.from('usuarios').insert({
        'nombre': nombre,
        'matricula': matricula,
        'correo': correo,
        'contrasena': password,
        'rol': 'estudiante',
      });

      if (!mounted) return;

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => AlertDialog(
          title: const Text('¡Registro exitoso!'),
          content: const Text(
            'Tu cuenta se guardó correctamente. '
            'Ya puedes iniciar sesión con tu matrícula y contraseña.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );

      if (!mounted) return;

      Navigator.pop(context);
    } on PostgrestException catch (e) {
      debugPrint(
        'Error de Supabase al registrar: ${e.message}',
      );
      debugPrint('Código: ${e.code}');
      debugPrint('Detalle: ${e.details}');
      debugPrint('Sugerencia: ${e.hint}');

      _mostrarMensaje(
        'No se pudo registrar. Revisa los datos obligatorios '
        'y los permisos de la tabla usuarios.',
      );
    } catch (e) {
      debugPrint('Error al registrar: $e');

      _mostrarMensaje(
        'Ocurrió un error al crear la cuenta.',
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
      appBar: AppBar(
        title: const Text('Crear cuenta'),
        backgroundColor: const Color(0xFF6D4C41),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.person_add_alt_1,
                        size: 65,
                        color: Color(0xFF6D4C41),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Registro de estudiante',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),

                      TextFormField(
                        controller: _nombreController,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: 'Nombre completo',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Ingresa tu nombre completo.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _matriculaController,
                        decoration: const InputDecoration(
                          labelText: 'Matrícula',
                          prefixIcon: Icon(Icons.badge),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Ingresa tu matrícula.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _correoController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Correo electrónico',
                          hintText: 'estudiante@ejemplo.com',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          final correo = value?.trim() ?? '';

                          if (correo.isEmpty) {
                            return 'Ingresa tu correo electrónico.';
                          }

                          if (!RegExp(
                            r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                          ).hasMatch(correo)) {
                            return 'Ingresa un correo válido.';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _passwordController,
                        obscureText: _ocultarPassword,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _ocultarPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _ocultarPassword =
                                    !_ocultarPassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'Usa al menos 6 caracteres.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _confirmarPasswordController,
                        obscureText: _ocultarConfirmacion,
                        decoration: InputDecoration(
                          labelText: 'Confirmar contraseña',
                          prefixIcon: const Icon(Icons.lock),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _ocultarConfirmacion
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _ocultarConfirmacion =
                                    !_ocultarConfirmacion;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Las contraseñas no coinciden.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      ElevatedButton(
                        onPressed: _cargando ? null : _crearCuenta,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6D4C41),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                        ),
                        child: _cargando
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text('Crear cuenta'),
                      ),

                      const SizedBox(height: 12),

                      TextButton(
                        onPressed: _cargando
                            ? null
                            : () => Navigator.pop(context),
                        child: const Text(
                          'Ya tengo una cuenta. Iniciar sesión',
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
