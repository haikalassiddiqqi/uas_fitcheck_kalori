import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitCheck',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 🧩 Step 1: Buat controller buat "ngintip" isi TextField
  final TextEditingController tinggiController = TextEditingController();
  final TextEditingController beratController = TextEditingController();
  String hasilBMI = "";
  String kategoriBMI = "";

  String pesanSaran = "";
Color warnaKategori = Colors.white;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
  backgroundColor: Colors.black,
 appBar: AppBar(
        title: const Text(
          "FITCHECK", 
          style: TextStyle(
            color: Color(0xFFDEFF9A), // Ini si Hijau Stabilo-nya
            fontWeight: FontWeight.bold, 
            letterSpacing: 2
          )
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
  body: SingleChildScrollView( // Cukup satu saja di sini
    child: Padding( // Langsung masuk ke Padding
      padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
  'Masukkan Data Tubuh',
  style: TextStyle(
    fontSize: 20, 
    color: Colors.white, // Ini yang bikin tulisannya muncul terang
    fontWeight: FontWeight.bold,
  ),
),
              Container(
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: const Color(0xFF1E1E1E),
    borderRadius: BorderRadius.circular(20),
  ),
  child: Column(
    children: [
      // TextField Tinggi
      TextField(
        controller: tinggiController,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.height, color: Color(0xFFDEFF9A)),
          labelText: "Tinggi Badan (cm)",
          labelStyle: const TextStyle(color: Colors.grey),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white12),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFDEFF9A)),
          ),
        ),
      ),
      const SizedBox(height: 25),
      // TextField Berat
      TextField(
        controller: beratController,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.monitor_weight_outlined, color: Color(0xFFDEFF9A)),
          labelText: "Berat Badan (kg)",
          labelStyle: const TextStyle(color: Colors.grey),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white12),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFDEFF9A)),
          ),
        ),
      ),
    ], // Penutup children (ini yang tadi hilang)
  ), // Penutup Column
), // Penutup Container
  
              const SizedBox(height: 30),
              ElevatedButton(
              onPressed: () {
  // 1. Ambil data dari controller
  double? tinggi = double.tryParse(tinggiController.text);
  double? berat = double.tryParse(beratController.text);

  // 2. Validasi Batas Manusiawi (Tinggi 50-250cm, Berat 10-250kg)
  if (tinggi == null || berat == null || 
      tinggi < 50 || tinggi > 250 || 
      berat < 10 || berat > 250) {
    
    setState(() {
      hasilBMI = "!"; // Tanda peringatan
      kategoriBMI = "Data Tidak Valid ❌";
      pesanSaran = "Pastikan tinggi (50-250 cm) dan berat (10-250 kg) diisi dengan benar ya!";
      warnaKategori = Colors.redAccent;
    });
    return; // Berhenti di sini, jangan lanjut hitung
  }

  // 3. Jika valid, baru hitung
  double tinggiMeter = tinggi / 100;
  double bmi = berat / (tinggiMeter * tinggiMeter);

  setState(() {
    hasilBMI = bmi.toStringAsFixed(2);
    
    if (bmi < 18.5) {
      kategoriBMI = "Underweight (Kurus) ⚠️";
      pesanSaran = "Ayo tambah asupan protein dan kalori sehatmu! Semangat!";
      warnaKategori = Colors.yellow;
    } else if (bmi >= 18.5 && bmi < 25) {
      kategoriBMI = "Normal (Ideal) 👍";
      pesanSaran = "Keren banget! Pertahankan pola hidup sehatmu!";
      warnaKategori = const Color(0xFFDEFF9A); // Hijau Neon
    } else if (bmi >= 25 && bmi < 30) {
      kategoriBMI = "Overweight (Gemuk) 🍎";
      pesanSaran = "Coba kurangi gorengan & mulai rutin olahraga yuk!";
      warnaKategori = Colors.orange;
    } else {
      kategoriBMI = "Obesity (Obesitas) 🚨";
      pesanSaran = "Waspada! Konsultasikan pola makanmu dengan ahli.";
      warnaKategori = Colors.red;
    }
  });
},
               style: ElevatedButton.styleFrom(
  backgroundColor: const Color(0xFFDEFF9A), // Warna Hijau Stabilo
  foregroundColor: Colors.black, // Teks jadi Hitam biar Sangar
  minimumSize: const Size(double.infinity, 55), // Tombol jadi panjang & tebal
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  elevation: 5,
),
child: const Text(
  'HITUNG BMI',
  style: TextStyle(
    fontWeight: FontWeight.bold, 
    fontSize: 18, 
    letterSpacing: 1.5
  ),
),
              ),
             const SizedBox(height: 30), // Memberi jarak lebih lega
const Text(
  "HASIL BMI",
  style: TextStyle(color: Colors.grey, fontSize: 16, letterSpacing: 2),
),
Text(
  hasilBMI,
  style: TextStyle(
    fontSize: 70, 
    fontWeight: FontWeight.bold, 
    color: warnaKategori, // Warna ini akan berubah otomatis (Hijau/Merah)
  ),
),
Text(
  kategoriBMI,
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: warnaKategori, // Senada dengan warna angka di atas
  ),
),
const SizedBox(height: 12),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 30),
  child: Text(
    pesanSaran,
    textAlign: TextAlign.center,
    style: const TextStyle(
      fontSize: 16,
      color: Colors.white70,
      fontStyle: FontStyle.italic,
    ),
  ),
),
            ],
          ),
        ),
      ),
    );
  }
}