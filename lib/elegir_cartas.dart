import 'package:flutter/material.dart';
import 'memorama_juego.dart';

class ElegirCartasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elegir Número de Cartas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemoramaHomePage(pairs: 8),
                  ),
                );
              },
              child: Text('8 Pares'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemoramaHomePage(pairs: 10),
                  ),
                );
              },
              child: Text('10 Pares'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemoramaHomePage(pairs: 12),
                  ),
                );
              },
              child: Text('12 Pares'),
            ),
          ],
        ),
      ),
    );
  }
}

