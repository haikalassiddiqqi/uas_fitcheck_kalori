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
    color: const Color(0xFF1E1E1E), // Abu-abu gelap premium
    borderRadius: BorderRadius.circular(20),
  ),
  child: Column(
    children: [
      TextField(
        controller: tinggiController,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: "Tinggi Badan (cm)",
          labelStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.height, color: Color(0xFFDEFF9A)), // Ikon warna neon
          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFDEFF9A))),
        ),
      ),
      const SizedBox(height: 20),
      TextField(
        controller: beratController,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: "Berat Badan (kg)",
          labelStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.monitor_weight, color: Color(0xFFDEFF9A)), // Ikon warna neon
          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFDEFF9A))),
        ),
      ),
    ],
  ),
),
              const SizedBox(height: 30),
              ElevatedButton(
              onPressed: () {
                  // 1. Ambil data dari controller DULU
                  double? tinggi = double.tryParse(tinggiController.text);
                  double? berat = double.tryParse(beratController.text);

                  // 2. Baru cek validitas dan hitung
                  if (tinggi != null && berat != null && tinggi > 0) {
                    double tinggiMeter = tinggi / 100;
                    double bmi = berat / (tinggiMeter * tinggiMeter);

                    setState(() {
                      hasilBMI = "BMI Kamu: ${bmi.toStringAsFixed(2)}";
                      
                      if (bmi < 18.5) {
                        kategoriBMI = "Kurus";
                      } else if (bmi >= 18.5 && bmi < 25) {
                        kategoriBMI = "Normal (Ideal)";
                      } else if (bmi >= 25 && bmi < 30) {
                        kategoriBMI = "Overweight (Gemuk)";
                      } else {
                        kategoriBMI = "Obesitas";
                      }
                    });
                    print("Hasil: $hasilBMI | Kategori: $kategoriBMI");
                  } else {
                    setState(() {
                      hasilBMI = "Input tidak valid!";
                      kategoriBMI = "";
                    });
                  }
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
              const SizedBox(height: 20),
             Text(
  hasilBMI,
  style: const TextStyle(
    fontSize: 40, 
    fontWeight: FontWeight.bold, 
    color: Color(0xFFDEFF9A) // Biar angkanya nyala Hijau Stabilo juga!
  ),
),
              const SizedBox(height: 10),
              Text(
                kategoriBMI,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange, // Warna orange biar jelas bedanya
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}