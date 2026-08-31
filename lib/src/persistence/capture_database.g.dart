// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capture_database.dart';

// ignore_for_file: type=lint
class $InstallationsTable extends Installations
    with TableInfo<$InstallationsTable, Installation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstallationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtUtcMicrosMeta =
      const VerificationMeta('createdAtUtcMicros');
  @override
  late final GeneratedColumn<int> createdAtUtcMicros = GeneratedColumn<int>(
    'created_at_utc_micros',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, createdAtUtcMicros];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'installations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Installation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at_utc_micros')) {
      context.handle(
        _createdAtUtcMicrosMeta,
        createdAtUtcMicros.isAcceptableOrUnknown(
          data['created_at_utc_micros']!,
          _createdAtUtcMicrosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMicrosMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Installation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Installation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAtUtcMicros: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_utc_micros'],
      )!,
    );
  }

  @override
  $InstallationsTable createAlias(String alias) {
    return $InstallationsTable(attachedDatabase, alias);
  }
}

class Installation extends DataClass implements Insertable<Installation> {
  final String id;
  final int createdAtUtcMicros;
  const Installation({required this.id, required this.createdAtUtcMicros});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at_utc_micros'] = Variable<int>(createdAtUtcMicros);
    return map;
  }

  InstallationsCompanion toCompanion(bool nullToAbsent) {
    return InstallationsCompanion(
      id: Value(id),
      createdAtUtcMicros: Value(createdAtUtcMicros),
    );
  }

  factory Installation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Installation(
      id: serializer.fromJson<String>(json['id']),
      createdAtUtcMicros: serializer.fromJson<int>(json['createdAtUtcMicros']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAtUtcMicros': serializer.toJson<int>(createdAtUtcMicros),
    };
  }

  Installation copyWith({String? id, int? createdAtUtcMicros}) => Installation(
    id: id ?? this.id,
    createdAtUtcMicros: createdAtUtcMicros ?? this.createdAtUtcMicros,
  );
  Installation copyWithCompanion(InstallationsCompanion data) {
    return Installation(
      id: data.id.present ? data.id.value : this.id,
      createdAtUtcMicros: data.createdAtUtcMicros.present
          ? data.createdAtUtcMicros.value
          : this.createdAtUtcMicros,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Installation(')
          ..write('id: $id, ')
          ..write('createdAtUtcMicros: $createdAtUtcMicros')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAtUtcMicros);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Installation &&
          other.id == this.id &&
          other.createdAtUtcMicros == this.createdAtUtcMicros);
}

