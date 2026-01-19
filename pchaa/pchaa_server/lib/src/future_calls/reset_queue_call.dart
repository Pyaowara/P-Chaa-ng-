import 'package:serverpod/serverpod.dart';
import '../generated/daily_queue_counters.dart';
import '../utils/thailand_time_utils.dart';

class ResetQueueCall extends FutureCall {
  @override
  Future<void> invoke(Session session, SerializableModel? object) async {
    var date = ThailandTimeUtils.getThailandDate();

    var existingCounter = await DailyQueueCounter.db.findFirstRow(
      session,
      where: (t) => t.queueDate.equals(date),
    );

    if (existingCounter != null) {
      existingCounter.iCount = 0;
      existingCounter.sCount = 0;
      await DailyQueueCounter.db.updateRow(session, existingCounter);
    } else {
      var newCounter = DailyQueueCounter(
        queueDate: date,
        iCount: 0,
        sCount: 0,
      );
      await DailyQueueCounter.db.insert(session, [newCounter]);
    }

    var nextReset = ThailandTimeUtils.getNextThailandMidnight();
    await session.serverpod.futureCallAtTime(
      'resetQueue',
      null,
      nextReset,
      identifier: 'dailyQueueReset',
    );
  }
}
