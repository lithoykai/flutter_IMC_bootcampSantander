import 'package:flutter/material.dart';
import 'package:imc_santander/widgets/adaptative_date_picker.dart';

class IMCForm extends StatefulWidget {
  final void Function(double height, double weight, DateTime date) save;
  const IMCForm(this.save, {super.key});

  @override
  State<IMCForm> createState() => _IMCFormState();
}

class _IMCFormState extends State<IMCForm> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  DateTime _date = DateTime.now();

  _submitForm() {
    final height = double.tryParse(_heightController.text) ?? 0.0;
    final weight = double.tryParse(_weightController.text) ?? 0.0;

    if (height <= 0 || weight <= 0) {
      return;
    }

    widget.save(height, weight, _date);
    _heightController.clear();
    _weightController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              TextField(
                controller: _heightController,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration:
                    const InputDecoration(label: Text('Sua altura atual (m)')),
              ),
              TextField(
                controller: _weightController,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration:
                    const InputDecoration(label: Text('Seu peso atual(kg)')),
              ),
              AdaptativeDatePicker(
                  selectedDate: _date,
                  onChangeDate: (newDate) {
                    setState(() {
                      _date = newDate;
                    });
                  }),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Calcular IMC'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
