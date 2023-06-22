// GENERATED FILE
// DO NOT MODIFY
// ignore_for_file: type=lint
import '../../../graphql/fragments.graphql.dart';
import '../../../graphql/schema.graphql.dart';
import 'dart:async';
import 'package:flutter/widgets.dart' as widgets;
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart' as graphql_flutter;

class Variables$Query$Thread {
  factory Variables$Query$Thread({
    int? id,
    int? page,
  }) =>
      Variables$Query$Thread._({
        if (id != null) r'id': id,
        if (page != null) r'page': page,
      });

  Variables$Query$Thread._(this._$data);

  factory Variables$Query$Thread.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('id')) {
      final l$id = data['id'];
      result$data['id'] = (l$id as int?);
    }
    if (data.containsKey('page')) {
      final l$page = data['page'];
      result$data['page'] = (l$page as int?);
    }
    return Variables$Query$Thread._(result$data);
  }

  Map<String, dynamic> _$data;

  int? get id => (_$data['id'] as int?);
  int? get page => (_$data['page'] as int?);
  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('id')) {
      final l$id = id;
      result$data['id'] = l$id;
    }
    if (_$data.containsKey('page')) {
      final l$page = page;
      result$data['page'] = l$page;
    }
    return result$data;
  }

  CopyWith$Variables$Query$Thread<Variables$Query$Thread> get copyWith =>
      CopyWith$Variables$Query$Thread(
        this,
        (i) => i,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$Thread) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (_$data.containsKey('id') != other._$data.containsKey('id')) {
      return false;
    }
    if (l$id != lOther$id) {
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
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$page = page;
    return Object.hashAll([
      _$data.containsKey('id') ? l$id : const {},
      _$data.containsKey('page') ? l$page : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Query$Thread<TRes> {
  factory CopyWith$Variables$Query$Thread(
    Variables$Query$Thread instance,
    TRes Function(Variables$Query$Thread) then,
  ) = _CopyWithImpl$Variables$Query$Thread;

  factory CopyWith$Variables$Query$Thread.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$Thread;

  TRes call({
    int? id,
    int? page,
  });
}

class _CopyWithImpl$Variables$Query$Thread<TRes>
    implements CopyWith$Variables$Query$Thread<TRes> {
  _CopyWithImpl$Variables$Query$Thread(
    this._instance,
    this._then,
  );

  final Variables$Query$Thread _instance;

  final TRes Function(Variables$Query$Thread) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? page = _undefined,
  }) =>
      _then(Variables$Query$Thread._({
        ..._instance._$data,
        if (id != _undefined) 'id': (id as int?),
        if (page != _undefined) 'page': (page as int?),
      }));
}

class _CopyWithStubImpl$Variables$Query$Thread<TRes>
    implements CopyWith$Variables$Query$Thread<TRes> {
  _CopyWithStubImpl$Variables$Query$Thread(this._res);

  TRes _res;

  call({
    int? id,
    int? page,
  }) =>
      _res;
}

class Query$Thread {
  Query$Thread({
    this.thread,
    this.comments,
    this.$__typename = 'Query',
  });

  factory Query$Thread.fromJson(Map<String, dynamic> json) {
    final l$thread = json['thread'];
    final l$comments = json['comments'];
    final l$$__typename = json['__typename'];
    return Query$Thread(
      thread: l$thread == null
          ? null
          : Query$Thread$thread.fromJson((l$thread as Map<String, dynamic>)),
      comments: l$comments == null
          ? null
          : Query$Thread$comments.fromJson(
              (l$comments as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$Thread$thread? thread;

  final Query$Thread$comments? comments;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$thread = thread;
    _resultData['thread'] = l$thread?.toJson();
    final l$comments = comments;
    _resultData['comments'] = l$comments?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$thread = thread;
    final l$comments = comments;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$thread,
      l$comments,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Thread) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$thread = thread;
    final lOther$thread = other.thread;
    if (l$thread != lOther$thread) {
      return false;
    }
    final l$comments = comments;
    final lOther$comments = other.comments;
    if (l$comments != lOther$comments) {
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

extension UtilityExtension$Query$Thread on Query$Thread {
  CopyWith$Query$Thread<Query$Thread> get copyWith => CopyWith$Query$Thread(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Thread<TRes> {
  factory CopyWith$Query$Thread(
    Query$Thread instance,
    TRes Function(Query$Thread) then,
  ) = _CopyWithImpl$Query$Thread;

  factory CopyWith$Query$Thread.stub(TRes res) = _CopyWithStubImpl$Query$Thread;

  TRes call({
    Query$Thread$thread? thread,
    Query$Thread$comments? comments,
    String? $__typename,
  });
  CopyWith$Query$Thread$thread<TRes> get thread;
  CopyWith$Query$Thread$comments<TRes> get comments;
}

class _CopyWithImpl$Query$Thread<TRes> implements CopyWith$Query$Thread<TRes> {
  _CopyWithImpl$Query$Thread(
    this._instance,
    this._then,
  );

  final Query$Thread _instance;

  final TRes Function(Query$Thread) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? thread = _undefined,
    Object? comments = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Thread(
        thread: thread == _undefined
            ? _instance.thread
            : (thread as Query$Thread$thread?),
        comments: comments == _undefined
            ? _instance.comments
            : (comments as Query$Thread$comments?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$Thread$thread<TRes> get thread {
    final local$thread = _instance.thread;
    return local$thread == null
        ? CopyWith$Query$Thread$thread.stub(_then(_instance))
        : CopyWith$Query$Thread$thread(local$thread, (e) => call(thread: e));
  }

  CopyWith$Query$Thread$comments<TRes> get comments {
    final local$comments = _instance.comments;
    return local$comments == null
        ? CopyWith$Query$Thread$comments.stub(_then(_instance))
        : CopyWith$Query$Thread$comments(
            local$comments, (e) => call(comments: e));
  }
}

class _CopyWithStubImpl$Query$Thread<TRes>
    implements CopyWith$Query$Thread<TRes> {
  _CopyWithStubImpl$Query$Thread(this._res);

  TRes _res;

  call({
    Query$Thread$thread? thread,
    Query$Thread$comments? comments,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$Thread$thread<TRes> get thread =>
      CopyWith$Query$Thread$thread.stub(_res);
  CopyWith$Query$Thread$comments<TRes> get comments =>
      CopyWith$Query$Thread$comments.stub(_res);
}

const documentNodeQueryThread = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'Thread'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'id')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'page')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'Thread'),
        alias: NameNode(value: 'thread'),
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'id'),
            value: VariableNode(name: NameNode(value: 'id')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'title'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'body'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'userId'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'replyCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'viewCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'isLocked'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'isSticky'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'isSubscribed'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'isLiked'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'likeCount'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'repliedAt'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'createdAt'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'name'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'avatar'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: SelectionSetNode(selections: [
                  FieldNode(
                    name: NameNode(value: 'large'),
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
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: 'categories'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'name'),
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
            name: NameNode(value: 'mediaCategories'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'title'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: SelectionSetNode(selections: [
                  FieldNode(
                    name: NameNode(value: 'userPreferred'),
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
                name: NameNode(value: 'coverImage'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: SelectionSetNode(selections: [
                  FieldNode(
                    name: NameNode(value: 'large'),
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
                name: NameNode(value: 'type'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'format'),
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
        alias: NameNode(value: 'comments'),
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'page'),
            value: VariableNode(name: NameNode(value: 'page')),
          ),
          ArgumentNode(
            name: NameNode(value: 'perPage'),
            value: IntValueNode(value: '15'),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'pageInfo'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                name: NameNode(value: 'PageInfo'),
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
            name: NameNode(value: 'threadComments'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'threadId'),
                value: VariableNode(name: NameNode(value: 'id')),
              )
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'threadId'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'comment'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'isLiked'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'likeCount'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'createdAt'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'user'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: SelectionSetNode(selections: [
                  FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'name'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'donatorTier'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'donatorBadge'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'moderatorRoles'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'avatar'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: SelectionSetNode(selections: [
                      FieldNode(
                        name: NameNode(value: 'large'),
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
                    name: NameNode(value: '__typename'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                ]),
              ),
              FieldNode(
                name: NameNode(value: 'childComments'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'isLocked'),
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
  fragmentDefinitionPageInfo,
]);
Query$Thread _parserFn$Query$Thread(Map<String, dynamic> data) =>
    Query$Thread.fromJson(data);
typedef OnQueryComplete$Query$Thread = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$Thread?,
);

class Options$Query$Thread extends graphql.QueryOptions<Query$Thread> {
  Options$Query$Thread({
    String? operationName,
    Variables$Query$Thread? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$Thread? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$Thread? onComplete,
    graphql.OnQueryError? onError,
  })  : onCompleteWithParsed = onComplete,
        super(
          variables: variables?.toJson() ?? {},
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
                    data == null ? null : _parserFn$Query$Thread(data),
                  ),
          onError: onError,
          document: documentNodeQueryThread,
          parserFn: _parserFn$Query$Thread,
        );

  final OnQueryComplete$Query$Thread? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
        ...super.onComplete == null
            ? super.properties
            : super.properties.where((property) => property != onComplete),
        onCompleteWithParsed,
      ];
}

class WatchOptions$Query$Thread
    extends graphql.WatchQueryOptions<Query$Thread> {
  WatchOptions$Query$Thread({
    String? operationName,
    Variables$Query$Thread? variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$Thread? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
          variables: variables?.toJson() ?? {},
          operationName: operationName,
          fetchPolicy: fetchPolicy,
          errorPolicy: errorPolicy,
          cacheRereadPolicy: cacheRereadPolicy,
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
          context: context,
          document: documentNodeQueryThread,
          pollInterval: pollInterval,
          eagerlyFetchResults: eagerlyFetchResults,
          carryForwardDataOnException: carryForwardDataOnException,
          fetchResults: fetchResults,
          parserFn: _parserFn$Query$Thread,
        );
}

class FetchMoreOptions$Query$Thread extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$Thread({
    required graphql.UpdateQuery updateQuery,
    Variables$Query$Thread? variables,
  }) : super(
          updateQuery: updateQuery,
          variables: variables?.toJson() ?? {},
          document: documentNodeQueryThread,
        );
}

extension ClientExtension$Query$Thread on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$Thread>> query$Thread(
          [Options$Query$Thread? options]) async =>
      await this.query(options ?? Options$Query$Thread());
  graphql.ObservableQuery<Query$Thread> watchQuery$Thread(
          [WatchOptions$Query$Thread? options]) =>
      this.watchQuery(options ?? WatchOptions$Query$Thread());
  void writeQuery$Thread({
    required Query$Thread data,
    Variables$Query$Thread? variables,
    bool broadcast = true,
  }) =>
      this.writeQuery(
        graphql.Request(
          operation: graphql.Operation(document: documentNodeQueryThread),
          variables: variables?.toJson() ?? const {},
        ),
        data: data.toJson(),
        broadcast: broadcast,
      );
  Query$Thread? readQuery$Thread({
    Variables$Query$Thread? variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryThread),
        variables: variables?.toJson() ?? const {},
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$Thread.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$Thread> useQuery$Thread(
        [Options$Query$Thread? options]) =>
    graphql_flutter.useQuery(options ?? Options$Query$Thread());
graphql.ObservableQuery<Query$Thread> useWatchQuery$Thread(
        [WatchOptions$Query$Thread? options]) =>
    graphql_flutter.useWatchQuery(options ?? WatchOptions$Query$Thread());

class Query$Thread$Widget extends graphql_flutter.Query<Query$Thread> {
  Query$Thread$Widget({
    widgets.Key? key,
    Options$Query$Thread? options,
    required graphql_flutter.QueryBuilder<Query$Thread> builder,
  }) : super(
          key: key,
          options: options ?? Options$Query$Thread(),
          builder: builder,
        );
}

class Query$Thread$thread {
  Query$Thread$thread({
    required this.id,
    this.title,
    this.body,
    required this.userId,
    this.replyCount,
    this.viewCount,
    this.isLocked,
    this.isSticky,
    this.isSubscribed,
    this.isLiked,
    required this.likeCount,
    this.repliedAt,
    required this.createdAt,
    this.user,
    this.categories,
    this.mediaCategories,
    this.$__typename = 'Thread',
  });

  factory Query$Thread$thread.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$body = json['body'];
    final l$userId = json['userId'];
    final l$replyCount = json['replyCount'];
    final l$viewCount = json['viewCount'];
    final l$isLocked = json['isLocked'];
    final l$isSticky = json['isSticky'];
    final l$isSubscribed = json['isSubscribed'];
    final l$isLiked = json['isLiked'];
    final l$likeCount = json['likeCount'];
    final l$repliedAt = json['repliedAt'];
    final l$createdAt = json['createdAt'];
    final l$user = json['user'];
    final l$categories = json['categories'];
    final l$mediaCategories = json['mediaCategories'];
    final l$$__typename = json['__typename'];
    return Query$Thread$thread(
      id: (l$id as int),
      title: (l$title as String?),
      body: (l$body as String?),
      userId: (l$userId as int),
      replyCount: (l$replyCount as int?),
      viewCount: (l$viewCount as int?),
      isLocked: (l$isLocked as bool?),
      isSticky: (l$isSticky as bool?),
      isSubscribed: (l$isSubscribed as bool?),
      isLiked: (l$isLiked as bool?),
      likeCount: (l$likeCount as int),
      repliedAt: (l$repliedAt as int?),
      createdAt: (l$createdAt as int),
      user: l$user == null
          ? null
          : Query$Thread$thread$user.fromJson((l$user as Map<String, dynamic>)),
      categories: (l$categories as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : Query$Thread$thread$categories.fromJson(
                  (e as Map<String, dynamic>)))
          .toList(),
      mediaCategories: (l$mediaCategories as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : Query$Thread$thread$mediaCategories.fromJson(
                  (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final String? title;

  final String? body;

  final int userId;

  final int? replyCount;

  final int? viewCount;

  final bool? isLocked;

  final bool? isSticky;

  final bool? isSubscribed;

  final bool? isLiked;

  final int likeCount;

  final int? repliedAt;

  final int createdAt;

  final Query$Thread$thread$user? user;

  final List<Query$Thread$thread$categories?>? categories;

  final List<Query$Thread$thread$mediaCategories?>? mediaCategories;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$body = body;
    _resultData['body'] = l$body;
    final l$userId = userId;
    _resultData['userId'] = l$userId;
    final l$replyCount = replyCount;
    _resultData['replyCount'] = l$replyCount;
    final l$viewCount = viewCount;
    _resultData['viewCount'] = l$viewCount;
    final l$isLocked = isLocked;
    _resultData['isLocked'] = l$isLocked;
    final l$isSticky = isSticky;
    _resultData['isSticky'] = l$isSticky;
    final l$isSubscribed = isSubscribed;
    _resultData['isSubscribed'] = l$isSubscribed;
    final l$isLiked = isLiked;
    _resultData['isLiked'] = l$isLiked;
    final l$likeCount = likeCount;
    _resultData['likeCount'] = l$likeCount;
    final l$repliedAt = repliedAt;
    _resultData['repliedAt'] = l$repliedAt;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = l$createdAt;
    final l$user = user;
    _resultData['user'] = l$user?.toJson();
    final l$categories = categories;
    _resultData['categories'] = l$categories?.map((e) => e?.toJson()).toList();
    final l$mediaCategories = mediaCategories;
    _resultData['mediaCategories'] =
        l$mediaCategories?.map((e) => e?.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$body = body;
    final l$userId = userId;
    final l$replyCount = replyCount;
    final l$viewCount = viewCount;
    final l$isLocked = isLocked;
    final l$isSticky = isSticky;
    final l$isSubscribed = isSubscribed;
    final l$isLiked = isLiked;
    final l$likeCount = likeCount;
    final l$repliedAt = repliedAt;
    final l$createdAt = createdAt;
    final l$user = user;
    final l$categories = categories;
    final l$mediaCategories = mediaCategories;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$title,
      l$body,
      l$userId,
      l$replyCount,
      l$viewCount,
      l$isLocked,
      l$isSticky,
      l$isSubscribed,
      l$isLiked,
      l$likeCount,
      l$repliedAt,
      l$createdAt,
      l$user,
      l$categories == null ? null : Object.hashAll(l$categories.map((v) => v)),
      l$mediaCategories == null
          ? null
          : Object.hashAll(l$mediaCategories.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Thread$thread) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$body = body;
    final lOther$body = other.body;
    if (l$body != lOther$body) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$replyCount = replyCount;
    final lOther$replyCount = other.replyCount;
    if (l$replyCount != lOther$replyCount) {
      return false;
    }
    final l$viewCount = viewCount;
    final lOther$viewCount = other.viewCount;
    if (l$viewCount != lOther$viewCount) {
      return false;
    }
    final l$isLocked = isLocked;
    final lOther$isLocked = other.isLocked;
    if (l$isLocked != lOther$isLocked) {
      return false;
    }
    final l$isSticky = isSticky;
    final lOther$isSticky = other.isSticky;
    if (l$isSticky != lOther$isSticky) {
      return false;
    }
    final l$isSubscribed = isSubscribed;
    final lOther$isSubscribed = other.isSubscribed;
    if (l$isSubscribed != lOther$isSubscribed) {
      return false;
    }
    final l$isLiked = isLiked;
    final lOther$isLiked = other.isLiked;
    if (l$isLiked != lOther$isLiked) {
      return false;
    }
    final l$likeCount = likeCount;
    final lOther$likeCount = other.likeCount;
    if (l$likeCount != lOther$likeCount) {
      return false;
    }
    final l$repliedAt = repliedAt;
    final lOther$repliedAt = other.repliedAt;
    if (l$repliedAt != lOther$repliedAt) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
      return false;
    }
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) {
      return false;
    }
    final l$categories = categories;
    final lOther$categories = other.categories;
    if (l$categories != null && lOther$categories != null) {
      if (l$categories.length != lOther$categories.length) {
        return false;
      }
      for (int i = 0; i < l$categories.length; i++) {
        final l$categories$entry = l$categories[i];
        final lOther$categories$entry = lOther$categories[i];
        if (l$categories$entry != lOther$categories$entry) {
          return false;
        }
      }
    } else if (l$categories != lOther$categories) {
      return false;
    }
    final l$mediaCategories = mediaCategories;
    final lOther$mediaCategories = other.mediaCategories;
    if (l$mediaCategories != null && lOther$mediaCategories != null) {
      if (l$mediaCategories.length != lOther$mediaCategories.length) {
        return false;
      }
      for (int i = 0; i < l$mediaCategories.length; i++) {
        final l$mediaCategories$entry = l$mediaCategories[i];
        final lOther$mediaCategories$entry = lOther$mediaCategories[i];
        if (l$mediaCategories$entry != lOther$mediaCategories$entry) {
          return false;
        }
      }
    } else if (l$mediaCategories != lOther$mediaCategories) {
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

extension UtilityExtension$Query$Thread$thread on Query$Thread$thread {
  CopyWith$Query$Thread$thread<Query$Thread$thread> get copyWith =>
      CopyWith$Query$Thread$thread(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Thread$thread<TRes> {
  factory CopyWith$Query$Thread$thread(
    Query$Thread$thread instance,
    TRes Function(Query$Thread$thread) then,
  ) = _CopyWithImpl$Query$Thread$thread;

  factory CopyWith$Query$Thread$thread.stub(TRes res) =
      _CopyWithStubImpl$Query$Thread$thread;

  TRes call({
    int? id,
    String? title,
    String? body,
    int? userId,
    int? replyCount,
    int? viewCount,
    bool? isLocked,
    bool? isSticky,
    bool? isSubscribed,
    bool? isLiked,
    int? likeCount,
    int? repliedAt,
    int? createdAt,
    Query$Thread$thread$user? user,
    List<Query$Thread$thread$categories?>? categories,
    List<Query$Thread$thread$mediaCategories?>? mediaCategories,
    String? $__typename,
  });
  CopyWith$Query$Thread$thread$user<TRes> get user;
  TRes categories(
      Iterable<Query$Thread$thread$categories?>? Function(
              Iterable<
                  CopyWith$Query$Thread$thread$categories<
                      Query$Thread$thread$categories>?>?)
          _fn);
  TRes mediaCategories(
      Iterable<Query$Thread$thread$mediaCategories?>? Function(
              Iterable<
                  CopyWith$Query$Thread$thread$mediaCategories<
                      Query$Thread$thread$mediaCategories>?>?)
          _fn);
}

class _CopyWithImpl$Query$Thread$thread<TRes>
    implements CopyWith$Query$Thread$thread<TRes> {
  _CopyWithImpl$Query$Thread$thread(
    this._instance,
    this._then,
  );

  final Query$Thread$thread _instance;

  final TRes Function(Query$Thread$thread) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? title = _undefined,
    Object? body = _undefined,
    Object? userId = _undefined,
    Object? replyCount = _undefined,
    Object? viewCount = _undefined,
    Object? isLocked = _undefined,
    Object? isSticky = _undefined,
    Object? isSubscribed = _undefined,
    Object? isLiked = _undefined,
    Object? likeCount = _undefined,
    Object? repliedAt = _undefined,
    Object? createdAt = _undefined,
    Object? user = _undefined,
    Object? categories = _undefined,
    Object? mediaCategories = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Thread$thread(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        title: title == _undefined ? _instance.title : (title as String?),
        body: body == _undefined ? _instance.body : (body as String?),
        userId: userId == _undefined || userId == null
            ? _instance.userId
            : (userId as int),
        replyCount: replyCount == _undefined
            ? _instance.replyCount
            : (replyCount as int?),
        viewCount:
            viewCount == _undefined ? _instance.viewCount : (viewCount as int?),
        isLocked:
            isLocked == _undefined ? _instance.isLocked : (isLocked as bool?),
        isSticky:
            isSticky == _undefined ? _instance.isSticky : (isSticky as bool?),
        isSubscribed: isSubscribed == _undefined
            ? _instance.isSubscribed
            : (isSubscribed as bool?),
        isLiked: isLiked == _undefined ? _instance.isLiked : (isLiked as bool?),
        likeCount: likeCount == _undefined || likeCount == null
            ? _instance.likeCount
            : (likeCount as int),
        repliedAt:
            repliedAt == _undefined ? _instance.repliedAt : (repliedAt as int?),
        createdAt: createdAt == _undefined || createdAt == null
            ? _instance.createdAt
            : (createdAt as int),
        user: user == _undefined
            ? _instance.user
            : (user as Query$Thread$thread$user?),
        categories: categories == _undefined
            ? _instance.categories
            : (categories as List<Query$Thread$thread$categories?>?),
        mediaCategories: mediaCategories == _undefined
            ? _instance.mediaCategories
            : (mediaCategories as List<Query$Thread$thread$mediaCategories?>?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$Thread$thread$user<TRes> get user {
    final local$user = _instance.user;
    return local$user == null
        ? CopyWith$Query$Thread$thread$user.stub(_then(_instance))
        : CopyWith$Query$Thread$thread$user(local$user, (e) => call(user: e));
  }

  TRes categories(
          Iterable<Query$Thread$thread$categories?>? Function(
                  Iterable<
                      CopyWith$Query$Thread$thread$categories<
                          Query$Thread$thread$categories>?>?)
              _fn) =>
      call(
          categories: _fn(_instance.categories?.map((e) => e == null
              ? null
              : CopyWith$Query$Thread$thread$categories(
                  e,
                  (i) => i,
                )))?.toList());
  TRes mediaCategories(
          Iterable<Query$Thread$thread$mediaCategories?>? Function(
                  Iterable<
                      CopyWith$Query$Thread$thread$mediaCategories<
                          Query$Thread$thread$mediaCategories>?>?)
              _fn) =>
      call(
          mediaCategories: _fn(_instance.mediaCategories?.map((e) => e == null
              ? null
              : CopyWith$Query$Thread$thread$mediaCategories(
                  e,
                  (i) => i,
                )))?.toList());
}

class _CopyWithStubImpl$Query$Thread$thread<TRes>
    implements CopyWith$Query$Thread$thread<TRes> {
  _CopyWithStubImpl$Query$Thread$thread(this._res);

  TRes _res;

  call({
    int? id,
    String? title,
    String? body,
    int? userId,
    int? replyCount,
    int? viewCount,
    bool? isLocked,
    bool? isSticky,
    bool? isSubscribed,
    bool? isLiked,
    int? likeCount,
    int? repliedAt,
    int? createdAt,
    Query$Thread$thread$user? user,
    List<Query$Thread$thread$categories?>? categories,
    List<Query$Thread$thread$mediaCategories?>? mediaCategories,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$Thread$thread$user<TRes> get user =>
      CopyWith$Query$Thread$thread$user.stub(_res);
  categories(_fn) => _res;
  mediaCategories(_fn) => _res;
}

class Query$Thread$thread$user {
  Query$Thread$thread$user({
    required this.id,
    required this.name,
    this.avatar,
    this.$__typename = 'User',
  });

  factory Query$Thread$thread$user.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$avatar = json['avatar'];
    final l$$__typename = json['__typename'];
    return Query$Thread$thread$user(
      id: (l$id as int),
      name: (l$name as String),
      avatar: l$avatar == null
          ? null
          : Query$Thread$thread$user$avatar.fromJson(
              (l$avatar as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final String name;

  final Query$Thread$thread$user$avatar? avatar;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$avatar = avatar;
    _resultData['avatar'] = l$avatar?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$avatar = avatar;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$avatar,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Thread$thread$user) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$avatar = avatar;
    final lOther$avatar = other.avatar;
    if (l$avatar != lOther$avatar) {
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

extension UtilityExtension$Query$Thread$thread$user
    on Query$Thread$thread$user {
  CopyWith$Query$Thread$thread$user<Query$Thread$thread$user> get copyWith =>
      CopyWith$Query$Thread$thread$user(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Thread$thread$user<TRes> {
  factory CopyWith$Query$Thread$thread$user(
    Query$Thread$thread$user instance,
    TRes Function(Query$Thread$thread$user) then,
  ) = _CopyWithImpl$Query$Thread$thread$user;

  factory CopyWith$Query$Thread$thread$user.stub(TRes res) =
      _CopyWithStubImpl$Query$Thread$thread$user;

  TRes call({
    int? id,
    String? name,
    Query$Thread$thread$user$avatar? avatar,
    String? $__typename,
  });
  CopyWith$Query$Thread$thread$user$avatar<TRes> get avatar;
}

class _CopyWithImpl$Query$Thread$thread$user<TRes>
    implements CopyWith$Query$Thread$thread$user<TRes> {
  _CopyWithImpl$Query$Thread$thread$user(
    this._instance,
    this._then,
  );

  final Query$Thread$thread$user _instance;

  final TRes Function(Query$Thread$thread$user) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? avatar = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Thread$thread$user(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        avatar: avatar == _undefined
            ? _instance.avatar
            : (avatar as Query$Thread$thread$user$avatar?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$Thread$thread$user$avatar<TRes> get avatar {
    final local$avatar = _instance.avatar;
    return local$avatar == null
        ? CopyWith$Query$Thread$thread$user$avatar.stub(_then(_instance))
        : CopyWith$Query$Thread$thread$user$avatar(
            local$avatar, (e) => call(avatar: e));
  }
}

class _CopyWithStubImpl$Query$Thread$thread$user<TRes>
    implements CopyWith$Query$Thread$thread$user<TRes> {
  _CopyWithStubImpl$Query$Thread$thread$user(this._res);

  TRes _res;

  call({
    int? id,
    String? name,
    Query$Thread$thread$user$avatar? avatar,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$Thread$thread$user$avatar<TRes> get avatar =>
      CopyWith$Query$Thread$thread$user$avatar.stub(_res);
}

class Query$Thread$thread$user$avatar {
  Query$Thread$thread$user$avatar({
    this.large,
    this.$__typename = 'UserAvatar',
  });

  factory Query$Thread$thread$user$avatar.fromJson(Map<String, dynamic> json) {
    final l$large = json['large'];
    final l$$__typename = json['__typename'];
    return Query$Thread$thread$user$avatar(
      large: (l$large as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String? large;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$large = large;
    _resultData['large'] = l$large;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$large = large;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$large,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Thread$thread$user$avatar) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$large = large;
    final lOther$large = other.large;
    if (l$large != lOther$large) {
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

extension UtilityExtension$Query$Thread$thread$user$avatar
    on Query$Thread$thread$user$avatar {
  CopyWith$Query$Thread$thread$user$avatar<Query$Thread$thread$user$avatar>
      get copyWith => CopyWith$Query$Thread$thread$user$avatar(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$Thread$thread$user$avatar<TRes> {
  factory CopyWith$Query$Thread$thread$user$avatar(
    Query$Thread$thread$user$avatar instance,
    TRes Function(Query$Thread$thread$user$avatar) then,
  ) = _CopyWithImpl$Query$Thread$thread$user$avatar;

  factory CopyWith$Query$Thread$thread$user$avatar.stub(TRes res) =
      _CopyWithStubImpl$Query$Thread$thread$user$avatar;

  TRes call({
    String? large,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$Thread$thread$user$avatar<TRes>
    implements CopyWith$Query$Thread$thread$user$avatar<TRes> {
  _CopyWithImpl$Query$Thread$thread$user$avatar(
    this._instance,
    this._then,
  );

  final Query$Thread$thread$user$avatar _instance;

  final TRes Function(Query$Thread$thread$user$avatar) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? large = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Thread$thread$user$avatar(
        large: large == _undefined ? _instance.large : (large as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$Thread$thread$user$avatar<TRes>
    implements CopyWith$Query$Thread$thread$user$avatar<TRes> {
  _CopyWithStubImpl$Query$Thread$thread$user$avatar(this._res);

  TRes _res;

  call({
    String? large,
    String? $__typename,
  }) =>
      _res;
}

class Query$Thread$thread$categories {
  Query$Thread$thread$categories({
    required this.id,
    required this.name,
    this.$__typename = 'ThreadCategory',
  });

  factory Query$Thread$thread$categories.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$$__typename = json['__typename'];
    return Query$Thread$thread$categories(
      id: (l$id as int),
      name: (l$name as String),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final String name;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Thread$thread$categories) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
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

extension UtilityExtension$Query$Thread$thread$categories
    on Query$Thread$thread$categories {
  CopyWith$Query$Thread$thread$categories<Query$Thread$thread$categories>
      get copyWith => CopyWith$Query$Thread$thread$categories(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$Thread$thread$categories<TRes> {
  factory CopyWith$Query$Thread$thread$categories(
    Query$Thread$thread$categories instance,
    TRes Function(Query$Thread$thread$categories) then,
  ) = _CopyWithImpl$Query$Thread$thread$categories;

  factory CopyWith$Query$Thread$thread$categories.stub(TRes res) =
      _CopyWithStubImpl$Query$Thread$thread$categories;

  TRes call({
    int? id,
    String? name,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$Thread$thread$categories<TRes>
    implements CopyWith$Query$Thread$thread$categories<TRes> {
  _CopyWithImpl$Query$Thread$thread$categories(
    this._instance,
    this._then,
  );

  final Query$Thread$thread$categories _instance;

  final TRes Function(Query$Thread$thread$categories) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Thread$thread$categories(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$Thread$thread$categories<TRes>
    implements CopyWith$Query$Thread$thread$categories<TRes> {
  _CopyWithStubImpl$Query$Thread$thread$categories(this._res);

  TRes _res;

  call({
    int? id,
    String? name,
    String? $__typename,
  }) =>
      _res;
}

class Query$Thread$thread$mediaCategories {
  Query$Thread$thread$mediaCategories({
    required this.id,
    this.title,
    this.coverImage,
    this.type,
    this.format,
    this.$__typename = 'Media',
  });

  factory Query$Thread$thread$mediaCategories.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$coverImage = json['coverImage'];
    final l$type = json['type'];
    final l$format = json['format'];
    final l$$__typename = json['__typename'];
    return Query$Thread$thread$mediaCategories(
      id: (l$id as int),
      title: l$title == null
          ? null
          : Query$Thread$thread$mediaCategories$title.fromJson(
              (l$title as Map<String, dynamic>)),
      coverImage: l$coverImage == null
          ? null
          : Query$Thread$thread$mediaCategories$coverImage.fromJson(
              (l$coverImage as Map<String, dynamic>)),
      type: l$type == null ? null : fromJson$Enum$MediaType((l$type as String)),
      format: l$format == null
          ? null
          : fromJson$Enum$MediaFormat((l$format as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final Query$Thread$thread$mediaCategories$title? title;

  final Query$Thread$thread$mediaCategories$coverImage? coverImage;

  final Enum$MediaType? type;

  final Enum$MediaFormat? format;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title?.toJson();
    final l$coverImage = coverImage;
    _resultData['coverImage'] = l$coverImage?.toJson();
    final l$type = type;
    _resultData['type'] = l$type == null ? null : toJson$Enum$MediaType(l$type);
    final l$format = format;
    _resultData['format'] =
        l$format == null ? null : toJson$Enum$MediaFormat(l$format);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$coverImage = coverImage;
    final l$type = type;
    final l$format = format;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$title,
      l$coverImage,
      l$type,
      l$format,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Thread$thread$mediaCategories) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$coverImage = coverImage;
    final lOther$coverImage = other.coverImage;
    if (l$coverImage != lOther$coverImage) {
      return false;
    }
    final l$type = type;
    final lOther$type = other.type;
    if (l$type != lOther$type) {
      return false;
    }
    final l$format = format;
    final lOther$format = other.format;
    if (l$format != lOther$format) {
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

extension UtilityExtension$Query$Thread$thread$mediaCategories
    on Query$Thread$thread$mediaCategories {
  CopyWith$Query$Thread$thread$mediaCategories<
          Query$Thread$thread$mediaCategories>
      get copyWith => CopyWith$Query$Thread$thread$mediaCategories(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$Thread$thread$mediaCategories<TRes> {
  factory CopyWith$Query$Thread$thread$mediaCategories(
    Query$Thread$thread$mediaCategories instance,
    TRes Function(Query$Thread$thread$mediaCategories) then,
  ) = _CopyWithImpl$Query$Thread$thread$mediaCategories;

  factory CopyWith$Query$Thread$thread$mediaCategories.stub(TRes res) =
      _CopyWithStubImpl$Query$Thread$thread$mediaCategories;

  TRes call({
    int? id,
    Query$Thread$thread$mediaCategories$title? title,
    Query$Thread$thread$mediaCategories$coverImage? coverImage,
    Enum$MediaType? type,
    Enum$MediaFormat? format,
    String? $__typename,
  });
  CopyWith$Query$Thread$thread$mediaCategories$title<TRes> get title;
  CopyWith$Query$Thread$thread$mediaCategories$coverImage<TRes> get coverImage;
}

class _CopyWithImpl$Query$Thread$thread$mediaCategories<TRes>
    implements CopyWith$Query$Thread$thread$mediaCategories<TRes> {
  _CopyWithImpl$Query$Thread$thread$mediaCategories(
    this._instance,
    this._then,
  );

  final Query$Thread$thread$mediaCategories _instance;

  final TRes Function(Query$Thread$thread$mediaCategories) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? title = _undefined,
    Object? coverImage = _undefined,
    Object? type = _undefined,
    Object? format = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Thread$thread$mediaCategories(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        title: title == _undefined
            ? _instance.title
            : (title as Query$Thread$thread$mediaCategories$title?),
        coverImage: coverImage == _undefined
            ? _instance.coverImage
            : (coverImage as Query$Thread$thread$mediaCategories$coverImage?),
        type: type == _undefined ? _instance.type : (type as Enum$MediaType?),
        format: format == _undefined
            ? _instance.format
            : (format as Enum$MediaFormat?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$Thread$thread$mediaCategories$title<TRes> get title {
    final local$title = _instance.title;
    return local$title == null
        ? CopyWith$Query$Thread$thread$mediaCategories$title.stub(
            _then(_instance))
        : CopyWith$Query$Thread$thread$mediaCategories$title(
            local$title, (e) => call(title: e));
  }

  CopyWith$Query$Thread$thread$mediaCategories$coverImage<TRes> get coverImage {
    final local$coverImage = _instance.coverImage;
    return local$coverImage == null
        ? CopyWith$Query$Thread$thread$mediaCategories$coverImage.stub(
            _then(_instance))
        : CopyWith$Query$Thread$thread$mediaCategories$coverImage(
            local$coverImage, (e) => call(coverImage: e));
  }
}

class _CopyWithStubImpl$Query$Thread$thread$mediaCategories<TRes>
    implements CopyWith$Query$Thread$thread$mediaCategories<TRes> {
  _CopyWithStubImpl$Query$Thread$thread$mediaCategories(this._res);

  TRes _res;

  call({
    int? id,
    Query$Thread$thread$mediaCategories$title? title,
    Query$Thread$thread$mediaCategories$coverImage? coverImage,
    Enum$MediaType? type,
    Enum$MediaFormat? format,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$Thread$thread$mediaCategories$title<TRes> get title =>
      CopyWith$Query$Thread$thread$mediaCategories$title.stub(_res);
  CopyWith$Query$Thread$thread$mediaCategories$coverImage<TRes>
      get coverImage =>
          CopyWith$Query$Thread$thread$mediaCategories$coverImage.stub(_res);
}

class Query$Thread$thread$mediaCategories$title {
  Query$Thread$thread$mediaCategories$title({
    this.userPreferred,
    this.$__typename = 'MediaTitle',
  });

  factory Query$Thread$thread$mediaCategories$title.fromJson(
      Map<String, dynamic> json) {
    final l$userPreferred = json['userPreferred'];
    final l$$__typename = json['__typename'];
    return Query$Thread$thread$mediaCategories$title(
      userPreferred: (l$userPreferred as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String? userPreferred;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$userPreferred = userPreferred;
    _resultData['userPreferred'] = l$userPreferred;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$userPreferred = userPreferred;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$userPreferred,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Thread$thread$mediaCategories$title) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userPreferred = userPreferred;
    final lOther$userPreferred = other.userPreferred;
    if (l$userPreferred != lOther$userPreferred) {
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

extension UtilityExtension$Query$Thread$thread$mediaCategories$title
    on Query$Thread$thread$mediaCategories$title {
  CopyWith$Query$Thread$thread$mediaCategories$title<
          Query$Thread$thread$mediaCategories$title>
      get copyWith => CopyWith$Query$Thread$thread$mediaCategories$title(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$Thread$thread$mediaCategories$title<TRes> {
  factory CopyWith$Query$Thread$thread$mediaCategories$title(
    Query$Thread$thread$mediaCategories$title instance,
    TRes Function(Query$Thread$thread$mediaCategories$title) then,
  ) = _CopyWithImpl$Query$Thread$thread$mediaCategories$title;

  factory CopyWith$Query$Thread$thread$mediaCategories$title.stub(TRes res) =
      _CopyWithStubImpl$Query$Thread$thread$mediaCategories$title;

  TRes call({
    String? userPreferred,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$Thread$thread$mediaCategories$title<TRes>
    implements CopyWith$Query$Thread$thread$mediaCategories$title<TRes> {
  _CopyWithImpl$Query$Thread$thread$mediaCategories$title(
    this._instance,
    this._then,
  );

  final Query$Thread$thread$mediaCategories$title _instance;

  final TRes Function(Query$Thread$thread$mediaCategories$title) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? userPreferred = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Thread$thread$mediaCategories$title(
        userPreferred: userPreferred == _undefined
            ? _instance.userPreferred
            : (userPreferred as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$Thread$thread$mediaCategories$title<TRes>
    implements CopyWith$Query$Thread$thread$mediaCategories$title<TRes> {
  _CopyWithStubImpl$Query$Thread$thread$mediaCategories$title(this._res);

  TRes _res;

  call({
    String? userPreferred,
    String? $__typename,
  }) =>
      _res;
}

class Query$Thread$thread$mediaCategories$coverImage {
  Query$Thread$thread$mediaCategories$coverImage({
    this.large,
    this.$__typename = 'MediaCoverImage',
  });

  factory Query$Thread$thread$mediaCategories$coverImage.fromJson(
      Map<String, dynamic> json) {
    final l$large = json['large'];
    final l$$__typename = json['__typename'];
    return Query$Thread$thread$mediaCategories$coverImage(
      large: (l$large as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String? large;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$large = large;
    _resultData['large'] = l$large;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$large = large;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$large,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Thread$thread$mediaCategories$coverImage) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$large = large;
    final lOther$large = other.large;
    if (l$large != lOther$large) {
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

extension UtilityExtension$Query$Thread$thread$mediaCategories$coverImage
    on Query$Thread$thread$mediaCategories$coverImage {
  CopyWith$Query$Thread$thread$mediaCategories$coverImage<
          Query$Thread$thread$mediaCategories$coverImage>
      get copyWith => CopyWith$Query$Thread$thread$mediaCategories$coverImage(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$Thread$thread$mediaCategories$coverImage<TRes> {
  factory CopyWith$Query$Thread$thread$mediaCategories$coverImage(
    Query$Thread$thread$mediaCategories$coverImage instance,
    TRes Function(Query$Thread$thread$mediaCategories$coverImage) then,
  ) = _CopyWithImpl$Query$Thread$thread$mediaCategories$coverImage;

  factory CopyWith$Query$Thread$thread$mediaCategories$coverImage.stub(
          TRes res) =
      _CopyWithStubImpl$Query$Thread$thread$mediaCategories$coverImage;

  TRes call({
    String? large,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$Thread$thread$mediaCategories$coverImage<TRes>
    implements CopyWith$Query$Thread$thread$mediaCategories$coverImage<TRes> {
  _CopyWithImpl$Query$Thread$thread$mediaCategories$coverImage(
    this._instance,
    this._then,
  );

  final Query$Thread$thread$mediaCategories$coverImage _instance;

  final TRes Function(Query$Thread$thread$mediaCategories$coverImage) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? large = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Thread$thread$mediaCategories$coverImage(
        large: large == _undefined ? _instance.large : (large as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$Thread$thread$mediaCategories$coverImage<TRes>
    implements CopyWith$Query$Thread$thread$mediaCategories$coverImage<TRes> {
  _CopyWithStubImpl$Query$Thread$thread$mediaCategories$coverImage(this._res);

  TRes _res;

  call({
    String? large,
    String? $__typename,
  }) =>
      _res;
}

class Query$Thread$comments {
  Query$Thread$comments({
    this.pageInfo,
    this.threadComments,
    this.$__typename = 'Page',
  });

  factory Query$Thread$comments.fromJson(Map<String, dynamic> json) {
    final l$pageInfo = json['pageInfo'];
    final l$threadComments = json['threadComments'];
    final l$$__typename = json['__typename'];
    return Query$Thread$comments(
      pageInfo: l$pageInfo == null
          ? null
          : Fragment$PageInfo.fromJson((l$pageInfo as Map<String, dynamic>)),
      threadComments: (l$threadComments as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : Query$Thread$comments$threadComments.fromJson(
                  (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$PageInfo? pageInfo;

  final List<Query$Thread$comments$threadComments?>? threadComments;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$pageInfo = pageInfo;
    _resultData['pageInfo'] = l$pageInfo?.toJson();
    final l$threadComments = threadComments;
    _resultData['threadComments'] =
        l$threadComments?.map((e) => e?.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$pageInfo = pageInfo;
    final l$threadComments = threadComments;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$pageInfo,
      l$threadComments == null
          ? null
          : Object.hashAll(l$threadComments.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Thread$comments) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$pageInfo = pageInfo;
    final lOther$pageInfo = other.pageInfo;
    if (l$pageInfo != lOther$pageInfo) {
      return false;
    }
    final l$threadComments = threadComments;
    final lOther$threadComments = other.threadComments;
    if (l$threadComments != null && lOther$threadComments != null) {
      if (l$threadComments.length != lOther$threadComments.length) {
        return false;
      }
      for (int i = 0; i < l$threadComments.length; i++) {
        final l$threadComments$entry = l$threadComments[i];
        final lOther$threadComments$entry = lOther$threadComments[i];
        if (l$threadComments$entry != lOther$threadComments$entry) {
          return false;
        }
      }
    } else if (l$threadComments != lOther$threadComments) {
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

extension UtilityExtension$Query$Thread$comments on Query$Thread$comments {
  CopyWith$Query$Thread$comments<Query$Thread$comments> get copyWith =>
      CopyWith$Query$Thread$comments(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Thread$comments<TRes> {
  factory CopyWith$Query$Thread$comments(
    Query$Thread$comments instance,
    TRes Function(Query$Thread$comments) then,
  ) = _CopyWithImpl$Query$Thread$comments;

  factory CopyWith$Query$Thread$comments.stub(TRes res) =
      _CopyWithStubImpl$Query$Thread$comments;

  TRes call({
    Fragment$PageInfo? pageInfo,
    List<Query$Thread$comments$threadComments?>? threadComments,
    String? $__typename,
  });
  CopyWith$Fragment$PageInfo<TRes> get pageInfo;
  TRes threadComments(
      Iterable<Query$Thread$comments$threadComments?>? Function(
              Iterable<
                  CopyWith$Query$Thread$comments$threadComments<
                      Query$Thread$comments$threadComments>?>?)
          _fn);
}

class _CopyWithImpl$Query$Thread$comments<TRes>
    implements CopyWith$Query$Thread$comments<TRes> {
  _CopyWithImpl$Query$Thread$comments(
    this._instance,
    this._then,
  );

  final Query$Thread$comments _instance;

  final TRes Function(Query$Thread$comments) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? pageInfo = _undefined,
    Object? threadComments = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Thread$comments(
        pageInfo: pageInfo == _undefined
            ? _instance.pageInfo
            : (pageInfo as Fragment$PageInfo?),
        threadComments: threadComments == _undefined
            ? _instance.threadComments
            : (threadComments as List<Query$Thread$comments$threadComments?>?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Fragment$PageInfo<TRes> get pageInfo {
    final local$pageInfo = _instance.pageInfo;
    return local$pageInfo == null
        ? CopyWith$Fragment$PageInfo.stub(_then(_instance))
        : CopyWith$Fragment$PageInfo(local$pageInfo, (e) => call(pageInfo: e));
  }

  TRes threadComments(
          Iterable<Query$Thread$comments$threadComments?>? Function(
                  Iterable<
                      CopyWith$Query$Thread$comments$threadComments<
                          Query$Thread$comments$threadComments>?>?)
              _fn) =>
      call(
          threadComments: _fn(_instance.threadComments?.map((e) => e == null
              ? null
              : CopyWith$Query$Thread$comments$threadComments(
                  e,
                  (i) => i,
                )))?.toList());
}

class _CopyWithStubImpl$Query$Thread$comments<TRes>
    implements CopyWith$Query$Thread$comments<TRes> {
  _CopyWithStubImpl$Query$Thread$comments(this._res);

  TRes _res;

  call({
    Fragment$PageInfo? pageInfo,
    List<Query$Thread$comments$threadComments?>? threadComments,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Fragment$PageInfo<TRes> get pageInfo =>
      CopyWith$Fragment$PageInfo.stub(_res);
  threadComments(_fn) => _res;
}

class Query$Thread$comments$threadComments {
  Query$Thread$comments$threadComments({
    required this.id,
    this.threadId,
    this.comment,
    this.isLiked,
    required this.likeCount,
    required this.createdAt,
    this.user,
    this.childComments,
    this.isLocked,
    this.$__typename = 'ThreadComment',
  });

  factory Query$Thread$comments$threadComments.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$threadId = json['threadId'];
    final l$comment = json['comment'];
    final l$isLiked = json['isLiked'];
    final l$likeCount = json['likeCount'];
    final l$createdAt = json['createdAt'];
    final l$user = json['user'];
    final l$childComments = json['childComments'];
    final l$isLocked = json['isLocked'];
    final l$$__typename = json['__typename'];
    return Query$Thread$comments$threadComments(
      id: (l$id as int),
      threadId: (l$threadId as int?),
      comment: (l$comment as String?),
      isLiked: (l$isLiked as bool?),
      likeCount: (l$likeCount as int),
      createdAt: (l$createdAt as int),
      user: l$user == null
          ? null
          : Query$Thread$comments$threadComments$user.fromJson(
              (l$user as Map<String, dynamic>)),
      childComments: (l$childComments as dynamic?),
      isLocked: (l$isLocked as bool?),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final int? threadId;

  final String? comment;

  final bool? isLiked;

  final int likeCount;

  final int createdAt;

  final Query$Thread$comments$threadComments$user? user;

  final dynamic? childComments;

  final bool? isLocked;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$threadId = threadId;
    _resultData['threadId'] = l$threadId;
    final l$comment = comment;
    _resultData['comment'] = l$comment;
    final l$isLiked = isLiked;
    _resultData['isLiked'] = l$isLiked;
    final l$likeCount = likeCount;
    _resultData['likeCount'] = l$likeCount;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = l$createdAt;
    final l$user = user;
    _resultData['user'] = l$user?.toJson();
    final l$childComments = childComments;
    _resultData['childComments'] = l$childComments;
    final l$isLocked = isLocked;
    _resultData['isLocked'] = l$isLocked;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$threadId = threadId;
    final l$comment = comment;
    final l$isLiked = isLiked;
    final l$likeCount = likeCount;
    final l$createdAt = createdAt;
    final l$user = user;
    final l$childComments = childComments;
    final l$isLocked = isLocked;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$threadId,
      l$comment,
      l$isLiked,
      l$likeCount,
      l$createdAt,
      l$user,
      l$childComments,
      l$isLocked,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Thread$comments$threadComments) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$threadId = threadId;
    final lOther$threadId = other.threadId;
    if (l$threadId != lOther$threadId) {
      return false;
    }
    final l$comment = comment;
    final lOther$comment = other.comment;
    if (l$comment != lOther$comment) {
      return false;
    }
    final l$isLiked = isLiked;
    final lOther$isLiked = other.isLiked;
    if (l$isLiked != lOther$isLiked) {
      return false;
    }
    final l$likeCount = likeCount;
    final lOther$likeCount = other.likeCount;
    if (l$likeCount != lOther$likeCount) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
      return false;
    }
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) {
      return false;
    }
    final l$childComments = childComments;
    final lOther$childComments = other.childComments;
    if (l$childComments != lOther$childComments) {
      return false;
    }
    final l$isLocked = isLocked;
    final lOther$isLocked = other.isLocked;
    if (l$isLocked != lOther$isLocked) {
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

extension UtilityExtension$Query$Thread$comments$threadComments
    on Query$Thread$comments$threadComments {
  CopyWith$Query$Thread$comments$threadComments<
          Query$Thread$comments$threadComments>
      get copyWith => CopyWith$Query$Thread$comments$threadComments(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$Thread$comments$threadComments<TRes> {
  factory CopyWith$Query$Thread$comments$threadComments(
    Query$Thread$comments$threadComments instance,
    TRes Function(Query$Thread$comments$threadComments) then,
  ) = _CopyWithImpl$Query$Thread$comments$threadComments;

  factory CopyWith$Query$Thread$comments$threadComments.stub(TRes res) =
      _CopyWithStubImpl$Query$Thread$comments$threadComments;

  TRes call({
    int? id,
    int? threadId,
    String? comment,
    bool? isLiked,
    int? likeCount,
    int? createdAt,
    Query$Thread$comments$threadComments$user? user,
    dynamic? childComments,
    bool? isLocked,
    String? $__typename,
  });
  CopyWith$Query$Thread$comments$threadComments$user<TRes> get user;
}

class _CopyWithImpl$Query$Thread$comments$threadComments<TRes>
    implements CopyWith$Query$Thread$comments$threadComments<TRes> {
  _CopyWithImpl$Query$Thread$comments$threadComments(
    this._instance,
    this._then,
  );

  final Query$Thread$comments$threadComments _instance;

  final TRes Function(Query$Thread$comments$threadComments) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? threadId = _undefined,
    Object? comment = _undefined,
    Object? isLiked = _undefined,
    Object? likeCount = _undefined,
    Object? createdAt = _undefined,
    Object? user = _undefined,
    Object? childComments = _undefined,
    Object? isLocked = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Thread$comments$threadComments(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        threadId:
            threadId == _undefined ? _instance.threadId : (threadId as int?),
        comment:
            comment == _undefined ? _instance.comment : (comment as String?),
        isLiked: isLiked == _undefined ? _instance.isLiked : (isLiked as bool?),
        likeCount: likeCount == _undefined || likeCount == null
            ? _instance.likeCount
            : (likeCount as int),
        createdAt: createdAt == _undefined || createdAt == null
            ? _instance.createdAt
            : (createdAt as int),
        user: user == _undefined
            ? _instance.user
            : (user as Query$Thread$comments$threadComments$user?),
        childComments: childComments == _undefined
            ? _instance.childComments
            : (childComments as dynamic?),
        isLocked:
            isLocked == _undefined ? _instance.isLocked : (isLocked as bool?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$Thread$comments$threadComments$user<TRes> get user {
    final local$user = _instance.user;
    return local$user == null
        ? CopyWith$Query$Thread$comments$threadComments$user.stub(
            _then(_instance))
        : CopyWith$Query$Thread$comments$threadComments$user(
            local$user, (e) => call(user: e));
  }
}

class _CopyWithStubImpl$Query$Thread$comments$threadComments<TRes>
    implements CopyWith$Query$Thread$comments$threadComments<TRes> {
  _CopyWithStubImpl$Query$Thread$comments$threadComments(this._res);

  TRes _res;

  call({
    int? id,
    int? threadId,
    String? comment,
    bool? isLiked,
    int? likeCount,
    int? createdAt,
    Query$Thread$comments$threadComments$user? user,
    dynamic? childComments,
    bool? isLocked,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$Thread$comments$threadComments$user<TRes> get user =>
      CopyWith$Query$Thread$comments$threadComments$user.stub(_res);
}

class Query$Thread$comments$threadComments$user {
  Query$Thread$comments$threadComments$user({
    required this.id,
    required this.name,
    this.donatorTier,
    this.donatorBadge,
    this.moderatorRoles,
    this.avatar,
    this.$__typename = 'User',
  });

  factory Query$Thread$comments$threadComments$user.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$donatorTier = json['donatorTier'];
    final l$donatorBadge = json['donatorBadge'];
    final l$moderatorRoles = json['moderatorRoles'];
    final l$avatar = json['avatar'];
    final l$$__typename = json['__typename'];
    return Query$Thread$comments$threadComments$user(
      id: (l$id as int),
      name: (l$name as String),
      donatorTier: (l$donatorTier as int?),
      donatorBadge: (l$donatorBadge as String?),
      moderatorRoles: (l$moderatorRoles as List<dynamic>?)
          ?.map((e) => e == null ? null : fromJson$Enum$ModRole((e as String)))
          .toList(),
      avatar: l$avatar == null
          ? null
          : Query$Thread$comments$threadComments$user$avatar.fromJson(
              (l$avatar as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final String name;

  final int? donatorTier;

  final String? donatorBadge;

  final List<Enum$ModRole?>? moderatorRoles;

  final Query$Thread$comments$threadComments$user$avatar? avatar;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$donatorTier = donatorTier;
    _resultData['donatorTier'] = l$donatorTier;
    final l$donatorBadge = donatorBadge;
    _resultData['donatorBadge'] = l$donatorBadge;
    final l$moderatorRoles = moderatorRoles;
    _resultData['moderatorRoles'] = l$moderatorRoles
        ?.map((e) => e == null ? null : toJson$Enum$ModRole(e))
        .toList();
    final l$avatar = avatar;
    _resultData['avatar'] = l$avatar?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$donatorTier = donatorTier;
    final l$donatorBadge = donatorBadge;
    final l$moderatorRoles = moderatorRoles;
    final l$avatar = avatar;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$donatorTier,
      l$donatorBadge,
      l$moderatorRoles == null
          ? null
          : Object.hashAll(l$moderatorRoles.map((v) => v)),
      l$avatar,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Thread$comments$threadComments$user) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$donatorTier = donatorTier;
    final lOther$donatorTier = other.donatorTier;
    if (l$donatorTier != lOther$donatorTier) {
      return false;
    }
    final l$donatorBadge = donatorBadge;
    final lOther$donatorBadge = other.donatorBadge;
    if (l$donatorBadge != lOther$donatorBadge) {
      return false;
    }
    final l$moderatorRoles = moderatorRoles;
    final lOther$moderatorRoles = other.moderatorRoles;
    if (l$moderatorRoles != null && lOther$moderatorRoles != null) {
      if (l$moderatorRoles.length != lOther$moderatorRoles.length) {
        return false;
      }
      for (int i = 0; i < l$moderatorRoles.length; i++) {
        final l$moderatorRoles$entry = l$moderatorRoles[i];
        final lOther$moderatorRoles$entry = lOther$moderatorRoles[i];
        if (l$moderatorRoles$entry != lOther$moderatorRoles$entry) {
          return false;
        }
      }
    } else if (l$moderatorRoles != lOther$moderatorRoles) {
      return false;
    }
    final l$avatar = avatar;
    final lOther$avatar = other.avatar;
    if (l$avatar != lOther$avatar) {
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

extension UtilityExtension$Query$Thread$comments$threadComments$user
    on Query$Thread$comments$threadComments$user {
  CopyWith$Query$Thread$comments$threadComments$user<
          Query$Thread$comments$threadComments$user>
      get copyWith => CopyWith$Query$Thread$comments$threadComments$user(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$Thread$comments$threadComments$user<TRes> {
  factory CopyWith$Query$Thread$comments$threadComments$user(
    Query$Thread$comments$threadComments$user instance,
    TRes Function(Query$Thread$comments$threadComments$user) then,
  ) = _CopyWithImpl$Query$Thread$comments$threadComments$user;

  factory CopyWith$Query$Thread$comments$threadComments$user.stub(TRes res) =
      _CopyWithStubImpl$Query$Thread$comments$threadComments$user;

  TRes call({
    int? id,
    String? name,
    int? donatorTier,
    String? donatorBadge,
    List<Enum$ModRole?>? moderatorRoles,
    Query$Thread$comments$threadComments$user$avatar? avatar,
    String? $__typename,
  });
  CopyWith$Query$Thread$comments$threadComments$user$avatar<TRes> get avatar;
}

class _CopyWithImpl$Query$Thread$comments$threadComments$user<TRes>
    implements CopyWith$Query$Thread$comments$threadComments$user<TRes> {
  _CopyWithImpl$Query$Thread$comments$threadComments$user(
    this._instance,
    this._then,
  );

  final Query$Thread$comments$threadComments$user _instance;

  final TRes Function(Query$Thread$comments$threadComments$user) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? donatorTier = _undefined,
    Object? donatorBadge = _undefined,
    Object? moderatorRoles = _undefined,
    Object? avatar = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Thread$comments$threadComments$user(
        id: id == _undefined || id == null ? _instance.id : (id as int),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        donatorTier: donatorTier == _undefined
            ? _instance.donatorTier
            : (donatorTier as int?),
        donatorBadge: donatorBadge == _undefined
            ? _instance.donatorBadge
            : (donatorBadge as String?),
        moderatorRoles: moderatorRoles == _undefined
            ? _instance.moderatorRoles
            : (moderatorRoles as List<Enum$ModRole?>?),
        avatar: avatar == _undefined
            ? _instance.avatar
            : (avatar as Query$Thread$comments$threadComments$user$avatar?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
  CopyWith$Query$Thread$comments$threadComments$user$avatar<TRes> get avatar {
    final local$avatar = _instance.avatar;
    return local$avatar == null
        ? CopyWith$Query$Thread$comments$threadComments$user$avatar.stub(
            _then(_instance))
        : CopyWith$Query$Thread$comments$threadComments$user$avatar(
            local$avatar, (e) => call(avatar: e));
  }
}

class _CopyWithStubImpl$Query$Thread$comments$threadComments$user<TRes>
    implements CopyWith$Query$Thread$comments$threadComments$user<TRes> {
  _CopyWithStubImpl$Query$Thread$comments$threadComments$user(this._res);

  TRes _res;

  call({
    int? id,
    String? name,
    int? donatorTier,
    String? donatorBadge,
    List<Enum$ModRole?>? moderatorRoles,
    Query$Thread$comments$threadComments$user$avatar? avatar,
    String? $__typename,
  }) =>
      _res;
  CopyWith$Query$Thread$comments$threadComments$user$avatar<TRes> get avatar =>
      CopyWith$Query$Thread$comments$threadComments$user$avatar.stub(_res);
}

class Query$Thread$comments$threadComments$user$avatar {
  Query$Thread$comments$threadComments$user$avatar({
    this.large,
    this.$__typename = 'UserAvatar',
  });

  factory Query$Thread$comments$threadComments$user$avatar.fromJson(
      Map<String, dynamic> json) {
    final l$large = json['large'];
    final l$$__typename = json['__typename'];
    return Query$Thread$comments$threadComments$user$avatar(
      large: (l$large as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String? large;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$large = large;
    _resultData['large'] = l$large;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$large = large;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$large,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Thread$comments$threadComments$user$avatar) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$large = large;
    final lOther$large = other.large;
    if (l$large != lOther$large) {
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

extension UtilityExtension$Query$Thread$comments$threadComments$user$avatar
    on Query$Thread$comments$threadComments$user$avatar {
  CopyWith$Query$Thread$comments$threadComments$user$avatar<
          Query$Thread$comments$threadComments$user$avatar>
      get copyWith => CopyWith$Query$Thread$comments$threadComments$user$avatar(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$Thread$comments$threadComments$user$avatar<TRes> {
  factory CopyWith$Query$Thread$comments$threadComments$user$avatar(
    Query$Thread$comments$threadComments$user$avatar instance,
    TRes Function(Query$Thread$comments$threadComments$user$avatar) then,
  ) = _CopyWithImpl$Query$Thread$comments$threadComments$user$avatar;

  factory CopyWith$Query$Thread$comments$threadComments$user$avatar.stub(
          TRes res) =
      _CopyWithStubImpl$Query$Thread$comments$threadComments$user$avatar;

  TRes call({
    String? large,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$Thread$comments$threadComments$user$avatar<TRes>
    implements CopyWith$Query$Thread$comments$threadComments$user$avatar<TRes> {
  _CopyWithImpl$Query$Thread$comments$threadComments$user$avatar(
    this._instance,
    this._then,
  );

  final Query$Thread$comments$threadComments$user$avatar _instance;

  final TRes Function(Query$Thread$comments$threadComments$user$avatar) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? large = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Thread$comments$threadComments$user$avatar(
        large: large == _undefined ? _instance.large : (large as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$Thread$comments$threadComments$user$avatar<TRes>
    implements CopyWith$Query$Thread$comments$threadComments$user$avatar<TRes> {
  _CopyWithStubImpl$Query$Thread$comments$threadComments$user$avatar(this._res);

  TRes _res;

  call({
    String? large,
    String? $__typename,
  }) =>
      _res;
}
