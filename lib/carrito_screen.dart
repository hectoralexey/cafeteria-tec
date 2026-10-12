import 'package:flutter/material.dart';
import 'carrito_global.dart';
import 'metodo_pago_screen.dart'; // Importamos la pantalla de método de pago

class CarritoScreen extends StatefulWidget {
  @override
  _CarritoScreenState createState() => _CarritoScreenState();
}

class _CarritoScreenState extends State<CarritoScreen> {
  @override
  Widget build(BuildContext context) {
    final items = CarritoGlobal.items;
    final double total = CarritoGlobal.calcularTotal();

    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          'Mi Carrito',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 800),
          padding: EdgeInsets.all(16.0),
          child: items.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Tu carrito está vacío',
                        style: TextStyle(fontSize: 18, color: Colors.grey[600], fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Agrega platillos desde las categorías para comenzar.',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Card(
                            margin: EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 1,
                            child: ListTile(
                              contentPadding: EdgeInsets.all(12),
                              leading: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.orange[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(item['imagen'] ?? Icons.fastfood, color: Colors.orange[800], size: 30),
                              ),
                              title: Text(
                                item['nombre'],
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              subtitle: Text('Cantidad: ${item['cantidad']}'),
                              trailing: Text(
                                item['precio'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[700],
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total a pagar:', style: TextStyle(fontSize: 18, color: Colors.grey[700])),
                              Text(
                                '\$${total.toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1B3B5B),
                              padding: EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            // AQUÍ VA EXACTAMENTE EL CÓDIGO QUE PEDISTE:
                            onPressed: items.isEmpty
                                ? null
                                : () async {
                                    // Abrimos la pantalla de métodos de pago y esperamos a que el usuario elija uno
                                    final metodoElegido = await Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MetodoPagoScreen()),
                                    );

                                    // Si el usuario seleccionó un método y regresó
                                    if (metodoElegido != null) {
                                      setState(() {
                                        CarritoGlobal.confirmarPedido();
                                      });

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('¡Pedido confirmado! Pagas con: $metodoElegido')),
                                      );
                                      
                                      Navigator.pop(context); // Regresa a la pantalla anterior
                                    }
                                  },
                            child: Text(
                              'Confirmar Pedido',
                              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}