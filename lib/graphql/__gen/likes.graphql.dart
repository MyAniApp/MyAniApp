import 'fragments/page_info.graphql.dart';
import 'package:gql/ast.dart';
import 'schema.graphql.dart';

class Variables$Query$Likes {
  factory Variables$Query$Likes({
    int? page,
    int? id,
    Enum$LikeableType? type,
  }) => Variables$Query$Likes._({
    if (page != null) r'page': page,
    if (id != null) r'id': id,
    if (type != null) r'type': type,
  });

  Variables$Query$Likes._(this._$data);

  factory Variables$Query$Likes.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('page')) {
      final l$page = data['page'];
      result$data['page'] = (l$page as int?);
    }
    if (data.containsKey('id')) {
      final l$id = data['id'];
      result$data['id'] = (l$id as int?);
    }
    if (data.containsKey('type')) {
      final l$type = data['type'];
      result$data['type'] = l$type == null
          ? null
          : fromJson$Enum$LikeableType((l$type as String));
    }
    return Variables$Query$Likes._(result$data);
  }

  Map<String, dynamic> _$data;

  int? get page => (_$data['page'] as int?);

  int? get id => (_$data['id'] as int?);

  Enum$LikeableType? get type => (_$data['type'] as Enum$LikeableType?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('page')) {
      final l$page = page;
      result$data['page'] = l$page;
    }
    if (_$data.containsKey('id')) {
      final l$id = id;
      result$data['id'] = l$id;
    }
    if (_$data.containsKey('type')) {
      final l$type = type;
      result$data['type'] = l$type == null
          ? null
          : toJson$Enum$LikeableType(l$type);
    }
    return result$data;
  }

  CopyWith$Variables$Query$Likes<Variables$Query$Likes> get copyWith =>
      CopyWith$Variables$Query$Likes(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$Likes || runtimeType != other.runtimeType) {
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
    final l$id = id;
    final lOther$id = other.id;
    if (_$data.containsKey('id') != other._$data.containsKey('id')) {
      return false;
    }
    if (l$id != lOther$id) {
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
    final l$id = id;
    final l$type = type;
    return Object.hashAll([
      _$data.containsKey('page') ? l$page : const {},
      _$data.containsKey('id') ? l$id : const {},
      _$data.containsKey('type') ? l$type : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Query$Likes<TRes> {
  factory CopyWith$Variables$Query$Likes(
    Variables$Query$Likes instance,
    TRes Function(Variables$Query$Likes) then,
  ) = _CopyWithImpl$Variables$Query$Likes;

  factory CopyWith$Variables$Query$Likes.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$Likes;

  TRes call({int? page, int? id, Enum$LikeableType? type});
}

class _CopyWithImpl$Variables$Query$Likes<TRes>
    implements CopyWith$Variables$Query$Likes<TRes> {
  _CopyWithImpl$Variables$Query$Likes(this._instance, this._then);

  final Variables$Query$Likes _instance;

  final TRes Function(Variables$Query$Likes) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? page = _undefined,
    Object? id = _undefined,
    Object? type = _undefined,
  }) => _then(
    Variables$Query$Likes._({
      ..._instance._$data,
      if (page != _undefined) 'page': (page as int?),
      if (id != _undefined) 'id': (id as int?),
      if (type != _undefined) 'type': (type as Enum$LikeableType?),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$Likes<TRes>
    implements CopyWith$Variables$Query$Likes<TRes> {
  _CopyWithStubImpl$Variables$Query$Likes(this._res);

  TRes _res;

  call({int? page, int? id, Enum$LikeableType? type}) => _res;
}

class Query$Likes {
  Query$Likes({this.Page, this.$__typename = 'Query'});

  factory Query$Likes.fromJson(Map<String, dynamic> json) {
    final l$Page = json['Page'];
    final l$$__typename = json['__typename'];
    return Query$Likes(
      Page: l$Page == null
          ? null
          : Query$Likes$Page.fromJson((l$Page as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$Likes$Page? Page;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$Page = Page;
    _resultData['Page'] = l$Page?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$Page = Page;
    final l$$__typename = $__typename;
    return Object.hashAll([l$Page, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Likes || runtimeType != other.runtimeType) {
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

extension UtilityExtension$Query$Likes on Query$Likes {
  CopyWith$Query$Likes<Query$Likes> get copyWith =>
      CopyWith$Query$Likes(this, (i) => i);
}

abstract class CopyWith$Query$Likes<TRes> {
  factory CopyWith$Query$Likes(
    Query$Likes instance,
    TRes Function(Query$Likes) then,
  ) = _CopyWithImpl$Query$Likes;

  factory CopyWith$Query$Likes.stub(TRes res) = _CopyWithStubImpl$Query$Likes;

  TRes call({Query$Likes$Page? Page, String? $__typename});
  CopyWith$Query$Likes$Page<TRes> get Page;
}

class _CopyWithImpl$Query$Likes<TRes> implements CopyWith$Query$Likes<TRes> {
  _CopyWithImpl$Query$Likes(this._instance, this._then);

  final Query$Likes _instance;

  final TRes Function(Query$Likes) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? Page = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$Likes(
          Page: Page == _undefined
              ? _instance.Page
              : (Page as Query$Likes$Page?),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
        ),
      );

  CopyWith$Query$Likes$Page<TRes> get Page {
    final local$Page = _instance.Page;
    return local$Page == null
        ? CopyWith$Query$Likes$Page.stub(_then(_instance))
        : CopyWith$Query$Likes$Page(local$Page, (e) => call(Page: e));
  }
}

class _CopyWithStubImpl$Query$Likes<TRes>
    implements CopyWith$Query$Likes<TRes> {
  _CopyWithStubImpl$Query$Likes(this._res);

  TRes _res;

  call({Query$Likes$Page? Page, String? $__typename}) => _res;

  CopyWith$Query$Likes$Page<TRes> get Page =>
      CopyWith$Query$Likes$Page.stub(_res);
}

const documentNodeQueryLikes = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'Likes'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'page')),
          type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'type')),
          type: NamedTypeNode(
            name: NameNode(value: 'LikeableType'),
            isNonNull: false,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'Page'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'page'),
                value: VariableNode(name: NameNode(value: 'page')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'pageInfo'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
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
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: 'likes'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'likeableId'),
                      value: VariableNode(name: NameNode(value: 'id')),
                    ),
                    ArgumentNode(
                      name: NameNode(value: 'type'),
                      value: VariableNode(name: NameNode(value: 'type')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
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
                        selectionSet: SelectionSetNode(
                          selections: [
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
                          ],
                        ),
                      ),
                      FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionPageInfo,
  ],
);

class Query$Likes$Page {
  Query$Likes$Page({this.pageInfo, this.likes, this.$__typename = 'Page'});

  factory Query$Likes$Page.fromJson(Map<String, dynamic> json) {
    final l$pageInfo = json['pageInfo'];
    final l$likes = json['likes'];
    final l$$__typename = json['__typename'];
    return Query$Likes$Page(
      pageInfo: l$pageInfo == null
          ? null
          : Fragment$PageInfo.fromJson((l$pageInfo as Map<String, dynamic>)),
      likes: (l$likes as List<dynamic>?)
          ?.map(
            (e) => e == null
                ? null
                : Query$Likes$Page$likes.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$PageInfo? pageInfo;

  final List<Query$Likes$Page$likes?>? likes;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$pageInfo = pageInfo;
    _resultData['pageInfo'] = l$pageInfo?.toJson();
    final l$likes = likes;
    _resultData['likes'] = l$likes?.map((e) => e?.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$pageInfo = pageInfo;
    final l$likes = likes;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$pageInfo,
      l$likes == null ? null : Object.hashAll(l$likes.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Likes$Page || runtimeType != other.runtimeType) {
      return false;
    }
    final l$pageInfo = pageInfo;
    final lOther$pageInfo = other.pageInfo;
    if (l$pageInfo != lOther$pageInfo) {
      return false;
    }
    final l$likes = likes;
    final lOther$likes = other.likes;
    if (l$likes != null && lOther$likes != null) {
      if (l$likes.length != lOther$likes.length) {
        return false;
      }
      for (int i = 0; i < l$likes.length; i++) {
        final l$likes$entry = l$likes[i];
        final lOther$likes$entry = lOther$likes[i];
        if (l$likes$entry != lOther$likes$entry) {
          return false;
        }
      }
    } else if (l$likes != lOther$likes) {
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

extension UtilityExtension$Query$Likes$Page on Query$Likes$Page {
  CopyWith$Query$Likes$Page<Query$Likes$Page> get copyWith =>
      CopyWith$Query$Likes$Page(this, (i) => i);
}

abstract class CopyWith$Query$Likes$Page<TRes> {
  factory CopyWith$Query$Likes$Page(
    Query$Likes$Page instance,
    TRes Function(Query$Likes$Page) then,
  ) = _CopyWithImpl$Query$Likes$Page;

  factory CopyWith$Query$Likes$Page.stub(TRes res) =
      _CopyWithStubImpl$Query$Likes$Page;

  TRes call({
    Fragment$PageInfo? pageInfo,
    List<Query$Likes$Page$likes?>? likes,
    String? $__typename,
  });
  CopyWith$Fragment$PageInfo<TRes> get pageInfo;
  TRes likes(
    Iterable<Query$Likes$Page$likes?>? Function(
      Iterable<CopyWith$Query$Likes$Page$likes<Query$Likes$Page$likes>?>?,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$Likes$Page<TRes>
    implements CopyWith$Query$Likes$Page<TRes> {
  _CopyWithImpl$Query$Likes$Page(this._instance, this._then);

  final Query$Likes$Page _instance;

  final TRes Function(Query$Likes$Page) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? pageInfo = _undefined,
    Object? likes = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$Likes$Page(
      pageInfo: pageInfo == _undefined
          ? _instance.pageInfo
          : (pageInfo as Fragment$PageInfo?),
      likes: likes == _undefined
          ? _instance.likes
          : (likes as List<Query$Likes$Page$likes?>?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Fragment$PageInfo<TRes> get pageInfo {
    final local$pageInfo = _instance.pageInfo;
    return local$pageInfo == null
        ? CopyWith$Fragment$PageInfo.stub(_then(_instance))
        : CopyWith$Fragment$PageInfo(local$pageInfo, (e) => call(pageInfo: e));
  }

  TRes likes(
    Iterable<Query$Likes$Page$likes?>? Function(
      Iterable<CopyWith$Query$Likes$Page$likes<Query$Likes$Page$likes>?>?,
    )
    _fn,
  ) => call(
    likes: _fn(
      _instance.likes?.map(
        (e) => e == null ? null : CopyWith$Query$Likes$Page$likes(e, (i) => i),
      ),
    )?.toList(),
  );
}

class _CopyWithStubImpl$Query$Likes$Page<TRes>
    implements CopyWith$Query$Likes$Page<TRes> {
  _CopyWithStubImpl$Query$Likes$Page(this._res);

  TRes _res;

  call({
    Fragment$PageInfo? pageInfo,
    List<Query$Likes$Page$likes?>? likes,
    String? $__typename,
  }) => _res;

  CopyWith$Fragment$PageInfo<TRes> get pageInfo =>
      CopyWith$Fragment$PageInfo.stub(_res);

  likes(_fn) => _res;
}

class Query$Likes$Page$likes {
  Query$Likes$Page$likes({
    required this.id,
    required this.name,
    this.avatar,
    this.$__typename = 'User',
  });

  factory Query$Likes$Page$likes.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$avatar = json['avatar'];
    final l$$__typename = json['__typename'];
    return Query$Likes$Page$likes(
      id: (l$id as int),
      name: (l$name as String),
      avatar: l$avatar == null
          ? null
          : Query$Likes$Page$likes$avatar.fromJson(
              (l$avatar as Map<String, dynamic>),
            ),
      $__typename: (l$$__typename as String),
    );
  }

  final int id;

  final String name;

  final Query$Likes$Page$likes$avatar? avatar;

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
    return Object.hashAll([l$id, l$name, l$avatar, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Likes$Page$likes || runtimeType != other.runtimeType) {
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

extension UtilityExtension$Query$Likes$Page$likes on Query$Likes$Page$likes {
  CopyWith$Query$Likes$Page$likes<Query$Likes$Page$likes> get copyWith =>
      CopyWith$Query$Likes$Page$likes(this, (i) => i);
}

abstract class CopyWith$Query$Likes$Page$likes<TRes> {
  factory CopyWith$Query$Likes$Page$likes(
    Query$Likes$Page$likes instance,
    TRes Function(Query$Likes$Page$likes) then,
  ) = _CopyWithImpl$Query$Likes$Page$likes;

  factory CopyWith$Query$Likes$Page$likes.stub(TRes res) =
      _CopyWithStubImpl$Query$Likes$Page$likes;

  TRes call({
    int? id,
    String? name,
    Query$Likes$Page$likes$avatar? avatar,
    String? $__typename,
  });
  CopyWith$Query$Likes$Page$likes$avatar<TRes> get avatar;
}

class _CopyWithImpl$Query$Likes$Page$likes<TRes>
    implements CopyWith$Query$Likes$Page$likes<TRes> {
  _CopyWithImpl$Query$Likes$Page$likes(this._instance, this._then);

  final Query$Likes$Page$likes _instance;

  final TRes Function(Query$Likes$Page$likes) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? avatar = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$Likes$Page$likes(
      id: id == _undefined || id == null ? _instance.id : (id as int),
      name: name == _undefined || name == null
          ? _instance.name
          : (name as String),
      avatar: avatar == _undefined
          ? _instance.avatar
          : (avatar as Query$Likes$Page$likes$avatar?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Query$Likes$Page$likes$avatar<TRes> get avatar {
    final local$avatar = _instance.avatar;
    return local$avatar == null
        ? CopyWith$Query$Likes$Page$likes$avatar.stub(_then(_instance))
        : CopyWith$Query$Likes$Page$likes$avatar(
            local$avatar,
            (e) => call(avatar: e),
          );
  }
}

class _CopyWithStubImpl$Query$Likes$Page$likes<TRes>
    implements CopyWith$Query$Likes$Page$likes<TRes> {
  _CopyWithStubImpl$Query$Likes$Page$likes(this._res);

  TRes _res;

  call({
    int? id,
    String? name,
    Query$Likes$Page$likes$avatar? avatar,
    String? $__typename,
  }) => _res;

  CopyWith$Query$Likes$Page$likes$avatar<TRes> get avatar =>
      CopyWith$Query$Likes$Page$likes$avatar.stub(_res);
}

class Query$Likes$Page$likes$avatar {
  Query$Likes$Page$likes$avatar({this.large, this.$__typename = 'UserAvatar'});

  factory Query$Likes$Page$likes$avatar.fromJson(Map<String, dynamic> json) {
    final l$large = json['large'];
    final l$$__typename = json['__typename'];
    return Query$Likes$Page$likes$avatar(
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
    return Object.hashAll([l$large, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Likes$Page$likes$avatar ||
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

extension UtilityExtension$Query$Likes$Page$likes$avatar
    on Query$Likes$Page$likes$avatar {
  CopyWith$Query$Likes$Page$likes$avatar<Query$Likes$Page$likes$avatar>
  get copyWith => CopyWith$Query$Likes$Page$likes$avatar(this, (i) => i);
}

abstract class CopyWith$Query$Likes$Page$likes$avatar<TRes> {
  factory CopyWith$Query$Likes$Page$likes$avatar(
    Query$Likes$Page$likes$avatar instance,
    TRes Function(Query$Likes$Page$likes$avatar) then,
  ) = _CopyWithImpl$Query$Likes$Page$likes$avatar;

  factory CopyWith$Query$Likes$Page$likes$avatar.stub(TRes res) =
      _CopyWithStubImpl$Query$Likes$Page$likes$avatar;

  TRes call({String? large, String? $__typename});
}

class _CopyWithImpl$Query$Likes$Page$likes$avatar<TRes>
    implements CopyWith$Query$Likes$Page$likes$avatar<TRes> {
  _CopyWithImpl$Query$Likes$Page$likes$avatar(this._instance, this._then);

  final Query$Likes$Page$likes$avatar _instance;

  final TRes Function(Query$Likes$Page$likes$avatar) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? large = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$Likes$Page$likes$avatar(
          large: large == _undefined ? _instance.large : (large as String?),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
        ),
      );
}

class _CopyWithStubImpl$Query$Likes$Page$likes$avatar<TRes>
    implements CopyWith$Query$Likes$Page$likes$avatar<TRes> {
  _CopyWithStubImpl$Query$Likes$Page$likes$avatar(this._res);

  TRes _res;

  call({String? large, String? $__typename}) => _res;
}