class InstallationsCompanion extends UpdateCompanion<Installation> {
  final Value<String> id;
  final Value<int> createdAtUtcMicros;
  final Value<int> rowid;
  const InstallationsCompanion({
    this.id = const Value.absent(),
    this.createdAtUtcMicros = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InstallationsCompanion.insert({
    required String id,
    required int createdAtUtcMicros,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAtUtcMicros = Value(createdAtUtcMicros);
  static Insertable<Installation> custom({
    Expression<String>? id,
    Expression<int>? createdAtUtcMicros,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAtUtcMicros != null)
        'created_at_utc_micros': createdAtUtcMicros,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InstallationsCompanion copyWith({
    Value<String>? id,
    Value<int>? createdAtUtcMicros,
    Value<int>? rowid,
  }) {
    return InstallationsCompanion(
      id: id ?? this.id,
      createdAtUtcMicros: createdAtUtcMicros ?? this.createdAtUtcMicros,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAtUtcMicros.present) {
      map['created_at_utc_micros'] = Variable<int>(createdAtUtcMicros.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InstallationsCompanion(')
          ..write('id: $id, ')
          ..write('createdAtUtcMicros: $createdAtUtcMicros, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RawCaptureRowsTable extends RawCaptureRows
    with TableInfo<$RawCaptureRowsTable, RawCaptureRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RawCaptureRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _captureIdMeta = const VerificationMeta(
    'captureId',
  );
  @override
  late final GeneratedColumn<String> captureId = GeneratedColumn<String>(
    'capture_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rawTextMeta = const VerificationMeta(
    'rawText',
  );
  @override
  late final GeneratedColumn<String> rawText = GeneratedColumn<String>(
    'raw_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceInstallationIdMeta =
      const VerificationMeta('sourceInstallationId');
  @override
  late final GeneratedColumn<String> sourceInstallationId =
      GeneratedColumn<String>(
        'source_installation_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES installations (id)',
        ),
      );
  static const VerificationMeta _capturedAtUtcMicrosMeta =
      const VerificationMeta('capturedAtUtcMicros');
  @override
  late final GeneratedColumn<int> capturedAtUtcMicros = GeneratedColumn<int>(
    'captured_at_utc_micros',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalOffsetMinutesMeta =
      const VerificationMeta('originalOffsetMinutes');
  @override
  late final GeneratedColumn<int> originalOffsetMinutes = GeneratedColumn<int>(
    'original_offset_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceTimeZoneIdMeta = const VerificationMeta(
    'sourceTimeZoneId',
  );
  @override
  late final GeneratedColumn<String> sourceTimeZoneId = GeneratedColumn<String>(
    'source_time_zone_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _visibilityMeta = const VerificationMeta(
    'visibility',
  );
  @override
  late final GeneratedColumn<String> visibility = GeneratedColumn<String>(
    'visibility',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtUtcMicrosMeta =
      const VerificationMeta('createdAtUtcMicros');
  @override
  late final GeneratedColumn<int> createdAtUtcMicros = GeneratedColumn<int>(
    'created_at_utc_micros',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    captureId,
    rawText,
    sourceInstallationId,
    capturedAtUtcMicros,
    originalOffsetMinutes,
    sourceTimeZoneId,
    visibility,
    revision,
    createdAtUtcMicros,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'raw_captures';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawCaptureRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('capture_id')) {
      context.handle(
        _captureIdMeta,
        captureId.isAcceptableOrUnknown(data['capture_id']!, _captureIdMeta),
      );
    } else if (isInserting) {
      context.missing(_captureIdMeta);
    }
    if (data.containsKey('raw_text')) {
      context.handle(
        _rawTextMeta,
        rawText.isAcceptableOrUnknown(data['raw_text']!, _rawTextMeta),
      );
    } else if (isInserting) {
      context.missing(_rawTextMeta);
    }
    if (data.containsKey('source_installation_id')) {
      context.handle(
        _sourceInstallationIdMeta,
        sourceInstallationId.isAcceptableOrUnknown(
          data['source_installation_id']!,
          _sourceInstallationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceInstallationIdMeta);
    }
    if (data.containsKey('captured_at_utc_micros')) {
      context.handle(
        _capturedAtUtcMicrosMeta,
        capturedAtUtcMicros.isAcceptableOrUnknown(
          data['captured_at_utc_micros']!,
          _capturedAtUtcMicrosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_capturedAtUtcMicrosMeta);
    }
    if (data.containsKey('original_offset_minutes')) {
      context.handle(
        _originalOffsetMinutesMeta,
        originalOffsetMinutes.isAcceptableOrUnknown(
          data['original_offset_minutes']!,
          _originalOffsetMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalOffsetMinutesMeta);
    }
    if (data.containsKey('source_time_zone_id')) {
      context.handle(
        _sourceTimeZoneIdMeta,
        sourceTimeZoneId.isAcceptableOrUnknown(
          data['source_time_zone_id']!,
          _sourceTimeZoneIdMeta,
        ),
      );
    }
    if (data.containsKey('visibility')) {
      context.handle(
        _visibilityMeta,
        visibility.isAcceptableOrUnknown(data['visibility']!, _visibilityMeta),
      );
    } else if (isInserting) {
      context.missing(_visibilityMeta);
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    } else if (isInserting) {
      context.missing(_revisionMeta);
    }
    if (data.containsKey('created_at_utc_micros')) {
      context.handle(
        _createdAtUtcMicrosMeta,
        createdAtUtcMicros.isAcceptableOrUnknown(
          data['created_at_utc_micros']!,
          _createdAtUtcMicrosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMicrosMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {captureId};
  @override
  RawCaptureRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawCaptureRow(
      captureId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}capture_id'],
      )!,
      rawText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_text'],
      )!,
      sourceInstallationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_installation_id'],
      )!,
      capturedAtUtcMicros: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}captured_at_utc_micros'],
      )!,
      originalOffsetMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}original_offset_minutes'],
      )!,
      sourceTimeZoneId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_time_zone_id'],
      ),
      visibility: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}visibility'],
      )!,
      revision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision'],
      )!,
      createdAtUtcMicros: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_utc_micros'],
      )!,
    );
  }

  @override
  $RawCaptureRowsTable createAlias(String alias) {
    return $RawCaptureRowsTable(attachedDatabase, alias);
  }
}

class RawCaptureRow extends DataClass implements Insertable<RawCaptureRow> {
  final String captureId;
  final String rawText;
  final String sourceInstallationId;
  final int capturedAtUtcMicros;
  final int originalOffsetMinutes;
  final String? sourceTimeZoneId;
  final String visibility;
  final int revision;
  final int createdAtUtcMicros;
  const RawCaptureRow({
    required this.captureId,
    required this.rawText,
    required this.sourceInstallationId,
    required this.capturedAtUtcMicros,
    required this.originalOffsetMinutes,
    this.sourceTimeZoneId,
    required this.visibility,
    required this.revision,
    required this.createdAtUtcMicros,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['capture_id'] = Variable<String>(captureId);
    map['raw_text'] = Variable<String>(rawText);
    map['source_installation_id'] = Variable<String>(sourceInstallationId);
    map['captured_at_utc_micros'] = Variable<int>(capturedAtUtcMicros);
    map['original_offset_minutes'] = Variable<int>(originalOffsetMinutes);
    if (!nullToAbsent || sourceTimeZoneId != null) {
      map['source_time_zone_id'] = Variable<String>(sourceTimeZoneId);
    }
    map['visibility'] = Variable<String>(visibility);
    map['revision'] = Variable<int>(revision);
    map['created_at_utc_micros'] = Variable<int>(createdAtUtcMicros);
    return map;
  }

  RawCaptureRowsCompanion toCompanion(bool nullToAbsent) {
    return RawCaptureRowsCompanion(
      captureId: Value(captureId),
      rawText: Value(rawText),
      sourceInstallationId: Value(sourceInstallationId),
      capturedAtUtcMicros: Value(capturedAtUtcMicros),
      originalOffsetMinutes: Value(originalOffsetMinutes),
      sourceTimeZoneId: sourceTimeZoneId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceTimeZoneId),
      visibility: Value(visibility),
      revision: Value(revision),
      createdAtUtcMicros: Value(createdAtUtcMicros),
    );
  }

  factory RawCaptureRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawCaptureRow(
      captureId: serializer.fromJson<String>(json['captureId']),
      rawText: serializer.fromJson<String>(json['rawText']),
      sourceInstallationId: serializer.fromJson<String>(
        json['sourceInstallationId'],
      ),
      capturedAtUtcMicros: serializer.fromJson<int>(
        json['capturedAtUtcMicros'],
      ),
      originalOffsetMinutes: serializer.fromJson<int>(
        json['originalOffsetMinutes'],
      ),
      sourceTimeZoneId: serializer.fromJson<String?>(json['sourceTimeZoneId']),
      visibility: serializer.fromJson<String>(json['visibility']),
      revision: serializer.fromJson<int>(json['revision']),
      createdAtUtcMicros: serializer.fromJson<int>(json['createdAtUtcMicros']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'captureId': serializer.toJson<String>(captureId),
      'rawText': serializer.toJson<String>(rawText),
      'sourceInstallationId': serializer.toJson<String>(sourceInstallationId),
      'capturedAtUtcMicros': serializer.toJson<int>(capturedAtUtcMicros),
      'originalOffsetMinutes': serializer.toJson<int>(originalOffsetMinutes),
      'sourceTimeZoneId': serializer.toJson<String?>(sourceTimeZoneId),
      'visibility': serializer.toJson<String>(visibility),
      'revision': serializer.toJson<int>(revision),
      'createdAtUtcMicros': serializer.toJson<int>(createdAtUtcMicros),
    };
  }

  RawCaptureRow copyWith({
    String? captureId,
    String? rawText,
    String? sourceInstallationId,
    int? capturedAtUtcMicros,
    int? originalOffsetMinutes,
    Value<String?> sourceTimeZoneId = const Value.absent(),
    String? visibility,
    int? revision,
    int? createdAtUtcMicros,
  }) => RawCaptureRow(
    captureId: captureId ?? this.captureId,
    rawText: rawText ?? this.rawText,
    sourceInstallationId: sourceInstallationId ?? this.sourceInstallationId,
    capturedAtUtcMicros: capturedAtUtcMicros ?? this.capturedAtUtcMicros,
    originalOffsetMinutes: originalOffsetMinutes ?? this.originalOffsetMinutes,
    sourceTimeZoneId: sourceTimeZoneId.present
        ? sourceTimeZoneId.value
        : this.sourceTimeZoneId,
    visibility: visibility ?? this.visibility,
    revision: revision ?? this.revision,
    createdAtUtcMicros: createdAtUtcMicros ?? this.createdAtUtcMicros,
  );
  RawCaptureRow copyWithCompanion(RawCaptureRowsCompanion data) {
    return RawCaptureRow(
      captureId: data.captureId.present ? data.captureId.value : this.captureId,
      rawText: data.rawText.present ? data.rawText.value : this.rawText,
      sourceInstallationId: data.sourceInstallationId.present
          ? data.sourceInstallationId.value
          : this.sourceInstallationId,
      capturedAtUtcMicros: data.capturedAtUtcMicros.present
          ? data.capturedAtUtcMicros.value
          : this.capturedAtUtcMicros,
      originalOffsetMinutes: data.originalOffsetMinutes.present
          ? data.originalOffsetMinutes.value
          : this.originalOffsetMinutes,
      sourceTimeZoneId: data.sourceTimeZoneId.present
          ? data.sourceTimeZoneId.value
          : this.sourceTimeZoneId,
      visibility: data.visibility.present
          ? data.visibility.value
          : this.visibility,
      revision: data.revision.present ? data.revision.value : this.revision,
      createdAtUtcMicros: data.createdAtUtcMicros.present
          ? data.createdAtUtcMicros.value
          : this.createdAtUtcMicros,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawCaptureRow(')
          ..write('captureId: $captureId, ')
          ..write('rawText: $rawText, ')
          ..write('sourceInstallationId: $sourceInstallationId, ')
          ..write('capturedAtUtcMicros: $capturedAtUtcMicros, ')
          ..write('originalOffsetMinutes: $originalOffsetMinutes, ')
          ..write('sourceTimeZoneId: $sourceTimeZoneId, ')
          ..write('visibility: $visibility, ')
          ..write('revision: $revision, ')
          ..write('createdAtUtcMicros: $createdAtUtcMicros')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    captureId,
    rawText,
    sourceInstallationId,
    capturedAtUtcMicros,
    originalOffsetMinutes,
    sourceTimeZoneId,
    visibility,
    revision,
    createdAtUtcMicros,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawCaptureRow &&
          other.captureId == this.captureId &&
          other.rawText == this.rawText &&
          other.sourceInstallationId == this.sourceInstallationId &&
          other.capturedAtUtcMicros == this.capturedAtUtcMicros &&
          other.originalOffsetMinutes == this.originalOffsetMinutes &&
          other.sourceTimeZoneId == this.sourceTimeZoneId &&
          other.visibility == this.visibility &&
          other.revision == this.revision &&
          other.createdAtUtcMicros == this.createdAtUtcMicros);
}

class RawCaptureRowsCompanion extends UpdateCompanion<RawCaptureRow> {
  final Value<String> captureId;
  final Value<String> rawText;
  final Value<String> sourceInstallationId;
  final Value<int> capturedAtUtcMicros;
  final Value<int> originalOffsetMinutes;
  final Value<String?> sourceTimeZoneId;
  final Value<String> visibility;
  final Value<int> revision;
  final Value<int> createdAtUtcMicros;
  final Value<int> rowid;
  const RawCaptureRowsCompanion({
    this.captureId = const Value.absent(),
    this.rawText = const Value.absent(),
    this.sourceInstallationId = const Value.absent(),
    this.capturedAtUtcMicros = const Value.absent(),
    this.originalOffsetMinutes = const Value.absent(),
    this.sourceTimeZoneId = const Value.absent(),
    this.visibility = const Value.absent(),
    this.revision = const Value.absent(),
    this.createdAtUtcMicros = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RawCaptureRowsCompanion.insert({
    required String captureId,
    required String rawText,
    required String sourceInstallationId,
    required int capturedAtUtcMicros,
    required int originalOffsetMinutes,
    this.sourceTimeZoneId = const Value.absent(),
    required String visibility,
    required int revision,
    required int createdAtUtcMicros,
    this.rowid = const Value.absent(),
  }) : captureId = Value(captureId),
       rawText = Value(rawText),
       sourceInstallationId = Value(sourceInstallationId),
       capturedAtUtcMicros = Value(capturedAtUtcMicros),
       originalOffsetMinutes = Value(originalOffsetMinutes),
       visibility = Value(visibility),
       revision = Value(revision),
       createdAtUtcMicros = Value(createdAtUtcMicros);
  static Insertable<RawCaptureRow> custom({
    Expression<String>? captureId,
    Expression<String>? rawText,
    Expression<String>? sourceInstallationId,
    Expression<int>? capturedAtUtcMicros,
    Expression<int>? originalOffsetMinutes,
    Expression<String>? sourceTimeZoneId,
    Expression<String>? visibility,
    Expression<int>? revision,
    Expression<int>? createdAtUtcMicros,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (captureId != null) 'capture_id': captureId,
      if (rawText != null) 'raw_text': rawText,
      if (sourceInstallationId != null)
        'source_installation_id': sourceInstallationId,
      if (capturedAtUtcMicros != null)
        'captured_at_utc_micros': capturedAtUtcMicros,
      if (originalOffsetMinutes != null)
        'original_offset_minutes': originalOffsetMinutes,
      if (sourceTimeZoneId != null) 'source_time_zone_id': sourceTimeZoneId,
      if (visibility != null) 'visibility': visibility,
      if (revision != null) 'revision': revision,
      if (createdAtUtcMicros != null)
        'created_at_utc_micros': createdAtUtcMicros,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RawCaptureRowsCompanion copyWith({
    Value<String>? captureId,
    Value<String>? rawText,
    Value<String>? sourceInstallationId,
    Value<int>? capturedAtUtcMicros,
    Value<int>? originalOffsetMinutes,
    Value<String?>? sourceTimeZoneId,
    Value<String>? visibility,
    Value<int>? revision,
    Value<int>? createdAtUtcMicros,
    Value<int>? rowid,
  }) {
    return RawCaptureRowsCompanion(
      captureId: captureId ?? this.captureId,
      rawText: rawText ?? this.rawText,
      sourceInstallationId: sourceInstallationId ?? this.sourceInstallationId,
      capturedAtUtcMicros: capturedAtUtcMicros ?? this.capturedAtUtcMicros,
      originalOffsetMinutes:
          originalOffsetMinutes ?? this.originalOffsetMinutes,
      sourceTimeZoneId: sourceTimeZoneId ?? this.sourceTimeZoneId,
      visibility: visibility ?? this.visibility,
      revision: revision ?? this.revision,
      createdAtUtcMicros: createdAtUtcMicros ?? this.createdAtUtcMicros,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (captureId.present) {
      map['capture_id'] = Variable<String>(captureId.value);
    }
    if (rawText.present) {
      map['raw_text'] = Variable<String>(rawText.value);
    }
    if (sourceInstallationId.present) {
      map['source_installation_id'] = Variable<String>(
        sourceInstallationId.value,
      );
    }
    if (capturedAtUtcMicros.present) {
      map['captured_at_utc_micros'] = Variable<int>(capturedAtUtcMicros.value);
    }
    if (originalOffsetMinutes.present) {
      map['original_offset_minutes'] = Variable<int>(
        originalOffsetMinutes.value,
      );
    }
    if (sourceTimeZoneId.present) {
      map['source_time_zone_id'] = Variable<String>(sourceTimeZoneId.value);
    }
    if (visibility.present) {
      map['visibility'] = Variable<String>(visibility.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (createdAtUtcMicros.present) {
      map['created_at_utc_micros'] = Variable<int>(createdAtUtcMicros.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RawCaptureRowsCompanion(')
          ..write('captureId: $captureId, ')
          ..write('rawText: $rawText, ')
          ..write('sourceInstallationId: $sourceInstallationId, ')
          ..write('capturedAtUtcMicros: $capturedAtUtcMicros, ')
          ..write('originalOffsetMinutes: $originalOffsetMinutes, ')
          ..write('sourceTimeZoneId: $sourceTimeZoneId, ')
          ..write('visibility: $visibility, ')
          ..write('revision: $revision, ')
          ..write('createdAtUtcMicros: $createdAtUtcMicros, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$CaptureDatabase extends GeneratedDatabase {
  _$CaptureDatabase(QueryExecutor e) : super(e);
  $CaptureDatabaseManager get managers => $CaptureDatabaseManager(this);
  late final $InstallationsTable installations = $InstallationsTable(this);
  late final $RawCaptureRowsTable rawCaptureRows = $RawCaptureRowsTable(this);
  late final Index rawCapturesOccurrenceIdx = Index(
    'raw_captures_occurrence_idx',
    'CREATE INDEX raw_captures_occurrence_idx ON raw_captures (captured_at_utc_micros, capture_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    installations,
    rawCaptureRows,
    rawCapturesOccurrenceIdx,
  ];
}

typedef $$InstallationsTableCreateCompanionBuilder =
    InstallationsCompanion Function({
      required String id,
      required int createdAtUtcMicros,
      Value<int> rowid,
    });
typedef $$InstallationsTableUpdateCompanionBuilder =
    InstallationsCompanion Function({
      Value<String> id,
      Value<int> createdAtUtcMicros,
      Value<int> rowid,
    });

final class $$InstallationsTableReferences
    extends
        BaseReferences<_$CaptureDatabase, $InstallationsTable, Installation> {
  $$InstallationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$RawCaptureRowsTable, List<RawCaptureRow>>
  _rawCaptureRowsRefsTable(_$CaptureDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.rawCaptureRows,
        aliasName: 'installations__id__raw_captures__source_installation_id',
      );

  $$RawCaptureRowsTableProcessedTableManager get rawCaptureRowsRefs {
    final manager = $$RawCaptureRowsTableTableManager($_db, $_db.rawCaptureRows)
        .filter(
          (f) =>
              f.sourceInstallationId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_rawCaptureRowsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InstallationsTableFilterComposer
    extends Composer<_$CaptureDatabase, $InstallationsTable> {
  $$InstallationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtUtcMicros => $composableBuilder(
    column: $table.createdAtUtcMicros,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> rawCaptureRowsRefs(
    Expression<bool> Function($$RawCaptureRowsTableFilterComposer f) f,
  ) {
    final $$RawCaptureRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rawCaptureRows,
      getReferencedColumn: (t) => t.sourceInstallationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RawCaptureRowsTableFilterComposer(
            $db: $db,
            $table: $db.rawCaptureRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InstallationsTableOrderingComposer
    extends Composer<_$CaptureDatabase, $InstallationsTable> {
  $$InstallationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtUtcMicros => $composableBuilder(
    column: $table.createdAtUtcMicros,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InstallationsTableAnnotationComposer
    extends Composer<_$CaptureDatabase, $InstallationsTable> {
  $$InstallationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get createdAtUtcMicros => $composableBuilder(
    column: $table.createdAtUtcMicros,
    builder: (column) => column,
  );

  Expression<T> rawCaptureRowsRefs<T extends Object>(
    Expression<T> Function($$RawCaptureRowsTableAnnotationComposer a) f,
  ) {
    final $$RawCaptureRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rawCaptureRows,
      getReferencedColumn: (t) => t.sourceInstallationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RawCaptureRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.rawCaptureRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InstallationsTableTableManager
    extends
        RootTableManager<
          _$CaptureDatabase,
          $InstallationsTable,
          Installation,
          $$InstallationsTableFilterComposer,
          $$InstallationsTableOrderingComposer,
          $$InstallationsTableAnnotationComposer,
          $$InstallationsTableCreateCompanionBuilder,
          $$InstallationsTableUpdateCompanionBuilder,
          (Installation, $$InstallationsTableReferences),
          Installation,
          PrefetchHooks Function({bool rawCaptureRowsRefs})
        > {
  $$InstallationsTableTableManager(
    _$CaptureDatabase db,
    $InstallationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InstallationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InstallationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InstallationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> createdAtUtcMicros = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InstallationsCompanion(
                id: id,
                createdAtUtcMicros: createdAtUtcMicros,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int createdAtUtcMicros,
                Value<int> rowid = const Value.absent(),
              }) => InstallationsCompanion.insert(
                id: id,
                createdAtUtcMicros: createdAtUtcMicros,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InstallationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({rawCaptureRowsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (rawCaptureRowsRefs) db.rawCaptureRows,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (rawCaptureRowsRefs)
                    await $_getPrefetchedData<
                      Installation,
                      $InstallationsTable,
                      RawCaptureRow
                    >(
                      currentTable: table,
                      referencedTable: $$InstallationsTableReferences
                          ._rawCaptureRowsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$InstallationsTableReferences(
                            db,
                            table,
                            p0,
                          ).rawCaptureRowsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.sourceInstallationId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$InstallationsTableProcessedTableManager =
    ProcessedTableManager<
      _$CaptureDatabase,
      $InstallationsTable,
      Installation,
      $$InstallationsTableFilterComposer,
      $$InstallationsTableOrderingComposer,
      $$InstallationsTableAnnotationComposer,
      $$InstallationsTableCreateCompanionBuilder,
      $$InstallationsTableUpdateCompanionBuilder,
      (Installation, $$InstallationsTableReferences),
      Installation,
      PrefetchHooks Function({bool rawCaptureRowsRefs})
    >;
typedef $$RawCaptureRowsTableCreateCompanionBuilder =
    RawCaptureRowsCompanion Function({
      required String captureId,
      required String rawText,
      required String sourceInstallationId,
      required int capturedAtUtcMicros,
      required int originalOffsetMinutes,
      Value<String?> sourceTimeZoneId,
      required String visibility,
      required int revision,
      required int createdAtUtcMicros,
      Value<int> rowid,
    });
typedef $$RawCaptureRowsTableUpdateCompanionBuilder =
    RawCaptureRowsCompanion Function({
      Value<String> captureId,
      Value<String> rawText,
      Value<String> sourceInstallationId,
      Value<int> capturedAtUtcMicros,
      Value<int> originalOffsetMinutes,
      Value<String?> sourceTimeZoneId,
      Value<String> visibility,
      Value<int> revision,
      Value<int> createdAtUtcMicros,
      Value<int> rowid,
    });

final class $$RawCaptureRowsTableReferences
    extends
        BaseReferences<_$CaptureDatabase, $RawCaptureRowsTable, RawCaptureRow> {
  $$RawCaptureRowsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $InstallationsTable _sourceInstallationIdTable(_$CaptureDatabase db) =>
      db.installations.createAlias(
        'raw_captures__source_installation_id__installations__id',
      );

  $$InstallationsTableProcessedTableManager get sourceInstallationId {
    final $_column = $_itemColumn<String>('source_installation_id')!;

    final manager = $$InstallationsTableTableManager(
      $_db,
      $_db.installations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _sourceInstallationIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RawCaptureRowsTableFilterComposer
    extends Composer<_$CaptureDatabase, $RawCaptureRowsTable> {
  $$RawCaptureRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get captureId => $composableBuilder(
    column: $table.captureId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawText => $composableBuilder(
    column: $table.rawText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get capturedAtUtcMicros => $composableBuilder(
    column: $table.capturedAtUtcMicros,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get originalOffsetMinutes => $composableBuilder(
    column: $table.originalOffsetMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceTimeZoneId => $composableBuilder(
    column: $table.sourceTimeZoneId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtUtcMicros => $composableBuilder(
    column: $table.createdAtUtcMicros,
    builder: (column) => ColumnFilters(column),
  );

  $$InstallationsTableFilterComposer get sourceInstallationId {
    final $$InstallationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceInstallationId,
      referencedTable: $db.installations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstallationsTableFilterComposer(
            $db: $db,
            $table: $db.installations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RawCaptureRowsTableOrderingComposer
    extends Composer<_$CaptureDatabase, $RawCaptureRowsTable> {
  $$RawCaptureRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get captureId => $composableBuilder(
    column: $table.captureId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawText => $composableBuilder(
    column: $table.rawText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get capturedAtUtcMicros => $composableBuilder(
    column: $table.capturedAtUtcMicros,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get originalOffsetMinutes => $composableBuilder(
    column: $table.originalOffsetMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceTimeZoneId => $composableBuilder(
    column: $table.sourceTimeZoneId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtUtcMicros => $composableBuilder(
    column: $table.createdAtUtcMicros,
    builder: (column) => ColumnOrderings(column),
  );

  $$InstallationsTableOrderingComposer get sourceInstallationId {
    final $$InstallationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceInstallationId,
      referencedTable: $db.installations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstallationsTableOrderingComposer(
            $db: $db,
            $table: $db.installations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RawCaptureRowsTableAnnotationComposer
    extends Composer<_$CaptureDatabase, $RawCaptureRowsTable> {
  $$RawCaptureRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get captureId =>
      $composableBuilder(column: $table.captureId, builder: (column) => column);

  GeneratedColumn<String> get rawText =>
      $composableBuilder(column: $table.rawText, builder: (column) => column);

  GeneratedColumn<int> get capturedAtUtcMicros => $composableBuilder(
    column: $table.capturedAtUtcMicros,
    builder: (column) => column,
  );

  GeneratedColumn<int> get originalOffsetMinutes => $composableBuilder(
    column: $table.originalOffsetMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceTimeZoneId => $composableBuilder(
    column: $table.sourceTimeZoneId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => column,
  );

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumn<int> get createdAtUtcMicros => $composableBuilder(
    column: $table.createdAtUtcMicros,
    builder: (column) => column,
  );

  $$InstallationsTableAnnotationComposer get sourceInstallationId {
    final $$InstallationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceInstallationId,
      referencedTable: $db.installations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstallationsTableAnnotationComposer(
            $db: $db,
            $table: $db.installations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RawCaptureRowsTableTableManager
    extends
        RootTableManager<
          _$CaptureDatabase,
          $RawCaptureRowsTable,
          RawCaptureRow,
          $$RawCaptureRowsTableFilterComposer,
          $$RawCaptureRowsTableOrderingComposer,
          $$RawCaptureRowsTableAnnotationComposer,
          $$RawCaptureRowsTableCreateCompanionBuilder,
          $$RawCaptureRowsTableUpdateCompanionBuilder,
          (RawCaptureRow, $$RawCaptureRowsTableReferences),
          RawCaptureRow,
          PrefetchHooks Function({bool sourceInstallationId})
        > {
  $$RawCaptureRowsTableTableManager(
    _$CaptureDatabase db,
    $RawCaptureRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RawCaptureRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RawCaptureRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RawCaptureRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> captureId = const Value.absent(),
                Value<String> rawText = const Value.absent(),
                Value<String> sourceInstallationId = const Value.absent(),
                Value<int> capturedAtUtcMicros = const Value.absent(),
                Value<int> originalOffsetMinutes = const Value.absent(),
                Value<String?> sourceTimeZoneId = const Value.absent(),
                Value<String> visibility = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<int> createdAtUtcMicros = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RawCaptureRowsCompanion(
                captureId: captureId,
                rawText: rawText,
                sourceInstallationId: sourceInstallationId,
                capturedAtUtcMicros: capturedAtUtcMicros,
                originalOffsetMinutes: originalOffsetMinutes,
                sourceTimeZoneId: sourceTimeZoneId,
                visibility: visibility,
                revision: revision,
                createdAtUtcMicros: createdAtUtcMicros,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String captureId,
                required String rawText,
                required String sourceInstallationId,
                required int capturedAtUtcMicros,
                required int originalOffsetMinutes,
                Value<String?> sourceTimeZoneId = const Value.absent(),
                required String visibility,
                required int revision,
                required int createdAtUtcMicros,
                Value<int> rowid = const Value.absent(),
              }) => RawCaptureRowsCompanion.insert(
                captureId: captureId,
                rawText: rawText,
                sourceInstallationId: sourceInstallationId,
                capturedAtUtcMicros: capturedAtUtcMicros,
                originalOffsetMinutes: originalOffsetMinutes,
                sourceTimeZoneId: sourceTimeZoneId,
                visibility: visibility,
                revision: revision,
                createdAtUtcMicros: createdAtUtcMicros,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RawCaptureRowsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sourceInstallationId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sourceInstallationId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sourceInstallationId,
                        referencedTable: $$RawCaptureRowsTableReferences
                            ._sourceInstallationIdTable(db),
                        referencedColumn: $$RawCaptureRowsTableReferences
                            ._sourceInstallationIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RawCaptureRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$CaptureDatabase,
      $RawCaptureRowsTable,
      RawCaptureRow,
      $$RawCaptureRowsTableFilterComposer,
      $$RawCaptureRowsTableOrderingComposer,
      $$RawCaptureRowsTableAnnotationComposer,
      $$RawCaptureRowsTableCreateCompanionBuilder,
      $$RawCaptureRowsTableUpdateCompanionBuilder,
      (RawCaptureRow, $$RawCaptureRowsTableReferences),
      RawCaptureRow,
      PrefetchHooks Function({bool sourceInstallationId})
    >;

class $CaptureDatabaseManager {
  final _$CaptureDatabase _db;
  $CaptureDatabaseManager(this._db);
  $$InstallationsTableTableManager get installations =>
      $$InstallationsTableTableManager(_db, _db.installations);
  $$RawCaptureRowsTableTableManager get rawCaptureRows =>
      $$RawCaptureRowsTableTableManager(_db, _db.rawCaptureRows);
}
