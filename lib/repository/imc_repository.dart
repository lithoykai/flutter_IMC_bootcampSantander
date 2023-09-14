import 'package:hive/hive.dart';
import 'package:imc_santander/models/imc.dart';

class IMCRepository {
  late Box? storage;
  IMCRepository({this.storage});
  final List<IMC> _items = [];

  List<IMC> get items => [..._items];

  Future<void> addIMC(IMC imc) async {
    storage = Hive.box('imcValues');

    storage!.add(imc.toJson());
    // storage!.put(imc.toJson());
    _items.add(imc);
  }

  Future<List<IMC>> fetchDatas() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (Hive.isBoxOpen('imcValues')) {
      storage = Hive.box('imcValues');
    } else {
      storage = await Hive.openBox('imcValues');
    }
    var items = storage!.get('imcValues');
    print(storage!.length);
    print(items);
    return _items;
  }
}
