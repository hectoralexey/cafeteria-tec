import 'package:flutter/material.dart';

class MetodoPagoScreen extends StatefulWidget {
  @override
  _MetodoPagoScreenState createState() => _MetodoPagoScreenState();
}

class _MetodoPagoScreenState extends State<MetodoPagoScreen> {
  // Método de pago seleccionado por defecto
  String _metodoSeleccionado = 'Efectivo al recoger';

  final List<Map<String, dynamic>> metodos = [
    {
      'titulo': 'Efectivo al recoger',
      'sub': 'Paga en caja al momento de pasar por tus alimentos.',
      'icono': Icons.money,
    },
    {
      'titulo': 'Saldo Tec',
      'sub': 'Cargo directo a tu cuenta estudiantil digital.',
      'icono': Icons.account_balance_wallet,
    },
    {
      'titulo': 'Tarjeta de Crédito / Débito',
      'sub': 'Pago en línea seguro (Visa, MasterCard).',
      'icono': Icons.credit_card,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          'Seleccionar Método de Pago',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '¿Cómo deseas pagar tu pedido?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800]),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: metodos.length,
                  itemBuilder: (context, index) {
                    final metodo = metodos[index];
                    bool seleccionado = _metodoSeleccionado == metodo['titulo'];
                    return Card(
                      margin: EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: seleccionado ? Color(0xFF1B3B5B) : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      elevation: 1,
                      child: RadioListTile<String>(
                        value: metodo['titulo'],
                        groupValue: _metodoSeleccionado,
                        activeColor: Color(0xFF1B3B5B),
                        onChanged: (value) {
                          setState(() {
                            _metodoSeleccionado = value!;
                          });
                        },
                        title: Text(
                          metodo['titulo'],
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Text(metodo['sub']),
                        secondary: Icon(metodo['icono'], color: Color(0xFF1B3B5B), size: 30),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1B3B5B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Regresamos a la pantalla anterior enviando el método de pago elegido
                    Navigator.pop(context, _metodoSeleccionado);
                  },
                  child: Text(
                    'Confirmar y Continuar',
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}