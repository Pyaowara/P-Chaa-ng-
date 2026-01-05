import 'package:serverpod/serverpod.dart';
import '../generated/daily_queue_counters.dart';
import 'thailand_time_utils.dart';

class QueueUtils {
  static Future<int> getLatestQueue(Session session, String type) async {
    if (type != 'i' && type != 's') {
      throw ArgumentError('Type must be "i" or "s"');
    }

    var date = ThailandTimeUtils.getThailandDate();

    var counter = await DailyQueueCounter.db.findFirstRow(
      session,
      where: (t) => t.queueDate.equals(date),
    );

    if (counter == null) {
      counter = DailyQueueCounter(
        queueDate: date,
        iCount: 0,
        sCount: 0,
      );
      await DailyQueueCounter.db.insert(session, [counter]);
    }

    return type == 'i' ? counter.iCount : counter.sCount;
  }

  static Future<int> newQueue(Session session, String type) async {
    if (type != 'i' && type != 's') {
      throw ArgumentError('Type must be "i" or "s"');
    }

    var date = ThailandTimeUtils.getThailandDate();

    var counter = await DailyQueueCounter.db.findFirstRow(
      session,
      where: (t) => t.queueDate.equals(date),
    );

    if (counter == null) {
      counter = DailyQueueCounter(
        queueDate: date,
        iCount: 0,
        sCount: 0,
      );
      await DailyQueueCounter.db.insert(session, [counter]);
    }

    if (type == 'i') {
      counter.iCount += 1;
    } else {
      counter.sCount += 1;
    }

    await DailyQueueCounter.db.updateRow(session, counter);

    return type == 'i' ? counter.iCount : counter.sCount;
  }
}
