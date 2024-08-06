import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
    _animation = Tween<Offset>(
      begin: Offset(3, 12),
      end: Offset(3, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> buildSpiralButtons() {
    List<Widget> buttons = [];
    List<Offset> positions = [
      Offset(0, 0),
      Offset(20, -60),
      Offset(-20, -120),
      Offset(20, -180),
      Offset(-20, -240),
      Offset(20, -300),
      Offset(-20, -360),
      Offset(20, -420),
      Offset(-20, -480),
    ];

    for (int i = 0; i < positions.length; i++) {
      buttons.add(Positioned(
        left: MediaQuery.of(context).size.width / 2 + positions[i].dx,
        top: MediaQuery.of(context).size.height / 2 + positions[i].dy,
        child: GestureDetector(
          onTap: () {
            // Navegar a otra página
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondPage(number: i + 1)),
            );
          },
          child: CircleAvatar(
            radius: 20,
            child: Text('${i + 1}'),
          ),
        ),
      ));
    }

    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aqui va el nombre de la leccion'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          // Fondo de gradiente para el atardecer y espacio
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.orange, // Atardecer en la parte inferior
                  Colors.blue,   // Cielo en el medio
                  Colors.black,  // Espacio en la parte superior
                ],
              ),
            ),
          ),
          ListView(
            children: [
              Container(
                height: 1500, // Asegura que el contenido sea desplazable
                child: Stack(
                  children: buildSpiralButtons(),
                ),
              ),
            ],
          ),
          SlideTransition(
            position: _animation,
            child: Positioned(
              bottom: 0,
              left: MediaQuery.of(context).size.width / 2 - 25,
              child: Icon(Icons.rocket, size: 50),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.grey[700],
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.computer, color: Colors.black),
              label: 'Computer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events, color: Colors.black),
              label: 'Awards',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.black),
              label: 'Settings',
            ),
          ],
          onTap: (index) {
            /*switch (index) {
              case 0:
                navigateToPage(context, 'Home');
                break;
              case 1:
                navigateToPage(context, 'Computer');
                break;
              case 2:
                navigateToPage(context, 'Awards');
                break;
              case 3:
                navigateToPage(context, 'Profile');
                break;
              case 4:
                navigateToPage(context, 'Settings');
                break;
            }*/
            // Navegar a la página correspondiente
          },
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final int number;

  SecondPage({required this.number});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page $number'),
      ),
      body: Center(
        child: Text('This is page number $number'),
      ),
    );
  }
}
