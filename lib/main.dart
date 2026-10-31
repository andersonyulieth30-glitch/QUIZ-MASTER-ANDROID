import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const QuizMaster());

const navy = Color(0xFF080D1B);
const panel = Color(0xFF151F38);
const cyan = Color(0xFF39D8FF);
const purple = Color(0xFF9B7BFF);

class QuizQuestion {
  final String es, en;
  final List<String> optionsEs, optionsEn;
  final int answer;
  const QuizQuestion(this.es, this.en, this.optionsEs, this.optionsEn, this.answer);
}

class QuizCategory {
  final String id, es, en;
  final IconData icon;
  final Color color;
  final List<QuizQuestion> questions;
  const QuizCategory(this.id, this.es, this.en, this.icon, this.color, this.questions);
}

const categories = <QuizCategory>[
  QuizCategory('general', 'Cultura general', 'General knowledge', Icons.lightbulb_outline, cyan, [
    QuizQuestion('¿Cuál es el planeta más grande?', 'What is the largest planet?', ['Marte','Júpiter','Venus','Saturno'], ['Mars','Jupiter','Venus','Saturn'], 1),
    QuizQuestion('¿Cuántos lados tiene un hexágono?', 'How many sides does a hexagon have?', ['5','6','7','8'], ['5','6','7','8'], 1),
    QuizQuestion('¿Cuál es la capital de Francia?', 'What is the capital of France?', ['Roma','Madrid','París','Lisboa'], ['Rome','Madrid','Paris','Lisbon'], 2),
    QuizQuestion('¿Cuántos días tiene una semana?', 'How many days are in a week?', ['5','6','7','8'], ['5','6','7','8'], 2),
    QuizQuestion('¿Qué instrumento tiene teclas blancas y negras?', 'Which instrument has black and white keys?', ['Guitarra','Piano','Violín','Flauta'], ['Guitar','Piano','Violin','Flute'], 1),
  ]),
  QuizCategory('science', 'Ciencia', 'Science', Icons.science_outlined, purple, [
    QuizQuestion('¿Qué gas absorben las plantas durante la fotosíntesis?', 'Which gas do plants absorb during photosynthesis?', ['Oxígeno','Nitrógeno','Dióxido de carbono','Hidrógeno'], ['Oxygen','Nitrogen','Carbon dioxide','Hydrogen'], 2),
    QuizQuestion('¿Cuál es el órgano que bombea la sangre?', 'Which organ pumps blood?', ['Pulmón','Corazón','Hígado','Riñón'], ['Lung','Heart','Liver','Kidney'], 1),
    QuizQuestion('¿Cuál es el estado del agua cuando se convierte en hielo?', 'What state is water in when it becomes ice?', ['Líquido','Gaseoso','Sólido','Plasma'], ['Liquid','Gas','Solid','Plasma'], 2),
    QuizQuestion('¿Qué estrella está más cerca de la Tierra?', 'Which star is closest to Earth?', ['Sirio','El Sol','Vega','Polaris'], ['Sirius','The Sun','Vega','Polaris'], 1),
    QuizQuestion('¿Qué parte de la célula contiene gran parte del ADN?', 'Which cell part contains most of its DNA?', ['Núcleo','Membrana','Citoplasma','Pared celular'], ['Nucleus','Membrane','Cytoplasm','Cell wall'], 0),
  ]),
  QuizCategory('geography', 'Geografía', 'Geography', Icons.public, const Color(0xFF55D6A5), [
    QuizQuestion('¿En qué continente está Egipto?', 'Which continent is Egypt in?', ['Asia','Europa','África','Oceanía'], ['Asia','Europe','Africa','Oceania'], 2),
    QuizQuestion('¿Cuál es el océano más grande?', 'What is the largest ocean?', ['Atlántico','Índico','Ártico','Pacífico'], ['Atlantic','Indian','Arctic','Pacific'], 3),
    QuizQuestion('¿Cuál es la capital de Colombia?', 'What is the capital of Colombia?', ['Medellín','Cali','Bogotá','Cartagena'], ['Medellin','Cali','Bogota','Cartagena'], 2),
    QuizQuestion('¿En qué continente está Japón?', 'Which continent is Japan in?', ['Europa','Asia','África','América'], ['Europe','Asia','Africa','America'], 1),
    QuizQuestion('¿Cuál es el desierto cálido más grande del mundo?', 'What is the largest hot desert in the world?', ['Gobi','Sahara','Kalahari','Atacama'], ['Gobi','Sahara','Kalahari','Atacama'], 1),
  ]),
  QuizCategory('math', 'Matemáticas', 'Mathematics', Icons.calculate_outlined, const Color(0xFFFFC857), [
    QuizQuestion('¿Cuánto es 9 × 7?', 'What is 9 × 7?', ['56','63','72','49'], ['56','63','72','49'], 1),
    QuizQuestion('¿Cuánto es 100 ÷ 4?', 'What is 100 ÷ 4?', ['20','25','30','40'], ['20','25','30','40'], 1),
    QuizQuestion('¿Cuál es el resultado de 15 + 28?', 'What is 15 + 28?', ['43','42','45','48'], ['43','42','45','48'], 0),
    QuizQuestion('¿Cuánto es 12²?', 'What is 12 squared?', ['124','144','122','142'], ['124','144','122','142'], 1),
    QuizQuestion('Si tienes 3 paquetes con 8 dulces cada uno, ¿cuántos dulces tienes?', 'If you have 3 packs with 8 sweets each, how many sweets do you have?', ['11','18','24','28'], ['11','18','24','28'], 2),
  ]),
];

