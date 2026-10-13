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
  static const VerificationMeta _payloadKindMeta = const VerificationMeta(
    'payloadKind',
  );
  @override
  late final GeneratedColumn<String> payloadKind = GeneratedColumn<String>(
    'payload_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('text'),
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
    payloadKind,
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
    if (data.containsKey('payload_kind')) {
      context.handle(
        _payloadKindMeta,
        payloadKind.isAcceptableOrUnknown(
          data['payload_kind']!,
          _payloadKindMeta,
        ),
      );
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
      payloadKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_kind'],
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
  final String payloadKind;
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
    required this.payloadKind,
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
    map['payload_kind'] = Variable<String>(payloadKind);
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
      payloadKind: Value(payloadKind),
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
      payloadKind: serializer.fromJson<String>(json['payloadKind']),
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
      'payloadKind': serializer.toJson<String>(payloadKind),
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
    String? payloadKind,
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
    payloadKind: payloadKind ?? this.payloadKind,
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
      payloadKind: data.payloadKind.present
          ? data.payloadKind.value
          : this.payloadKind,
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
          ..write('payloadKind: $payloadKind, ')
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
    payloadKind,
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
          other.payloadKind == this.payloadKind &&
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
  final Value<String> payloadKind;
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
    this.payloadKind = const Value.absent(),
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
    this.payloadKind = const Value.absent(),
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
    Expression<String>? payloadKind,
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
      if (payloadKind != null) 'payload_kind': payloadKind,
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
    Value<String>? payloadKind,
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
      payloadKind: payloadKind ?? this.payloadKind,
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
    if (payloadKind.present) {
      map['payload_kind'] = Variable<String>(payloadKind.value);
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
          ..write('payloadKind: $payloadKind, ')
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

class $RawMediaRowsTable extends RawMediaRows
    with TableInfo<$RawMediaRowsTable, RawMediaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RawMediaRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _mediaIdMeta = const VerificationMeta(
    'mediaId',
  );
  @override
  late final GeneratedColumn<String> mediaId = GeneratedColumn<String>(
    'media_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
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
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES raw_captures (capture_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _relativePathMeta = const VerificationMeta(
    'relativePath',
  );
  @override
  late final GeneratedColumn<String> relativePath = GeneratedColumn<String>(
    'relative_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  @override
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
    'sha256',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _byteLengthMeta = const VerificationMeta(
    'byteLength',
  );
  @override
  late final GeneratedColumn<int> byteLength = GeneratedColumn<int>(
    'byte_length',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _codecMeta = const VerificationMeta('codec');
  @override
  late final GeneratedColumn<String> codec = GeneratedColumn<String>(
    'codec',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMillisMeta = const VerificationMeta(
    'durationMillis',
  );
  @override
  late final GeneratedColumn<int> durationMillis = GeneratedColumn<int>(
    'duration_millis',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
    mediaId,
    captureId,
    relativePath,
    sha256,
    byteLength,
    mimeType,
    codec,
    durationMillis,
    createdAtUtcMicros,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'raw_media';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawMediaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('media_id')) {
      context.handle(
        _mediaIdMeta,
        mediaId.isAcceptableOrUnknown(data['media_id']!, _mediaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mediaIdMeta);
    }
    if (data.containsKey('capture_id')) {
      context.handle(
        _captureIdMeta,
        captureId.isAcceptableOrUnknown(data['capture_id']!, _captureIdMeta),
      );
    } else if (isInserting) {
      context.missing(_captureIdMeta);
    }
    if (data.containsKey('relative_path')) {
      context.handle(
        _relativePathMeta,
        relativePath.isAcceptableOrUnknown(
          data['relative_path']!,
          _relativePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relativePathMeta);
    }
    if (data.containsKey('sha256')) {
      context.handle(
        _sha256Meta,
        sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta),
      );
    } else if (isInserting) {
      context.missing(_sha256Meta);
    }
    if (data.containsKey('byte_length')) {
      context.handle(
        _byteLengthMeta,
        byteLength.isAcceptableOrUnknown(data['byte_length']!, _byteLengthMeta),
      );
    } else if (isInserting) {
      context.missing(_byteLengthMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    }
    if (data.containsKey('codec')) {
      context.handle(
        _codecMeta,
        codec.isAcceptableOrUnknown(data['codec']!, _codecMeta),
      );
    }
    if (data.containsKey('duration_millis')) {
      context.handle(
        _durationMillisMeta,
        durationMillis.isAcceptableOrUnknown(
          data['duration_millis']!,
          _durationMillisMeta,
        ),
      );
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
  Set<GeneratedColumn> get $primaryKey => {mediaId};
  @override
  RawMediaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawMediaRow(
      mediaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_id'],
      )!,
      captureId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}capture_id'],
      )!,
      relativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_path'],
      )!,
      sha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256'],
      )!,
      byteLength: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}byte_length'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      ),
      codec: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}codec'],
      ),
      durationMillis: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_millis'],
      ),
      createdAtUtcMicros: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_utc_micros'],
      )!,
    );
  }

  @override
  $RawMediaRowsTable createAlias(String alias) {
    return $RawMediaRowsTable(attachedDatabase, alias);
  }
}

