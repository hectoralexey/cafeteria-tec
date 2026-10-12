import 'package:flutter/material.dart';

class PerfilScreen extends StatelessWidget {
  final String nombreUsuario;

  const PerfilScreen({Key? key, required this.nombreUsuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          'Mi Perfil',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView( // Envolvemos con scroll para evitar desbordamientos
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                SizedBox(height: 10),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFF1B3B5B),
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),
                SizedBox(height: 16),
                Text(
                  nombreUsuario,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                SizedBox(height: 6),
                Text(
                  'Estudiante - Cafetería Tec',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 25),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 1,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.school, color: Colors.blue[800]),
                        title: Text('Tipo de cuenta'),
                        subtitle: Text('Estudiante Regular'),
                      ),
                      Divider(height: 1),
                      ListTile(
                        leading: Icon(Icons.payment, color: Colors.green[700]),
                        title: Text('Método de pago preferido'),
                        subtitle: Text('Saldo Tec / Efectivo al recoger'),
                      ),
                      Divider(height: 1),
                      ListTile(
                        leading: Icon(Icons.notifications, color: Colors.orange[800]),
                        title: Text('Notificaciones de pedidos'),
                        subtitle: Text('Activadas'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: Icon(Icons.logout, color: Colors.red),
                    label: Text(
                      'Cerrar Sesión',
                      style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      // Regresa hasta la primera pantalla (Login) limpiando toda la ruta
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}