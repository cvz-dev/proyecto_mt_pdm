// AppProyectoMT.dart
import 'package:flutter/material.dart';

void main() => runApp(AppProyectoMT());

class AppProyectoMT extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mérida, Yucatán",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// Colores de la app
Color verdeHenequen = Color(0xFF2E8B57);
Color blancoMerida = Color(0xFFFAFAFA);
Color grisMaya = Color(0xFF424242);

// Contenido de cada sección (mismo índice en las tres listas)
List<String> titulos = [
  "Paseo de Montejo",
  "Gran Parque La Plancha",
  "Gran Museo del Mundo Maya",
];

List<String> imagenes = [
  "assets/merida/paseo-montejo.png",
  "assets/merida/parque-la-plancha.jpg",
  "assets/merida/museo-maya.jpg",
];

List<String> etiquetas = [
  "Avenida histórica",
  "Parque urbano",
  "Museo",
];

List<String> textos = [
  "Avenida de casonas del siglo XIX inspirada en París.",
  "Antiguos talleres del tren convertidos en parque.",
  "La historia maya en un edificio inspirado en la ceiba.",
];

class _MyHomePageState extends State<MyHomePage> {
  int _seccionActual = 0;

  // Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blancoMerida,
      appBar: AppBar(
        title: Text("Mérida, Yucatán"),
        backgroundColor: verdeHenequen,
        foregroundColor: Colors.white,
      ),
      drawer: _buildDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _buildContenido(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _seccionActual,
        onTap: _cambiarSeccion,
        backgroundColor: Colors.white,
        selectedItemColor: verdeHenequen,
        unselectedItemColor: grisMaya,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.directions_walk), label: "Montejo"),
          BottomNavigationBarItem(icon: Icon(Icons.park), label: "La Plancha"),
          BottomNavigationBarItem(icon: Icon(Icons.museum), label: "Museo Maya"),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: verdeHenequen),
            child: Text(
              "Lugares turísticos de Mérida",
              textScaler: TextScaler.linear(1.5),
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: Icon(Icons.directions_walk),
            title: Text(titulos[0]),
            onTap: () => _seleccionarEnDrawer(0),
          ),
          ListTile(
            leading: Icon(Icons.park),
            title: Text(titulos[1]),
            onTap: () => _seleccionarEnDrawer(1),
          ),
          ListTile(
            leading: Icon(Icons.museum),
            title: Text(titulos[2]),
            onTap: () => _seleccionarEnDrawer(2),
          ),
        ],
      ),
    );
  }

  // Determina la orientación del teléfono
  Widget _buildContenido() {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return _buildHorizontal();
    } else {
      return _buildVertical();
    }
  }

  // Vertical: título arriba a la izquierda y descripción abajo a la derecha
  Widget _buildVertical() {
    return _buildTarjeta(
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTitulo(),
          _buildDescripcion(TextAlign.right, Colors.white, 1.0),
        ],
      ),
    );
  }

  // Horizontal: imagen con el título a la izquierda y descripción afuera a la derecha
  Widget _buildHorizontal() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: _buildTarjeta(
            Align(alignment: Alignment.topLeft, child: _buildTitulo()),
          ),
        ),
        SizedBox(width: 20.0,),
        Expanded(
          flex: 2,
          child: _buildDescripcion(TextAlign.center, grisMaya, 1.2),
        ),
      ],
    );
  }

  // Imagen con esquinas redondeadas y los textos encima
  Widget _buildTarjeta(Widget textos) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        image: DecorationImage(
          image: AssetImage(imagenes[_seccionActual]),
          fit: BoxFit.cover,
          // Oscurece un poco la imagen para que se lea el texto blanco
          colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
        ),
      ),
      child: textos,
    );
  }

  Widget _buildTitulo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          etiquetas[_seccionActual],
          textScaler: TextScaler.linear(1.1),
          style: TextStyle(color: Colors.white),
        ),
        Text(
          titulos[_seccionActual],
          textScaler: TextScaler.linear(1.9),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildDescripcion(TextAlign alineacion, Color color, double tamano) {
    return Text(
      textos[_seccionActual],
      textAlign: alineacion,
      textScaler: TextScaler.linear(tamano),
      style: TextStyle(color: color, fontWeight: FontWeight.w500),
    );
  }

  // Actions
  void _cambiarSeccion(int nuevaSeccion) {
    setState(() {
      _seccionActual = nuevaSeccion;
    });
  }

  void _seleccionarEnDrawer(int seccion) {
    _cambiarSeccion(seccion);
    Navigator.pop(context); // Cierra el Drawer
  }
}
