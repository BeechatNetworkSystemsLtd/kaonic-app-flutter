import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../objectbox.g.dart';

class StorageService {
  late final Store _store;

  StorageService() {
  }

  Future<void> init() async {
    _store = await openStore(
      directory:
          p.join((await getApplicationDocumentsDirectory()).path, "kaonic_db"),
    );
  }

  Box<T> initRepository<T>() => Box<T>(_store);
}
