// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark
import '../../../../graphql/fragments.graphql.dart';
import '../../../../graphql/schema.graphql.dart';
import 'dart:async';
import 'package:flutter/widgets.dart' as widgets;
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart' as graphql_flutter;

class Variables$Query$Overview {
  factory Variables$Query$Overview({
    int? page,
    required int userId,
    Enum$MediaType? type,
  }) =>
      Variables$Query$Overview._({
        if (page != null) r'page': page,
        r'userId': userId,
        if (type != null) r'type': type,
      });

  Variables$Query$Overview._(this._$data);

  factory Variables$Query$Overview.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('page')) {
      final l$page = data['page'];
      result$data['page'] = (l$page as int?);
    }
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as int);
    if (data.containsKey('type')) {
      final l$type = data['type'];
      result$data['type'] =
          l$type == null ? null : fromJson$Enum$MediaType((l$type as String));
    }
    return Variables$Query$Overview._(result$data);
  }

  Map<String, dynamic> _$data;

  int? get page => (_$data['page'] as int?);
  int get userId => (_$data['userId'] as int);
  Enum$MediaType? get type => (_$data['type'] as Enum$MediaType?);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('page')) {
      final l$page = page;
      result$data['page'] = l$page;
    }
    final l$userId = userId;
    result$data['userId'] = l$userId;
    if (_$data.containsKey('type')) {
      final l$type = type;
      result$data['type'] =
          l$type == null ? null : toJson$Enum$MediaType(l$type);
    }
    return result$data;
  }

  CopyWith$Variables$Query$Overview<Variables$Query$Overview> get copyWith =>
      CopyWith$Variables$Query$Overview(
        this,
        (i) => i,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$Overview) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$page = page;
    final lOther$page = other.page;
    if (_$data.containsKey('page') != other._$data.containsKey('page')) {
      return false;
    }
    if (l$page != lOther$page) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$type = type;
    final lOther$type = other.type;
    if (_$data.containsKey('type') != other._$data.containsKey('type')) {
      return false;
    }
    if (l$type != lOther$type) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$page = page;
    final l$userId = userId;
    final l$type = type;
    return Object.hashAll([
      _$data.containsKey('page') ? l$page : const {},
      l$userId,
      _$data.containsKey('type') ? l$type : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Query$Overview<TRes> {
  factory CopyWith$Variables$Query$Overview(
    Variables$Query$Overview instance,
    TRes Function(Variables$Query$Overview) then,
  ) = _CopyWithImpl$Variables$Query$Overview;

  factory CopyWith$Variables$Query$Overview.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$Overview;

  TRes call({
    int? page,
    int? userId,
    Enum$MediaType? type,
  });
}

class _CopyWithImpl$Variables$Query$Overview<TRes>
    implements CopyWith$Variables$Query$Overview<TRes> {
  _CopyWithImpl$Variables$Query$Overview(
    this._instance,
    this._then,
  );

  final Variables$Query$Overview _instance;

  final TRes Function(Variables$Query$Overview) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? page = _undefined,
    Object? userId = _undefined,
    Object? type = _undefined,
  }) =>
      _then(Variables$Query$Overview._({
        ..._instance._$data,
        if (page != _undefined) 'page': (page as int?),
        if (userId != _undefined && userId != null) 'userId': (userId as int),
        if (type != _undefined) 'type': (type as Enum$MediaType?),
      }));
}

class _CopyWithStubImpl$Variables$Query$Overview<TRes>
    implements CopyWith$Variables$Query$Overview<TRes> {
  _CopyWithStubImpl$Variables$Query$Overview(this._res);

  TRes _res;

  call({
    int? page,
    int? userId,
    Enum$MediaType? type,
  }) =>
      _res;
}

class Query$Overview {
  Query$Overview({
    this.releasing,
    this.list,
    this.forums,
    this.$__typename = 'Query',
  });

