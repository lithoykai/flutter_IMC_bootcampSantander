import 'package:hive/hive.dart';
import 'package:imc_santander/models/imc.dart';

class IMCRepository {
  late Box? storage;
  IMCRepository({this.storage});

  Future<void> addIMC(IMC imc) async {
    storage = Hive.box('imcValues');
    storage!.add(imc.toJson());
    fetchDatas();
  }

  Future<void> deleteIMC(var key) async {
    storage!.delete(key);
  }

  Future<List> fetchDatas() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (Hive.isBoxOpen('imcValues')) {
      storage = Hive.box('imcValues');
    } else {
      storage = await Hive.openBox('imcValues');
    }
    final data = storage!.keys.map((key) {
      final item = storage!.get(key);
      return IMC(
          key: key,
          height: item["height"],
          weight: item["weight"],
          date: DateTime.tryParse(item['date']) ?? DateTime.now());
    }).toList();
    return data.reversed.toList();
  }
}
