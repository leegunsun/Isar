// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testcollection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTestCollectionCollection on Isar {
  IsarCollection<TestCollection> get testCollections => this.collection();
}

const TestCollectionSchema = CollectionSchema(
  name: r'Test',
  id: -5479267249076327074,
  properties: {
    r'embed': PropertySchema(
      id: 0,
      name: r'embed',
      type: IsarType.object,
      target: r'Recepient',
    ),
    r'embedList': PropertySchema(
      id: 1,
      name: r'embedList',
      type: IsarType.objectList,
      target: r'Recepient',
    ),
    r'listTest': PropertySchema(
      id: 2,
      name: r'listTest',
      type: IsarType.stringList,
    ),
    r'waIncom': PropertySchema(
      id: 3,
      name: r'waIncom',
      type: IsarType.string,
    )
  },
  estimateSize: _testCollectionEstimateSize,
  serialize: _testCollectionSerialize,
  deserialize: _testCollectionDeserialize,
  deserializeProp: _testCollectionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'Recepient': RecepientSchema},
  getId: _testCollectionGetId,
  getLinks: _testCollectionGetLinks,
  attach: _testCollectionAttach,
  version: '3.1.0+1',
);

int _testCollectionEstimateSize(
  TestCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.recipient;
    if (value != null) {
      bytesCount += 3 +
          RecepientSchema.estimateSize(
              value, allOffsets[Recepient]!, allOffsets);
    }
  }
  {
    final list = object.listRTest;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[Recepient]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              RecepientSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final list = object.listTest;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.marchent;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _testCollectionSerialize(
  TestCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<Recepient>(
    offsets[0],
    allOffsets,
    RecepientSchema.serialize,
    object.recipient,
  );
  writer.writeObjectList<Recepient>(
    offsets[1],
    allOffsets,
    RecepientSchema.serialize,
    object.listRTest,
  );
  writer.writeStringList(offsets[2], object.listTest);
  writer.writeString(offsets[3], object.marchent);
}

TestCollection _testCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TestCollection();
  object.recipient = reader.readObjectOrNull<Recepient>(
    offsets[0],
    RecepientSchema.deserialize,
    allOffsets,
  );
  object.listRTest = reader.readObjectList<Recepient>(
    offsets[1],
    RecepientSchema.deserialize,
    allOffsets,
    Recepient(),
  );
  object.myObjectId = id;
  object.listTest = reader.readStringList(offsets[2]);
  object.marchent = reader.readStringOrNull(offsets[3]);
  return object;
}

P _testCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<Recepient>(
        offset,
        RecepientSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readObjectList<Recepient>(
        offset,
        RecepientSchema.deserialize,
        allOffsets,
        Recepient(),
      )) as P;
    case 2:
      return (reader.readStringList(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _testCollectionGetId(TestCollection object) {
  return object.myObjectId;
}

List<IsarLinkBase<dynamic>> _testCollectionGetLinks(TestCollection object) {
  return [];
}

void _testCollectionAttach(
    IsarCollection<dynamic> col, Id id, TestCollection object) {
  object.myObjectId = id;
}

extension TestCollectionQueryWhereSort
    on QueryBuilder<TestCollection, TestCollection, QWhere> {
  QueryBuilder<TestCollection, TestCollection, QAfterWhere> anyMyObjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TestCollectionQueryWhere
    on QueryBuilder<TestCollection, TestCollection, QWhereClause> {
  QueryBuilder<TestCollection, TestCollection, QAfterWhereClause>
      myObjectIdEqualTo(Id myObjectId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: myObjectId,
        upper: myObjectId,
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterWhereClause>
      myObjectIdNotEqualTo(Id myObjectId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: myObjectId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: myObjectId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: myObjectId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: myObjectId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterWhereClause>
      myObjectIdGreaterThan(Id myObjectId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: myObjectId, includeLower: include),
      );
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterWhereClause>
      myObjectIdLessThan(Id myObjectId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: myObjectId, includeUpper: include),
      );
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterWhereClause>
      myObjectIdBetween(
    Id lowerMyObjectId,
    Id upperMyObjectId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerMyObjectId,
        includeLower: includeLower,
        upper: upperMyObjectId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TestCollectionQueryFilter
    on QueryBuilder<TestCollection, TestCollection, QFilterCondition> {
  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      recipientIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'embed',
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      recipientIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'embed',
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listRTestIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'embedList',
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listRTestIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'embedList',
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listRTestLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'embedList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listRTestIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'embedList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listRTestIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'embedList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listRTestLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'embedList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listRTestLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'embedList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listRTestLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'embedList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      myObjectIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      myObjectIdGreaterThan(
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

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      myObjectIdLessThan(
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

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      myObjectIdBetween(
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

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listTestIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'listTest',
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listTestIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'listTest',
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listTestElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'listTest',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listTestElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'listTest',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listTestElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'listTest',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listTestElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'listTest',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listTestElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'listTest',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listTestElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'listTest',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listTestElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'listTest',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listTestElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'listTest',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listTestElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'listTest',
        value: '',
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listTestElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'listTest',
        value: '',
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listTestLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listTest',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listTestIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listTest',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listTestIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listTest',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listTestLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listTest',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listTestLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listTest',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listTestLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'listTest',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      marchentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'waIncom',
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      marchentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'waIncom',
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      marchentEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'waIncom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      marchentGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'waIncom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      marchentLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'waIncom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      marchentBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'waIncom',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      marchentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'waIncom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      marchentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'waIncom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      marchentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'waIncom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      marchentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'waIncom',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      marchentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'waIncom',
        value: '',
      ));
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      marchentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'waIncom',
        value: '',
      ));
    });
  }
}

extension TestCollectionQueryObject
    on QueryBuilder<TestCollection, TestCollection, QFilterCondition> {
  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition> recipient(
      FilterQuery<Recepient> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'embed');
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterFilterCondition>
      listRTestElement(FilterQuery<Recepient> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'embedList');
    });
  }
}

