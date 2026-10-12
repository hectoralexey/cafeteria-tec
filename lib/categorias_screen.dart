import 'package:flutter/material.dart';
import 'productos_screen.dart';
import 'carrito_screen.dart';
import 'pedidos_screen.dart';
import 'perfil_screen.dart'; // Importamos la pantalla de perfil

class CategoriasScreen extends StatelessWidget {
  final String nombreUsuario;

  const CategoriasScreen({Key? key, required this.nombreUsuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Cafetería Tec',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black87),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CarritoScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¡Hola, $nombreUsuario!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                Text(
                  '¿Qué te gustaría pedir hoy?',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 20),
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.4,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    _buildCategoryCard('Desayunos', Icons.bakery_dining, Colors.orange, context),
                    _buildCategoryCard('Comidas', Icons.restaurant, Colors.redAccent, context),
                    _buildCategoryCard('Bebidas', Icons.local_cafe, Colors.blue, context),
                    _buildCategoryCard('Snacks', Icons.fastfood, Colors.green, context),
                    _buildCategoryCard('Postres', Icons.cake, Colors.purpleAccent, context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // 0 es Inicio
        selectedItemColor: Colors.blue[800],
        onTap: (index) {
          if (index == 0) {
            // Ya estamos en inicio
          } else if (index == 1) {
            // Navegamos a Pedidos
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PedidosScreen()),
            );
          } else if (index == 2) {
            // Navegamos a Perfil pasando el nombre del usuario
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PerfilScreen(nombreUsuario: nombreUsuario),
              ),
            );
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Pedidos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductosScreen(categoria: title, nombreUsuario: nombreUsuario),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}