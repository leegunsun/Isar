// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'igtest.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIgTestCollection on Isar {
  IsarCollection<IgTest> get igTests => this.collection();
}

const IgTestSchema = CollectionSchema(
  name: r'IgTest',
  id: -7138808372980734551,
  properties: {
    r'igAge': PropertySchema(
      id: 0,
      name: r'igAge',
      type: IsarType.long,
    ),
    r'igName': PropertySchema(
      id: 1,
      name: r'igName',
      type: IsarType.string,
    )
  },
  estimateSize: _igTestEstimateSize,
  serialize: _igTestSerialize,
  deserialize: _igTestDeserialize,
  deserializeProp: _igTestDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _igTestGetId,
  getLinks: _igTestGetLinks,
  attach: _igTestAttach,
  version: '3.1.0+1',
);

int _igTestEstimateSize(
  IgTest object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.igUsername;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _igTestSerialize(
  IgTest object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.age);
  writer.writeString(offsets[1], object.igUsername);
}

IgTest _igTestDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IgTest();
  object.id = id;
  object.age = reader.readLongOrNull(offsets[0]);
  object.igUsername = reader.readStringOrNull(offsets[1]);
  return object;
}

P _igTestDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _igTestGetId(IgTest object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _igTestGetLinks(IgTest object) {
  return [];
}

void _igTestAttach(IsarCollection<dynamic> col, Id id, IgTest object) {
  object.id = id;
}

extension IgTestQueryWhereSort on QueryBuilder<IgTest, IgTest, QWhere> {
  QueryBuilder<IgTest, IgTest, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IgTestQueryWhere on QueryBuilder<IgTest, IgTest, QWhereClause> {
  QueryBuilder<IgTest, IgTest, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<IgTest, IgTest, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterWhereClause> idBetween(
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
}

extension IgTestQueryFilter on QueryBuilder<IgTest, IgTest, QFilterCondition> {
  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> idBetween(
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

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> ageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'igAge',
      ));
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> ageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'igAge',
      ));
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> ageEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'igAge',
        value: value,
      ));
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> ageGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'igAge',
        value: value,
      ));
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> ageLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'igAge',
        value: value,
      ));
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> ageBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'igAge',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> igUsernameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'igName',
      ));
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> igUsernameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'igName',
      ));
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> igUsernameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'igName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> igUsernameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'igName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> igUsernameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'igName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> igUsernameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'igName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> igUsernameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'igName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> igUsernameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'igName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> igUsernameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'igName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> igUsernameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'igName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> igUsernameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'igName',
        value: '',
      ));
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterFilterCondition> igUsernameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'igName',
        value: '',
      ));
    });
  }
}

extension IgTestQueryObject on QueryBuilder<IgTest, IgTest, QFilterCondition> {}

extension IgTestQueryLinks on QueryBuilder<IgTest, IgTest, QFilterCondition> {}

extension IgTestQuerySortBy on QueryBuilder<IgTest, IgTest, QSortBy> {
  QueryBuilder<IgTest, IgTest, QAfterSortBy> sortByAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'igAge', Sort.asc);
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterSortBy> sortByAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'igAge', Sort.desc);
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterSortBy> sortByIgUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'igName', Sort.asc);
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterSortBy> sortByIgUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'igName', Sort.desc);
    });
  }
}

extension IgTestQuerySortThenBy on QueryBuilder<IgTest, IgTest, QSortThenBy> {
  QueryBuilder<IgTest, IgTest, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterSortBy> thenByAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'igAge', Sort.asc);
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterSortBy> thenByAgeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'igAge', Sort.desc);
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterSortBy> thenByIgUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'igName', Sort.asc);
    });
  }

  QueryBuilder<IgTest, IgTest, QAfterSortBy> thenByIgUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'igName', Sort.desc);
    });
  }
}

extension IgTestQueryWhereDistinct on QueryBuilder<IgTest, IgTest, QDistinct> {
  QueryBuilder<IgTest, IgTest, QDistinct> distinctByAge() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'igAge');
    });
  }

  QueryBuilder<IgTest, IgTest, QDistinct> distinctByIgUsername(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'igName', caseSensitive: caseSensitive);
    });
  }
}

extension IgTestQueryProperty on QueryBuilder<IgTest, IgTest, QQueryProperty> {
  QueryBuilder<IgTest, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IgTest, int?, QQueryOperations> ageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'igAge');
    });
  }

  QueryBuilder<IgTest, String?, QQueryOperations> igUsernameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'igName');
    });
  }
}
