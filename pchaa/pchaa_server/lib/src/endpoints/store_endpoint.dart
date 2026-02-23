import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../utils/auth_utils.dart';

class StoreEndpoint extends Endpoint {
  Future<StoreSettings> getStoreSettings(Session session) async {
    await AuthUtils.allowedRoles(session, [UserRole.owner]);

    var store = await StoreSettings.db.findFirstRow(session);
    if (store == null) {
      store = StoreSettings(
        isOpen: false,
        openTime: '07:00:00',
        closeTime: '14:00:00',
        autoOpenClose: false,
      );
      store = await StoreSettings.db.insertRow(session, store);
    }
    return store;
  }

  Future<void> updateStoreStatus(
    Session session,
    bool isOpen,
  ) async {
    await AuthUtils.allowedRoles(session, [UserRole.owner]);

    final store = await getStoreSettings(session);
    store.isOpen = isOpen;
    await StoreSettings.db.updateRow(session, store);
  }

  Future<void> updateStoreSettings(
    Session session,
    StoreSettings storeSettings,
  ) async {
    await AuthUtils.allowedRoles(session, [UserRole.owner]);

    final existing = await getStoreSettings(session);
    storeSettings.id = existing.id;
    await StoreSettings.db.updateRow(session, storeSettings);
  }
}
