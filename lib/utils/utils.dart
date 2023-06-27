import 'package:myaniapp/graphql/__generated/graphql/fragments.graphql.dart';

DateTime dateFromTimestamp(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
}

bool isTodayFromTimestamp(int? timestamp) {
  if (timestamp == null) return false;
  var now = DateTime.now();
  var date = dateFromTimestamp(timestamp);
  return now.year == date.year &&
      now.month == date.month &&
      (now.day) == (date.day);
}

bool hasTimestampPassed(int? timestamp) {
  if (timestamp == null) return false;
  var date = dateFromTimestamp(timestamp).difference(DateTime.now());
  if (date.isNegative) return true;
  return false;
}

List<Fragment$ReleasingMedia> sortReleases(
  List<Fragment$ReleasingMedia?> releases, {
  bool includeUnreleased = false,
}) {
  return releases
      .where((element) {
        if (includeUnreleased) return true;
        return element?.airingSchedule != null &&
            element?.nextAiringEpisode != null &&
            dateFromTimestamp((element!.nextAiringEpisode?.airingAt ??
                        element.airingSchedule!.edges!.first!.node!.airingAt))
                    .difference(DateTime.now())
                    .inDays <=
                7;
      })
      .whereType<Fragment$ReleasingMedia>()
      .toList()
    ..sort(
      (a, b) {
        // first check if a and b have airingSchedule and a next episode
        if ((a.airingSchedule ?? a.nextAiringEpisode) == null &&
            (b.airingSchedule ?? b.nextAiringEpisode) == null) {
          return 0;
        } else if ((b.airingSchedule ?? b.nextAiringEpisode) == null) {
          return -1;
        } else if ((a.airingSchedule ?? a.nextAiringEpisode) == null) {
          return 1;
        }

        var prevEpia = a.airingSchedule!.edges!.firstWhere(
          (element) =>
              element?.node?.episode == (a.nextAiringEpisode!.episode - 1),
          orElse: () => null,
        );
        var prevEpib = b.airingSchedule!.edges!.firstWhere(
          (element) =>
              element?.node?.episode == (b.nextAiringEpisode!.episode - 1),
          orElse: () => null,
        );

        var todaya = isTodayFromTimestamp(prevEpia?.node?.airingAt);
        var todayb = isTodayFromTimestamp(prevEpib?.node?.airingAt);

        // check if the most recent episode released is today
        if (todaya && todayb) {
          return 0;
        } else if (todayb) {
          return 1;
        } else if (todaya) {
          return -1;
        }

        var datea = dateFromTimestamp(a.nextAiringEpisode!.airingAt);
        var dateb = dateFromTimestamp(b.nextAiringEpisode!.airingAt);

        return datea.compareTo(dateb);
      },
    );
}
