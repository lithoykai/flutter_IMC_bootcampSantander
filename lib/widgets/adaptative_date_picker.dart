import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onChangeDate;

  const AdaptativeDatePicker({super.key, 
    required this.selectedDate,
    required this.onChangeDate,
  });

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      onChangeDate(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2020),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onChangeDate,
            ),
          )
        : SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  // flex: 1,
                  // ignore: unnecessary_null_comparison
                  child: Text(selectedDate == null
                      ? 'Nenhuma data selecionada.'
                      : 'Data Selecionada: ${DateFormat('dd/MM/yy').format(selectedDate)}'),
                ),
                ElevatedButton(
                  onPressed: () => _showDatePicker(context),
                  style: ElevatedButton.styleFrom(
                   
                  ),
                  child: const Text(
                    'Selecionar data',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}