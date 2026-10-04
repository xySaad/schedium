import 'package:drift/drift.dart';
import 'package:schedium/schedium/persistent_item.dart';
import 'package:signals_flutter/signals_core.dart';

class PersistentListSignal<
  Ti extends TableInfo<Ti, R>,
  R,
  P extends PersistentRow<Ti, R>
>
    extends Signal<List<P>> {
  final GeneratedDatabase db;
  final Ti table;
  final P Function(R) rowToItem;

  PersistentListSignal.loadFromDB(this.db, this.table, this.rowToItem)
    : super([]) {
    db.select(table).get().then((rows) {
      final items = rows.map((r) {
        final item = rowToItem(r);
        item.syncToDB(db, table);
        return item;
      }).toList();
      value = items;
    });
  }

  /// Persistent add
  void add(P item) {
    final Signal<List<P>> self = this;
    self.add(item);
    db.into(table).insert(item);
    item.syncToDB(db, table);
  }
}
