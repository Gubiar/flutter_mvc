// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ToDoModel.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetToDoCollection on Isar {
  IsarCollection<ToDo> get toDos => this.collection();
}

const ToDoSchema = CollectionSchema(
  name: r'ToDo',
  id: 8921182537089852344,
  properties: {
    r'dataConclusao': PropertySchema(
      id: 0,
      name: r'dataConclusao',
      type: IsarType.dateTime,
    ),
    r'dataCriacao': PropertySchema(
      id: 1,
      name: r'dataCriacao',
      type: IsarType.dateTime,
    ),
    r'dataMaximaConclusao': PropertySchema(
      id: 2,
      name: r'dataMaximaConclusao',
      type: IsarType.dateTime,
    ),
    r'item': PropertySchema(
      id: 3,
      name: r'item',
      type: IsarType.string,
    ),
    r'statusId': PropertySchema(
      id: 4,
      name: r'statusId',
      type: IsarType.long,
    )
  },
  estimateSize: _toDoEstimateSize,
  serialize: _toDoSerialize,
  deserialize: _toDoDeserialize,
  deserializeProp: _toDoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _toDoGetId,
  getLinks: _toDoGetLinks,
  attach: _toDoAttach,
  version: '3.1.0+1',
);

int _toDoEstimateSize(
  ToDo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.item;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _toDoSerialize(
  ToDo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dataConclusao);
  writer.writeDateTime(offsets[1], object.dataCriacao);
  writer.writeDateTime(offsets[2], object.dataMaximaConclusao);
  writer.writeString(offsets[3], object.item);
  writer.writeLong(offsets[4], object.statusId);
}

ToDo _toDoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ToDo();
  object.dataConclusao = reader.readDateTimeOrNull(offsets[0]);
  object.dataCriacao = reader.readDateTimeOrNull(offsets[1]);
  object.dataMaximaConclusao = reader.readDateTimeOrNull(offsets[2]);
  object.id = id;
  object.item = reader.readStringOrNull(offsets[3]);
  object.statusId = reader.readLongOrNull(offsets[4]);
  return object;
}

P _toDoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _toDoGetId(ToDo object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _toDoGetLinks(ToDo object) {
  return [];
}

void _toDoAttach(IsarCollection<dynamic> col, Id id, ToDo object) {
  object.id = id;
}

extension ToDoQueryWhereSort on QueryBuilder<ToDo, ToDo, QWhere> {
  QueryBuilder<ToDo, ToDo, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ToDoQueryWhere on QueryBuilder<ToDo, ToDo, QWhereClause> {
  QueryBuilder<ToDo, ToDo, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<ToDo, ToDo, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterWhereClause> idBetween(
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

extension ToDoQueryFilter on QueryBuilder<ToDo, ToDo, QFilterCondition> {
  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> dataConclusaoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dataConclusao',
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> dataConclusaoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dataConclusao',
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> dataConclusaoEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataConclusao',
        value: value,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> dataConclusaoGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dataConclusao',
        value: value,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> dataConclusaoLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dataConclusao',
        value: value,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> dataConclusaoBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dataConclusao',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> dataCriacaoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dataCriacao',
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> dataCriacaoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dataCriacao',
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> dataCriacaoEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataCriacao',
        value: value,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> dataCriacaoGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dataCriacao',
        value: value,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> dataCriacaoLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dataCriacao',
        value: value,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> dataCriacaoBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dataCriacao',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> dataMaximaConclusaoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dataMaximaConclusao',
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition>
      dataMaximaConclusaoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dataMaximaConclusao',
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> dataMaximaConclusaoEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataMaximaConclusao',
        value: value,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition>
      dataMaximaConclusaoGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dataMaximaConclusao',
        value: value,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> dataMaximaConclusaoLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dataMaximaConclusao',
        value: value,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> dataMaximaConclusaoBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dataMaximaConclusao',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> itemIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'item',
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> itemIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'item',
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> itemEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'item',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> itemGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'item',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> itemLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'item',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> itemBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'item',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> itemStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'item',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> itemEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'item',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> itemContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'item',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> itemMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'item',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> itemIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'item',
        value: '',
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> itemIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'item',
        value: '',
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> statusIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'statusId',
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> statusIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'statusId',
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> statusIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statusId',
        value: value,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> statusIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'statusId',
        value: value,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> statusIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'statusId',
        value: value,
      ));
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterFilterCondition> statusIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'statusId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ToDoQueryObject on QueryBuilder<ToDo, ToDo, QFilterCondition> {}

extension ToDoQueryLinks on QueryBuilder<ToDo, ToDo, QFilterCondition> {}

extension ToDoQuerySortBy on QueryBuilder<ToDo, ToDo, QSortBy> {
  QueryBuilder<ToDo, ToDo, QAfterSortBy> sortByDataConclusao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataConclusao', Sort.asc);
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterSortBy> sortByDataConclusaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataConclusao', Sort.desc);
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterSortBy> sortByDataCriacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCriacao', Sort.asc);
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterSortBy> sortByDataCriacaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCriacao', Sort.desc);
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterSortBy> sortByDataMaximaConclusao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataMaximaConclusao', Sort.asc);
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterSortBy> sortByDataMaximaConclusaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataMaximaConclusao', Sort.desc);
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterSortBy> sortByItem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'item', Sort.asc);
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterSortBy> sortByItemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'item', Sort.desc);
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterSortBy> sortByStatusId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusId', Sort.asc);
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterSortBy> sortByStatusIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusId', Sort.desc);
    });
  }
}

