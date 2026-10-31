import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const QuizMaster());

class QuizMaster extends StatelessWidget {
  const QuizMaster({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'QUIZ MASTER',
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF0B1020),
      colorScheme: const ColorScheme.dark(primary: Color(0xFF00C2FF)),
    ),
    home: const HomePage(),
  );
}

const qs = [
  ['¿Cuál es el planeta más grande?', 'What is the largest planet?', ['Marte','Júpiter','Venus','Saturno'], ['Mars','Jupiter','Venus','Saturn'], 1],
  ['¿Cuántos lados tiene un hexágono?', 'How many sides has a hexagon?', ['5','6','7','8'], ['5','6','7','8'], 1],
  ['¿Capital de Francia?', 'Capital of France?', ['Roma','Madrid','París','Lisboa'], ['Rome','Madrid','Paris','Lisbon'], 2],
  ['¿Qué gas usan las plantas en la fotosíntesis?', 'Which gas do plants use for photosynthesis?', ['Oxígeno','Nitrógeno','CO₂','Hidrógeno'], ['Oxygen','Nitrogen','CO₂','Hydrogen'], 2],
  ['¿Cuánto es 9 × 7?', 'What is 9 × 7?', ['56','63','72','49'], ['56','63','72','49'], 1],
  ['¿En qué continente está Egipto?', 'Which continent is Egypt in?', ['Asia','Europa','África','Oceanía'], ['Asia','Europe','Africa','Oceania'], 2],
  ['¿Cuál es el océano más grande?', 'What is the largest ocean?', ['Atlántico','Índico','Ártico','Pacífico'], ['Atlantic','Indian','Arctic','Pacific'], 3],
  ['¿Qué instrumento tiene teclas blancas y negras?', 'Which instrument has black and white keys?', ['Guitarra','Piano','Violín','Flauta'], ['Guitar','Piano','Violin','Flute'], 1],
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  bool en = false;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      decoration: const BoxDecoration(gradient: LinearGradient(
        colors: [Color(0xFF172448), Color(0xFF090D19), Color(0xFF21133B)],
        begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: SafeArea(child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Align(alignment: Alignment.centerRight, child: TextButton(
            onPressed: () => setState(() => en = !en),
            child: Text(en ? 'ENGLISH' : 'ESPAÑOL'))),
          const Spacer(),
          const Icon(Icons.bolt, size: 76, color: Color(0xFF00C2FF)),
          const Text('QUIZ MASTER', textAlign: TextAlign.center,
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900, letterSpacing: 2)),
          const SizedBox(height: 10),
          Text(en ? 'Challenge your mind!' : '¡Desafía tu mente!',
            textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 40),
          _mode(context, Icons.person, en ? 'Single player' : 'Un jugador',
            en ? 'START GAME' : 'COMENZAR', () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => QuizPage(en: en)))),
          const SizedBox(height: 14),
          _mode(context, Icons.people, en ? 'Two players' : 'Dos jugadores',
            en ? 'COMING SOON' : 'PRÓXIMAMENTE', () => _soon(context, en)),
          const SizedBox(height: 14),
          _mode(context, Icons.public, en ? 'Online multiplayer' : 'Multijugador online',
            en ? 'COMING SOON' : 'PRÓXIMAMENTE', () => _soon(context, en)),
          const Spacer(),
          const Text('NEXORA GAMES', textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white38, letterSpacing: 3, fontSize: 11)),
        ]),
      )),
    ),
  );
  void _soon(BuildContext c, bool e) => ScaffoldMessenger.of(c).showSnackBar(
    SnackBar(content: Text(e ? 'Coming soon' : 'Próximamente')));
  Widget _mode(BuildContext c, IconData icon, String title, String sub, VoidCallback tap) =>
    InkWell(onTap: tap, borderRadius: BorderRadius.circular(16), child: Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: const Color(0xFF202A48),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF00C2FF).withOpacity(.5))),
      child: Row(children: [Icon(icon, color: const Color(0xFF00C2FF), size: 28),
        const SizedBox(width: 14), Expanded(child: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold))),
        Text(sub, style: const TextStyle(color: Color(0xFF00C2FF), fontSize: 10))])));
}

