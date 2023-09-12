import 'package:imc_santander/models/imc.dart';

class IMCRepository {
  final List<IMC> _items = [];
  List<IMC> get items => [..._items];

  Future<void> addIMC(IMC imc) async {
    _items.add(imc);
  }

  Future<List<IMC>> fetchDatas() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _items;
  }
}
