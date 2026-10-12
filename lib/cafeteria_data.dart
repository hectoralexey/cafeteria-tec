class CafeteriaData {
  // Singleton para mantener una única instancia en toda la app
  static final CafeteriaData _instance = CafeteriaData._internal();
  factory CafeteriaData() => _instance;
  CafeteriaData._internal();

  // Catálogo inicial vacío o con productos reales que tú definas
  final List<Map<String, dynamic>> productos = [
    {'id': '1', 'nombre': 'Café Americano', 'categoria': 'Bebidas Calientes', 'precio': 25.0, 'disponible': true},
    {'id': '2', 'nombre': 'Cappuccino', 'categoria': 'Bebidas Calientes', 'precio': 35.0, 'disponible': true},
    {'id': '3', 'nombre': 'Sándwich de Jamón', 'categoria': 'Alimentos / Snacks', 'precio': 35.0, 'disponible': true},
    {'id': '4', 'nombre': 'Pay de Limón', 'categoria': 'Postres', 'precio': 30.0, 'disponible': true},
  ];

  // Lista de pedidos en tiempo real
  final List<Map<String, dynamic>> pedidos = [];

  // Métodos para el personal
  void agregarProducto(String nombre, String categoria, double precio) {
    productos.add({
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'nombre': nombre,
      'categoria': categoria,
      'precio': precio,
      'disponible': true,
    });
  }

  void cambiarDisponibilidad(String id, bool estado) {
    final index = productos.indexWhere((p) => p['id'] == id);
    if (index != -1) {
      productos[index]['disponible'] = estado;
    }
  }

  void cambiarEstadoPedido(String id, String nuevoEstado) {
    final index = pedidos.indexWhere((p) => p['id'] == id);
    if (index != -1) {
      pedidos[index]['estado'] = nuevoEstado;
    }
  }
}

// Instancia global accesible en toda la app
final cafeteriaStorage = CafeteriaData();