class QuizPage extends StatefulWidget {
  final bool en;
  const QuizPage({super.key, required this.en});
  @override
  State<QuizPage> createState() => _QuizPageState();
}
class _QuizPageState extends State<QuizPage> {
  int i = 0, score = 0, seconds = 15;
  int? chosen;
  bool answered = false;
  Timer? timer;
  List get options => qs[i][widget.en ? 3 : 2] as List;
  void startTimer() {
    timer?.cancel(); seconds = 15;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (seconds <= 1) { t.cancel(); next(); }
      else { setState(() => seconds--); }
    });
  }
  @override
  void initState() { super.initState(); startTimer(); }
  void choose(int n) {
    if (answered) return;
    timer?.cancel();
    setState(() { chosen = n; answered = true; if (n == qs[i][4]) score++; });
    Future.delayed(const Duration(milliseconds: 900), () { if (mounted) next(); });
  }
  void next() {
    if (!mounted) return;
    if (i == qs.length - 1) {
      timer?.cancel();
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => ResultPage(score: score, en: widget.en)));
    } else { setState(() { i++; chosen = null; answered = false; }); startTimer(); }
  }
  @override
  void dispose() { timer?.cancel(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('QUIZ MASTER'), backgroundColor: Colors.transparent),
    body: Padding(padding: const EdgeInsets.all(22), child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('${widget.en ? 'QUESTION' : 'PREGUNTA'} ${i+1}/${qs.length}'),
          Text('00:${seconds.toString().padLeft(2,'0')}',
            style: const TextStyle(color: Color(0xFF00C2FF), fontSize: 20))]),
        const SizedBox(height: 12),
        LinearProgressIndicator(value: (i+1)/qs.length, color: const Color(0xFF00C2FF)),
        const SizedBox(height: 32),
        Text(qs[i][widget.en ? 1 : 0] as String,
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        ...List.generate(4, (n) {
          Color border = Colors.white24, fill = const Color(0xFF202A48);
          if (answered && n == qs[i][4]) { border = Colors.greenAccent; fill = Colors.green.withOpacity(.2); }
          else if (answered && n == chosen) { border = Colors.redAccent; fill = Colors.red.withOpacity(.2); }
          return Padding(padding: const EdgeInsets.only(bottom: 12), child: InkWell(
            onTap: () => choose(n), borderRadius: BorderRadius.circular(14),
            child: Container(padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(color: fill, borderRadius: BorderRadius.circular(14),
                border: Border.all(color: border)),
              child: Text('${String.fromCharCode(65+n)}.  ${options[n]}',
                style: const TextStyle(fontSize: 16)))));
        }),
        const Spacer(),
        Text('${widget.en ? 'SCORE' : 'PUNTOS'}: $score', textAlign: TextAlign.center),
      ])),
  );
}

class ResultPage extends StatelessWidget {
  final int score;
  final bool en;
  const ResultPage({super.key, required this.score, required this.en});
  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Padding(
    padding: const EdgeInsets.all(28), child: Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.emoji_events, size: 90, color: Color(0xFFFFC857)),
        const SizedBox(height: 20),
        Text(en ? 'GAME OVER' : '¡JUEGO TERMINADO!',
          style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text('$score / ${qs.length}', style: const TextStyle(
          fontSize: 48, color: Color(0xFF00C2FF), fontWeight: FontWeight.bold)),
        Text(en ? 'Good effort. Try again!' : '¡Buen intento! Vuelve a jugar.'),
        const SizedBox(height: 32),
        SizedBox(width: double.infinity, child: ElevatedButton(
          onPressed: () => Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => const HomePage()), (r) => false),
          child: Text(en ? 'PLAY AGAIN' : 'VOLVER A JUGAR'))),
      ]))),
  );
}
