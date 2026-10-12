import 'package:flutter/material.dart';
import 'cafeteria_data.dart';
import 'main.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({Key? key}) : super(key: key);

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  // Controla qué vista muestra el panel: 'pedidos' o 'historial'
  String _vistaActual = 'pedidos';

  void _avanzarEstado(Map<String, dynamic> pedido, String nuevoEstado) {
    setState(() {
      pedido['estado'] = nuevoEstado;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filtros de pedidos en tiempo real desde cafeteriaStorage
    final pedidosNuevos = cafeteriaStorage.pedidos.where((p) => p['estado'] == 'Pendiente' || p['estado'] == 'Nuevo').toList();
    final enPreparacion = cafeteriaStorage.pedidos.where((p) => p['estado'] == 'Preparando').toList();
    final listos = cafeteriaStorage.pedidos.where((p) => p['estado'] == 'Listo').toList();
    final entregados = cafeteriaStorage.pedidos.where((p) => p['estado'] == 'Entregado').toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0F2537),
      body: Row(
        children: [
          // Barra lateral izquierda (Sidebar)
          Container(
            width: 220,
            color: const Color(0xFF0A1822),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.local_cafe, color: Colors.orangeAccent, size: 28),
                    SizedBox(width: 10),
                    Text(
                      'Cafetería Tec',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                _buildSidebarItem(Icons.receipt_long, 'Pedidos', _vistaActual == 'pedidos', () {
                  setState(() => _vistaActual = 'pedidos');
                }),
                const SizedBox(height: 10),
                _buildSidebarItem(Icons.history, 'Historial', _vistaActual == 'historial', () {
                  setState(() => _vistaActual = 'historial');
                }),
                const Spacer(),
                const Divider(color: Colors.white24),
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.redAccent),
                  title: const Text('Cerrar sesión', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),

          // Contenido Principal
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _vistaActual == 'pedidos' ? 'Gestión de Pedidos' : 'Historial de Pedidos Entregados',
                        style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh, color: Colors.orangeAccent),
                        tooltip: 'Actualizar vista',
                        onPressed: () => setState(() {}),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: _vistaActual == 'pedidos'
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Columna 1: Pedidos nuevos
                              Expanded(
                                child: _buildKanbanColumn(
                                  titulo: 'Pedidos nuevos (${pedidosNuevos.length})',
                                  colorHeader: Colors.red.shade700,
                                  pedidos: pedidosNuevos,
                                  accionTexto: 'Comenzar preparación',
                                  accionColor: Colors.blue.shade700,
                                  onAccion: (p) => _avanzarEstado(p, 'Preparando'),
                                ),
                              ),
                              const SizedBox(width: 16),

                              // Columna 2: En preparación
                              Expanded(
                                child: _buildKanbanColumn(
                                  titulo: 'En preparación (${enPreparacion.length})',
                                  colorHeader: Colors.amber.shade800,
                                  pedidos: enPreparacion,
                                  accionTexto: 'Pedido listo',
                                  accionColor: Colors.blue.shade700,
                                  onAccion: (p) => _avanzarEstado(p, 'Listo'),
                                ),
                              ),
                              const SizedBox(width: 16),

                              // Columna 3: Listos
                              Expanded(
                                child: _buildKanbanColumn(
                                  titulo: 'Listos (${listos.length})',
                                  colorHeader: Colors.green.shade700,
                                  pedidos: listos,
                                  accionTexto: 'Entregado',
                                  accionColor: Colors.green.shade800,
                                  onAccion: (p) => _avanzarEstado(p, 'Entregado'),
                                ),
                              ),
                              const SizedBox(width: 16),

                              // Columna 4: Entregados
                              Expanded(
                                child: _buildKanbanColumn(
                                  titulo: 'Entregados (${entregados.length})',
                                  colorHeader: Colors.blueGrey.shade700,
                                  pedidos: entregados,
                                  accionTexto: 'Completado',
                                  accionColor: Colors.grey.shade600,
                                  onAccion: null,
                                ),
                              ),
                            ],
                          )
                        : _buildHistorialView(entregados),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String label, bool activo, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: activo ? const Color(0xFF1B3B5B) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: activo ? Colors.white : Colors.white60, size: 20),
        title: Text(label, style: TextStyle(color: activo ? Colors.white : Colors.white60, fontSize: 14, fontWeight: FontWeight.w500)),
        onTap: onTap,
        dense: true,
      ),
    );
  }

  Widget _buildKanbanColumn({
    required String titulo,
    required Color colorHeader,
    required List<Map<String, dynamic>> pedidos,
    required String accionTexto,
    required Color accionColor,
    required Function(Map<String, dynamic>)? onAccion,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF132D42),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: colorHeader,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
            width: double.infinity,
            child: Text(
              titulo,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Expanded(
            child: pedidos.isEmpty
                ? const Center(
                    child: Text('Sin pedidos', style: TextStyle(color: Colors.white38, fontSize: 13)),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: pedidos.length,
                    itemBuilder: (context, index) {
                      final p = pedidos[index];
                      return Card(
                        color: const Color(0xFF1B3B5B),
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(p['id'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                                  Text(p['cliente'] ?? '', style: const TextStyle(color: Colors.orangeAccent, fontSize: 11)),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(p['detalle'], style: const TextStyle(color: Colors.white70, fontSize: 12)),
                              const SizedBox(height: 6),
                              Text('Total: \$${p['total']?.toStringAsFixed(2) ?? '0.00'}', style: const TextStyle(color: Colors.greenAccent, fontSize: 12)),
                              const SizedBox(height: 12),
                              if (onAccion != null)
                                SizedBox(
                                  width: double.infinity,
                                  height: 32,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: accionColor,
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () => onAccion(p),
                                    child: Text(accionTexto, style: const TextStyle(color: Colors.white, fontSize: 11)),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistorialView(List<Map<String, dynamic>> entregados) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF132D42),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: entregados.isEmpty
          ? const Center(child: Text('No hay pedidos en el historial aún.', style: TextStyle(color: Colors.white38)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: entregados.length,
              itemBuilder: (context, index) {
                final p = entregados[index];
                return Card(
                  color: const Color(0xFF1B3B5B),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text('${p['id']} - Cliente: ${p['cliente']}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: Text('Productos: ${p['detalle']} | Total: \$${p['total']?.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white70)),
                    trailing: const Text('Entregado', style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
    );
  }
}