// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:schedium/database/tables/tasks_table.drift.dart' as i1;
import 'package:schedium/schedium/drift_converters.dart' as i2;
import 'package:schedium/model/task/task_state.dart' as i3;
import 'package:schedium/database/tables/tasks_table.dart' as i4;

typedef $$TasksTableCreateCompanionBuilder =
    i1.TasksCompanion Function({
      i0.Value<int> id,
      required i2.DriftSignal<String> title,
      i0.Value<i2.DriftSignal<String?>> description,
      required i2.DriftSignal<i3.TaskState> state,
      required i2.DriftSignal<bool> isDeleted,
    });
typedef $$TasksTableUpdateCompanionBuilder =
    i1.TasksCompanion Function({
      i0.Value<int> id,
      i0.Value<i2.DriftSignal<String>> title,
      i0.Value<i2.DriftSignal<String?>> description,
      i0.Value<i2.DriftSignal<i3.TaskState>> state,
      i0.Value<i2.DriftSignal<bool>> isDeleted,
    });

class $$TasksTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnWithTypeConverterFilters<
    i2.DriftSignal<String>,
    i2.DriftSignal<String>,
    String
  >
  get title => $composableBuilder(
    column: $table.title,
    builder: (column) => i0.ColumnWithTypeConverterFilters(column),
  );

  i0.ColumnWithTypeConverterFilters<
    i2.DriftSignal<String?>,
    i2.DriftSignal<String>,
    String
  >
  get description => $composableBuilder(
    column: $table.description,
    builder: (column) => i0.ColumnWithTypeConverterFilters(column),
  );

  i0.ColumnWithTypeConverterFilters<
    i2.DriftSignal<i3.TaskState>,
    i2.DriftSignal<i3.TaskState>,
    String
  >
  get state => $composableBuilder(
    column: $table.state,
    builder: (column) => i0.ColumnWithTypeConverterFilters(column),
  );

  i0.ColumnWithTypeConverterFilters<
    i2.DriftSignal<bool>,
    i2.DriftSignal<bool>,
    bool
  >
  get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => i0.ColumnWithTypeConverterFilters(column),
  );
}

class $$TasksTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $$TasksTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumnWithTypeConverter<i2.DriftSignal<String>, String>
  get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  i0.GeneratedColumnWithTypeConverter<i2.DriftSignal<String?>, String>
  get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  i0.GeneratedColumnWithTypeConverter<i2.DriftSignal<i3.TaskState>, String>
  get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  i0.GeneratedColumnWithTypeConverter<i2.DriftSignal<bool>, bool>
  get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);
}

class $$TasksTableTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.$TasksTable,
          i1.Task,
          i1.$$TasksTableFilterComposer,
          i1.$$TasksTableOrderingComposer,
          i1.$$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (
            i1.Task,
            i0.BaseReferences<i0.GeneratedDatabase, i1.$TasksTable, i1.Task>,
          ),
          i1.Task,
          i0.PrefetchHooks Function()
        > {
  $$TasksTableTableManager(i0.GeneratedDatabase db, i1.$TasksTable table)
    : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                i0.Value<i2.DriftSignal<String>> title =
                    const i0.Value.absent(),
                i0.Value<i2.DriftSignal<String?>> description =
                    const i0.Value.absent(),
                i0.Value<i2.DriftSignal<i3.TaskState>> state =
                    const i0.Value.absent(),
                i0.Value<i2.DriftSignal<bool>> isDeleted =
                    const i0.Value.absent(),
              }) => i1.TasksCompanion(
                id: id,
                title: title,
                description: description,
                state: state,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                required i2.DriftSignal<String> title,
                i0.Value<i2.DriftSignal<String?>> description =
                    const i0.Value.absent(),
                required i2.DriftSignal<i3.TaskState> state,
                required i2.DriftSignal<bool> isDeleted,
              }) => i1.TasksCompanion.insert(
                id: id,
                title: title,
                description: description,
                state: state,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.$TasksTable,
      i1.Task,
      i1.$$TasksTableFilterComposer,
      i1.$$TasksTableOrderingComposer,
      i1.$$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (
        i1.Task,
        i0.BaseReferences<i0.GeneratedDatabase, i1.$TasksTable, i1.Task>,
      ),
      i1.Task,
      i0.PrefetchHooks Function()
    >;

class $TasksTable extends i4.Tasks with i0.TableInfo<$TasksTable, i1.Task> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  @override
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final i0.GeneratedColumnWithTypeConverter<i2.DriftSignal<String>, String>
  title = i0.GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<i2.DriftSignal<String>>(i1.$TasksTable.$convertertitle);
  @override
  late final i0.GeneratedColumnWithTypeConverter<
    i2.DriftSignal<String?>,
    String
  >
  description =
      i0.GeneratedColumn<String>(
        'description',
        aliasedName,
        true,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<i2.DriftSignal<String?>>(
        i1.$TasksTable.$converterdescription,
      );
  @override
  late final i0.GeneratedColumnWithTypeConverter<
    i2.DriftSignal<i3.TaskState>,
    String
  >
  state = i0.GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<i2.DriftSignal<i3.TaskState>>(i1.$TasksTable.$converterstate);
  @override
  late final i0.GeneratedColumnWithTypeConverter<i2.DriftSignal<bool>, bool>
  isDeleted = i0.GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: i0.DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
  ).withConverter<i2.DriftSignal<bool>>(i1.$TasksTable.$converterisDeleted);
  @override
  List<i0.GeneratedColumn> get $columns => [
    id,
    title,
    description,
    state,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.Task> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.Task(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: i1.$TasksTable.$convertertitle.fromSql(
        attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string,
          data['${effectivePrefix}title'],
        )!,
      ),
      description: i1.$TasksTable.$converterdescription.fromSql(
        attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string,
          data['${effectivePrefix}description'],
        ),
      ),
      state: i1.$TasksTable.$converterstate.fromSql(
        attachedDatabase.typeMapping.read(
          i0.DriftSqlType.string,
          data['${effectivePrefix}state'],
        )!,
      ),
      isDeleted: i1.$TasksTable.$converterisDeleted.fromSql(
        attachedDatabase.typeMapping.read(
          i0.DriftSqlType.bool,
          data['${effectivePrefix}is_deleted'],
        )!,
      ),
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }

  static i0.TypeConverter<i2.DriftSignal<String>, String> $convertertitle =
      i2.SignalConverter.plain();
  static i0.TypeConverter<i2.DriftSignal<String?>, String?>
  $converterdescription = i2.SignalConverter.nullable();
  static i0.TypeConverter<i2.DriftSignal<i3.TaskState>, String>
  $converterstate = i2.SignalConverter.forEnum(i3.TaskState.values);
  static i0.TypeConverter<i2.DriftSignal<bool>, bool> $converterisDeleted =
      i2.SignalConverter.plain();
}

