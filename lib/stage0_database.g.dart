// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stage0_database.dart';

// ignore_for_file: type=lint
class $RawCapturesTable extends RawCaptures
    with TableInfo<$RawCapturesTable, RawCapture> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RawCapturesTable(this.attachedDatabase, [this._alias]);
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
    Insertable<RawCapture> instance, {
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
  RawCapture map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawCapture(
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
  $RawCapturesTable createAlias(String alias) {
    return $RawCapturesTable(attachedDatabase, alias);
  }
}

class RawCapture extends DataClass implements Insertable<RawCapture> {
  final String captureId;
  final String rawText;
  final String sourceInstallationId;
  final int capturedAtUtcMicros;
  final int originalOffsetMinutes;
  final String? sourceTimeZoneId;
  final String visibility;
  final int revision;
  final int createdAtUtcMicros;
  const RawCapture({
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

  RawCapturesCompanion toCompanion(bool nullToAbsent) {
    return RawCapturesCompanion(
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

  factory RawCapture.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawCapture(
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

  RawCapture copyWith({
    String? captureId,
    String? rawText,
    String? sourceInstallationId,
    int? capturedAtUtcMicros,
    int? originalOffsetMinutes,
    Value<String?> sourceTimeZoneId = const Value.absent(),
    String? visibility,
    int? revision,
    int? createdAtUtcMicros,
  }) => RawCapture(
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
  RawCapture copyWithCompanion(RawCapturesCompanion data) {
    return RawCapture(
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
    return (StringBuffer('RawCapture(')
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
      (other is RawCapture &&
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

class RawCapturesCompanion extends UpdateCompanion<RawCapture> {
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
  const RawCapturesCompanion({
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
  RawCapturesCompanion.insert({
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
  static Insertable<RawCapture> custom({
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

  RawCapturesCompanion copyWith({
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
    return RawCapturesCompanion(
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
    return (StringBuffer('RawCapturesCompanion(')
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

class $RawMediaReferencesTable extends RawMediaReferences
    with TableInfo<$RawMediaReferencesTable, RawMediaReference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RawMediaReferencesTable(this.attachedDatabase, [this._alias]);
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
      'REFERENCES raw_captures (capture_id)',
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
  static const String $name = 'raw_media_references';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawMediaReference> instance, {
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
  RawMediaReference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawMediaReference(
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
  $RawMediaReferencesTable createAlias(String alias) {
    return $RawMediaReferencesTable(attachedDatabase, alias);
  }
}

class RawMediaReference extends DataClass
    implements Insertable<RawMediaReference> {
  final String mediaId;
  final String captureId;
  final String relativePath;
  final String sha256;
  final int byteLength;
  final String? mimeType;
  final String? codec;
  final int? durationMillis;
  final int createdAtUtcMicros;
  const RawMediaReference({
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

  RawMediaReferencesCompanion toCompanion(bool nullToAbsent) {
    return RawMediaReferencesCompanion(
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

  factory RawMediaReference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawMediaReference(
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

  RawMediaReference copyWith({
    String? mediaId,
    String? captureId,
    String? relativePath,
    String? sha256,
    int? byteLength,
    Value<String?> mimeType = const Value.absent(),
    Value<String?> codec = const Value.absent(),
    Value<int?> durationMillis = const Value.absent(),
    int? createdAtUtcMicros,
  }) => RawMediaReference(
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
  RawMediaReference copyWithCompanion(RawMediaReferencesCompanion data) {
    return RawMediaReference(
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
    return (StringBuffer('RawMediaReference(')
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
      (other is RawMediaReference &&
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

class RawMediaReferencesCompanion extends UpdateCompanion<RawMediaReference> {
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
  const RawMediaReferencesCompanion({
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
  RawMediaReferencesCompanion.insert({
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
  static Insertable<RawMediaReference> custom({
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

  RawMediaReferencesCompanion copyWith({
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
    return RawMediaReferencesCompanion(
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
    return (StringBuffer('RawMediaReferencesCompanion(')
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

class $DerivedArtifactsTable extends DerivedArtifacts
    with TableInfo<$DerivedArtifactsTable, DerivedArtifact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DerivedArtifactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _artifactIdMeta = const VerificationMeta(
    'artifactId',
  );
  @override
  late final GeneratedColumn<String> artifactId = GeneratedColumn<String>(
    'artifact_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceCaptureIdMeta = const VerificationMeta(
    'sourceCaptureId',
  );
  @override
  late final GeneratedColumn<String> sourceCaptureId = GeneratedColumn<String>(
    'source_capture_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES raw_captures (capture_id)',
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
    artifactId,
    sourceCaptureId,
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
    if (data.containsKey('artifact_id')) {
      context.handle(
        _artifactIdMeta,
        artifactId.isAcceptableOrUnknown(data['artifact_id']!, _artifactIdMeta),
      );
    } else if (isInserting) {
      context.missing(_artifactIdMeta);
    }
    if (data.containsKey('source_capture_id')) {
      context.handle(
        _sourceCaptureIdMeta,
        sourceCaptureId.isAcceptableOrUnknown(
          data['source_capture_id']!,
          _sourceCaptureIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceCaptureIdMeta);
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
  Set<GeneratedColumn> get $primaryKey => {artifactId};
  @override
  DerivedArtifact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DerivedArtifact(
      artifactId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artifact_id'],
      )!,
      sourceCaptureId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_capture_id'],
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
  final String artifactId;
  final String sourceCaptureId;
  final String artifactKind;
  final String content;
  final String provenance;
  final int createdAtUtcMicros;
  const DerivedArtifact({
    required this.artifactId,
    required this.sourceCaptureId,
    required this.artifactKind,
    required this.content,
    required this.provenance,
    required this.createdAtUtcMicros,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['artifact_id'] = Variable<String>(artifactId);
    map['source_capture_id'] = Variable<String>(sourceCaptureId);
    map['artifact_kind'] = Variable<String>(artifactKind);
    map['content'] = Variable<String>(content);
    map['provenance'] = Variable<String>(provenance);
    map['created_at_utc_micros'] = Variable<int>(createdAtUtcMicros);
    return map;
  }

  DerivedArtifactsCompanion toCompanion(bool nullToAbsent) {
    return DerivedArtifactsCompanion(
      artifactId: Value(artifactId),
      sourceCaptureId: Value(sourceCaptureId),
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
      artifactId: serializer.fromJson<String>(json['artifactId']),
      sourceCaptureId: serializer.fromJson<String>(json['sourceCaptureId']),
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
      'artifactId': serializer.toJson<String>(artifactId),
      'sourceCaptureId': serializer.toJson<String>(sourceCaptureId),
      'artifactKind': serializer.toJson<String>(artifactKind),
      'content': serializer.toJson<String>(content),
      'provenance': serializer.toJson<String>(provenance),
      'createdAtUtcMicros': serializer.toJson<int>(createdAtUtcMicros),
    };
  }

  DerivedArtifact copyWith({
    String? artifactId,
    String? sourceCaptureId,
    String? artifactKind,
    String? content,
    String? provenance,
    int? createdAtUtcMicros,
  }) => DerivedArtifact(
    artifactId: artifactId ?? this.artifactId,
    sourceCaptureId: sourceCaptureId ?? this.sourceCaptureId,
    artifactKind: artifactKind ?? this.artifactKind,
    content: content ?? this.content,
    provenance: provenance ?? this.provenance,
    createdAtUtcMicros: createdAtUtcMicros ?? this.createdAtUtcMicros,
  );
  DerivedArtifact copyWithCompanion(DerivedArtifactsCompanion data) {
    return DerivedArtifact(
      artifactId: data.artifactId.present
          ? data.artifactId.value
          : this.artifactId,
      sourceCaptureId: data.sourceCaptureId.present
          ? data.sourceCaptureId.value
          : this.sourceCaptureId,
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
          ..write('artifactId: $artifactId, ')
          ..write('sourceCaptureId: $sourceCaptureId, ')
          ..write('artifactKind: $artifactKind, ')
          ..write('content: $content, ')
          ..write('provenance: $provenance, ')
          ..write('createdAtUtcMicros: $createdAtUtcMicros')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    artifactId,
    sourceCaptureId,
    artifactKind,
    content,
    provenance,
    createdAtUtcMicros,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DerivedArtifact &&
          other.artifactId == this.artifactId &&
          other.sourceCaptureId == this.sourceCaptureId &&
          other.artifactKind == this.artifactKind &&
          other.content == this.content &&
          other.provenance == this.provenance &&
          other.createdAtUtcMicros == this.createdAtUtcMicros);
}

class DerivedArtifactsCompanion extends UpdateCompanion<DerivedArtifact> {
  final Value<String> artifactId;
  final Value<String> sourceCaptureId;
  final Value<String> artifactKind;
  final Value<String> content;
  final Value<String> provenance;
  final Value<int> createdAtUtcMicros;
  final Value<int> rowid;
  const DerivedArtifactsCompanion({
    this.artifactId = const Value.absent(),
    this.sourceCaptureId = const Value.absent(),
    this.artifactKind = const Value.absent(),
    this.content = const Value.absent(),
    this.provenance = const Value.absent(),
    this.createdAtUtcMicros = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DerivedArtifactsCompanion.insert({
    required String artifactId,
    required String sourceCaptureId,
    required String artifactKind,
    required String content,
    required String provenance,
    required int createdAtUtcMicros,
    this.rowid = const Value.absent(),
  }) : artifactId = Value(artifactId),
       sourceCaptureId = Value(sourceCaptureId),
       artifactKind = Value(artifactKind),
       content = Value(content),
       provenance = Value(provenance),
       createdAtUtcMicros = Value(createdAtUtcMicros);
  static Insertable<DerivedArtifact> custom({
    Expression<String>? artifactId,
    Expression<String>? sourceCaptureId,
    Expression<String>? artifactKind,
    Expression<String>? content,
    Expression<String>? provenance,
    Expression<int>? createdAtUtcMicros,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (artifactId != null) 'artifact_id': artifactId,
      if (sourceCaptureId != null) 'source_capture_id': sourceCaptureId,
      if (artifactKind != null) 'artifact_kind': artifactKind,
      if (content != null) 'content': content,
      if (provenance != null) 'provenance': provenance,
      if (createdAtUtcMicros != null)
        'created_at_utc_micros': createdAtUtcMicros,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DerivedArtifactsCompanion copyWith({
    Value<String>? artifactId,
    Value<String>? sourceCaptureId,
    Value<String>? artifactKind,
    Value<String>? content,
    Value<String>? provenance,
    Value<int>? createdAtUtcMicros,
    Value<int>? rowid,
  }) {
    return DerivedArtifactsCompanion(
      artifactId: artifactId ?? this.artifactId,
      sourceCaptureId: sourceCaptureId ?? this.sourceCaptureId,
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
    if (artifactId.present) {
      map['artifact_id'] = Variable<String>(artifactId.value);
    }
    if (sourceCaptureId.present) {
      map['source_capture_id'] = Variable<String>(sourceCaptureId.value);
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
          ..write('artifactId: $artifactId, ')
          ..write('sourceCaptureId: $sourceCaptureId, ')
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
typedef $$RawCapturesTableUpdateCompanionBuilder =
    RawCapturesCompanion Function({
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

final class $$RawCapturesTableReferences
    extends BaseReferences<_$Stage0Database, $RawCapturesTable, RawCapture> {
  $$RawCapturesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RawMediaReferencesTable, List<RawMediaReference>>
  _rawMediaReferencesRefsTable(_$Stage0Database db) =>
      MultiTypedResultKey.fromTable(
        db.rawMediaReferences,
        aliasName: 'raw_captures__capture_id__raw_media_references__capture_id',
      );

  $$RawMediaReferencesTableProcessedTableManager get rawMediaReferencesRefs {
    final manager =
        $$RawMediaReferencesTableTableManager(
          $_db,
          $_db.rawMediaReferences,
        ).filter(
          (f) => f.captureId.captureId.sqlEquals(
            $_itemColumn<String>('capture_id')!,
          ),
        );

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
        aliasName:
            'raw_captures__capture_id__derived_artifacts__source_capture_id',
      );

  $$DerivedArtifactsTableProcessedTableManager get derivedArtifactsRefs {
    final manager =
        $$DerivedArtifactsTableTableManager($_db, $_db.derivedArtifacts).filter(
          (f) => f.sourceCaptureId.captureId.sqlEquals(
            $_itemColumn<String>('capture_id')!,
          ),
        );

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
  ColumnFilters<String> get captureId => $composableBuilder(
    column: $table.captureId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawText => $composableBuilder(
    column: $table.rawText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceInstallationId => $composableBuilder(
    column: $table.sourceInstallationId,
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

  Expression<bool> rawMediaReferencesRefs(
    Expression<bool> Function($$RawMediaReferencesTableFilterComposer f) f,
  ) {
    final $$RawMediaReferencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.captureId,
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
      getCurrentColumn: (t) => t.captureId,
      referencedTable: $db.derivedArtifacts,
      getReferencedColumn: (t) => t.sourceCaptureId,
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
  ColumnOrderings<String> get captureId => $composableBuilder(
    column: $table.captureId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawText => $composableBuilder(
    column: $table.rawText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceInstallationId => $composableBuilder(
    column: $table.sourceInstallationId,
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
  GeneratedColumn<String> get captureId =>
      $composableBuilder(column: $table.captureId, builder: (column) => column);

  GeneratedColumn<String> get rawText =>
      $composableBuilder(column: $table.rawText, builder: (column) => column);

  GeneratedColumn<String> get sourceInstallationId => $composableBuilder(
    column: $table.sourceInstallationId,
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

  Expression<T> rawMediaReferencesRefs<T extends Object>(
    Expression<T> Function($$RawMediaReferencesTableAnnotationComposer a) f,
  ) {
    final $$RawMediaReferencesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.captureId,
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
      getCurrentColumn: (t) => t.captureId,
      referencedTable: $db.derivedArtifacts,
      getReferencedColumn: (t) => t.sourceCaptureId,
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
              }) => RawCapturesCompanion(
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
              }) => RawCapturesCompanion.insert(
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
                                (e) => e.captureId == item.captureId,
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
                                (e) => e.sourceCaptureId == item.captureId,
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
typedef $$RawMediaReferencesTableUpdateCompanionBuilder =
    RawMediaReferencesCompanion Function({
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

  static $RawCapturesTable _captureIdTable(_$Stage0Database db) =>
      db.rawCaptures.createAlias(
        'raw_media_references__capture_id__raw_captures__capture_id',
      );

  $$RawCapturesTableProcessedTableManager get captureId {
    final $_column = $_itemColumn<String>('capture_id')!;

    final manager = $$RawCapturesTableTableManager(
      $_db,
      $_db.rawCaptures,
    ).filter((f) => f.captureId.sqlEquals($_column));
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

  $$RawCapturesTableFilterComposer get captureId {
    final $$RawCapturesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.captureId,
      referencedTable: $db.rawCaptures,
      getReferencedColumn: (t) => t.captureId,
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

  $$RawCapturesTableOrderingComposer get captureId {
    final $$RawCapturesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.captureId,
      referencedTable: $db.rawCaptures,
      getReferencedColumn: (t) => t.captureId,
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

  $$RawCapturesTableAnnotationComposer get captureId {
    final $$RawCapturesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.captureId,
      referencedTable: $db.rawCaptures,
      getReferencedColumn: (t) => t.captureId,
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
              }) => RawMediaReferencesCompanion(
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
              }) => RawMediaReferencesCompanion.insert(
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
      required String artifactId,
      required String sourceCaptureId,
      required String artifactKind,
      required String content,
      required String provenance,
      required int createdAtUtcMicros,
      Value<int> rowid,
    });
typedef $$DerivedArtifactsTableUpdateCompanionBuilder =
    DerivedArtifactsCompanion Function({
      Value<String> artifactId,
      Value<String> sourceCaptureId,
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

  static $RawCapturesTable _sourceCaptureIdTable(_$Stage0Database db) =>
      db.rawCaptures.createAlias(
        'derived_artifacts__source_capture_id__raw_captures__capture_id',
      );

  $$RawCapturesTableProcessedTableManager get sourceCaptureId {
    final $_column = $_itemColumn<String>('source_capture_id')!;

    final manager = $$RawCapturesTableTableManager(
      $_db,
      $_db.rawCaptures,
    ).filter((f) => f.captureId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceCaptureIdTable($_db));
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
  ColumnFilters<String> get artifactId => $composableBuilder(
    column: $table.artifactId,
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

  $$RawCapturesTableFilterComposer get sourceCaptureId {
    final $$RawCapturesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceCaptureId,
      referencedTable: $db.rawCaptures,
      getReferencedColumn: (t) => t.captureId,
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
  ColumnOrderings<String> get artifactId => $composableBuilder(
    column: $table.artifactId,
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

  $$RawCapturesTableOrderingComposer get sourceCaptureId {
    final $$RawCapturesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceCaptureId,
      referencedTable: $db.rawCaptures,
      getReferencedColumn: (t) => t.captureId,
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
  GeneratedColumn<String> get artifactId => $composableBuilder(
    column: $table.artifactId,
    builder: (column) => column,
  );

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

  $$RawCapturesTableAnnotationComposer get sourceCaptureId {
    final $$RawCapturesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceCaptureId,
      referencedTable: $db.rawCaptures,
      getReferencedColumn: (t) => t.captureId,
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
          PrefetchHooks Function({bool sourceCaptureId})
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
                Value<String> artifactId = const Value.absent(),
                Value<String> sourceCaptureId = const Value.absent(),
                Value<String> artifactKind = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String> provenance = const Value.absent(),
                Value<int> createdAtUtcMicros = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DerivedArtifactsCompanion(
                artifactId: artifactId,
                sourceCaptureId: sourceCaptureId,
                artifactKind: artifactKind,
                content: content,
                provenance: provenance,
                createdAtUtcMicros: createdAtUtcMicros,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String artifactId,
                required String sourceCaptureId,
                required String artifactKind,
                required String content,
                required String provenance,
                required int createdAtUtcMicros,
                Value<int> rowid = const Value.absent(),
              }) => DerivedArtifactsCompanion.insert(
                artifactId: artifactId,
                sourceCaptureId: sourceCaptureId,
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
          prefetchHooksCallback: ({sourceCaptureId = false}) {
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
                    if (sourceCaptureId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sourceCaptureId,
                        referencedTable: $$DerivedArtifactsTableReferences
                            ._sourceCaptureIdTable(db),
                        referencedColumn: $$DerivedArtifactsTableReferences
                            ._sourceCaptureIdTable(db)
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
      PrefetchHooks Function({bool sourceCaptureId})
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
