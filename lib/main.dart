import 'package:flutter/material.dart';
import 'package:imc_santander/models/imc.dart';
import 'package:imc_santander/repository/imc_repository.dart';
import 'package:imc_santander/widgets/imc_form.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'IMC App'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  IMCRepository imcRepository = IMCRepository();
  List<IMC> _imcList = const <IMC>[];

  void _openModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return IMCForm(_addIMC);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchIMCDatas();
  }

  void fetchIMCDatas() async {
    _imcList = await imcRepository.fetchDatas();
    setState(() {});
  }

  _addIMC(double height, double weight, DateTime date) {
    final newIMC = IMC(
      height: height,
      weight: weight,
      date: date,
    );
    setState(() {
      imcRepository.addIMC(newIMC);
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (ctx, i) {
            final imc = _imcList[i];
            return Card(
              elevation: 2,
              child: ListTile(
                leading: Text(
                  DateFormat('MM/y').format(imc.date),
                  style: const TextStyle(fontSize: 15),
                ),
                title: Text(
                  imc.imcValue,
                  style: const TextStyle(fontSize: 15),
                ),
                trailing: Column(
                  children: [
                    const Text('IMC:'),
                    Text(
                      imc.calcIMC().toStringAsFixed(1),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Sua altura: ${imc.height.toStringAsFixed(2)} | Seu peso: ${imc.height.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: _imcList.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openModal,
        tooltip: 'Add new IMC',
        child: const Icon(Icons.add),
      ),
    );
  }
}
