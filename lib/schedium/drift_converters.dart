import 'package:drift/drift.dart';
import 'package:signals_flutter/signals_core.dart';

class SignalConverter<D, S> extends TypeConverter<DriftSignal<D>, S> {
  final D Function(S) _read;
  final S Function(D) _write;
  const SignalConverter.create(this._read, this._write);

  static SignalConverter<T, T> plain<T extends Object>() =>
      SignalConverter.create((v) => v, (v) => v);

  static SignalConverter<T?, T?> nullable<T extends Object>() =>
      SignalConverter.create((v) => v, (v) => v);

  static SignalConverter<T, String> forEnum<T extends Enum>(List<T> values) =>
      SignalConverter.create((s) => values.byName(s), (d) => d.name);

  @override
  DriftSignal<D> fromSql(S fromDb) => DriftSignal(_read(fromDb));

  @override
  S toSql(DriftSignal<D> value) => _write(value.internalValue);
}

class DriftSignal<T> extends Signal<T> {
  DriftSignal(super.internalValue);

  void Function() subscribeToDB<Ti extends TableInfo<Ti, R>, R>(
    GeneratedDatabase db,
    Ti table,
    Expression<bool> Function(Ti) filter,
    UpdateCompanion<R> companion,
  ) {
    return super.subscribe((_) {
      final stmt = db.update(table)..where(filter);
      stmt.write(companion);
    });
  }

  @override
  bool operator ==(Object other) =>
      other is DriftSignal<T> && other.internalValue == internalValue;

  @override
  int get hashCode => internalValue.hashCode;
}
