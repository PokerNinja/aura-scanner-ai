// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetScanHistoryCollection on Isar {
  IsarCollection<ScanHistory> get scanHistorys => this.collection();
}

const ScanHistorySchema = CollectionSchema(
  name: r'ScanHistory',
  id: -7298131417670308154,
  properties: {
    r'auraScore': PropertySchema(
      id: 0,
      name: r'auraScore',
      type: IsarType.long,
    ),
    r'faceHeadTiltX': PropertySchema(
      id: 1,
      name: r'faceHeadTiltX',
      type: IsarType.double,
    ),
    r'faceSmilingProbability': PropertySchema(
      id: 2,
      name: r'faceSmilingProbability',
      type: IsarType.double,
    ),
    r'imagePath': PropertySchema(
      id: 3,
      name: r'imagePath',
      type: IsarType.string,
    ),
    r'phrase': PropertySchema(
      id: 4,
      name: r'phrase',
      type: IsarType.string,
    ),
    r'scanDate': PropertySchema(
      id: 5,
      name: r'scanDate',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _scanHistoryEstimateSize,
  serialize: _scanHistorySerialize,
  deserialize: _scanHistoryDeserialize,
  deserializeProp: _scanHistoryDeserializeProp,
  idName: r'id',
  indexes: {
    r'faceSmilingProbability': IndexSchema(
      id: 3657762872200415833,
      name: r'faceSmilingProbability',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'faceSmilingProbability',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _scanHistoryGetId,
  getLinks: _scanHistoryGetLinks,
  attach: _scanHistoryAttach,
  version: '3.1.0+1',
);

int _scanHistoryEstimateSize(
  ScanHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.imagePath.length * 3;
  bytesCount += 3 + object.phrase.length * 3;
  return bytesCount;
}

void _scanHistorySerialize(
  ScanHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.auraScore);
  writer.writeDouble(offsets[1], object.faceHeadTiltX);
  writer.writeDouble(offsets[2], object.faceSmilingProbability);
  writer.writeString(offsets[3], object.imagePath);
  writer.writeString(offsets[4], object.phrase);
  writer.writeDateTime(offsets[5], object.scanDate);
}

ScanHistory _scanHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ScanHistory();
  object.auraScore = reader.readLong(offsets[0]);
  object.faceHeadTiltX = reader.readDouble(offsets[1]);
  object.faceSmilingProbability = reader.readDouble(offsets[2]);
  object.id = id;
  object.imagePath = reader.readString(offsets[3]);
  object.phrase = reader.readString(offsets[4]);
  object.scanDate = reader.readDateTime(offsets[5]);
  return object;
}

P _scanHistoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _scanHistoryGetId(ScanHistory object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _scanHistoryGetLinks(ScanHistory object) {
  return [];
}

void _scanHistoryAttach(
    IsarCollection<dynamic> col, Id id, ScanHistory object) {
  object.id = id;
}

extension ScanHistoryQueryWhereSort
    on QueryBuilder<ScanHistory, ScanHistory, QWhere> {
  QueryBuilder<ScanHistory, ScanHistory, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterWhere>
      anyFaceSmilingProbability() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'faceSmilingProbability'),
      );
    });
  }
}

