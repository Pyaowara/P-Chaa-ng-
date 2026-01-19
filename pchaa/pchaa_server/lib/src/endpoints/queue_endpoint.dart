import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../utils/thailand_time_utils.dart';

class QueueEndpoint extends Endpoint {
  Future<Map<String, int>> getQueueCounters(Session session) async {
    var date = ThailandTimeUtils.getThailandDate();
    var counter = await DailyQueueCounter.db.findFirstRow(
      session,
      where: (t) => t.queueDate.equals(date),
    );

    if (counter == null) {
      return {'iCount': 0, 'sCount': 0};
    }

    return {'iCount': counter.iCount, 'sCount': counter.sCount};
  }
}
