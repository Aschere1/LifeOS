// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stage0_database.dart';

// ignore_for_file: type=lint
class $RawCapturesTable extends RawCaptures
    with TableInfo<$RawCapturesTable, RawCapture> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RawCapturesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
  static const VerificationMeta _sourceDeviceIdMeta = const VerificationMeta(
    'sourceDeviceId',
  );
  @override
  late final GeneratedColumn<String> sourceDeviceId = GeneratedColumn<String>(
    'source_device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _sourceTimeZoneMeta = const VerificationMeta(
    'sourceTimeZone',
  );
  @override
  late final GeneratedColumn<String> sourceTimeZone = GeneratedColumn<String>(
    'source_time_zone',
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
    id,
    rawText,
    sourceDeviceId,
    capturedAtUtcMicros,
    originalOffsetMinutes,
    sourceTimeZone,
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
    Insertable<RawCapture> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('raw_text')) {
      context.handle(
        _rawTextMeta,
        rawText.isAcceptableOrUnknown(data['raw_text']!, _rawTextMeta),
      );
    } else if (isInserting) {
      context.missing(_rawTextMeta);
    }
    if (data.containsKey('source_device_id')) {
      context.handle(
        _sourceDeviceIdMeta,
        sourceDeviceId.isAcceptableOrUnknown(
          data['source_device_id']!,
          _sourceDeviceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceDeviceIdMeta);
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
    if (data.containsKey('source_time_zone')) {
      context.handle(
        _sourceTimeZoneMeta,
        sourceTimeZone.isAcceptableOrUnknown(
          data['source_time_zone']!,
          _sourceTimeZoneMeta,
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawCapture map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawCapture(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      rawText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_text'],
      )!,
      sourceDeviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_device_id'],
      )!,
      capturedAtUtcMicros: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}captured_at_utc_micros'],
      )!,
      originalOffsetMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}original_offset_minutes'],
      )!,
      sourceTimeZone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_time_zone'],
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
  $RawCapturesTable createAlias(String alias) {
    return $RawCapturesTable(attachedDatabase, alias);
  }
}

class RawCapture extends DataClass implements Insertable<RawCapture> {
  final String id;
  final String rawText;
  final String sourceDeviceId;
  final int capturedAtUtcMicros;
  final int originalOffsetMinutes;
  final String? sourceTimeZone;
  final String visibility;
  final int revision;
  final int createdAtUtcMicros;
  const RawCapture({
    required this.id,
    required this.rawText,
    required this.sourceDeviceId,
    required this.capturedAtUtcMicros,
    required this.originalOffsetMinutes,
    this.sourceTimeZone,
    required this.visibility,
    required this.revision,
    required this.createdAtUtcMicros,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['raw_text'] = Variable<String>(rawText);
    map['source_device_id'] = Variable<String>(sourceDeviceId);
    map['captured_at_utc_micros'] = Variable<int>(capturedAtUtcMicros);
    map['original_offset_minutes'] = Variable<int>(originalOffsetMinutes);
    if (!nullToAbsent || sourceTimeZone != null) {
      map['source_time_zone'] = Variable<String>(sourceTimeZone);
    }
    map['visibility'] = Variable<String>(visibility);
    map['revision'] = Variable<int>(revision);
    map['created_at_utc_micros'] = Variable<int>(createdAtUtcMicros);
    return map;
  }

  RawCapturesCompanion toCompanion(bool nullToAbsent) {
    return RawCapturesCompanion(
      id: Value(id),
      rawText: Value(rawText),
      sourceDeviceId: Value(sourceDeviceId),
      capturedAtUtcMicros: Value(capturedAtUtcMicros),
      originalOffsetMinutes: Value(originalOffsetMinutes),
      sourceTimeZone: sourceTimeZone == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceTimeZone),
      visibility: Value(visibility),
      revision: Value(revision),
      createdAtUtcMicros: Value(createdAtUtcMicros),
    );
  }

  factory RawCapture.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawCapture(
      id: serializer.fromJson<String>(json['id']),
      rawText: serializer.fromJson<String>(json['rawText']),
      sourceDeviceId: serializer.fromJson<String>(json['sourceDeviceId']),
      capturedAtUtcMicros: serializer.fromJson<int>(
        json['capturedAtUtcMicros'],
      ),
      originalOffsetMinutes: serializer.fromJson<int>(
        json['originalOffsetMinutes'],
      ),
      sourceTimeZone: serializer.fromJson<String?>(json['sourceTimeZone']),
      visibility: serializer.fromJson<String>(json['visibility']),
      revision: serializer.fromJson<int>(json['revision']),
      createdAtUtcMicros: serializer.fromJson<int>(json['createdAtUtcMicros']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'rawText': serializer.toJson<String>(rawText),
      'sourceDeviceId': serializer.toJson<String>(sourceDeviceId),
      'capturedAtUtcMicros': serializer.toJson<int>(capturedAtUtcMicros),
      'originalOffsetMinutes': serializer.toJson<int>(originalOffsetMinutes),
      'sourceTimeZone': serializer.toJson<String?>(sourceTimeZone),
      'visibility': serializer.toJson<String>(visibility),
      'revision': serializer.toJson<int>(revision),
      'createdAtUtcMicros': serializer.toJson<int>(createdAtUtcMicros),
    };
  }