extension ScanHistoryQueryWhere
    on QueryBuilder<ScanHistory, ScanHistory, QWhereClause> {
  QueryBuilder<ScanHistory, ScanHistory, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterWhereClause>
      faceSmilingProbabilityEqualTo(double faceSmilingProbability) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'faceSmilingProbability',
        value: [faceSmilingProbability],
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterWhereClause>
      faceSmilingProbabilityNotEqualTo(double faceSmilingProbability) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'faceSmilingProbability',
              lower: [],
              upper: [faceSmilingProbability],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'faceSmilingProbability',
              lower: [faceSmilingProbability],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'faceSmilingProbability',
              lower: [faceSmilingProbability],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'faceSmilingProbability',
              lower: [],
              upper: [faceSmilingProbability],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterWhereClause>
      faceSmilingProbabilityGreaterThan(
    double faceSmilingProbability, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'faceSmilingProbability',
        lower: [faceSmilingProbability],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterWhereClause>
      faceSmilingProbabilityLessThan(
    double faceSmilingProbability, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'faceSmilingProbability',
        lower: [],
        upper: [faceSmilingProbability],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterWhereClause>
      faceSmilingProbabilityBetween(
    double lowerFaceSmilingProbability,
    double upperFaceSmilingProbability, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'faceSmilingProbability',
        lower: [lowerFaceSmilingProbability],
        includeLower: includeLower,
        upper: [upperFaceSmilingProbability],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ScanHistoryQueryFilter
    on QueryBuilder<ScanHistory, ScanHistory, QFilterCondition> {
  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      auraScoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'auraScore',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      auraScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'auraScore',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      auraScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'auraScore',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      auraScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'auraScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      faceHeadTiltXEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'faceHeadTiltX',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      faceHeadTiltXGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'faceHeadTiltX',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      faceHeadTiltXLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'faceHeadTiltX',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      faceHeadTiltXBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'faceHeadTiltX',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      faceSmilingProbabilityEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'faceSmilingProbability',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      faceSmilingProbabilityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'faceSmilingProbability',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      faceSmilingProbabilityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'faceSmilingProbability',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      faceSmilingProbabilityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'faceSmilingProbability',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      imagePathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      imagePathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      imagePathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      imagePathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imagePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      imagePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      imagePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      imagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imagePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      imagePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imagePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      imagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      imagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imagePath',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition> phraseEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phrase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      phraseGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phrase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition> phraseLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phrase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition> phraseBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phrase',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      phraseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'phrase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition> phraseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'phrase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition> phraseContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'phrase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition> phraseMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'phrase',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      phraseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phrase',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      phraseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phrase',
        value: '',
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition> scanDateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scanDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      scanDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scanDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition>
      scanDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scanDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterFilterCondition> scanDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scanDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ScanHistoryQueryObject
    on QueryBuilder<ScanHistory, ScanHistory, QFilterCondition> {}

extension ScanHistoryQueryLinks
    on QueryBuilder<ScanHistory, ScanHistory, QFilterCondition> {}

extension ScanHistoryQuerySortBy
    on QueryBuilder<ScanHistory, ScanHistory, QSortBy> {
  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy> sortByAuraScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'auraScore', Sort.asc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy> sortByAuraScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'auraScore', Sort.desc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy> sortByFaceHeadTiltX() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'faceHeadTiltX', Sort.asc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy>
      sortByFaceHeadTiltXDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'faceHeadTiltX', Sort.desc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy>
      sortByFaceSmilingProbability() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'faceSmilingProbability', Sort.asc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy>
      sortByFaceSmilingProbabilityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'faceSmilingProbability', Sort.desc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy> sortByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy> sortByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy> sortByPhrase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phrase', Sort.asc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy> sortByPhraseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phrase', Sort.desc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy> sortByScanDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scanDate', Sort.asc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy> sortByScanDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scanDate', Sort.desc);
    });
  }
}

extension ScanHistoryQuerySortThenBy
    on QueryBuilder<ScanHistory, ScanHistory, QSortThenBy> {
  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy> thenByAuraScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'auraScore', Sort.asc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy> thenByAuraScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'auraScore', Sort.desc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy> thenByFaceHeadTiltX() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'faceHeadTiltX', Sort.asc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy>
      thenByFaceHeadTiltXDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'faceHeadTiltX', Sort.desc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy>
      thenByFaceSmilingProbability() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'faceSmilingProbability', Sort.asc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy>
      thenByFaceSmilingProbabilityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'faceSmilingProbability', Sort.desc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy> thenByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy> thenByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy> thenByPhrase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phrase', Sort.asc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy> thenByPhraseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phrase', Sort.desc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy> thenByScanDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scanDate', Sort.asc);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QAfterSortBy> thenByScanDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scanDate', Sort.desc);
    });
  }
}

extension ScanHistoryQueryWhereDistinct
    on QueryBuilder<ScanHistory, ScanHistory, QDistinct> {
  QueryBuilder<ScanHistory, ScanHistory, QDistinct> distinctByAuraScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'auraScore');
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QDistinct> distinctByFaceHeadTiltX() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'faceHeadTiltX');
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QDistinct>
      distinctByFaceSmilingProbability() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'faceSmilingProbability');
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QDistinct> distinctByImagePath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imagePath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QDistinct> distinctByPhrase(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phrase', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ScanHistory, ScanHistory, QDistinct> distinctByScanDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scanDate');
    });
  }
}

extension ScanHistoryQueryProperty
    on QueryBuilder<ScanHistory, ScanHistory, QQueryProperty> {
  QueryBuilder<ScanHistory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ScanHistory, int, QQueryOperations> auraScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'auraScore');
    });
  }

  QueryBuilder<ScanHistory, double, QQueryOperations> faceHeadTiltXProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'faceHeadTiltX');
    });
  }

  QueryBuilder<ScanHistory, double, QQueryOperations>
      faceSmilingProbabilityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'faceSmilingProbability');
    });
  }

  QueryBuilder<ScanHistory, String, QQueryOperations> imagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imagePath');
    });
  }

  QueryBuilder<ScanHistory, String, QQueryOperations> phraseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phrase');
    });
  }

  QueryBuilder<ScanHistory, DateTime, QQueryOperations> scanDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scanDate');
    });
  }
}
