import 'package:flutter/material.dart';
import 'carrito_global.dart';
import 'carrito_screen.dart';
import 'pedidos_screen.dart';
import 'perfil_screen.dart'; // Importamos la pantalla de perfil

class ProductosScreen extends StatelessWidget {
  final String categoria;
  final String nombreUsuario; // Recibimos el nombre para mantenerlo en la navegación

  const ProductosScreen({Key? key, required this.categoria, required this.nombreUsuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> obtenerProductos() {
      switch (categoria) {
        case 'Desayunos':
          return [
            {
              'nombre': 'Chilaquiles Verdes o Rojos',
              'descripcion': 'Con pollo, crema, queso fresco y frijoles.',
              'precio': '\$55.00',
              'imagen': Icons.breakfast_dining,
            },
            {
              'nombre': 'Hot Cakes (3 pzas)',
              'descripcion': 'Acompañados de mantequilla y miel de maple.',
              'precio': '\$40.00',
              'imagen': Icons.cake,
            },
            {
              'nombre': 'Huevos Rancheros',
              'descripcion': 'Estrellados sobre tortilla frita con salsa de tomate y frijoles.',
              'precio': '\$48.00',
              'imagen': Icons.egg,
            },
            {
              'nombre': 'Omelette de Jamón y Queso',
              'descripcion': 'Huevos revueltos rellenos de queso Oaxaca y jamón, con pan tostado.',
              'precio': '\$50.00',
              'imagen': Icons.food_bank,
            },
            {
              'nombre': 'Molletes Tradicionales (2 pzas)',
              'descripcion': 'Bolillo untado con frijoles refritos, gratinados con queso y pico de gallo.',
              'precio': '\$35.00',
              'imagen': Icons.bakery_dining,
            },
            {
              'nombre': 'Sincronizadas de Jamón',
              'descripcion': 'Tortillas de harina con queso amarillo, jamón y ensalada ligera.',
              'precio': '\$42.00',
              'imagen': Icons.lunch_dining,
            },
          ];
        case 'Comidas':
          return [
            {
              'nombre': 'Tacos al Pastor',
              'descripcion': 'Orden de 5 tacos con piña, cilantro y cebolla.',
              'precio': '\$45.00',
              'imagen': Icons.fastfood,
            },
            {
              'nombre': 'Pollo a la Plancha',
              'descripcion': 'Pechuga asada acompañada de ensalada y arroz.',
              'precio': '\$65.00',
              'imagen': Icons.restaurant_menu,
            },
            {
              'nombre': 'Milanesa de Res',
              'descripcion': 'Empanizada crujiente con guarnición de papas a la francesa y ensalada.',
              'precio': '\$75.00',
              'imagen': Icons.dinner_dining,
            },
            {
              'nombre': 'Tortas Ahogadas',
              'descripcion': 'Birote salado relleno de carnitas, bañado en salsa picante de jitomate.',
              'precio': '\$60.00',
              'imagen': Icons.lunch_dining,
            },
            {
              'nombre': 'Enchiladas Suizas',
              'descripcion': 'Rellenas de pollo, bañadas en salsa verde cremosa y gratinadas.',
              'precio': '\$70.00',
              'imagen': Icons.room_service,
            },
            {
              'nombre': 'Hamburguesa Clásica con Papas',
              'descripcion': 'Carne de res, queso cheddar, lechuga, jitomate y aderezo de la casa.',
              'precio': '\$80.00',
              'imagen': Icons.fastfood,
            },
          ];
        case 'Bebidas':
          return [
            {
              'nombre': 'Agua de Horchata',
              'descripcion': 'Vaso de agua fresca de sabor natural (500ml).',
              'precio': '\$20.00',
              'imagen': Icons.local_drink,
            },
            {
              'nombre': 'Café Americano',
              'descripcion': 'Café caliente recién filtrado del día.',
              'precio': '\$25.00',
              'imagen': Icons.local_cafe,
            },
            {
              'nombre': 'Café Latte con Vainilla',
              'descripcion': 'Espresso doble con leche vaporizada y un toque de vainilla.',
              'precio': '\$38.00',
              'imagen': Icons.coffee,
            },
            {
              'nombre': 'Licuado de Plátano',
              'descripcion': 'Preparado con leche, plátano fresco y un toque de canela.',
              'precio': '\$30.00',
              'imagen': Icons.local_bar,
            },
            {
              'nombre': 'Agua de Jamaica',
              'descripcion': 'Infusión natural de flor de jamaica bien fría.',
              'precio': '\$20.00',
              'imagen': Icons.water_drop,
            },
            {
              'nombre': 'Refresco de Lata (355ml)',
              'descripcion': 'Elige entre Coca-Cola, Sprite, Fresa o Manzanita.',
              'precio': '\$22.00',
              'imagen': Icons.local_drink,
            },
            {
              'nombre': 'Jugo de Naranja Natural',
              'descripcion': 'Exprimido al momento, vaso de 500ml.',
              'precio': '\$32.00',
              'imagen': Icons.local_florist,
            },
          ];
        case 'Snacks':
          return [
            {
              'nombre': 'Papas Preparadas',
              'descripcion': 'Papas fritas con salsa botanera, limón y sal.',
              'precio': '\$30.00',
              'imagen': Icons.set_meal,
            },
            {
              'nombre': 'Sándwich de Jamón y Queso',
              'descripcion': 'Pan tostado con aderezo, lechuga y jitomate.',
              'precio': '\$35.00',
              'imagen': Icons.lunch_dining,
            },
            {
              'nombre': 'Baguette de Atún',
              'descripcion': 'Pan artesanal con ensalada de atún, mayonesa y pepino.',
              'precio': '\$50.00',
              'imagen': Icons.food_bank,
            },
            {
              'nombre': 'Fruta Picada con Chile y Limón',
              'descripcion': 'Mezcla fresca de sandía, melón, papaya y piña con chilito.',
              'precio': '\$35.00',
              'imagen': Icons.eco,
            },
            {
              'nombre': 'Nachos con Queso Cheddar',
              'descripcion': 'Totopos crujientes bañados en queso fundido y rodajas de jalapeño.',
              'precio': '\$40.00',
              'imagen': Icons.local_pizza,
            },
            {
              'nombre': 'Curly Fries (Papas en espiral)',
              'descripcion': 'Porción de papas sazonadas en espiral bien crujientes.',
              'precio': '\$45.00',
              'imagen': Icons.fastfood,
            },
          ];
        case 'Postres':
          return [
            {
              'nombre': 'Flan Napolitano',
              'descripcion': 'Porción individual de flan casero con cajeta.',
              'precio': '\$28.00',
              'imagen': Icons.icecream,
            },
            {
              'nombre': 'Pastel de Chocolate',
              'descripcion': 'Rebanada de pastel húmedo de chocolate.',
              'precio': '\$38.00',
              'imagen': Icons.cake,
            },
            {
              'nombre': 'Gelatina de Mosaico',
              'descripcion': 'Cubos de gelatina de sabores con crema dulce.',
              'precio': '\$22.00',
              'imagen': Icons.star,
            },
            {
              'nombre': 'Galletas con Chispas de Chocolate (3 pzas)',
              'descripcion': 'Horneadas del día, crujientes por fuera y suaves por dentro.',
              'precio': '\$25.00',
              'imagen': Icons.cookie,
            },
            {
              'nombre': 'Pay de Limón',
              'descripcion': 'Rebanada fría de pay con base de galleta María y crema de limón.',
              'precio': '\$32.00',
              'imagen': Icons.pie_chart,
            },
            {
              'nombre': 'Arroz con Leche',
              'descripcion': 'Postre tradicional espolvoreado con canela molida.',
              'precio': '\$26.00',
              'imagen': Icons.rice_bowl,
            },
          ];
        default:
          return [];
      }
    }

    final List<Map<String, dynamic>> productos = obtenerProductos();

    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          categoria,
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
          padding: EdgeInsets.all(16.0),
          child: productos.isEmpty
              ? Center(child: Text('No hay productos en esta categoría.'))
              : ListView.builder(
                  itemCount: productos.length,
                  itemBuilder: (context, index) {
                    final producto = productos[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(producto['imagen'], color: Colors.blue[800], size: 30),
                        ),
                        title: Text(
                          producto['nombre'],
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text(producto['descripcion']),
                            SizedBox(height: 8),
                            Text(
                              producto['precio'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1B3B5B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            CarritoGlobal.agregarProducto(producto);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('¡${producto['nombre']} agregado al carrito!'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          child: Text('Agregar', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, 
        selectedItemColor: Colors.blue[800],
        onTap: (index) {
          if (index == 0) {
            // Regresar a la pantalla principal de categorías
            Navigator.popUntil(context, (route) => route.isFirst);
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
}