class QuizMaster extends StatelessWidget {
  const QuizMaster({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'QUIZ MASTER',
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: navy,
      colorScheme: const ColorScheme.dark(primary: cyan, secondary: purple),
      appBarTheme: const AppBarTheme(backgroundColor: navy, elevation: 0),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
        backgroundColor: cyan, foregroundColor: navy, padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        textStyle: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1))),
    ),
    home: const HomePage(),
  );
}

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
        colors: [Color(0xFF101F3D), navy, Color(0xFF24143D)],
        begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: SafeArea(child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 12, 22, 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Container(width: 8, height: 8, decoration: const BoxDecoration(
                color: Color(0xFF55D6A5), shape: BoxShape.circle)),
              const SizedBox(width: 8),
              const Text('NEXORA GAMES', style: TextStyle(color: Colors.white60,
                fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2)),
            ]),
            OutlinedButton.icon(
              onPressed: () => setState(() => en = !en),
              icon: const Icon(Icons.language_rounded, size: 17),
              label: Text(en ? 'ENGLISH' : 'ESPAÑOL'),
              style: OutlinedButton.styleFrom(foregroundColor: cyan,
                side: BorderSide(color: cyan.withOpacity(.45)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
            ),
          ]),
          const SizedBox(height: 34),
          Center(child: Container(
            width: 220, height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: cyan.withOpacity(.75), width: 2),
              boxShadow: [BoxShadow(color: cyan.withOpacity(.22), blurRadius: 28, spreadRadius: 2)],
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset('assets/mastercito.png', fit: BoxFit.cover, alignment: Alignment.topCenter),
          )),
          const SizedBox(height: 18),
          const Text('QUIZ MASTER 4.0', textAlign: TextAlign.center,
            style: TextStyle(fontSize: 31, fontWeight: FontWeight.w900,
              letterSpacing: 1.8, color: Colors.white, shadows: [Shadow(color: purple, blurRadius: 16)])),
          const SizedBox(height: 8),
          Text(en ? 'THINK FAST. PLAY SMART. WIN BIG.' : 'PIENSA RÁPIDO. JUEGA INTELIGENTE. SUPÉRATE.',
            textAlign: TextAlign.center, style: const TextStyle(color: Colors.white60,
              fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
          const SizedBox(height: 28),
          Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(color: Colors.white.withOpacity(.045),
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: Colors.white.withOpacity(.10))),
            child: Row(children: [
              const Icon(Icons.auto_awesome_rounded, color: Color(0xFFFFC857), size: 22),
              const SizedBox(width: 11),
              Expanded(child: Text(en ? 'Hey bro! I am Mastercito. Ready for a challenge?' : '¡Hola bro! Soy Mastercito. ¿Listo para un gran desafío?',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
            ])),
          const SizedBox(height: 17),
          _homeTile(Icons.person_rounded, en ? 'SINGLE PLAYER' : 'UN JUGADOR',
            en ? 'Choose a category and test yourself' : 'Elige una categoría y demuestra lo que sabes',
            cyan, true, () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => CategoryPage(en: en)))),
          const SizedBox(height: 13),
          _homeTile(Icons.people_alt_rounded, en ? 'TWO PLAYERS' : 'DOS JUGADORES',
            en ? 'Challenge a friend on one device' : 'Reta a un amigo en el mismo dispositivo',
            purple, false, () => _soon()),
          const SizedBox(height: 13),
          _homeTile(Icons.wifi_rounded, en ? 'ONLINE MULTIPLAYER' : 'MULTIJUGADOR ONLINE',
            en ? 'Play with people around the world' : 'Compite con jugadores de todo el mundo',
            const Color(0xFF55D6A5), false, () => _soon()),
          const SizedBox(height: 27),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.shield_moon_outlined, color: Colors.white38, size: 14),
            const SizedBox(width: 7),
            Text(en ? 'VERSION 4.0  •  SHOW THAT YOU ARE A MASTER' : 'VERSIÓN 4.0  •  DEMUESTRA QUE ERES UN MASTER',
              textAlign: TextAlign.center, style: const TextStyle(color: Colors.white38,
                fontSize: 9, letterSpacing: 1.1, fontWeight: FontWeight.w600)),
          ]),
        ]),
      )),
    ),
  );

  Widget _homeTile(IconData icon, String title, String subtitle, Color color,
      bool active, VoidCallback onTap) => Material(
    color: Colors.transparent,
    child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(19),
      child: Ink(decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight,
          colors: [color.withOpacity(.15), panel]),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: color.withOpacity(active ? .75 : .35), width: active ? 1.4 : 1)),
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
          child: Row(children: [
            Container(width: 48, height: 48,
              decoration: BoxDecoration(color: color.withOpacity(.15),
                borderRadius: BorderRadius.circular(14)),
              child: Icon(icon, color: color, size: 27)),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w900,
                letterSpacing: .6, fontSize: 13, color: Colors.white)),
              const SizedBox(height: 5),
              Text(subtitle, style: const TextStyle(color: Colors.white60, fontSize: 11)),
            ])),
            const SizedBox(width: 8),
            active
              ? Icon(Icons.arrow_forward_rounded, color: color, size: 23)
              : Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(color: color.withOpacity(.12),
                    borderRadius: BorderRadius.circular(8)),
                  child: Text(en ? 'SOON' : 'PRONTO', style: TextStyle(color: color,
                    fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: .7))),
          ])),
      )),
  );

  void _soon() => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(en ? 'This mode is coming soon!' : '¡Este modo estará disponible próximamente!')));
}

