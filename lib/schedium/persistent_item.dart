import 'package:drift/drift.dart';
import 'package:schedium/schedium/drift_converters.dart';

mixin PersistentRow<Ti extends TableInfo<Ti, R>, R> on Insertable<R> {
  List<(DriftSignal, UpdateCompanion<R>)> get columns;
  Expression<bool> filter(Ti t);

  void syncToDB(GeneratedDatabase db, Ti table) {
    for (final (sig, companion) in columns) {
      sig.subscribeToDB(db, table, filter, companion);
    }
  }
}