  factory Query$Overview.fromJson(Map<String, dynamic> json) {
    final l$releasing = json['releasing'];
    final l$list = json['list'];
    final l$forums = json['forums'];
    final l$$__typename = json['__typename'];
    return Query$Overview(
      releasing: l$releasing == null
          ? null
          : Query$Overview$releasing.fromJson(
              (l$releasing as Map<String, dynamic>)),
      list: l$list == null
          ? null
          : Query$Overview$list.fromJson((l$list as Map<String, dynamic>)),
      forums: l$forums == null
          ? null
          : Query$Overview$forums.fromJson((l$forums as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$Overview$releasing? releasing;

  final Query$Overview$list? list;

  final Query$Overview$forums? forums;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$releasing = releasing;
    _resultData['releasing'] = l$releasing?.toJson();
    final l$list = list;
    _resultData['list'] = l$list?.toJson();
    final l$forums = forums;
    _resultData['forums'] = l$forums?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$releasing = releasing;
    final l$list = list;
    final l$forums = forums;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$releasing,
      l$list,
      l$forums,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Overview) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$releasing = releasing;
    final lOther$releasing = other.releasing;
    if (l$releasing != lOther$releasing) {
      return false;
    }
    final l$list = list;
    final lOther$list = other.list;
    if (l$list != lOther$list) {
      return false;
    }
    final l$forums = forums;
    final lOther$forums = other.forums;
    if (l$forums != lOther$forums) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$Overview on Query$Overview {
  CopyWith$Query$Overview<Query$Overview> get copyWith =>
      CopyWith$Query$Overview(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Overview<TRes> {
  factory CopyWith$Query$Overview(
    Query$Overview instance,
    TRes Function(Query$Overview) then,
  ) = _CopyWithImpl$Query$Overview;

  factory CopyWith$Query$Overview.stub(TRes res) =
      _CopyWithStubImpl$Query$Overview;

  TRes call({
    Query$Overview$releasing? releasing,
    Query$Overview$list? list,
    Query$Overview$forums? forums,
    String? $__typename,
  });
  CopyWith$Query$Overview$releasing<TRes> get releasing;
  CopyWith$Query$Overview$list<TRes> get list;
  CopyWith$Query$Overview$forums<TRes> get forums;
}

class _CopyWithImpl$Query$Overview<TRes>
    implements CopyWith$Query$Overview<TRes> {
  _CopyWithImpl$Query$Overview(
    this._instance,
    this._then,
  );

  final Query$Overview _instance;

  final TRes Function(Query$Overview) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? releasing = _undefined,
    Object? list = _undefined,
    Object? forums = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Overview(
        releasing: releasing == _undefined
            ? _instance.releasing
            : (releasing as Query$Overview$releasing?),
        list: list == _undefined
            ? _instance.list
            : (list as Query$Overview$list?),
        forums: forums == _undefined
            ? _instance.forums
            : (forums as Query$Overview$forums?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$Overview$releasing<TRes> get releasing {
    final local$releasing = _instance.releasing;
    return local$releasing == null
        ? CopyWith$Query$Overview$releasing.stub(_then(_instance))
        : CopyWith$Query$Overview$releasing(
            local$releasing, (e) => call(releasing: e));
  }

  CopyWith$Query$Overview$list<TRes> get list {
    final local$list = _instance.list;
    return local$list == null
        ? CopyWith$Query$Overview$list.stub(_then(_instance))
        : CopyWith$Query$Overview$list(local$list, (e) => call(list: e));
  }

  CopyWith$Query$Overview$forums<TRes> get forums {
    final local$forums = _instance.forums;
    return local$forums == null
        ? CopyWith$Query$Overview$forums.stub(_then(_instance))
        : CopyWith$Query$Overview$forums(local$forums, (e) => call(forums: e));
  }
}

class _CopyWithStubImpl$Query$Overview<TRes>
    implements CopyWith$Query$Overview<TRes> {
  _CopyWithStubImpl$Query$Overview(this._res);

  TRes _res;

  call({
    Query$Overview$releasing? releasing,
    Query$Overview$list? list,
    Query$Overview$forums? forums,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$Overview$releasing<TRes> get releasing =>
      CopyWith$Query$Overview$releasing.stub(_res);
  CopyWith$Query$Overview$list<TRes> get list =>
      CopyWith$Query$Overview$list.stub(_res);
  CopyWith$Query$Overview$forums<TRes> get forums =>
      CopyWith$Query$Overview$forums.stub(_res);
}

const documentNodeQueryOverview = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'Overview'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'page')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: IntValueNode(value: '1')),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'userId')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'type')),
        type: NamedTypeNode(
          name: NameNode(value: 'MediaType'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'Page'),
        alias: NameNode(value: 'releasing'),
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'page'),
            value: VariableNode(name: NameNode(value: 'page')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'pageInfo'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'hasNextPage'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: 'media'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'onList'),
                value: BooleanValueNode(value: true),
              ),
              ArgumentNode(
                name: NameNode(value: 'status_in'),
                value: ListValueNode(values: [
                  EnumValueNode(name: NameNode(value: 'RELEASING')),
                  EnumValueNode(name: NameNode(value: 'NOT_YET_RELEASED')),
                ]),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                name: NameNode(value: 'ReleasingMedia'),
                directives: [],
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: 'Page'),
        alias: NameNode(value: 'list'),
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'mediaList'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'userId'),
                value: VariableNode(name: NameNode(value: 'userId')),
              ),
              ArgumentNode(
                name: NameNode(value: 'status_in'),
                value: ListValueNode(values: [
                  EnumValueNode(name: NameNode(value: 'CURRENT')),
                  EnumValueNode(name: NameNode(value: 'REPEATING')),
                ]),
              ),
              ArgumentNode(
                name: NameNode(value: 'sort'),
                value:
                    EnumValueNode(name: NameNode(value: 'UPDATED_TIME_DESC')),
              ),
              ArgumentNode(
                name: NameNode(value: 'type'),
                value: VariableNode(name: NameNode(value: 'type')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                name: NameNode(value: 'MediaListEntry'),
                directives: [],
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: 'Page'),
        alias: NameNode(value: 'forums'),
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'perPage'),
            value: IntValueNode(value: '5'),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'threads'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'sort'),
                value: EnumValueNode(name: NameNode(value: 'REPLIED_AT_DESC')),
              )
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                name: NameNode(value: 'ThreadFragment'),
                directives: [],
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionReleasingMedia,
  fragmentDefinitionMediaFragment,
  fragmentDefinitionMediaListEntry,
  fragmentDefinitionFuzzyDate,
  fragmentDefinitionThreadFragment,
]);
Query$Overview _parserFn$Query$Overview(Map<String, dynamic> data) =>
    Query$Overview.fromJson(data);
