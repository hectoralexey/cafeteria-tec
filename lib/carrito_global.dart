import 'cafeteria_data.dart'; // Importamos la memoria global del personal

class CarritoGlobal {
  // Lista de los productos que están actualmente en el carrito
  static final List<Map<String, dynamic>> items = [];

  // Lista donde se guardarán los pedidos confirmados por el usuario
  static final List<Map<String, dynamic>> pedidosRealizados = [];

  static void agregarProducto(Map<String, dynamic> producto) {
    bool existe = false;
    for (var item in items) {
      if (item['nombre'] == producto['nombre']) {
        item['cantidad'] = (item['cantidad'] ?? 1) + 1;
        existe = true;
        break;
      }
    }
    if (!existe) {
      final nuevoItem = Map<String, dynamic>.from(producto);
      nuevoItem['cantidad'] = 1;
      items.add(nuevoItem);
    }
  }

  static double calcularTotal() {
    double total = 0;
    for (var item in items) {
      String precioStr = item['precio'].toString().replaceAll('\$', '');
      double precio = double.tryParse(precioStr) ?? 0.0;
      int cantidad = item['cantidad'] ?? 1;
      total += precio * cantidad;
    }
    return total;
  }

  // Método para confirmar el pedido actual y pasarlo tanto al historial como al personal
  static void confirmarPedido({String nombreUsuario = "Estudiante"}) {
    if (items.isEmpty) return;

    // Creamos la descripción de los platillos
    String descripcionPlatillos = items.map((item) => "${item['cantidad']}x ${item['nombre']}").join(', ');
    double totalDouble = calcularTotal();
    String totalStr = "\$${totalDouble.toStringAsFixed(2)}";

    // Generamos un ID único basado en el número de pedidos
    String idPedido = "#TEC-${1040 + pedidosRealizados.length}";

    // 1. Guardamos en el historial del alumno (para su pantalla de pedidos)
    pedidosRealizados.insert(0, {
      'idPedido': idPedido,
      'platillos': descripcionPlatillos,
      'total': totalStr,
      'estado': 'Pendiente',
      'fecha': 'Hace un momento',
    });

    // 2. ¡EL PUENTE EN TIEMPO REAL! Lo enviamos al panel del personal
    cafeteriaStorage.pedidos.add({
      'id': idPedido,
      'cliente': nombreUsuario,
      'detalle': descripcionPlatillos,
      'total': totalDouble,
      'estado': 'Pendiente', // Aparecerá automáticamente en la columna de "Pedidos nuevos"
    });

    // Vaciamos el carrito actual
    items.clear();
  }

  static void limpiar() {
    items.clear();
  }
}