  RawCapture copyWith({
    String? id,
    String? rawText,
    String? sourceDeviceId,
    int? capturedAtUtcMicros,
    int? originalOffsetMinutes,
    Value<String?> sourceTimeZone = const Value.absent(),
    String? visibility,
    int? revision,
    int? createdAtUtcMicros,
  }) => RawCapture(
    id: id ?? this.id,
    rawText: rawText ?? this.rawText,
    sourceDeviceId: sourceDeviceId ?? this.sourceDeviceId,
    capturedAtUtcMicros: capturedAtUtcMicros ?? this.capturedAtUtcMicros,
    originalOffsetMinutes: originalOffsetMinutes ?? this.originalOffsetMinutes,
    sourceTimeZone: sourceTimeZone.present
        ? sourceTimeZone.value
        : this.sourceTimeZone,
    visibility: visibility ?? this.visibility,
    revision: revision ?? this.revision,
    createdAtUtcMicros: createdAtUtcMicros ?? this.createdAtUtcMicros,
  );
  RawCapture copyWithCompanion(RawCapturesCompanion data) {
    return RawCapture(
      id: data.id.present ? data.id.value : this.id,
      rawText: data.rawText.present ? data.rawText.value : this.rawText,
      sourceDeviceId: data.sourceDeviceId.present
          ? data.sourceDeviceId.value
          : this.sourceDeviceId,
      capturedAtUtcMicros: data.capturedAtUtcMicros.present
          ? data.capturedAtUtcMicros.value
          : this.capturedAtUtcMicros,
      originalOffsetMinutes: data.originalOffsetMinutes.present
          ? data.originalOffsetMinutes.value
          : this.originalOffsetMinutes,
      sourceTimeZone: data.sourceTimeZone.present
          ? data.sourceTimeZone.value
          : this.sourceTimeZone,
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
    return (StringBuffer('RawCapture(')
          ..write('id: $id, ')
          ..write('rawText: $rawText, ')
          ..write('sourceDeviceId: $sourceDeviceId, ')
          ..write('capturedAtUtcMicros: $capturedAtUtcMicros, ')
          ..write('originalOffsetMinutes: $originalOffsetMinutes, ')
          ..write('sourceTimeZone: $sourceTimeZone, ')
          ..write('visibility: $visibility, ')
          ..write('revision: $revision, ')
          ..write('createdAtUtcMicros: $createdAtUtcMicros')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    rawText,
    sourceDeviceId,
    capturedAtUtcMicros,
    originalOffsetMinutes,
    sourceTimeZone,
    visibility,
    revision,
    createdAtUtcMicros,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawCapture &&
          other.id == this.id &&
          other.rawText == this.rawText &&
          other.sourceDeviceId == this.sourceDeviceId &&
          other.capturedAtUtcMicros == this.capturedAtUtcMicros &&
          other.originalOffsetMinutes == this.originalOffsetMinutes &&
          other.sourceTimeZone == this.sourceTimeZone &&
          other.visibility == this.visibility &&
          other.revision == this.revision &&
          other.createdAtUtcMicros == this.createdAtUtcMicros);
}

class RawCapturesCompanion extends UpdateCompanion<RawCapture> {
  final Value<String> id;
  final Value<String> rawText;
  final Value<String> sourceDeviceId;
  final Value<int> capturedAtUtcMicros;
  final Value<int> originalOffsetMinutes;
  final Value<String?> sourceTimeZone;
  final Value<String> visibility;
  final Value<int> revision;
  final Value<int> createdAtUtcMicros;
  final Value<int> rowid;
  const RawCapturesCompanion({
    this.id = const Value.absent(),
    this.rawText = const Value.absent(),
    this.sourceDeviceId = const Value.absent(),
    this.capturedAtUtcMicros = const Value.absent(),
    this.originalOffsetMinutes = const Value.absent(),
    this.sourceTimeZone = const Value.absent(),
    this.visibility = const Value.absent(),
    this.revision = const Value.absent(),
    this.createdAtUtcMicros = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RawCapturesCompanion.insert({
    required String id,
    required String rawText,
    required String sourceDeviceId,
    required int capturedAtUtcMicros,
    required int originalOffsetMinutes,
    this.sourceTimeZone = const Value.absent(),
    required String visibility,
    required int revision,
    required int createdAtUtcMicros,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       rawText = Value(rawText),
       sourceDeviceId = Value(sourceDeviceId),
       capturedAtUtcMicros = Value(capturedAtUtcMicros),
       originalOffsetMinutes = Value(originalOffsetMinutes),
       visibility = Value(visibility),
       revision = Value(revision),
       createdAtUtcMicros = Value(createdAtUtcMicros);
  static Insertable<RawCapture> custom({
    Expression<String>? id,
    Expression<String>? rawText,
    Expression<String>? sourceDeviceId,
    Expression<int>? capturedAtUtcMicros,
    Expression<int>? originalOffsetMinutes,
    Expression<String>? sourceTimeZone,
    Expression<String>? visibility,
    Expression<int>? revision,
    Expression<int>? createdAtUtcMicros,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rawText != null) 'raw_text': rawText,
      if (sourceDeviceId != null) 'source_device_id': sourceDeviceId,
      if (capturedAtUtcMicros != null)
        'captured_at_utc_micros': capturedAtUtcMicros,
      if (originalOffsetMinutes != null)
        'original_offset_minutes': originalOffsetMinutes,
      if (sourceTimeZone != null) 'source_time_zone': sourceTimeZone,
      if (visibility != null) 'visibility': visibility,
      if (revision != null) 'revision': revision,
      if (createdAtUtcMicros != null)
        'created_at_utc_micros': createdAtUtcMicros,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RawCapturesCompanion copyWith({
    Value<String>? id,
    Value<String>? rawText,
    Value<String>? sourceDeviceId,
    Value<int>? capturedAtUtcMicros,
    Value<int>? originalOffsetMinutes,
    Value<String?>? sourceTimeZone,
    Value<String>? visibility,
    Value<int>? revision,
    Value<int>? createdAtUtcMicros,
    Value<int>? rowid,
  }) {
    return RawCapturesCompanion(
      id: id ?? this.id,
      rawText: rawText ?? this.rawText,
      sourceDeviceId: sourceDeviceId ?? this.sourceDeviceId,
      capturedAtUtcMicros: capturedAtUtcMicros ?? this.capturedAtUtcMicros,
      originalOffsetMinutes:
          originalOffsetMinutes ?? this.originalOffsetMinutes,
      sourceTimeZone: sourceTimeZone ?? this.sourceTimeZone,
      visibility: visibility ?? this.visibility,
      revision: revision ?? this.revision,
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
    if (rawText.present) {
      map['raw_text'] = Variable<String>(rawText.value);
    }
    if (sourceDeviceId.present) {
      map['source_device_id'] = Variable<String>(sourceDeviceId.value);
    }
    if (capturedAtUtcMicros.present) {
      map['captured_at_utc_micros'] = Variable<int>(capturedAtUtcMicros.value);
    }
    if (originalOffsetMinutes.present) {
      map['original_offset_minutes'] = Variable<int>(
        originalOffsetMinutes.value,
      );
    }
    if (sourceTimeZone.present) {
      map['source_time_zone'] = Variable<String>(sourceTimeZone.value);
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
    return (StringBuffer('RawCapturesCompanion(')
          ..write('id: $id, ')
          ..write('rawText: $rawText, ')
          ..write('sourceDeviceId: $sourceDeviceId, ')
          ..write('capturedAtUtcMicros: $capturedAtUtcMicros, ')
          ..write('originalOffsetMinutes: $originalOffsetMinutes, ')
          ..write('sourceTimeZone: $sourceTimeZone, ')
          ..write('visibility: $visibility, ')
          ..write('revision: $revision, ')
          ..write('createdAtUtcMicros: $createdAtUtcMicros, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RawMediaReferencesTable extends RawMediaReferences
    with TableInfo<$RawMediaReferencesTable, RawMediaReference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RawMediaReferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
      'REFERENCES raw_captures (id)',
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    id,
    captureId,
    relativePath,
    sha256,
    byteLength,
    mimeType,
    codec,
    createdAtUtcMicros,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'raw_media_references';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawMediaReference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
    } else if (isInserting) {
      context.missing(_mimeTypeMeta);
    }
    if (data.containsKey('codec')) {
      context.handle(
        _codecMeta,
        codec.isAcceptableOrUnknown(data['codec']!, _codecMeta),
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawMediaReference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawMediaReference(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
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
      )!,
      codec: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}codec'],
      ),
      createdAtUtcMicros: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_utc_micros'],
      )!,
    );
  }

  @override
  $RawMediaReferencesTable createAlias(String alias) {
    return $RawMediaReferencesTable(attachedDatabase, alias);
  }
}

class RawMediaReference extends DataClass
    implements Insertable<RawMediaReference> {
  final String id;
  final String captureId;
  final String relativePath;
  final String sha256;
  final int byteLength;
  final String mimeType;
  final String? codec;
  final int createdAtUtcMicros;
  const RawMediaReference({
    required this.id,
    required this.captureId,
    required this.relativePath,
    required this.sha256,
    required this.byteLength,
    required this.mimeType,
    this.codec,
    required this.createdAtUtcMicros,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['capture_id'] = Variable<String>(captureId);
    map['relative_path'] = Variable<String>(relativePath);
    map['sha256'] = Variable<String>(sha256);
    map['byte_length'] = Variable<int>(byteLength);
    map['mime_type'] = Variable<String>(mimeType);
    if (!nullToAbsent || codec != null) {
      map['codec'] = Variable<String>(codec);
    }
    map['created_at_utc_micros'] = Variable<int>(createdAtUtcMicros);
    return map;
  }

  RawMediaReferencesCompanion toCompanion(bool nullToAbsent) {
    return RawMediaReferencesCompanion(
      id: Value(id),
      captureId: Value(captureId),
      relativePath: Value(relativePath),
      sha256: Value(sha256),
      byteLength: Value(byteLength),
      mimeType: Value(mimeType),
      codec: codec == null && nullToAbsent
          ? const Value.absent()
          : Value(codec),
      createdAtUtcMicros: Value(createdAtUtcMicros),
    );
  }

  factory RawMediaReference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawMediaReference(
      id: serializer.fromJson<String>(json['id']),
      captureId: serializer.fromJson<String>(json['captureId']),
      relativePath: serializer.fromJson<String>(json['relativePath']),
      sha256: serializer.fromJson<String>(json['sha256']),
      byteLength: serializer.fromJson<int>(json['byteLength']),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      codec: serializer.fromJson<String?>(json['codec']),
      createdAtUtcMicros: serializer.fromJson<int>(json['createdAtUtcMicros']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'captureId': serializer.toJson<String>(captureId),
      'relativePath': serializer.toJson<String>(relativePath),
      'sha256': serializer.toJson<String>(sha256),
      'byteLength': serializer.toJson<int>(byteLength),
      'mimeType': serializer.toJson<String>(mimeType),
      'codec': serializer.toJson<String?>(codec),
      'createdAtUtcMicros': serializer.toJson<int>(createdAtUtcMicros),
    };
  }

  RawMediaReference copyWith({
    String? id,
    String? captureId,
    String? relativePath,
    String? sha256,
    int? byteLength,
    String? mimeType,
    Value<String?> codec = const Value.absent(),
    int? createdAtUtcMicros,
  }) => RawMediaReference(
    id: id ?? this.id,
    captureId: captureId ?? this.captureId,
    relativePath: relativePath ?? this.relativePath,
    sha256: sha256 ?? this.sha256,
    byteLength: byteLength ?? this.byteLength,
    mimeType: mimeType ?? this.mimeType,
    codec: codec.present ? codec.value : this.codec,
    createdAtUtcMicros: createdAtUtcMicros ?? this.createdAtUtcMicros,
  );
  RawMediaReference copyWithCompanion(RawMediaReferencesCompanion data) {
    return RawMediaReference(
      id: data.id.present ? data.id.value : this.id,
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
      createdAtUtcMicros: data.createdAtUtcMicros.present
          ? data.createdAtUtcMicros.value
          : this.createdAtUtcMicros,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawMediaReference(')
          ..write('id: $id, ')
          ..write('captureId: $captureId, ')
          ..write('relativePath: $relativePath, ')
          ..write('sha256: $sha256, ')
          ..write('byteLength: $byteLength, ')
          ..write('mimeType: $mimeType, ')
          ..write('codec: $codec, ')
          ..write('createdAtUtcMicros: $createdAtUtcMicros')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    captureId,
    relativePath,
    sha256,
    byteLength,
    mimeType,
    codec,
    createdAtUtcMicros,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawMediaReference &&
          other.id == this.id &&
          other.captureId == this.captureId &&
          other.relativePath == this.relativePath &&
          other.sha256 == this.sha256 &&
          other.byteLength == this.byteLength &&
          other.mimeType == this.mimeType &&
          other.codec == this.codec &&
          other.createdAtUtcMicros == this.createdAtUtcMicros);
}

class RawMediaReferencesCompanion extends UpdateCompanion<RawMediaReference> {
  final Value<String> id;
  final Value<String> captureId;
  final Value<String> relativePath;
  final Value<String> sha256;
  final Value<int> byteLength;
  final Value<String> mimeType;
  final Value<String?> codec;
  final Value<int> createdAtUtcMicros;
  final Value<int> rowid;
  const RawMediaReferencesCompanion({
    this.id = const Value.absent(),
    this.captureId = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.byteLength = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.codec = const Value.absent(),
    this.createdAtUtcMicros = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RawMediaReferencesCompanion.insert({
    required String id,
    required String captureId,
    required String relativePath,
    required String sha256,
    required int byteLength,
    required String mimeType,
    this.codec = const Value.absent(),
    required int createdAtUtcMicros,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       captureId = Value(captureId),
       relativePath = Value(relativePath),
       sha256 = Value(sha256),
       byteLength = Value(byteLength),
       mimeType = Value(mimeType),
       createdAtUtcMicros = Value(createdAtUtcMicros);
  static Insertable<RawMediaReference> custom({
    Expression<String>? id,
    Expression<String>? captureId,
    Expression<String>? relativePath,
    Expression<String>? sha256,
    Expression<int>? byteLength,
    Expression<String>? mimeType,
    Expression<String>? codec,
    Expression<int>? createdAtUtcMicros,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (captureId != null) 'capture_id': captureId,
      if (relativePath != null) 'relative_path': relativePath,
      if (sha256 != null) 'sha256': sha256,
      if (byteLength != null) 'byte_length': byteLength,
      if (mimeType != null) 'mime_type': mimeType,
      if (codec != null) 'codec': codec,
      if (createdAtUtcMicros != null)
        'created_at_utc_micros': createdAtUtcMicros,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RawMediaReferencesCompanion copyWith({
    Value<String>? id,
    Value<String>? captureId,
    Value<String>? relativePath,
    Value<String>? sha256,
    Value<int>? byteLength,
    Value<String>? mimeType,
    Value<String?>? codec,
    Value<int>? createdAtUtcMicros,
    Value<int>? rowid,
  }) {
    return RawMediaReferencesCompanion(
      id: id ?? this.id,
      captureId: captureId ?? this.captureId,
      relativePath: relativePath ?? this.relativePath,
      sha256: sha256 ?? this.sha256,
      byteLength: byteLength ?? this.byteLength,
      mimeType: mimeType ?? this.mimeType,
      codec: codec ?? this.codec,
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
    return (StringBuffer('RawMediaReferencesCompanion(')
          ..write('id: $id, ')
          ..write('captureId: $captureId, ')
          ..write('relativePath: $relativePath, ')
          ..write('sha256: $sha256, ')
          ..write('byteLength: $byteLength, ')
          ..write('mimeType: $mimeType, ')
          ..write('codec: $codec, ')
          ..write('createdAtUtcMicros: $createdAtUtcMicros, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DerivedArtifactsTable extends DerivedArtifacts
    with TableInfo<$DerivedArtifactsTable, DerivedArtifact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DerivedArtifactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
      'REFERENCES raw_captures (id)',
    ),
  );
  static const VerificationMeta _artifactKindMeta = const VerificationMeta(
    'artifactKind',
  );
  @override
  late final GeneratedColumn<String> artifactKind = GeneratedColumn<String>(
    'artifact_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _provenanceMeta = const VerificationMeta(
    'provenance',
  );
  @override
  late final GeneratedColumn<String> provenance = GeneratedColumn<String>(
    'provenance',
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
  List<GeneratedColumn> get $columns => [
    id,
    captureId,
    artifactKind,
    content,
    provenance,
    createdAtUtcMicros,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'derived_artifacts';
  @override
  VerificationContext validateIntegrity(
    Insertable<DerivedArtifact> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('capture_id')) {
      context.handle(
        _captureIdMeta,
        captureId.isAcceptableOrUnknown(data['capture_id']!, _captureIdMeta),
      );
    } else if (isInserting) {
      context.missing(_captureIdMeta);
    }
    if (data.containsKey('artifact_kind')) {
      context.handle(
        _artifactKindMeta,
        artifactKind.isAcceptableOrUnknown(
          data['artifact_kind']!,
          _artifactKindMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_artifactKindMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('provenance')) {
      context.handle(
        _provenanceMeta,
        provenance.isAcceptableOrUnknown(data['provenance']!, _provenanceMeta),
      );
    } else if (isInserting) {
      context.missing(_provenanceMeta);
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
  DerivedArtifact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DerivedArtifact(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      captureId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}capture_id'],
      )!,
      artifactKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artifact_kind'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      provenance: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provenance'],
      )!,
      createdAtUtcMicros: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_utc_micros'],
      )!,
    );
  }

  @override
  $DerivedArtifactsTable createAlias(String alias) {
    return $DerivedArtifactsTable(attachedDatabase, alias);
  }
}

class DerivedArtifact extends DataClass implements Insertable<DerivedArtifact> {
  final String id;
  final String captureId;
  final String artifactKind;
  final String content;
  final String provenance;
  final int createdAtUtcMicros;
  const DerivedArtifact({
    required this.id,
    required this.captureId,
    required this.artifactKind,
    required this.content,
    required this.provenance,
    required this.createdAtUtcMicros,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['capture_id'] = Variable<String>(captureId);
    map['artifact_kind'] = Variable<String>(artifactKind);
    map['content'] = Variable<String>(content);
    map['provenance'] = Variable<String>(provenance);
    map['created_at_utc_micros'] = Variable<int>(createdAtUtcMicros);
    return map;
  }

  DerivedArtifactsCompanion toCompanion(bool nullToAbsent) {
    return DerivedArtifactsCompanion(
      id: Value(id),
      captureId: Value(captureId),
      artifactKind: Value(artifactKind),
      content: Value(content),
      provenance: Value(provenance),
      createdAtUtcMicros: Value(createdAtUtcMicros),
    );
  }

  factory DerivedArtifact.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DerivedArtifact(
      id: serializer.fromJson<String>(json['id']),
      captureId: serializer.fromJson<String>(json['captureId']),
      artifactKind: serializer.fromJson<String>(json['artifactKind']),
      content: serializer.fromJson<String>(json['content']),
      provenance: serializer.fromJson<String>(json['provenance']),
      createdAtUtcMicros: serializer.fromJson<int>(json['createdAtUtcMicros']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'captureId': serializer.toJson<String>(captureId),
      'artifactKind': serializer.toJson<String>(artifactKind),
      'content': serializer.toJson<String>(content),
      'provenance': serializer.toJson<String>(provenance),
      'createdAtUtcMicros': serializer.toJson<int>(createdAtUtcMicros),
    };
  }

  DerivedArtifact copyWith({
    String? id,
    String? captureId,
    String? artifactKind,
    String? content,
    String? provenance,
    int? createdAtUtcMicros,
  }) => DerivedArtifact(
    id: id ?? this.id,
    captureId: captureId ?? this.captureId,
    artifactKind: artifactKind ?? this.artifactKind,
    content: content ?? this.content,
    provenance: provenance ?? this.provenance,
    createdAtUtcMicros: createdAtUtcMicros ?? this.createdAtUtcMicros,
  );
  DerivedArtifact copyWithCompanion(DerivedArtifactsCompanion data) {
    return DerivedArtifact(
      id: data.id.present ? data.id.value : this.id,
      captureId: data.captureId.present ? data.captureId.value : this.captureId,
      artifactKind: data.artifactKind.present
          ? data.artifactKind.value
          : this.artifactKind,
      content: data.content.present ? data.content.value : this.content,
      provenance: data.provenance.present
          ? data.provenance.value
          : this.provenance,
      createdAtUtcMicros: data.createdAtUtcMicros.present
          ? data.createdAtUtcMicros.value
          : this.createdAtUtcMicros,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DerivedArtifact(')
          ..write('id: $id, ')
          ..write('captureId: $captureId, ')
          ..write('artifactKind: $artifactKind, ')
          ..write('content: $content, ')
          ..write('provenance: $provenance, ')
          ..write('createdAtUtcMicros: $createdAtUtcMicros')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    captureId,
    artifactKind,
    content,
    provenance,
    createdAtUtcMicros,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DerivedArtifact &&
          other.id == this.id &&
          other.captureId == this.captureId &&
          other.artifactKind == this.artifactKind &&
          other.content == this.content &&
          other.provenance == this.provenance &&
          other.createdAtUtcMicros == this.createdAtUtcMicros);
}

class DerivedArtifactsCompanion extends UpdateCompanion<DerivedArtifact> {
  final Value<String> id;
  final Value<String> captureId;
  final Value<String> artifactKind;
  final Value<String> content;
  final Value<String> provenance;
  final Value<int> createdAtUtcMicros;
  final Value<int> rowid;
  const DerivedArtifactsCompanion({
    this.id = const Value.absent(),
    this.captureId = const Value.absent(),
    this.artifactKind = const Value.absent(),
    this.content = const Value.absent(),
    this.provenance = const Value.absent(),
    this.createdAtUtcMicros = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DerivedArtifactsCompanion.insert({
    required String id,
    required String captureId,
    required String artifactKind,
    required String content,
    required String provenance,
    required int createdAtUtcMicros,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       captureId = Value(captureId),
       artifactKind = Value(artifactKind),
       content = Value(content),
       provenance = Value(provenance),
       createdAtUtcMicros = Value(createdAtUtcMicros);
  static Insertable<DerivedArtifact> custom({
    Expression<String>? id,
    Expression<String>? captureId,
    Expression<String>? artifactKind,
    Expression<String>? content,
    Expression<String>? provenance,
    Expression<int>? createdAtUtcMicros,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (captureId != null) 'capture_id': captureId,
      if (artifactKind != null) 'artifact_kind': artifactKind,
      if (content != null) 'content': content,
      if (provenance != null) 'provenance': provenance,
      if (createdAtUtcMicros != null)
        'created_at_utc_micros': createdAtUtcMicros,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DerivedArtifactsCompanion copyWith({
    Value<String>? id,
    Value<String>? captureId,
    Value<String>? artifactKind,
    Value<String>? content,
    Value<String>? provenance,
    Value<int>? createdAtUtcMicros,
    Value<int>? rowid,
  }) {
    return DerivedArtifactsCompanion(
      id: id ?? this.id,
      captureId: captureId ?? this.captureId,
      artifactKind: artifactKind ?? this.artifactKind,
      content: content ?? this.content,
      provenance: provenance ?? this.provenance,
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
    if (captureId.present) {
      map['capture_id'] = Variable<String>(captureId.value);
    }
    if (artifactKind.present) {
      map['artifact_kind'] = Variable<String>(artifactKind.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (provenance.present) {
      map['provenance'] = Variable<String>(provenance.value);
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
    return (StringBuffer('DerivedArtifactsCompanion(')
          ..write('id: $id, ')
          ..write('captureId: $captureId, ')
          ..write('artifactKind: $artifactKind, ')
          ..write('content: $content, ')
          ..write('provenance: $provenance, ')
          ..write('createdAtUtcMicros: $createdAtUtcMicros, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Stage0Database extends GeneratedDatabase {
  _$Stage0Database(QueryExecutor e) : super(e);
  $Stage0DatabaseManager get managers => $Stage0DatabaseManager(this);
  late final $RawCapturesTable rawCaptures = $RawCapturesTable(this);
  late final $RawMediaReferencesTable rawMediaReferences =
      $RawMediaReferencesTable(this);
  late final $DerivedArtifactsTable derivedArtifacts = $DerivedArtifactsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    rawCaptures,
    rawMediaReferences,
    derivedArtifacts,
  ];
}

typedef $$RawCapturesTableCreateCompanionBuilder =
    RawCapturesCompanion Function({
      required String id,
      required String rawText,
      required String sourceDeviceId,
      required int capturedAtUtcMicros,
      required int originalOffsetMinutes,
      Value<String?> sourceTimeZone,
      required String visibility,
      required int revision,
      required int createdAtUtcMicros,
      Value<int> rowid,
    });
typedef $$RawCapturesTableUpdateCompanionBuilder =
    RawCapturesCompanion Function({
      Value<String> id,
      Value<String> rawText,
      Value<String> sourceDeviceId,
      Value<int> capturedAtUtcMicros,
      Value<int> originalOffsetMinutes,
      Value<String?> sourceTimeZone,
      Value<String> visibility,
      Value<int> revision,
      Value<int> createdAtUtcMicros,
      Value<int> rowid,
    });

final class $$RawCapturesTableReferences
    extends BaseReferences<_$Stage0Database, $RawCapturesTable, RawCapture> {
  $$RawCapturesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RawMediaReferencesTable, List<RawMediaReference>>
  _rawMediaReferencesRefsTable(_$Stage0Database db) =>
      MultiTypedResultKey.fromTable(
        db.rawMediaReferences,
        aliasName: 'raw_captures__id__raw_media_references__capture_id',
      );

  $$RawMediaReferencesTableProcessedTableManager get rawMediaReferencesRefs {
    final manager = $$RawMediaReferencesTableTableManager(
      $_db,
      $_db.rawMediaReferences,
    ).filter((f) => f.captureId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _rawMediaReferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DerivedArtifactsTable, List<DerivedArtifact>>
  _derivedArtifactsRefsTable(_$Stage0Database db) =>
      MultiTypedResultKey.fromTable(
        db.derivedArtifacts,
        aliasName: 'raw_captures__id__derived_artifacts__capture_id',
      );

  $$DerivedArtifactsTableProcessedTableManager get derivedArtifactsRefs {
    final manager = $$DerivedArtifactsTableTableManager(
      $_db,
      $_db.derivedArtifacts,
    ).filter((f) => f.captureId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _derivedArtifactsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RawCapturesTableFilterComposer
    extends Composer<_$Stage0Database, $RawCapturesTable> {
  $$RawCapturesTableFilterComposer({
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

  ColumnFilters<String> get rawText => $composableBuilder(
    column: $table.rawText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceDeviceId => $composableBuilder(
    column: $table.sourceDeviceId,
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

  ColumnFilters<String> get sourceTimeZone => $composableBuilder(
    column: $table.sourceTimeZone,
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

  Expression<bool> rawMediaReferencesRefs(
    Expression<bool> Function($$RawMediaReferencesTableFilterComposer f) f,
  ) {
    final $$RawMediaReferencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rawMediaReferences,
      getReferencedColumn: (t) => t.captureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RawMediaReferencesTableFilterComposer(
            $db: $db,
            $table: $db.rawMediaReferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> derivedArtifactsRefs(
    Expression<bool> Function($$DerivedArtifactsTableFilterComposer f) f,
  ) {
    final $$DerivedArtifactsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.derivedArtifacts,
      getReferencedColumn: (t) => t.captureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DerivedArtifactsTableFilterComposer(
            $db: $db,
            $table: $db.derivedArtifacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RawCapturesTableOrderingComposer
    extends Composer<_$Stage0Database, $RawCapturesTable> {
  $$RawCapturesTableOrderingComposer({
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

  ColumnOrderings<String> get rawText => $composableBuilder(
    column: $table.rawText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceDeviceId => $composableBuilder(
    column: $table.sourceDeviceId,
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

  ColumnOrderings<String> get sourceTimeZone => $composableBuilder(
    column: $table.sourceTimeZone,
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
}

class $$RawCapturesTableAnnotationComposer
    extends Composer<_$Stage0Database, $RawCapturesTable> {
  $$RawCapturesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get rawText =>
      $composableBuilder(column: $table.rawText, builder: (column) => column);

  GeneratedColumn<String> get sourceDeviceId => $composableBuilder(
    column: $table.sourceDeviceId,
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

  GeneratedColumn<String> get sourceTimeZone => $composableBuilder(
    column: $table.sourceTimeZone,
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

  Expression<T> rawMediaReferencesRefs<T extends Object>(
    Expression<T> Function($$RawMediaReferencesTableAnnotationComposer a) f,
  ) {
    final $$RawMediaReferencesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.rawMediaReferences,
          getReferencedColumn: (t) => t.captureId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RawMediaReferencesTableAnnotationComposer(
                $db: $db,
                $table: $db.rawMediaReferences,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> derivedArtifactsRefs<T extends Object>(
    Expression<T> Function($$DerivedArtifactsTableAnnotationComposer a) f,
  ) {
    final $$DerivedArtifactsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.derivedArtifacts,
      getReferencedColumn: (t) => t.captureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DerivedArtifactsTableAnnotationComposer(
            $db: $db,
            $table: $db.derivedArtifacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RawCapturesTableTableManager
    extends
        RootTableManager<
          _$Stage0Database,
          $RawCapturesTable,
          RawCapture,
          $$RawCapturesTableFilterComposer,
          $$RawCapturesTableOrderingComposer,
          $$RawCapturesTableAnnotationComposer,
          $$RawCapturesTableCreateCompanionBuilder,
          $$RawCapturesTableUpdateCompanionBuilder,
          (RawCapture, $$RawCapturesTableReferences),
          RawCapture,
          PrefetchHooks Function({
            bool rawMediaReferencesRefs,
            bool derivedArtifactsRefs,
          })
        > {
  $$RawCapturesTableTableManager(_$Stage0Database db, $RawCapturesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RawCapturesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RawCapturesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RawCapturesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> rawText = const Value.absent(),
                Value<String> sourceDeviceId = const Value.absent(),
                Value<int> capturedAtUtcMicros = const Value.absent(),
                Value<int> originalOffsetMinutes = const Value.absent(),
                Value<String?> sourceTimeZone = const Value.absent(),
                Value<String> visibility = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<int> createdAtUtcMicros = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RawCapturesCompanion(
                id: id,
                rawText: rawText,
                sourceDeviceId: sourceDeviceId,
                capturedAtUtcMicros: capturedAtUtcMicros,
                originalOffsetMinutes: originalOffsetMinutes,
                sourceTimeZone: sourceTimeZone,
                visibility: visibility,
                revision: revision,
                createdAtUtcMicros: createdAtUtcMicros,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String rawText,
                required String sourceDeviceId,
                required int capturedAtUtcMicros,
                required int originalOffsetMinutes,
                Value<String?> sourceTimeZone = const Value.absent(),
                required String visibility,
                required int revision,
                required int createdAtUtcMicros,
                Value<int> rowid = const Value.absent(),
              }) => RawCapturesCompanion.insert(
                id: id,
                rawText: rawText,
                sourceDeviceId: sourceDeviceId,
                capturedAtUtcMicros: capturedAtUtcMicros,
                originalOffsetMinutes: originalOffsetMinutes,
                sourceTimeZone: sourceTimeZone,
                visibility: visibility,
                revision: revision,
                createdAtUtcMicros: createdAtUtcMicros,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RawCapturesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({rawMediaReferencesRefs = false, derivedArtifactsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (rawMediaReferencesRefs) db.rawMediaReferences,
                    if (derivedArtifactsRefs) db.derivedArtifacts,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (rawMediaReferencesRefs)
                        await $_getPrefetchedData<
                          RawCapture,
                          $RawCapturesTable,
                          RawMediaReference
                        >(
                          currentTable: table,
                          referencedTable: $$RawCapturesTableReferences
                              ._rawMediaReferencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RawCapturesTableReferences(
                                db,
                                table,
                                p0,
                              ).rawMediaReferencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.captureId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (derivedArtifactsRefs)
                        await $_getPrefetchedData<
                          RawCapture,
                          $RawCapturesTable,
                          DerivedArtifact
                        >(
                          currentTable: table,
                          referencedTable: $$RawCapturesTableReferences
                              ._derivedArtifactsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RawCapturesTableReferences(
                                db,
                                table,
                                p0,
                              ).derivedArtifactsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.captureId == item.id,
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

typedef $$RawCapturesTableProcessedTableManager =
    ProcessedTableManager<
      _$Stage0Database,
      $RawCapturesTable,
      RawCapture,
      $$RawCapturesTableFilterComposer,
      $$RawCapturesTableOrderingComposer,
      $$RawCapturesTableAnnotationComposer,
      $$RawCapturesTableCreateCompanionBuilder,
      $$RawCapturesTableUpdateCompanionBuilder,
      (RawCapture, $$RawCapturesTableReferences),
      RawCapture,
      PrefetchHooks Function({
        bool rawMediaReferencesRefs,
        bool derivedArtifactsRefs,
      })
    >;
typedef $$RawMediaReferencesTableCreateCompanionBuilder =
    RawMediaReferencesCompanion Function({
      required String id,
      required String captureId,
      required String relativePath,
      required String sha256,
      required int byteLength,
      required String mimeType,
      Value<String?> codec,
      required int createdAtUtcMicros,
      Value<int> rowid,
    });
typedef $$RawMediaReferencesTableUpdateCompanionBuilder =
    RawMediaReferencesCompanion Function({
      Value<String> id,
      Value<String> captureId,
      Value<String> relativePath,
      Value<String> sha256,
      Value<int> byteLength,
      Value<String> mimeType,
      Value<String?> codec,
      Value<int> createdAtUtcMicros,
      Value<int> rowid,
    });

final class $$RawMediaReferencesTableReferences
    extends
        BaseReferences<
          _$Stage0Database,
          $RawMediaReferencesTable,
          RawMediaReference
        > {
  $$RawMediaReferencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RawCapturesTable _captureIdTable(_$Stage0Database db) => db
      .rawCaptures
      .createAlias('raw_media_references__capture_id__raw_captures__id');

  $$RawCapturesTableProcessedTableManager get captureId {
    final $_column = $_itemColumn<String>('capture_id')!;

    final manager = $$RawCapturesTableTableManager(
      $_db,
      $_db.rawCaptures,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_captureIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RawMediaReferencesTableFilterComposer
    extends Composer<_$Stage0Database, $RawMediaReferencesTable> {
  $$RawMediaReferencesTableFilterComposer({
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

  ColumnFilters<int> get createdAtUtcMicros => $composableBuilder(
    column: $table.createdAtUtcMicros,
    builder: (column) => ColumnFilters(column),
  );

  $$RawCapturesTableFilterComposer get captureId {
    final $$RawCapturesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.captureId,
      referencedTable: $db.rawCaptures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RawCapturesTableFilterComposer(
            $db: $db,
            $table: $db.rawCaptures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RawMediaReferencesTableOrderingComposer
    extends Composer<_$Stage0Database, $RawMediaReferencesTable> {
  $$RawMediaReferencesTableOrderingComposer({
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

  ColumnOrderings<int> get createdAtUtcMicros => $composableBuilder(
    column: $table.createdAtUtcMicros,
    builder: (column) => ColumnOrderings(column),
  );

  $$RawCapturesTableOrderingComposer get captureId {
    final $$RawCapturesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.captureId,
      referencedTable: $db.rawCaptures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RawCapturesTableOrderingComposer(
            $db: $db,
            $table: $db.rawCaptures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RawMediaReferencesTableAnnotationComposer
    extends Composer<_$Stage0Database, $RawMediaReferencesTable> {
  $$RawMediaReferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

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

  GeneratedColumn<int> get createdAtUtcMicros => $composableBuilder(
    column: $table.createdAtUtcMicros,
    builder: (column) => column,
  );

  $$RawCapturesTableAnnotationComposer get captureId {
    final $$RawCapturesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.captureId,
      referencedTable: $db.rawCaptures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RawCapturesTableAnnotationComposer(
            $db: $db,
            $table: $db.rawCaptures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RawMediaReferencesTableTableManager
    extends
        RootTableManager<
          _$Stage0Database,
          $RawMediaReferencesTable,
          RawMediaReference,
          $$RawMediaReferencesTableFilterComposer,
          $$RawMediaReferencesTableOrderingComposer,
          $$RawMediaReferencesTableAnnotationComposer,
          $$RawMediaReferencesTableCreateCompanionBuilder,
          $$RawMediaReferencesTableUpdateCompanionBuilder,
          (RawMediaReference, $$RawMediaReferencesTableReferences),
          RawMediaReference,
          PrefetchHooks Function({bool captureId})
        > {
  $$RawMediaReferencesTableTableManager(
    _$Stage0Database db,
    $RawMediaReferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RawMediaReferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RawMediaReferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RawMediaReferencesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> captureId = const Value.absent(),
                Value<String> relativePath = const Value.absent(),
                Value<String> sha256 = const Value.absent(),
                Value<int> byteLength = const Value.absent(),
                Value<String> mimeType = const Value.absent(),
                Value<String?> codec = const Value.absent(),
                Value<int> createdAtUtcMicros = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RawMediaReferencesCompanion(
                id: id,
                captureId: captureId,
                relativePath: relativePath,
                sha256: sha256,
                byteLength: byteLength,
                mimeType: mimeType,
                codec: codec,
                createdAtUtcMicros: createdAtUtcMicros,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String captureId,
                required String relativePath,
                required String sha256,
                required int byteLength,
                required String mimeType,
                Value<String?> codec = const Value.absent(),
                required int createdAtUtcMicros,
                Value<int> rowid = const Value.absent(),
              }) => RawMediaReferencesCompanion.insert(
                id: id,
                captureId: captureId,
                relativePath: relativePath,
                sha256: sha256,
                byteLength: byteLength,
                mimeType: mimeType,
                codec: codec,
                createdAtUtcMicros: createdAtUtcMicros,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RawMediaReferencesTableReferences(db, table, e),
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
                        referencedTable: $$RawMediaReferencesTableReferences
                            ._captureIdTable(db),
                        referencedColumn: $$RawMediaReferencesTableReferences
                            ._captureIdTable(db)
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

typedef $$RawMediaReferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$Stage0Database,
      $RawMediaReferencesTable,
      RawMediaReference,
      $$RawMediaReferencesTableFilterComposer,
      $$RawMediaReferencesTableOrderingComposer,
      $$RawMediaReferencesTableAnnotationComposer,
      $$RawMediaReferencesTableCreateCompanionBuilder,
      $$RawMediaReferencesTableUpdateCompanionBuilder,
      (RawMediaReference, $$RawMediaReferencesTableReferences),
      RawMediaReference,
      PrefetchHooks Function({bool captureId})
    >;
typedef $$DerivedArtifactsTableCreateCompanionBuilder =
    DerivedArtifactsCompanion Function({
      required String id,
      required String captureId,
      required String artifactKind,
      required String content,
      required String provenance,
      required int createdAtUtcMicros,
      Value<int> rowid,
    });
typedef $$DerivedArtifactsTableUpdateCompanionBuilder =
    DerivedArtifactsCompanion Function({
      Value<String> id,
      Value<String> captureId,
      Value<String> artifactKind,
      Value<String> content,
      Value<String> provenance,
      Value<int> createdAtUtcMicros,
      Value<int> rowid,
    });

final class $$DerivedArtifactsTableReferences
    extends
        BaseReferences<
          _$Stage0Database,
          $DerivedArtifactsTable,
          DerivedArtifact
        > {
  $$DerivedArtifactsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RawCapturesTable _captureIdTable(_$Stage0Database db) => db
      .rawCaptures
      .createAlias('derived_artifacts__capture_id__raw_captures__id');

  $$RawCapturesTableProcessedTableManager get captureId {
    final $_column = $_itemColumn<String>('capture_id')!;

    final manager = $$RawCapturesTableTableManager(
      $_db,
      $_db.rawCaptures,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_captureIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DerivedArtifactsTableFilterComposer
    extends Composer<_$Stage0Database, $DerivedArtifactsTable> {
  $$DerivedArtifactsTableFilterComposer({
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

  ColumnFilters<String> get artifactKind => $composableBuilder(
    column: $table.artifactKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provenance => $composableBuilder(
    column: $table.provenance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtUtcMicros => $composableBuilder(
    column: $table.createdAtUtcMicros,
    builder: (column) => ColumnFilters(column),
  );

  $$RawCapturesTableFilterComposer get captureId {
    final $$RawCapturesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.captureId,
      referencedTable: $db.rawCaptures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RawCapturesTableFilterComposer(
            $db: $db,
            $table: $db.rawCaptures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DerivedArtifactsTableOrderingComposer
    extends Composer<_$Stage0Database, $DerivedArtifactsTable> {
  $$DerivedArtifactsTableOrderingComposer({
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

  ColumnOrderings<String> get artifactKind => $composableBuilder(
    column: $table.artifactKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provenance => $composableBuilder(
    column: $table.provenance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtUtcMicros => $composableBuilder(
    column: $table.createdAtUtcMicros,
    builder: (column) => ColumnOrderings(column),
  );

  $$RawCapturesTableOrderingComposer get captureId {
    final $$RawCapturesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.captureId,
      referencedTable: $db.rawCaptures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RawCapturesTableOrderingComposer(
            $db: $db,
            $table: $db.rawCaptures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DerivedArtifactsTableAnnotationComposer
    extends Composer<_$Stage0Database, $DerivedArtifactsTable> {
  $$DerivedArtifactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get artifactKind => $composableBuilder(
    column: $table.artifactKind,
    builder: (column) => column,
  );

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get provenance => $composableBuilder(
    column: $table.provenance,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAtUtcMicros => $composableBuilder(
    column: $table.createdAtUtcMicros,
    builder: (column) => column,
  );

  $$RawCapturesTableAnnotationComposer get captureId {
    final $$RawCapturesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.captureId,
      referencedTable: $db.rawCaptures,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RawCapturesTableAnnotationComposer(
            $db: $db,
            $table: $db.rawCaptures,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DerivedArtifactsTableTableManager
    extends
        RootTableManager<
          _$Stage0Database,
          $DerivedArtifactsTable,
          DerivedArtifact,
          $$DerivedArtifactsTableFilterComposer,
          $$DerivedArtifactsTableOrderingComposer,
          $$DerivedArtifactsTableAnnotationComposer,
          $$DerivedArtifactsTableCreateCompanionBuilder,
          $$DerivedArtifactsTableUpdateCompanionBuilder,
          (DerivedArtifact, $$DerivedArtifactsTableReferences),
          DerivedArtifact,
          PrefetchHooks Function({bool captureId})
        > {
  $$DerivedArtifactsTableTableManager(
    _$Stage0Database db,
    $DerivedArtifactsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DerivedArtifactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DerivedArtifactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DerivedArtifactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> captureId = const Value.absent(),
                Value<String> artifactKind = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String> provenance = const Value.absent(),
                Value<int> createdAtUtcMicros = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DerivedArtifactsCompanion(
                id: id,
                captureId: captureId,
                artifactKind: artifactKind,
                content: content,
                provenance: provenance,
                createdAtUtcMicros: createdAtUtcMicros,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String captureId,
                required String artifactKind,
                required String content,
                required String provenance,
                required int createdAtUtcMicros,
                Value<int> rowid = const Value.absent(),
              }) => DerivedArtifactsCompanion.insert(
                id: id,
                captureId: captureId,
                artifactKind: artifactKind,
                content: content,
                provenance: provenance,
                createdAtUtcMicros: createdAtUtcMicros,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DerivedArtifactsTableReferences(db, table, e),
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
                        referencedTable: $$DerivedArtifactsTableReferences
                            ._captureIdTable(db),
                        referencedColumn: $$DerivedArtifactsTableReferences
                            ._captureIdTable(db)
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

typedef $$DerivedArtifactsTableProcessedTableManager =
    ProcessedTableManager<
      _$Stage0Database,
      $DerivedArtifactsTable,
      DerivedArtifact,
      $$DerivedArtifactsTableFilterComposer,
      $$DerivedArtifactsTableOrderingComposer,
      $$DerivedArtifactsTableAnnotationComposer,
      $$DerivedArtifactsTableCreateCompanionBuilder,
      $$DerivedArtifactsTableUpdateCompanionBuilder,
      (DerivedArtifact, $$DerivedArtifactsTableReferences),
      DerivedArtifact,
      PrefetchHooks Function({bool captureId})
    >;

class $Stage0DatabaseManager {
  final _$Stage0Database _db;
  $Stage0DatabaseManager(this._db);
  $$RawCapturesTableTableManager get rawCaptures =>
      $$RawCapturesTableTableManager(_db, _db.rawCaptures);
  $$RawMediaReferencesTableTableManager get rawMediaReferences =>
      $$RawMediaReferencesTableTableManager(_db, _db.rawMediaReferences);
  $$DerivedArtifactsTableTableManager get derivedArtifacts =>
      $$DerivedArtifactsTableTableManager(_db, _db.derivedArtifacts);
}