class RawMediaRow extends DataClass implements Insertable<RawMediaRow> {
  final String mediaId;
  final String captureId;
  final String relativePath;
  final String sha256;
  final int byteLength;
  final String? mimeType;
  final String? codec;
  final int? durationMillis;
  final int createdAtUtcMicros;
  const RawMediaRow({
    required this.mediaId,
    required this.captureId,
    required this.relativePath,
    required this.sha256,
    required this.byteLength,
    this.mimeType,
    this.codec,
    this.durationMillis,
    required this.createdAtUtcMicros,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['media_id'] = Variable<String>(mediaId);
    map['capture_id'] = Variable<String>(captureId);
    map['relative_path'] = Variable<String>(relativePath);
    map['sha256'] = Variable<String>(sha256);
    map['byte_length'] = Variable<int>(byteLength);
    if (!nullToAbsent || mimeType != null) {
      map['mime_type'] = Variable<String>(mimeType);
    }
    if (!nullToAbsent || codec != null) {
      map['codec'] = Variable<String>(codec);
    }
    if (!nullToAbsent || durationMillis != null) {
      map['duration_millis'] = Variable<int>(durationMillis);
    }
    map['created_at_utc_micros'] = Variable<int>(createdAtUtcMicros);
    return map;
  }

  RawMediaRowsCompanion toCompanion(bool nullToAbsent) {
    return RawMediaRowsCompanion(
      mediaId: Value(mediaId),
      captureId: Value(captureId),
      relativePath: Value(relativePath),
      sha256: Value(sha256),
      byteLength: Value(byteLength),
      mimeType: mimeType == null && nullToAbsent
          ? const Value.absent()
          : Value(mimeType),
      codec: codec == null && nullToAbsent
          ? const Value.absent()
          : Value(codec),
      durationMillis: durationMillis == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMillis),
      createdAtUtcMicros: Value(createdAtUtcMicros),
    );
  }

  factory RawMediaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawMediaRow(
      mediaId: serializer.fromJson<String>(json['mediaId']),
      captureId: serializer.fromJson<String>(json['captureId']),
      relativePath: serializer.fromJson<String>(json['relativePath']),
      sha256: serializer.fromJson<String>(json['sha256']),
      byteLength: serializer.fromJson<int>(json['byteLength']),
      mimeType: serializer.fromJson<String?>(json['mimeType']),
      codec: serializer.fromJson<String?>(json['codec']),
      durationMillis: serializer.fromJson<int?>(json['durationMillis']),
      createdAtUtcMicros: serializer.fromJson<int>(json['createdAtUtcMicros']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mediaId': serializer.toJson<String>(mediaId),
      'captureId': serializer.toJson<String>(captureId),
      'relativePath': serializer.toJson<String>(relativePath),
      'sha256': serializer.toJson<String>(sha256),
      'byteLength': serializer.toJson<int>(byteLength),
      'mimeType': serializer.toJson<String?>(mimeType),
      'codec': serializer.toJson<String?>(codec),
      'durationMillis': serializer.toJson<int?>(durationMillis),
      'createdAtUtcMicros': serializer.toJson<int>(createdAtUtcMicros),
    };
  }