class Task extends i0.DataClass implements i0.Insertable<i1.Task> {
  final int id;
  final i2.DriftSignal<String> title;
  final i2.DriftSignal<String?> description;
  final i2.DriftSignal<i3.TaskState> state;
  final i2.DriftSignal<bool> isDeleted;
  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.state,
    required this.isDeleted,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    {
      map['title'] = i0.Variable<String>(
        i1.$TasksTable.$convertertitle.toSql(title),
      );
    }
    {
      map['description'] = i0.Variable<String>(
        i1.$TasksTable.$converterdescription.toSql(description),
      );
    }
    {
      map['state'] = i0.Variable<String>(
        i1.$TasksTable.$converterstate.toSql(state),
      );
    }
    {
      map['is_deleted'] = i0.Variable<bool>(
        i1.$TasksTable.$converterisDeleted.toSql(isDeleted),
      );
    }
    return map;
  }

  i1.TasksCompanion toCompanion(bool nullToAbsent) {
    return i1.TasksCompanion(
      id: i0.Value(id),
      title: i0.Value(title),
      description: i0.Value(description),
      state: i0.Value(state),
      isDeleted: i0.Value(isDeleted),
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<i2.DriftSignal<String>>(json['title']),
      description: serializer.fromJson<i2.DriftSignal<String?>>(
        json['description'],
      ),
      state: serializer.fromJson<i2.DriftSignal<i3.TaskState>>(json['state']),
      isDeleted: serializer.fromJson<i2.DriftSignal<bool>>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<i2.DriftSignal<String>>(title),
      'description': serializer.toJson<i2.DriftSignal<String?>>(description),
      'state': serializer.toJson<i2.DriftSignal<i3.TaskState>>(state),
      'isDeleted': serializer.toJson<i2.DriftSignal<bool>>(isDeleted),
    };
  }

  i1.Task copyWith({
    int? id,
    i2.DriftSignal<String>? title,
    i2.DriftSignal<String?>? description,
    i2.DriftSignal<i3.TaskState>? state,
    i2.DriftSignal<bool>? isDeleted,
  }) => i1.Task(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    state: state ?? this.state,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Task copyWithCompanion(i1.TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      state: data.state.present ? data.state.value : this.state,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('state: $state, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, state, isDeleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.state == this.state &&
          other.isDeleted == this.isDeleted);
}

class TasksCompanion extends i0.UpdateCompanion<i1.Task> {
  final i0.Value<int> id;
  final i0.Value<i2.DriftSignal<String>> title;
  final i0.Value<i2.DriftSignal<String?>> description;
  final i0.Value<i2.DriftSignal<i3.TaskState>> state;
  final i0.Value<i2.DriftSignal<bool>> isDeleted;
  const TasksCompanion({
    this.id = const i0.Value.absent(),
    this.title = const i0.Value.absent(),
    this.description = const i0.Value.absent(),
    this.state = const i0.Value.absent(),
    this.isDeleted = const i0.Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const i0.Value.absent(),
    required i2.DriftSignal<String> title,
    this.description = const i0.Value.absent(),
    required i2.DriftSignal<i3.TaskState> state,
    required i2.DriftSignal<bool> isDeleted,
  }) : title = i0.Value(title),
       state = i0.Value(state),
       isDeleted = i0.Value(isDeleted);
  static i0.Insertable<i1.Task> custom({
    i0.Expression<int>? id,
    i0.Expression<String>? title,
    i0.Expression<String>? description,
    i0.Expression<String>? state,
    i0.Expression<bool>? isDeleted,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (state != null) 'state': state,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  i1.TasksCompanion copyWith({
    i0.Value<int>? id,
    i0.Value<i2.DriftSignal<String>>? title,
    i0.Value<i2.DriftSignal<String?>>? description,
    i0.Value<i2.DriftSignal<i3.TaskState>>? state,
    i0.Value<i2.DriftSignal<bool>>? isDeleted,
  }) {
    return i1.TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      state: state ?? this.state,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = i0.Variable<String>(
        i1.$TasksTable.$convertertitle.toSql(title.value),
      );
    }
    if (description.present) {
      map['description'] = i0.Variable<String>(
        i1.$TasksTable.$converterdescription.toSql(description.value),
      );
    }
    if (state.present) {
      map['state'] = i0.Variable<String>(
        i1.$TasksTable.$converterstate.toSql(state.value),
      );
    }
    if (isDeleted.present) {
      map['is_deleted'] = i0.Variable<bool>(
        i1.$TasksTable.$converterisDeleted.toSql(isDeleted.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('state: $state, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}
