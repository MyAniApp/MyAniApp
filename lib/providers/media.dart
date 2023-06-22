import 'package:myaniapp/graphql.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/media/media.graphql.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

var mediaProvider =
    StreamProvider.autoDispose.family<Query$Media$Media, int>((ref, id) async* {
  var query = client.value.watchQuery$Media(
    WatchOptions$Query$Media(
      variables: Variables$Query$Media(id: id),
    ),
  );

  ref.onDispose(query.close);
  var cachedResult = query.fetchResults().eagerResult.parsedData?.Media;

  if (cachedResult != null) yield cachedResult;

  await for (final data in query.stream) {
    if (data.hasException) {
      ref.state = AsyncValue.error(data.exception!, StackTrace.current);
      return;
    } else if (data.isLoading && data.parsedData == null) {
      ref.state = const AsyncValue.loading();
      return;
    }
    yield data.parsedData!.Media!;
  }
});
