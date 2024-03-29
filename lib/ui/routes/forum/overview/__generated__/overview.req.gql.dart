// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gql_exec/gql_exec.dart' as _i4;
import 'package:myaniapp/graphql/__generated__/serializers.gql.dart' as _i6;
import 'package:myaniapp/ui/routes/forum/overview/__generated__/overview.ast.gql.dart'
    as _i5;
import 'package:myaniapp/ui/routes/forum/overview/__generated__/overview.data.gql.dart'
    as _i2;
import 'package:myaniapp/ui/routes/forum/overview/__generated__/overview.var.gql.dart'
    as _i3;

part 'overview.req.gql.g.dart';

abstract class GForumOverviewReq
    implements
        Built<GForumOverviewReq, GForumOverviewReqBuilder>,
        _i1.OperationRequest<_i2.GForumOverviewData, _i3.GForumOverviewVars> {
  GForumOverviewReq._();

  factory GForumOverviewReq([Function(GForumOverviewReqBuilder b) updates]) =
      _$GForumOverviewReq;

  static void _initializeBuilder(GForumOverviewReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'ForumOverview',
    )
    ..executeOnListen = true;

  @override
  _i3.GForumOverviewVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
        operation: operation,
        variables: vars.toJson(),
      );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GForumOverviewData? Function(
    _i2.GForumOverviewData?,
    _i2.GForumOverviewData?,
  )? get updateResult;
  @override
  _i2.GForumOverviewData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  _i2.GForumOverviewData? parseData(Map<String, dynamic> json) =>
      _i2.GForumOverviewData.fromJson(json);

  static Serializer<GForumOverviewReq> get serializer =>
      _$gForumOverviewReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GForumOverviewReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GForumOverviewReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GForumOverviewReq.serializer,
        json,
      );
}
