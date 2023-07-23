import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:piano/piano.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    load('assets/piano.sf2');
    super.initState();
  }

  void load(String asset) async {
    FlutterMidi().unmute();
    ByteData byte = await rootBundle.load(asset);
    FlutterMidi().prepare(sf2: byte);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Piano'),
        centerTitle: true,
      ),
      body: InteractivePiano(
        keyWidth: 60,
        noteRange: NoteRange.forClefs([
          Clef.Bass,
          Clef.Alto,
          Clef.Treble,
        ]),
        onNotePositionTapped: (position) {
          FlutterMidi().playMidiNote(midi: position.pitch);
        },
      ),
    );
  }
}