extension ToDoQuerySortThenBy on QueryBuilder<ToDo, ToDo, QSortThenBy> {
  QueryBuilder<ToDo, ToDo, QAfterSortBy> thenByDataConclusao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataConclusao', Sort.asc);
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterSortBy> thenByDataConclusaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataConclusao', Sort.desc);
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterSortBy> thenByDataCriacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCriacao', Sort.asc);
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterSortBy> thenByDataCriacaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataCriacao', Sort.desc);
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterSortBy> thenByDataMaximaConclusao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataMaximaConclusao', Sort.asc);
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterSortBy> thenByDataMaximaConclusaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataMaximaConclusao', Sort.desc);
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterSortBy> thenByItem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'item', Sort.asc);
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterSortBy> thenByItemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'item', Sort.desc);
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterSortBy> thenByStatusId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusId', Sort.asc);
    });
  }

  QueryBuilder<ToDo, ToDo, QAfterSortBy> thenByStatusIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusId', Sort.desc);
    });
  }
}

extension ToDoQueryWhereDistinct on QueryBuilder<ToDo, ToDo, QDistinct> {
  QueryBuilder<ToDo, ToDo, QDistinct> distinctByDataConclusao() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataConclusao');
    });
  }

  QueryBuilder<ToDo, ToDo, QDistinct> distinctByDataCriacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataCriacao');
    });
  }

  QueryBuilder<ToDo, ToDo, QDistinct> distinctByDataMaximaConclusao() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataMaximaConclusao');
    });
  }

  QueryBuilder<ToDo, ToDo, QDistinct> distinctByItem(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'item', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ToDo, ToDo, QDistinct> distinctByStatusId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statusId');
    });
  }
}

extension ToDoQueryProperty on QueryBuilder<ToDo, ToDo, QQueryProperty> {
  QueryBuilder<ToDo, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ToDo, DateTime?, QQueryOperations> dataConclusaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataConclusao');
    });
  }

  QueryBuilder<ToDo, DateTime?, QQueryOperations> dataCriacaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataCriacao');
    });
  }

  QueryBuilder<ToDo, DateTime?, QQueryOperations>
      dataMaximaConclusaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataMaximaConclusao');
    });
  }

  QueryBuilder<ToDo, String?, QQueryOperations> itemProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'item');
    });
  }

  QueryBuilder<ToDo, int?, QQueryOperations> statusIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statusId');
    });
  }
}
