import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  final sovellus = MaterialApp(home: Scaffold(body: Fonttikoko()));
  runApp(sovellus);
}

class Fonttikoko extends StatefulWidget {

  @override
  FonttikokoState createState() => FonttikokoState();
}

class FonttikokoState extends State <Fonttikoko> {
  late double fonttikoko;

  @override
  void initState() {
    super.initState();
    paivita();
  }

  kasvata() async {
    await kasvataFonttikokoa();
    paivita();
  }

  vahenna() async {
    await vahennaFonttikokoa();
    paivita();
  }

  paivita() async {
    fonttikoko = await haeFonttikoko();

    // paivitetaan nakyma
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final kasvataNappi = IconButton(
      icon: const Icon(Icons.add),
      onPressed: kasvata
    );

    final vNappi = IconButton(
      icon: const Icon(Icons.remove),
      onPressed: vahenna
    );

    return Column(children: [
      kasvataNappi, vNappi,
      Text('Lorem Ipsum', style: TextStyle(fontSize: fonttikoko))
    ]);
  }
}

Future<double> haeFonttikoko() async {
  SharedPreferences asetukset = await SharedPreferences.getInstance();
  if (asetukset.containsKey('FONTTIKOKO')) {
    return asetukset.getDouble('FONTTIKOKO')!;
  }

  return 14.0;
}

Future<void> kasvataFonttikokoa() async {
  var koko = await haeFonttikoko();
  SharedPreferences asetukset = await SharedPreferences.getInstance();
  asetukset.setDouble('FONTTIKOKO', koko + 1);
}

Future<void> vahennaFonttikokoa() async {
  var koko = await haeFonttikoko();
  SharedPreferences asetukset = await SharedPreferences.getInstance();
  asetukset.setDouble('FONTTIKOKO', koko - 1);
}