class CategoryPage extends StatelessWidget {
  final bool en;
  const CategoryPage({super.key, required this.en});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(en ? 'CHOOSE A CATEGORY' : 'ELIGE UNA CATEGORÍA')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(en ? 'What do you want to challenge today?' : '¿Qué quieres poner a prueba hoy?',
        style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8), Text(en ? '5 questions • 15 seconds each' : '5 preguntas • 15 segundos por pregunta',
        style: const TextStyle(color: Colors.white60)),
      const SizedBox(height: 22),
      Expanded(child: ListView.separated(itemCount: categories.length, separatorBuilder: (_, __) => const SizedBox(height: 13),
        itemBuilder: (context, index) {
          final c = categories[index];
          return Material(color: panel, borderRadius: BorderRadius.circular(18), child: InkWell(
            borderRadius: BorderRadius.circular(18), onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => QuizPage(en: en, category: c))),
            child: Container(padding: const EdgeInsets.all(19), decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18), border: Border.all(color: c.color.withOpacity(.45))),
              child: Row(children: [Container(width: 54, height: 54, decoration: BoxDecoration(
                color: c.color.withOpacity(.13), borderRadius: BorderRadius.circular(15)),
                child: Icon(c.icon, color: c.color, size: 29)), const SizedBox(width: 15),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(en ? c.en : c.es, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4), Text(en ? '5 questions' : '5 preguntas', style: const TextStyle(color: Colors.white60, fontSize: 12)),
                ])), Icon(Icons.arrow_forward_ios_rounded, color: c.color, size: 17)])),
          ));
        })),
    ])),
  );
}

class QuizPage extends StatefulWidget {
  final bool en;
  final QuizCategory category;
  const QuizPage({super.key, required this.en, required this.category});
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int i = 0, score = 0, seconds = 15;
  int? chosen;
  bool answered = false;
  Timer? timer;
  QuizQuestion get q => widget.category.questions[i];
  List<String> get options => widget.en ? q.optionsEn : q.optionsEs;