typedef OnQueryComplete$Query$Overview = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$Overview?,
);

class Options$Query$Overview extends graphql.QueryOptions<Query$Overview> {
  Options$Query$Overview({
    String? operationName,
    required Variables$Query$Overview variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$Overview? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$Overview? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          pollInterval: pollInterval,
          context: context,
          onComplete: onComplete == null
              ? null
              : (data) => onComplete(
                    data,
                    data == null ? null : _parserFn$Query$Overview(data),
                  ),
          onError: onError,
          document: documentNodeQueryOverview,
          parserFn: _parserFn$Query$Overview,
        );

  final OnQueryComplete$Query$Overview? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$Overview
    extends graphql.WatchQueryOptions<Query$Overview> {
  WatchOptions$Query$Overview({
    String? operationName,
    required Variables$Query$Overview variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$Overview? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables.toJson(),
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryOverview,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$Overview,
        );
}

class FetchMoreOptions$Query$Overview extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$Overview({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$Overview variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables.toJson(),
          document: documentNodeQueryOverview,
        );
}

extension ClientExtension$Query$Overview on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$Overview>> query$Overview(
          Options$Query$Overview options) async =>
      await this.query(options);
  graphql.ObservableQuery<Query$Overview> watchQuery$Overview(
          WatchOptions$Query$Overview options) =>
      this.watchQuery(options);
  void writeQuery$Overview({
    required Query$Overview data,
    required Variables$Query$Overview variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation: graphql.Operation(document: documentNodeQueryOverview),
          variables: variables.toJson(),
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$Overview? readQuery$Overview({
    required Variables$Query$Overview variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryOverview),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$Overview.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$Overview> useQuery$Overview(
        Options$Query$Overview options) =>
    graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$Overview> useWatchQuery$Overview(
        WatchOptions$Query$Overview options) =>
    graphql_flutter.useWatchQuery(options);

class Query$Overview$Widget extends graphql_flutter.Query<Query$Overview> {
  Query$Overview$Widget({
    widgets.Key? key,
    required Options$Query$Overview options,
    required graphql_flutter.QueryBuilder<Query$Overview> builder,
  }) : super(
          key: key,
          options: options,
          builder: builder,
        );
}

class Query$Overview$releasing {
  Query$Overview$releasing({
    this.pageInfo,
    this.media,
    this.$__typename = 'Page',
  });

  factory Query$Overview$releasing.fromJson(Map<String, dynamic> json) {
    final l$pageInfo = json['pageInfo'];
    final l$media = json['media'];
    final l$$__typename = json['__typename'];
    return Query$Overview$releasing(
      pageInfo: l$pageInfo == null
          ? null
          : Query$Overview$releasing$pageInfo.fromJson(
              (l$pageInfo as Map<String, dynamic>)),
      media: (l$media as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : Fragment$ReleasingMedia.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$Overview$releasing$pageInfo? pageInfo;

  final List<Fragment$ReleasingMedia?>? media;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$pageInfo = pageInfo;
    _resultData['pageInfo'] = l$pageInfo?.toJson();
    final l$media = media;
    _resultData['media'] = l$media?.map((e) => e?.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$pageInfo = pageInfo;
    final l$media = media;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$pageInfo,
      l$media == null ? null : Object.hashAll(l$media.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Overview$releasing) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$pageInfo = pageInfo;
    final lOther$pageInfo = other.pageInfo;
    if (l$pageInfo != lOther$pageInfo) {
      return false;
    }
    final l$media = media;
    final lOther$media = other.media;
    if (l$media != null && lOther$media != null) {
      if (l$media.length != lOther$media.length) {
        return false;
      }
      for (int i = 0; i < l$media.length; i++) {
        final l$media$entry = l$media[i];
        final lOther$media$entry = lOther$media[i];
        if (l$media$entry != lOther$media$entry) {
          return false;
        }
      }
    } else if (l$media != lOther$media) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$Overview$releasing
    on Query$Overview$releasing {
  CopyWith$Query$Overview$releasing<Query$Overview$releasing> get copyWith =>
      CopyWith$Query$Overview$releasing(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Overview$releasing<TRes> {
  factory CopyWith$Query$Overview$releasing(
    Query$Overview$releasing instance,
    TRes Function(Query$Overview$releasing) then,
  ) = _CopyWithImpl$Query$Overview$releasing;

  factory CopyWith$Query$Overview$releasing.stub(TRes res) =
      _CopyWithStubImpl$Query$Overview$releasing;

  TRes call({
    Query$Overview$releasing$pageInfo? pageInfo,
    List<Fragment$ReleasingMedia?>? media,
    String? $__typename,
  });
  CopyWith$Query$Overview$releasing$pageInfo<TRes> get pageInfo;
  TRes media(
      Iterable<Fragment$ReleasingMedia?>? Function(
              Iterable<
                  CopyWith$Fragment$ReleasingMedia<Fragment$ReleasingMedia>?>?)
          _fn);
}

class _CopyWithImpl$Query$Overview$releasing<TRes>
    implements CopyWith$Query$Overview$releasing<TRes> {
  _CopyWithImpl$Query$Overview$releasing(
    this._instance,
    this._then,
  );

  final Query$Overview$releasing _instance;

  final TRes Function(Query$Overview$releasing) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? pageInfo = _undefined,
    Object? media = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Overview$releasing(
        pageInfo: pageInfo == _undefined
            ? _instance.pageInfo
            : (pageInfo as Query$Overview$releasing$pageInfo?),
        media: media == _undefined
            ? _instance.media
            : (media as List<Fragment$ReleasingMedia?>?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$Overview$releasing$pageInfo<TRes> get pageInfo {
    final local$pageInfo = _instance.pageInfo;
    return local$pageInfo == null
        ? CopyWith$Query$Overview$releasing$pageInfo.stub(_then(_instance))
        : CopyWith$Query$Overview$releasing$pageInfo(
            local$pageInfo, (e) => call(pageInfo: e));
  }

  TRes media(
          Iterable<Fragment$ReleasingMedia?>? Function(
                  Iterable<
                      CopyWith$Fragment$ReleasingMedia<
                          Fragment$ReleasingMedia>?>?)
              _fn) =>
      call(
          media: _fn(_instance.media?.map((e) => e == null
              ? null
              : CopyWith$Fragment$ReleasingMedia(
                  e,
                  (i) => i,
                )))?.toList());
}

class _CopyWithStubImpl$Query$Overview$releasing<TRes>
    implements CopyWith$Query$Overview$releasing<TRes> {
  _CopyWithStubImpl$Query$Overview$releasing(this._res);

  TRes _res;

  call({
    Query$Overview$releasing$pageInfo? pageInfo,
    List<Fragment$ReleasingMedia?>? media,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$Overview$releasing$pageInfo<TRes> get pageInfo =>
      CopyWith$Query$Overview$releasing$pageInfo.stub(_res);
  media(_fn) => _res;
}

class Query$Overview$releasing$pageInfo {
  Query$Overview$releasing$pageInfo({
    this.hasNextPage,
    this.$__typename = 'PageInfo',
  });

  factory Query$Overview$releasing$pageInfo.fromJson(
      Map<String, dynamic> json) {
    final l$hasNextPage = json['hasNextPage'];
    final l$$__typename = json['__typename'];
    return Query$Overview$releasing$pageInfo(
      hasNextPage: (l$hasNextPage as bool?),
      $__typename: (l$$__typename as String),
    );
  }

  final bool? hasNextPage;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$hasNextPage = hasNextPage;
    _resultData['hasNextPage'] = l$hasNextPage;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$hasNextPage = hasNextPage;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$hasNextPage,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Overview$releasing$pageInfo) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$hasNextPage = hasNextPage;
    final lOther$hasNextPage = other.hasNextPage;
    if (l$hasNextPage != lOther$hasNextPage) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$Overview$releasing$pageInfo
    on Query$Overview$releasing$pageInfo {
  CopyWith$Query$Overview$releasing$pageInfo<Query$Overview$releasing$pageInfo>
      get copyWith => CopyWith$Query$Overview$releasing$pageInfo(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$Overview$releasing$pageInfo<TRes> {
  factory CopyWith$Query$Overview$releasing$pageInfo(
    Query$Overview$releasing$pageInfo instance,
    TRes Function(Query$Overview$releasing$pageInfo) then,
  ) = _CopyWithImpl$Query$Overview$releasing$pageInfo;

  factory CopyWith$Query$Overview$releasing$pageInfo.stub(TRes res) =
      _CopyWithStubImpl$Query$Overview$releasing$pageInfo;

  TRes call({
    bool? hasNextPage,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$Overview$releasing$pageInfo<TRes>
    implements CopyWith$Query$Overview$releasing$pageInfo<TRes> {
  _CopyWithImpl$Query$Overview$releasing$pageInfo(
    this._instance,
    this._then,
  );

  final Query$Overview$releasing$pageInfo _instance;

  final TRes Function(Query$Overview$releasing$pageInfo) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? hasNextPage = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Overview$releasing$pageInfo(
        hasNextPage: hasNextPage == _undefined
            ? _instance.hasNextPage
            : (hasNextPage as bool?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$Overview$releasing$pageInfo<TRes>
    implements CopyWith$Query$Overview$releasing$pageInfo<TRes> {
  _CopyWithStubImpl$Query$Overview$releasing$pageInfo(this._res);

  TRes _res;

  call({
    bool? hasNextPage,
    String? $__typename,
  }) =>
      _res;
}

class Query$Overview$list {
  Query$Overview$list({
    this.mediaList,
    this.$__typename = 'Page',
  });

  factory Query$Overview$list.fromJson(Map<String, dynamic> json) {
    final l$mediaList = json['mediaList'];
    final l$$__typename = json['__typename'];
    return Query$Overview$list(
      mediaList: (l$mediaList as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : Fragment$MediaListEntry.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$MediaListEntry?>? mediaList;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$mediaList = mediaList;
    _resultData['mediaList'] = l$mediaList?.map((e) => e?.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$mediaList = mediaList;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$mediaList == null ? null : Object.hashAll(l$mediaList.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Overview$list) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$mediaList = mediaList;
    final lOther$mediaList = other.mediaList;
    if (l$mediaList != null && lOther$mediaList != null) {
      if (l$mediaList.length != lOther$mediaList.length) {
        return false;
      }
      for (int i = 0; i < l$mediaList.length; i++) {
        final l$mediaList$entry = l$mediaList[i];
        final lOther$mediaList$entry = lOther$mediaList[i];
        if (l$mediaList$entry != lOther$mediaList$entry) {
          return false;
        }
      }
    } else if (l$mediaList != lOther$mediaList) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$Overview$list on Query$Overview$list {
  CopyWith$Query$Overview$list<Query$Overview$list> get copyWith =>
      CopyWith$Query$Overview$list(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Overview$list<TRes> {
  factory CopyWith$Query$Overview$list(
    Query$Overview$list instance,
    TRes Function(Query$Overview$list) then,
  ) = _CopyWithImpl$Query$Overview$list;

  factory CopyWith$Query$Overview$list.stub(TRes res) =
      _CopyWithStubImpl$Query$Overview$list;

  TRes call({
    List<Fragment$MediaListEntry?>? mediaList,
    String? $__typename,
  });
  TRes mediaList(
      Iterable<Fragment$MediaListEntry?>? Function(
              Iterable<
                  CopyWith$Fragment$MediaListEntry<Fragment$MediaListEntry>?>?)
          _fn);
}

class _CopyWithImpl$Query$Overview$list<TRes>
    implements CopyWith$Query$Overview$list<TRes> {
  _CopyWithImpl$Query$Overview$list(
    this._instance,
    this._then,
  );

  final Query$Overview$list _instance;

  final TRes Function(Query$Overview$list) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? mediaList = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Overview$list(
        mediaList: mediaList == _undefined
            ? _instance.mediaList
            : (mediaList as List<Fragment$MediaListEntry?>?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  TRes mediaList(
          Iterable<Fragment$MediaListEntry?>? Function(
                  Iterable<
                      CopyWith$Fragment$MediaListEntry<
                          Fragment$MediaListEntry>?>?)
              _fn) =>
      call(
          mediaList: _fn(_instance.mediaList?.map((e) => e == null
              ? null
              : CopyWith$Fragment$MediaListEntry(
                  e,
                  (i) => i,
                )))?.toList());
}

class _CopyWithStubImpl$Query$Overview$list<TRes>
    implements CopyWith$Query$Overview$list<TRes> {
  _CopyWithStubImpl$Query$Overview$list(this._res);

  TRes _res;

  call({
    List<Fragment$MediaListEntry?>? mediaList,
    String? $__typename,
  }) =>
      _res;
  mediaList(_fn) => _res;
}

class Query$Overview$forums {
  Query$Overview$forums({
    this.threads,
    this.$__typename = 'Page',
  });

  factory Query$Overview$forums.fromJson(Map<String, dynamic> json) {
    final l$threads = json['threads'];
    final l$$__typename = json['__typename'];
    return Query$Overview$forums(
      threads: (l$threads as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : Fragment$ThreadFragment.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$ThreadFragment?>? threads;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$threads = threads;
    _resultData['threads'] = l$threads?.map((e) => e?.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$threads = threads;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$threads == null ? null : Object.hashAll(l$threads.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Overview$forums) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$threads = threads;
    final lOther$threads = other.threads;
    if (l$threads != null && lOther$threads != null) {
      if (l$threads.length != lOther$threads.length) {
        return false;
      }
      for (int i = 0; i < l$threads.length; i++) {
        final l$threads$entry = l$threads[i];
        final lOther$threads$entry = lOther$threads[i];
        if (l$threads$entry != lOther$threads$entry) {
          return false;
        }
      }
    } else if (l$threads != lOther$threads) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$Overview$forums on Query$Overview$forums {
  CopyWith$Query$Overview$forums<Query$Overview$forums> get copyWith =>
      CopyWith$Query$Overview$forums(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Overview$forums<TRes> {
  factory CopyWith$Query$Overview$forums(
    Query$Overview$forums instance,
    TRes Function(Query$Overview$forums) then,
  ) = _CopyWithImpl$Query$Overview$forums;

  factory CopyWith$Query$Overview$forums.stub(TRes res) =
      _CopyWithStubImpl$Query$Overview$forums;

  TRes call({
    List<Fragment$ThreadFragment?>? threads,
    String? $__typename,
  });
  TRes threads(
      Iterable<Fragment$ThreadFragment?>? Function(
              Iterable<
                  CopyWith$Fragment$ThreadFragment<Fragment$ThreadFragment>?>?)
          _fn);
}

class _CopyWithImpl$Query$Overview$forums<TRes>
    implements CopyWith$Query$Overview$forums<TRes> {
  _CopyWithImpl$Query$Overview$forums(
    this._instance,
    this._then,
  );

  final Query$Overview$forums _instance;

  final TRes Function(Query$Overview$forums) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? threads = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Overview$forums(
        threads: threads == _undefined
            ? _instance.threads
            : (threads as List<Fragment$ThreadFragment?>?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  TRes threads(
          Iterable<Fragment$ThreadFragment?>? Function(
                  Iterable<
                      CopyWith$Fragment$ThreadFragment<
                          Fragment$ThreadFragment>?>?)
              _fn) =>
      call(
          threads: _fn(_instance.threads?.map((e) => e == null
              ? null
              : CopyWith$Fragment$ThreadFragment(
                  e,
                  (i) => i,
                )))?.toList());
}

class _CopyWithStubImpl$Query$Overview$forums<TRes>
    implements CopyWith$Query$Overview$forums<TRes> {
  _CopyWithStubImpl$Query$Overview$forums(this._res);

  TRes _res;

  call({
    List<Fragment$ThreadFragment?>? threads,
    String? $__typename,
  }) =>
      _res;
  threads(_fn) => _res;
}