extension TestCollectionQueryLinks
    on QueryBuilder<TestCollection, TestCollection, QFilterCondition> {}

extension TestCollectionQuerySortBy
    on QueryBuilder<TestCollection, TestCollection, QSortBy> {
  QueryBuilder<TestCollection, TestCollection, QAfterSortBy> sortByMarchent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waIncom', Sort.asc);
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterSortBy>
      sortByMarchentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waIncom', Sort.desc);
    });
  }
}

extension TestCollectionQuerySortThenBy
    on QueryBuilder<TestCollection, TestCollection, QSortThenBy> {
  QueryBuilder<TestCollection, TestCollection, QAfterSortBy>
      thenByMyObjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterSortBy>
      thenByMyObjectIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterSortBy> thenByMarchent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waIncom', Sort.asc);
    });
  }

  QueryBuilder<TestCollection, TestCollection, QAfterSortBy>
      thenByMarchentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waIncom', Sort.desc);
    });
  }
}

extension TestCollectionQueryWhereDistinct
    on QueryBuilder<TestCollection, TestCollection, QDistinct> {
  QueryBuilder<TestCollection, TestCollection, QDistinct> distinctByListTest() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'listTest');
    });
  }

  QueryBuilder<TestCollection, TestCollection, QDistinct> distinctByMarchent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waIncom', caseSensitive: caseSensitive);
    });
  }
}

extension TestCollectionQueryProperty
    on QueryBuilder<TestCollection, TestCollection, QQueryProperty> {
  QueryBuilder<TestCollection, int, QQueryOperations> myObjectIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TestCollection, Recepient?, QQueryOperations>
      recipientProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'embed');
    });
  }

  QueryBuilder<TestCollection, List<Recepient>?, QQueryOperations>
      listRTestProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'embedList');
    });
  }

  QueryBuilder<TestCollection, List<String>?, QQueryOperations>
      listTestProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'listTest');
    });
  }

  QueryBuilder<TestCollection, String?, QQueryOperations> marchentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waIncom');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RecepientSchema = Schema(
  name: r'Recepient',
  id: 197522405829910364,
  properties: {
    r'address': PropertySchema(
      id: 0,
      name: r'address',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _recepientEstimateSize,
  serialize: _recepientSerialize,
  deserialize: _recepientDeserialize,
  deserializeProp: _recepientDeserializeProp,
);

int _recepientEstimateSize(
  Recepient object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.address;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _recepientSerialize(
  Recepient object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.address);
  writer.writeString(offsets[1], object.name);
}

Recepient _recepientDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Recepient();
  object.address = reader.readStringOrNull(offsets[0]);
  object.name = reader.readStringOrNull(offsets[1]);
  return object;
}

P _recepientDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension RecepientQueryFilter
    on QueryBuilder<Recepient, Recepient, QFilterCondition> {
  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> addressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'address',
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> addressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'address',
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> addressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> addressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> addressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> addressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'address',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> addressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> addressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> addressContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> addressMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'address',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> addressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition>
      addressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Recepient, Recepient, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension RecepientQueryObject
    on QueryBuilder<Recepient, Recepient, QFilterCondition> {}