  @override
  void initState() { super.initState(); startTimer(); }
  void startTimer() {
    timer?.cancel(); seconds = 15;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (seconds <= 1) { t.cancel(); next(); }
      else { setState(() => seconds--); }
    });
  }
  void choose(int n) {
    if (answered) return;
    timer?.cancel();
    setState(() { chosen = n; answered = true; if (n == q.answer) score++; });
    Future.delayed(const Duration(milliseconds: 850), () { if (mounted) next(); });
  }
  void next() {
    if (!mounted) return;
    if (i == widget.category.questions.length - 1) {
      timer?.cancel();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ResultPage(
        score: score, en: widget.en, category: widget.category)));
    } else {
      setState(() { i++; chosen = null; answered = false; });
      startTimer();
    }
  }
  @override
  void dispose() { timer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.en ? widget.category.en.toUpperCase() : widget.category.es.toUpperCase())),
    body: Padding(padding: const EdgeInsets.fromLTRB(20, 18, 20, 20), child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('${widget.en ? 'QUESTION' : 'PREGUNTA'} ${i + 1}/${widget.category.questions.length}',
            style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
          Row(children: [const Icon(Icons.timer_outlined, color: cyan, size: 19), const SizedBox(width: 5),
            Text('00:${seconds.toString().padLeft(2, '0')}', style: const TextStyle(color: cyan, fontSize: 19, fontWeight: FontWeight.bold))]),
        ]),
        const SizedBox(height: 13),
        ClipRRect(borderRadius: BorderRadius.circular(10), child: LinearProgressIndicator(
          value: (i + 1) / widget.category.questions.length, minHeight: 7, color: widget.category.color,
          backgroundColor: Colors.white12)),
        const SizedBox(height: 32),
        Text(widget.en ? q.en : q.es,
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold, height: 1.3)),
        const SizedBox(height: 25),
        ...List.generate(4, (n) {
          Color border = Colors.white24, fill = panel;
          if (answered && n == q.answer) { border = Colors.greenAccent; fill = Colors.green.withOpacity(.18); }
          else if (answered && n == chosen) { border = Colors.redAccent; fill = Colors.red.withOpacity(.18); }
          return Padding(padding: const EdgeInsets.only(bottom: 12), child: Material(color: fill,
            borderRadius: BorderRadius.circular(15), child: InkWell(onTap: () => choose(n),
              borderRadius: BorderRadius.circular(15), child: Container(padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: border)),
                child: Row(children: [Container(width: 30, height: 30, alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(9)),
                  child: Text(String.fromCharCode(65 + n), style: const TextStyle(fontWeight: FontWeight.bold))),
                  const SizedBox(width: 13), Expanded(child: Text(options[n], style: const TextStyle(fontSize: 16)))])))));
        }),
        const Spacer(),
        Text('${widget.en ? 'SCORE' : 'PUNTOS'}: $score', textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
      ])),
  );
}

class ResultPage extends StatelessWidget {
  final int score;
  final bool en;
  final QuizCategory category;
  const ResultPage({super.key, required this.score, required this.en, required this.category});
  @override
  Widget build(BuildContext context) {
    final message = score == 5 ? (en ? 'PERFECT SCORE!' : '¡PUNTUACIÓN PERFECTA!')
      : score >= 3 ? (en ? 'GREAT JOB!' : '¡MUY BIEN!') : (en ? 'KEEP PRACTICING!' : '¡SIGUE PRACTICANDO!');
    return Scaffold(body: Container(decoration: const BoxDecoration(gradient: LinearGradient(
      colors: [Color(0xFF14264A), navy, Color(0xFF21143B)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: SafeArea(child: Center(child: Padding(padding: const EdgeInsets.all(28),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.emoji_events_rounded, size: 94, color: Color(0xFFFFC857)),
          const SizedBox(height: 22), Text(en ? 'CHALLENGE COMPLETED' : 'DESAFÍO COMPLETADO',
            textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, letterSpacing: 1.5)),
          const SizedBox(height: 12), Text('$score / 5', style: const TextStyle(
            fontSize: 54, color: cyan, fontWeight: FontWeight.w900)),
          Text(message, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8), Text(en ? category.en : category.es, style: const TextStyle(color: Colors.white60)),
          const SizedBox(height: 34), SizedBox(width: double.infinity, child: ElevatedButton(
            onPressed: () => Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => const HomePage()), (r) => false),
            child: Text(en ? 'BACK TO HOME' : 'VOLVER AL INICIO'))),
        ])),
      )),
    ));
  }
}
