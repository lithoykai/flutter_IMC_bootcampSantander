import 'package:hive/hive.dart';
import 'package:imc_santander/models/imc.dart';

class IMCRepository {
  late Box? storage;
  IMCRepository({this.storage});
  final List _items = [];

  List<IMC> get items => [..._items];

  Future<void> addIMC(IMC imc) async {
    storage = Hive.box('imcValues');

    storage!.add(imc.toJson());
    // storage!.put(imc.toJson());
    _items.add(imc);
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

      return {
        "key": key,
        "height": item["height"],
        "weight": item['weight'],
        'date': DateTime.parse(item['date'])
      };
    }).toList();

    return data.reversed.toList();
  }
}
