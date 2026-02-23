import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class StoreUtils {
  static Future<bool> isStoreOpen(Session session) async {
    var store = await StoreSettings.db.findFirstRow(session);
    if (store == null) {
      return false;
    }
    return store.isOpen;
  }
}