  RawMediaRow copyWith({
    String? mediaId,
    String? captureId,
    String? relativePath,
    String? sha256,
    int? byteLength,
    Value<String?> mimeType = const Value.absent(),
    Value<String?> codec = const Value.absent(),
    Value<int?> durationMillis = const Value.absent(),
    int? createdAtUtcMicros,
  }) => RawMediaRow(
    mediaId: mediaId ?? this.mediaId,
    captureId: captureId ?? this.captureId,
    relativePath: relativePath ?? this.relativePath,
    sha256: sha256 ?? this.sha256,
    byteLength: byteLength ?? this.byteLength,
    mimeType: mimeType.present ? mimeType.value : this.mimeType,
    codec: codec.present ? codec.value : this.codec,
    durationMillis: durationMillis.present
        ? durationMillis.value
        : this.durationMillis,
    createdAtUtcMicros: createdAtUtcMicros ?? this.createdAtUtcMicros,
  );
  RawMediaRow copyWithCompanion(RawMediaRowsCompanion data) {
    return RawMediaRow(
      mediaId: data.mediaId.present ? data.mediaId.value : this.mediaId,
      captureId: data.captureId.present ? data.captureId.value : this.captureId,
      relativePath: data.relativePath.present
          ? data.relativePath.value
          : this.relativePath,
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
      byteLength: data.byteLength.present
          ? data.byteLength.value
          : this.byteLength,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      codec: data.codec.present ? data.codec.value : this.codec,
      durationMillis: data.durationMillis.present
          ? data.durationMillis.value
          : this.durationMillis,
      createdAtUtcMicros: data.createdAtUtcMicros.present
          ? data.createdAtUtcMicros.value
          : this.createdAtUtcMicros,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawMediaRow(')
          ..write('mediaId: $mediaId, ')
          ..write('captureId: $captureId, ')
          ..write('relativePath: $relativePath, ')
          ..write('sha256: $sha256, ')
          ..write('byteLength: $byteLength, ')
          ..write('mimeType: $mimeType, ')
          ..write('codec: $codec, ')
          ..write('durationMillis: $durationMillis, ')
          ..write('createdAtUtcMicros: $createdAtUtcMicros')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    mediaId,
    captureId,
    relativePath,
    sha256,
    byteLength,
    mimeType,
    codec,
    durationMillis,
    createdAtUtcMicros,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawMediaRow &&
          other.mediaId == this.mediaId &&
          other.captureId == this.captureId &&
          other.relativePath == this.relativePath &&
          other.sha256 == this.sha256 &&
          other.byteLength == this.byteLength &&
          other.mimeType == this.mimeType &&
          other.codec == this.codec &&
          other.durationMillis == this.durationMillis &&
          other.createdAtUtcMicros == this.createdAtUtcMicros);
}

class RawMediaRowsCompanion extends UpdateCompanion<RawMediaRow> {
  final Value<String> mediaId;
  final Value<String> captureId;
  final Value<String> relativePath;
  final Value<String> sha256;
  final Value<int> byteLength;
  final Value<String?> mimeType;
  final Value<String?> codec;
  final Value<int?> durationMillis;
  final Value<int> createdAtUtcMicros;
  final Value<int> rowid;
  const RawMediaRowsCompanion({
    this.mediaId = const Value.absent(),
    this.captureId = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.byteLength = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.codec = const Value.absent(),
    this.durationMillis = const Value.absent(),
    this.createdAtUtcMicros = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RawMediaRowsCompanion.insert({
    required String mediaId,
    required String captureId,
    required String relativePath,
    required String sha256,
    required int byteLength,
    this.mimeType = const Value.absent(),
    this.codec = const Value.absent(),
    this.durationMillis = const Value.absent(),
    required int createdAtUtcMicros,
    this.rowid = const Value.absent(),
  }) : mediaId = Value(mediaId),
       captureId = Value(captureId),
       relativePath = Value(relativePath),
       sha256 = Value(sha256),
       byteLength = Value(byteLength),
       createdAtUtcMicros = Value(createdAtUtcMicros);
  static Insertable<RawMediaRow> custom({
    Expression<String>? mediaId,
    Expression<String>? captureId,
    Expression<String>? relativePath,
    Expression<String>? sha256,
    Expression<int>? byteLength,
    Expression<String>? mimeType,
    Expression<String>? codec,
    Expression<int>? durationMillis,
    Expression<int>? createdAtUtcMicros,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (mediaId != null) 'media_id': mediaId,
      if (captureId != null) 'capture_id': captureId,
      if (relativePath != null) 'relative_path': relativePath,
      if (sha256 != null) 'sha256': sha256,
      if (byteLength != null) 'byte_length': byteLength,
      if (mimeType != null) 'mime_type': mimeType,
      if (codec != null) 'codec': codec,
      if (durationMillis != null) 'duration_millis': durationMillis,
      if (createdAtUtcMicros != null)
        'created_at_utc_micros': createdAtUtcMicros,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RawMediaRowsCompanion copyWith({
    Value<String>? mediaId,
    Value<String>? captureId,
    Value<String>? relativePath,
    Value<String>? sha256,
    Value<int>? byteLength,
    Value<String?>? mimeType,
    Value<String?>? codec,
    Value<int?>? durationMillis,
    Value<int>? createdAtUtcMicros,
    Value<int>? rowid,
  }) {
    return RawMediaRowsCompanion(
      mediaId: mediaId ?? this.mediaId,
      captureId: captureId ?? this.captureId,
      relativePath: relativePath ?? this.relativePath,
      sha256: sha256 ?? this.sha256,
      byteLength: byteLength ?? this.byteLength,
      mimeType: mimeType ?? this.mimeType,
      codec: codec ?? this.codec,
      durationMillis: durationMillis ?? this.durationMillis,
      createdAtUtcMicros: createdAtUtcMicros ?? this.createdAtUtcMicros,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mediaId.present) {
      map['media_id'] = Variable<String>(mediaId.value);
    }
    if (captureId.present) {
      map['capture_id'] = Variable<String>(captureId.value);
    }
    if (relativePath.present) {
      map['relative_path'] = Variable<String>(relativePath.value);
    }
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (byteLength.present) {
      map['byte_length'] = Variable<int>(byteLength.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (codec.present) {
      map['codec'] = Variable<String>(codec.value);
    }
    if (durationMillis.present) {
      map['duration_millis'] = Variable<int>(durationMillis.value);
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
    return (StringBuffer('RawMediaRowsCompanion(')
          ..write('mediaId: $mediaId, ')
          ..write('captureId: $captureId, ')
          ..write('relativePath: $relativePath, ')
          ..write('sha256: $sha256, ')
          ..write('byteLength: $byteLength, ')
          ..write('mimeType: $mimeType, ')
          ..write('codec: $codec, ')
          ..write('durationMillis: $durationMillis, ')
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
  late final $RawMediaRowsTable rawMediaRows = $RawMediaRowsTable(this);
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
    rawMediaRows,
    rawCapturesOccurrenceIdx,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'raw_captures',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('raw_media', kind: UpdateKind.delete)],
    ),
  ]);
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
      Value<String> payloadKind,
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
      Value<String> payloadKind,
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

  static MultiTypedResultKey<$RawMediaRowsTable, List<RawMediaRow>>
  _rawMediaRowsRefsTable(_$CaptureDatabase db) => MultiTypedResultKey.fromTable(
    db.rawMediaRows,
    aliasName: 'raw_captures__capture_id__raw_media__capture_id',
  );

  $$RawMediaRowsTableProcessedTableManager get rawMediaRowsRefs {
    final manager = $$RawMediaRowsTableTableManager($_db, $_db.rawMediaRows)
        .filter(
          (f) => f.captureId.captureId.sqlEquals(
            $_itemColumn<String>('capture_id')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(_rawMediaRowsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
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

  ColumnFilters<String> get payloadKind => $composableBuilder(
    column: $table.payloadKind,
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

  Expression<bool> rawMediaRowsRefs(
    Expression<bool> Function($$RawMediaRowsTableFilterComposer f) f,
  ) {
    final $$RawMediaRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.captureId,
      referencedTable: $db.rawMediaRows,
      getReferencedColumn: (t) => t.captureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RawMediaRowsTableFilterComposer(
            $db: $db,
            $table: $db.rawMediaRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
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

  ColumnOrderings<String> get payloadKind => $composableBuilder(
    column: $table.payloadKind,
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

  GeneratedColumn<String> get payloadKind => $composableBuilder(
    column: $table.payloadKind,
    builder: (column) => column,
  );

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

  Expression<T> rawMediaRowsRefs<T extends Object>(
    Expression<T> Function($$RawMediaRowsTableAnnotationComposer a) f,
  ) {
    final $$RawMediaRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.captureId,
      referencedTable: $db.rawMediaRows,
      getReferencedColumn: (t) => t.captureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RawMediaRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.rawMediaRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
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
          PrefetchHooks Function({
            bool sourceInstallationId,
            bool rawMediaRowsRefs,
          })
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
                Value<String> payloadKind = const Value.absent(),
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
                payloadKind: payloadKind,
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
                Value<String> payloadKind = const Value.absent(),
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
                payloadKind: payloadKind,
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
          prefetchHooksCallback:
              ({sourceInstallationId = false, rawMediaRowsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (rawMediaRowsRefs) db.rawMediaRows,
                  ],
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
                    return [
                      if (rawMediaRowsRefs)
                        await $_getPrefetchedData<
                          RawCaptureRow,
                          $RawCaptureRowsTable,
                          RawMediaRow
                        >(
                          currentTable: table,
                          referencedTable: $$RawCaptureRowsTableReferences
                              ._rawMediaRowsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RawCaptureRowsTableReferences(
                                db,
                                table,
                                p0,
                              ).rawMediaRowsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.captureId == item.captureId,
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
      PrefetchHooks Function({bool sourceInstallationId, bool rawMediaRowsRefs})
    >;
typedef $$RawMediaRowsTableCreateCompanionBuilder =
    RawMediaRowsCompanion Function({
      required String mediaId,
      required String captureId,
      required String relativePath,
      required String sha256,
      required int byteLength,
      Value<String?> mimeType,
      Value<String?> codec,
      Value<int?> durationMillis,
      required int createdAtUtcMicros,
      Value<int> rowid,
    });
typedef $$RawMediaRowsTableUpdateCompanionBuilder =
    RawMediaRowsCompanion Function({
      Value<String> mediaId,
      Value<String> captureId,
      Value<String> relativePath,
      Value<String> sha256,
      Value<int> byteLength,
      Value<String?> mimeType,
      Value<String?> codec,
      Value<int?> durationMillis,
      Value<int> createdAtUtcMicros,
      Value<int> rowid,
    });

final class $$RawMediaRowsTableReferences
    extends BaseReferences<_$CaptureDatabase, $RawMediaRowsTable, RawMediaRow> {
  $$RawMediaRowsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RawCaptureRowsTable _captureIdTable(_$CaptureDatabase db) => db
      .rawCaptureRows
      .createAlias('raw_media__capture_id__raw_captures__capture_id');

  $$RawCaptureRowsTableProcessedTableManager get captureId {
    final $_column = $_itemColumn<String>('capture_id')!;

    final manager = $$RawCaptureRowsTableTableManager(
      $_db,
      $_db.rawCaptureRows,
    ).filter((f) => f.captureId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_captureIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RawMediaRowsTableFilterComposer
    extends Composer<_$CaptureDatabase, $RawMediaRowsTable> {
  $$RawMediaRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get mediaId => $composableBuilder(
    column: $table.mediaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get byteLength => $composableBuilder(
    column: $table.byteLength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codec => $composableBuilder(
    column: $table.codec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMillis => $composableBuilder(
    column: $table.durationMillis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtUtcMicros => $composableBuilder(
    column: $table.createdAtUtcMicros,
    builder: (column) => ColumnFilters(column),
  );

  $$RawCaptureRowsTableFilterComposer get captureId {
    final $$RawCaptureRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.captureId,
      referencedTable: $db.rawCaptureRows,
      getReferencedColumn: (t) => t.captureId,
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
    return composer;
  }
}

class $$RawMediaRowsTableOrderingComposer
    extends Composer<_$CaptureDatabase, $RawMediaRowsTable> {
  $$RawMediaRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get mediaId => $composableBuilder(
    column: $table.mediaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get byteLength => $composableBuilder(
    column: $table.byteLength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codec => $composableBuilder(
    column: $table.codec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMillis => $composableBuilder(
    column: $table.durationMillis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtUtcMicros => $composableBuilder(
    column: $table.createdAtUtcMicros,
    builder: (column) => ColumnOrderings(column),
  );

  $$RawCaptureRowsTableOrderingComposer get captureId {
    final $$RawCaptureRowsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.captureId,
      referencedTable: $db.rawCaptureRows,
      getReferencedColumn: (t) => t.captureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RawCaptureRowsTableOrderingComposer(
            $db: $db,
            $table: $db.rawCaptureRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RawMediaRowsTableAnnotationComposer
    extends Composer<_$CaptureDatabase, $RawMediaRowsTable> {
  $$RawMediaRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get mediaId =>
      $composableBuilder(column: $table.mediaId, builder: (column) => column);

  GeneratedColumn<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sha256 =>
      $composableBuilder(column: $table.sha256, builder: (column) => column);

  GeneratedColumn<int> get byteLength => $composableBuilder(
    column: $table.byteLength,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<String> get codec =>
      $composableBuilder(column: $table.codec, builder: (column) => column);

  GeneratedColumn<int> get durationMillis => $composableBuilder(
    column: $table.durationMillis,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAtUtcMicros => $composableBuilder(
    column: $table.createdAtUtcMicros,
    builder: (column) => column,
  );

  $$RawCaptureRowsTableAnnotationComposer get captureId {
    final $$RawCaptureRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.captureId,
      referencedTable: $db.rawCaptureRows,
      getReferencedColumn: (t) => t.captureId,
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
    return composer;
  }
}

class $$RawMediaRowsTableTableManager
    extends
        RootTableManager<
          _$CaptureDatabase,
          $RawMediaRowsTable,
          RawMediaRow,
          $$RawMediaRowsTableFilterComposer,
          $$RawMediaRowsTableOrderingComposer,
          $$RawMediaRowsTableAnnotationComposer,
          $$RawMediaRowsTableCreateCompanionBuilder,
          $$RawMediaRowsTableUpdateCompanionBuilder,
          (RawMediaRow, $$RawMediaRowsTableReferences),
          RawMediaRow,
          PrefetchHooks Function({bool captureId})
        > {
  $$RawMediaRowsTableTableManager(
    _$CaptureDatabase db,
    $RawMediaRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RawMediaRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RawMediaRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RawMediaRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> mediaId = const Value.absent(),
                Value<String> captureId = const Value.absent(),
                Value<String> relativePath = const Value.absent(),
                Value<String> sha256 = const Value.absent(),
                Value<int> byteLength = const Value.absent(),
                Value<String?> mimeType = const Value.absent(),
                Value<String?> codec = const Value.absent(),
                Value<int?> durationMillis = const Value.absent(),
                Value<int> createdAtUtcMicros = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RawMediaRowsCompanion(
                mediaId: mediaId,
                captureId: captureId,
                relativePath: relativePath,
                sha256: sha256,
                byteLength: byteLength,
                mimeType: mimeType,
                codec: codec,
                durationMillis: durationMillis,
                createdAtUtcMicros: createdAtUtcMicros,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String mediaId,
                required String captureId,
                required String relativePath,
                required String sha256,
                required int byteLength,
                Value<String?> mimeType = const Value.absent(),
                Value<String?> codec = const Value.absent(),
                Value<int?> durationMillis = const Value.absent(),
                required int createdAtUtcMicros,
                Value<int> rowid = const Value.absent(),
              }) => RawMediaRowsCompanion.insert(
                mediaId: mediaId,
                captureId: captureId,
                relativePath: relativePath,
                sha256: sha256,
                byteLength: byteLength,
                mimeType: mimeType,
                codec: codec,
                durationMillis: durationMillis,
                createdAtUtcMicros: createdAtUtcMicros,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RawMediaRowsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({captureId = false}) {
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
                    if (captureId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.captureId,
                        referencedTable: $$RawMediaRowsTableReferences
                            ._captureIdTable(db),
                        referencedColumn: $$RawMediaRowsTableReferences
                            ._captureIdTable(db)
                            .captureId,
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

typedef $$RawMediaRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$CaptureDatabase,
      $RawMediaRowsTable,
      RawMediaRow,
      $$RawMediaRowsTableFilterComposer,
      $$RawMediaRowsTableOrderingComposer,
      $$RawMediaRowsTableAnnotationComposer,
      $$RawMediaRowsTableCreateCompanionBuilder,
      $$RawMediaRowsTableUpdateCompanionBuilder,
      (RawMediaRow, $$RawMediaRowsTableReferences),
      RawMediaRow,
      PrefetchHooks Function({bool captureId})
    >;

class $CaptureDatabaseManager {
  final _$CaptureDatabase _db;
  $CaptureDatabaseManager(this._db);
  $$InstallationsTableTableManager get installations =>
      $$InstallationsTableTableManager(_db, _db.installations);
  $$RawCaptureRowsTableTableManager get rawCaptureRows =>
      $$RawCaptureRowsTableTableManager(_db, _db.rawCaptureRows);
  $$RawMediaRowsTableTableManager get rawMediaRows =>
      $$RawMediaRowsTableTableManager(_db, _db.rawMediaRows);
}
