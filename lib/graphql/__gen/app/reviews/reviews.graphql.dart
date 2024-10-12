import '../../graphql/fragments/page_info.graphql.dart';
import '../../graphql/fragments/review.graphql.dart';
import '../../graphql/fragments/user.graphql.dart';
import 'package:gql/ast.dart';

class Variables$Query$Reviews {
  factory Variables$Query$Reviews({
    int? page,
    int? perPage,
  }) =>
      Variables$Query$Reviews._({
        if (page != null) r'page': page,
        if (perPage != null) r'perPage': perPage,
      });

  Variables$Query$Reviews._(this._$data);

  factory Variables$Query$Reviews.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('page')) {
      final l$page = data['page'];
      result$data['page'] = (l$page as int?);
    }
    if (data.containsKey('perPage')) {
      final l$perPage = data['perPage'];
      result$data['perPage'] = (l$perPage as int?);
    }
    return Variables$Query$Reviews._(result$data);
  }

  Map<String, dynamic> _$data;

  int? get page => (_$data['page'] as int?);

  int? get perPage => (_$data['perPage'] as int?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('page')) {
      final l$page = page;
      result$data['page'] = l$page;
    }
    if (_$data.containsKey('perPage')) {
      final l$perPage = perPage;
      result$data['perPage'] = l$perPage;
    }
    return result$data;
  }

  CopyWith$Variables$Query$Reviews<Variables$Query$Reviews> get copyWith =>
      CopyWith$Variables$Query$Reviews(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$Reviews ||
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
    final l$perPage = perPage;
    final lOther$perPage = other.perPage;
    if (_$data.containsKey('perPage') != other._$data.containsKey('perPage')) {
      return false;
    }
    if (l$perPage != lOther$perPage) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$page = page;
    final l$perPage = perPage;
    return Object.hashAll([
      _$data.containsKey('page') ? l$page : const {},
      _$data.containsKey('perPage') ? l$perPage : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Query$Reviews<TRes> {
  factory CopyWith$Variables$Query$Reviews(
    Variables$Query$Reviews instance,
    TRes Function(Variables$Query$Reviews) then,
  ) = _CopyWithImpl$Variables$Query$Reviews;

  factory CopyWith$Variables$Query$Reviews.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$Reviews;

  TRes call({
    int? page,
    int? perPage,
  });
}

class _CopyWithImpl$Variables$Query$Reviews<TRes>
    implements CopyWith$Variables$Query$Reviews<TRes> {
  _CopyWithImpl$Variables$Query$Reviews(
    this._instance,
    this._then,
  );

  final Variables$Query$Reviews _instance;

  final TRes Function(Variables$Query$Reviews) _then;

  static const _undefined = <dynamic, dynamic>{};

  @override
  TRes call({
    Object? page = _undefined,
    Object? perPage = _undefined,
  }) =>
      _then(Variables$Query$Reviews._({
        ..._instance._$data,
        if (page != _undefined) 'page': (page as int?),
        if (perPage != _undefined) 'perPage': (perPage as int?),
      }));
}

class _CopyWithStubImpl$Variables$Query$Reviews<TRes>
    implements CopyWith$Variables$Query$Reviews<TRes> {
  _CopyWithStubImpl$Variables$Query$Reviews(this._res);

  final TRes _res;

  @override
  call({
    int? page,
    int? perPage,
  }) =>
      _res;
}

class Query$Reviews {
  Query$Reviews({
    this.Page,
    this.$__typename = 'Query',
  });

  factory Query$Reviews.fromJson(Map<String, dynamic> json) {
    final l$Page = json['Page'];
    final l$$__typename = json['__typename'];
    return Query$Reviews(
      Page: l$Page == null
          ? null
          : Query$Reviews$Page.fromJson((l$Page as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$Reviews$Page? Page;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final resultData = <String, dynamic>{};
    final l$Page = Page;
    resultData['Page'] = l$Page?.toJson();
    final l$$__typename = $__typename;
    resultData['__typename'] = l$$__typename;
    return resultData;
  }

  @override
  int get hashCode {
    final l$Page = Page;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$Page,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Reviews || runtimeType != other.runtimeType) {
      return false;
    }
    final l$Page = Page;
    final lOther$Page = other.Page;
    if (l$Page != lOther$Page) {
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

extension UtilityExtension$Query$Reviews on Query$Reviews {
  CopyWith$Query$Reviews<Query$Reviews> get copyWith => CopyWith$Query$Reviews(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Reviews<TRes> {
  factory CopyWith$Query$Reviews(
    Query$Reviews instance,
    TRes Function(Query$Reviews) then,
  ) = _CopyWithImpl$Query$Reviews;

  factory CopyWith$Query$Reviews.stub(TRes res) =
      _CopyWithStubImpl$Query$Reviews;

  TRes call({
    Query$Reviews$Page? Page,
    String? $__typename,
  });
  CopyWith$Query$Reviews$Page<TRes> get Page;
}

class _CopyWithImpl$Query$Reviews<TRes>
    implements CopyWith$Query$Reviews<TRes> {
  _CopyWithImpl$Query$Reviews(
    this._instance,
    this._then,
  );

  final Query$Reviews _instance;

  final TRes Function(Query$Reviews) _then;

  static const _undefined = <dynamic, dynamic>{};

  @override
  TRes call({
    Object? Page = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Reviews(
        Page:
            Page == _undefined ? _instance.Page : (Page as Query$Reviews$Page?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  @override
  CopyWith$Query$Reviews$Page<TRes> get Page {
    final local$Page = _instance.Page;
    return local$Page == null
        ? CopyWith$Query$Reviews$Page.stub(_then(_instance))
        : CopyWith$Query$Reviews$Page(local$Page, (e) => call(Page: e));
  }
}

class _CopyWithStubImpl$Query$Reviews<TRes>
    implements CopyWith$Query$Reviews<TRes> {
  _CopyWithStubImpl$Query$Reviews(this._res);

  final TRes _res;

  @override
  call({
    Query$Reviews$Page? Page,
    String? $__typename,
  }) =>
      _res;

  @override
  CopyWith$Query$Reviews$Page<TRes> get Page =>
      CopyWith$Query$Reviews$Page.stub(_res);
}

const documentNodeQueryReviews = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'Reviews'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'page')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'perPage')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: IntValueNode(value: '30')),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'Page'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'page'),
            value: VariableNode(name: NameNode(value: 'page')),
          ),
          ArgumentNode(
            name: NameNode(value: 'perPage'),
            value: VariableNode(name: NameNode(value: 'perPage')),
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
            name: NameNode(value: 'reviews'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'sort'),
                value: EnumValueNode(name: NameNode(value: 'ID_DESC')),
              )
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                name: NameNode(value: 'ReviewFragment'),
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
  fragmentDefinitionPageInfo,
  fragmentDefinitionReviewFragment,
  fragmentDefinitionUserFragment,
]);

class Query$Reviews$Page {
  Query$Reviews$Page({
    this.pageInfo,
    this.reviews,
    this.$__typename = 'Page',
  });

  factory Query$Reviews$Page.fromJson(Map<String, dynamic> json) {
    final l$pageInfo = json['pageInfo'];
    final l$reviews = json['reviews'];
    final l$$__typename = json['__typename'];
    return Query$Reviews$Page(
      pageInfo: l$pageInfo == null
          ? null
          : Fragment$PageInfo.fromJson((l$pageInfo as Map<String, dynamic>)),
      reviews: (l$reviews as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : Fragment$ReviewFragment.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$PageInfo? pageInfo;

  final List<Fragment$ReviewFragment?>? reviews;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final resultData = <String, dynamic>{};
    final l$pageInfo = pageInfo;
    resultData['pageInfo'] = l$pageInfo?.toJson();
    final l$reviews = reviews;
    resultData['reviews'] = l$reviews?.map((e) => e?.toJson()).toList();
    final l$$__typename = $__typename;
    resultData['__typename'] = l$$__typename;
    return resultData;
  }

  @override
  int get hashCode {
    final l$pageInfo = pageInfo;
    final l$reviews = reviews;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$pageInfo,
      l$reviews == null ? null : Object.hashAll(l$reviews.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Reviews$Page || runtimeType != other.runtimeType) {
      return false;
    }
    final l$pageInfo = pageInfo;
    final lOther$pageInfo = other.pageInfo;
    if (l$pageInfo != lOther$pageInfo) {
      return false;
    }
    final l$reviews = reviews;
    final lOther$reviews = other.reviews;
    if (l$reviews != null && lOther$reviews != null) {
      if (l$reviews.length != lOther$reviews.length) {
        return false;
      }
      for (int i = 0; i < l$reviews.length; i++) {
        final l$reviews$entry = l$reviews[i];
        final lOther$reviews$entry = lOther$reviews[i];
        if (l$reviews$entry != lOther$reviews$entry) {
          return false;
        }
      }
    } else if (l$reviews != lOther$reviews) {
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

extension UtilityExtension$Query$Reviews$Page on Query$Reviews$Page {
  CopyWith$Query$Reviews$Page<Query$Reviews$Page> get copyWith =>
      CopyWith$Query$Reviews$Page(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Reviews$Page<TRes> {
  factory CopyWith$Query$Reviews$Page(
    Query$Reviews$Page instance,
    TRes Function(Query$Reviews$Page) then,
  ) = _CopyWithImpl$Query$Reviews$Page;

  factory CopyWith$Query$Reviews$Page.stub(TRes res) =
      _CopyWithStubImpl$Query$Reviews$Page;

  TRes call({
    Fragment$PageInfo? pageInfo,
    List<Fragment$ReviewFragment?>? reviews,
    String? $__typename,
  });
  CopyWith$Fragment$PageInfo<TRes> get pageInfo;
  TRes reviews(
      Iterable<Fragment$ReviewFragment?>? Function(
              Iterable<
                  CopyWith$Fragment$ReviewFragment<Fragment$ReviewFragment>?>?)
          fn);
}

class _CopyWithImpl$Query$Reviews$Page<TRes>
    implements CopyWith$Query$Reviews$Page<TRes> {
  _CopyWithImpl$Query$Reviews$Page(
    this._instance,
    this._then,
  );

  final Query$Reviews$Page _instance;

  final TRes Function(Query$Reviews$Page) _then;

  static const _undefined = <dynamic, dynamic>{};

  @override
  TRes call({
    Object? pageInfo = _undefined,
    Object? reviews = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Reviews$Page(
        pageInfo: pageInfo == _undefined
            ? _instance.pageInfo
            : (pageInfo as Fragment$PageInfo?),
        reviews: reviews == _undefined
            ? _instance.reviews
            : (reviews as List<Fragment$ReviewFragment?>?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  @override
  CopyWith$Fragment$PageInfo<TRes> get pageInfo {
    final local$pageInfo = _instance.pageInfo;
    return local$pageInfo == null
        ? CopyWith$Fragment$PageInfo.stub(_then(_instance))
        : CopyWith$Fragment$PageInfo(local$pageInfo, (e) => call(pageInfo: e));
  }

  @override
  TRes reviews(
          Iterable<Fragment$ReviewFragment?>? Function(
                  Iterable<
                      CopyWith$Fragment$ReviewFragment<
                          Fragment$ReviewFragment>?>?)
              fn) =>
      call(
          reviews: fn(_instance.reviews?.map((e) => e == null
              ? null
              : CopyWith$Fragment$ReviewFragment(
                  e,
                  (i) => i,
                )))?.toList());
}

class _CopyWithStubImpl$Query$Reviews$Page<TRes>
    implements CopyWith$Query$Reviews$Page<TRes> {
  _CopyWithStubImpl$Query$Reviews$Page(this._res);

  final TRes _res;

  @override
  call({
    Fragment$PageInfo? pageInfo,
    List<Fragment$ReviewFragment?>? reviews,
    String? $__typename,
  }) =>
      _res;

  @override
  CopyWith$Fragment$PageInfo<TRes> get pageInfo =>
      CopyWith$Fragment$PageInfo.stub(_res);

  @override
  reviews(fn) => _res;
}
