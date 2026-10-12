import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final _supabase = Supabase.instance.client;

  // 1. Obtener los productos desde Supabase
  Future<List<Map<String, dynamic>>> obtenerProductos() async {
    final response = await _supabase.from('PRODUCTOS').select().eq('disponible', true);
    return List<Map<String, dynamic>>.from(response);
  }

  // 2. Registrar un pedido y su detalle en la nube de forma relacional
  Future<void> crearPedido(List<Map<String, dynamic>> itemsCarrito, double total) async {
    // Insertar el pedido maestro (asumimos id_usuario = 1 para la prueba)
    final pedidoRes = await _supabase.from('PEDIDOS').insert({
      'id_usuario': 1,
      'total': total,
      'estado': 'Pendiente',
    }).select().single();

    int idPedido = pedidoRes['id_pedido'];

    // Insertar cada ítem del carrito en la tabla DETALLE_PEDIDO
    for (var item in itemsCarrito) {
      String precioStr = item['precio'].toString().replaceAll('\$', '');
      double precio = double.tryParse(precioStr) ?? 0.0;

      await _supabase.from('DETALLE_PEDIDO').insert({
        'id_pedido': idPedido,
        'id_producto': item['id_producto'] ?? 1,
        'cantidad': item['cantidad'] ?? 1,
        'precio': precio,
      });
    }
  }

  // 3. Obtener los pedidos para el panel del personal
  Future<List<Map<String, dynamic>>> obtenerPedidosPersonal() async {
    final response = await _supabase.from('PEDIDOS').select().order('id_pedido', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  // 4. Actualizar el estado de un pedido desde el panel
  Future<void> actualizarEstadoPedido(int idPedido, String nuevoEstado) async {
    await _supabase.from('PEDIDOS').update({'estado': nuevoEstado}).eq('id_pedido', idPedido);
  }
}