import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myaniapp/app/settings/widgets.dart';
import 'package:myaniapp/app/staff/production.screen.dart';
import 'package:myaniapp/app/staff/roles.screen.dart';
import 'package:myaniapp/common/cached_image.dart';
import 'package:myaniapp/common/hiding_floating_button.dart';
import 'package:myaniapp/common/image_viewer.dart';
import 'package:myaniapp/common/ink_well_image.dart';
import 'package:myaniapp/common/list_setting_button.dart';
import 'package:myaniapp/common/markdown/markdown.dart';
import 'package:myaniapp/common/pagination.dart';
import 'package:myaniapp/common/show.dart';
import 'package:myaniapp/common/sliver_tabbar_view.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/__gen/fragments/staff.graphql.dart';
import 'package:myaniapp/graphql/__gen/media.graphql.dart';
import 'package:myaniapp/graphql/__gen/schema.graphql.dart';
import 'package:myaniapp/graphql/__gen/staff.graphql.dart';
import 'package:myaniapp/graphql/queries.dart';
import 'package:myaniapp/common/gql_widget.dart';
import 'package:myaniapp/main.dart';
import 'package:myaniapp/providers/list_settings.dart';
import 'package:myaniapp/providers/user.dart';
import 'package:mygraphql/graphql.dart';

final _extractInfo = RegExp(r"^((?:(?:\*\*)|(?:__))[^]*?\n\n)");
final staffSortFilters = {
  Enum$MediaSort.START_DATE_DESC: "Newest",
  Enum$MediaSort.START_DATE: "Oldest",
  Enum$MediaSort.TITLE_NATIVE: "Title",
  Enum$MediaSort.POPULARITY_DESC: "Popularity",
  Enum$MediaSort.FAVOURITES_DESC: "Favourites",
  Enum$MediaSort.SCORE_DESC: "Average Score",
};

class StaffScreen extends HookConsumerWidget {
  const StaffScreen({super.key, required this.id, this.placeholder});

  final int id;
  final Fragment$StaffFragment? placeholder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var (:snapshot, :fetchMore, :refetch) = gqlClient.useQuery(
      GQLRequest(
        staffQuery,
        variables: Variables$Query$Staff(
          id: id,
          sort: [.START_DATE_DESC],
        ).toJson(),
        parseData: Query$Staff.fromJson,
      ),
    );

    return GQLWidget(
      response: snapshot,
      refetch: refetch,
      loading: null,
      error: Scaffold(
        appBar: AppBar(),
        body: GraphqlError(
          exception: (snapshot.errors, snapshot.linkError),
          refetch: refetch,
        ),
      ),
      builder: () {
        if (snapshot.loading == true && placeholder == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator.adaptive()),
          );
        }

        var data = snapshot.parsedData?.Staff;

        return StaffView(
          fetchMore: fetchMore,
          request: snapshot.request!,
          refetch: refetch,
          placeholder: placeholder,
          staff: data,
        );
      },
    );
  }

  bool hasTabs(Query$Staff$Staff staff) {
    return staff.characterMedia!.edges!.isNotEmpty == true &&
        staff.staffMedia!.edges!.isNotEmpty == true;
  }
}

class StaffView extends ConsumerStatefulWidget {
  const StaffView({
    super.key,
    this.staff,
    this.placeholder,
    required this.refetch,
    required this.fetchMore,
    required this.request,
  });

  final GQLRequest request;
  final QueryRefetch refetch;
  final QueryHookFetchMore fetchMore;
  final Query$Staff$Staff? staff;
  final Fragment$StaffFragment? placeholder;

  @override
  ConsumerState<StaffView> createState() => _StaffViewState();
}

class _StaffViewState extends ConsumerState<StaffView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  int currentIndex = 0;
  bool done = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(listener);
    _moveTo();
  }

  void _moveTo() {
    if (done || widget.staff == null) return;
    // if (widget.staff == null) return;
    // tabController?.dispose();
    var index = hasTabs(widget.staff!)
        ? 0
        : widget.staff!.staffMedia!.edges!.isNotEmpty == true
        ? 1
        : 0;
    currentIndex = index;
    tabController.animateTo(index);
    done = true;
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  void listener() {
    if (currentIndex != tabController.index) {
      setState(() => currentIndex = tabController.index);
    }
  }

  @override
  void didUpdateWidget(covariant StaffView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _moveTo();
  }

  @override
  Widget build(BuildContext context) {
    var listSettings = ref.watch(listSettingsProvider);

    return HidingFloatingButton(
      button: Show(
        when: widget.staff != null,
        child: () => FloatingActionButton.extended(
          heroTag: null,
          onPressed: widget.staff!.isFavouriteBlocked
              ? null
              : () => gqlClient
                    .query(
                      GQLRequest(
                        toggleFavoriteQuery,
                        variables: Variables$Mutation$ToggleFavorite(
                          staffId: widget.staff!.id,
                        ).toJson(),
                      ),
                    )
                    .last
                    .then((_) => widget.refetch()),
          label: Row(
            children: [
              Icon(
                Icons.favorite,
                color: widget.staff!.isFavourite ? Colors.red[200] : null,
              ),
              SizedBox(width: 5),
              Text(
                widget.staff!.favourites!.abbreviate(),
                style: context.theme.textTheme.bodyMedium?.bold,
              ),
            ],
          ),
          backgroundColor: Colors.red[900],
        ),
      ),
      builder: (button) => Scaffold(
        floatingActionButton: button,
        body: RefreshIndicator.adaptive(
          onRefresh: widget.refetch,
          notificationPredicate: (notification) => notification.depth == 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                pinned: true,
                title: Text(
                  (widget.staff ?? widget.placeholder)!.name!.userPreferred!,
                  maxLines: 2,
                ),
                // expandedHeight: 182,
                // snap: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => StaffFilters(
                          request: widget.request,
                          fetchMore: widget.fetchMore,
                        ),
                      );
                    },
                    icon: Icon(Icons.filter_alt),
                  ),
                  const SizedBox(width: 5),
                  if (widget.staff != null &&
                      widget.staff!.characterMedia!.edges!.isNotEmpty &&
                      (!hasTabs(widget.staff!) || tabController.index == 0))
                    ListSettingButton(
                      type: listSettings.staffVA,
                      onUpdate: (type) => ref
                          .read(listSettingsProvider.notifier)
                          .update(listSettings.copyWith(staffVA: type)),
                    ),
                  if (widget.staff != null &&
                      widget.staff!.staffMedia!.edges!.isNotEmpty &&
                      (!hasTabs(widget.staff!) || tabController.index == 1))
                    ListSettingButton(
                      type: listSettings.staffProduction,
                      onUpdate: (type) => ref
                          .read(listSettingsProvider.notifier)
                          .update(listSettings.copyWith(staffProduction: type)),
                    ),
                ],
              ),
              Show(
                when: widget.staff != null,
                fallback: const SliverToBoxAdapter(child: SizedBox()),
                child: () {
                  var metadata = _extractInfo
                      .firstMatch(widget.staff!.description ?? "")
                      ?.group(1);
                  var description = metadata != null
                      ? widget.staff!.description?.replaceAll(metadata, "")
                      : widget.staff!.description;

                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWellImage(
                                onTap: () => ImageViewer.showImage(
                                  context,
                                  (widget.staff ?? widget.placeholder)!
                                      .image!
                                      .large!,
                                  tag: (widget.staff ?? widget.placeholder)!.id,
                                ),
                                borderRadius: imageRadius,
                                child: ClipRRect(
                                  borderRadius: imageRadius,
                                  child: Hero(
                                    tag: (widget.staff ?? widget.placeholder)!
                                        .id,
                                    child: CachedImage(
                                      (widget.staff ?? widget.placeholder)!
                                          .image!
                                          .large!,
                                      height: 150,
                                      width: 106,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (widget.staff!.dateOfBirth
                                              ?.toDateString() !=
                                          null)
                                        _InfoText(
                                          title: "Birth:",
                                          text: widget.staff!.dateOfBirth!
                                              .toDateString()!,
                                        ),
                                      if (widget.staff!.dateOfDeath
                                              ?.toDateString() !=
                                          null)
                                        _InfoText(
                                          title: "Death:",
                                          text: widget.staff!.dateOfDeath!
                                              .toDateString()!,
                                        ),
                                      if (widget.staff!.age != null)
                                        _InfoText(
                                          title: "Age:",
                                          text: widget.staff!.age!.toString(),
                                        ),
                                      if (widget.staff!.homeTown != null)
                                        _InfoText(
                                          title: "Hometown:",
                                          text: widget.staff!.homeTown!,
                                        ),
                                      if (widget.staff!.gender != null)
                                        _InfoText(
                                          title: "Gender:",
                                          text: widget.staff!.gender!,
                                        ),
                                      if (widget
                                              .staff!
                                              .yearsActive
                                              ?.isNotEmpty ==
                                          true)
                                        _InfoText(
                                          title: "Year Active:",
                                          text:
                                              "${widget.staff!.yearsActive![0]} - ${widget.staff!.yearsActive?.elementAtOrNull(1) ?? "Present"}",
                                        ),
                                      if (widget.staff!.bloodType != null)
                                        _InfoText(
                                          title: "Blood Type:",
                                          text: widget.staff!.bloodType!,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (metadata != null)
                            MarkdownWidget.body(
                              data: metadata,
                              padding: const EdgeInsets.all(0),
                            ),
                          MarkdownWidget.body(
                            data: description ?? "*No Description*",
                            selectable: true,
                            padding: const EdgeInsets.all(0),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Show(
                when: widget.staff != null && hasTabs(widget.staff!),
                fallback: const SliverToBoxAdapter(child: SizedBox()),
                child: () => SliverPersistentHeader(
                  delegate: SliverTabBarViewDelegate(
                    child: TabBar(
                      controller: tabController,
                      isScrollable: true,
                      tabs: const [
                        Tab(text: "VA Roles"),
                        Tab(text: "Staff"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            body: Show(
              when: widget.staff != null,
              fallback: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              child: () => ScrollConfiguration(
                behavior: ScrollConfiguration.of(
                  context,
                ).copyWith(scrollbars: false),
                child: GraphqlPagination(
                  pageInfo: tabController.index == 0
                      ? widget.staff!.characterMedia!.pageInfo!
                      : widget.staff!.staffMedia!.pageInfo!,
                  req: (nextPage) {
                    bool isCharacter = tabController.index == 0 ? true : false;

                    if (isCharacter) {
                      return widget.fetchMore(
                        variables: Variables$Query$Staff.fromJson(
                          widget.request.variables,
                        ).copyWith(characterPage: nextPage).toJson(),
                        mergeResults: defaultMergeResults(
                          "Staff.characterMedia.edges",
                        ),
                      );
                    }

                    return widget.fetchMore(
                      variables: Variables$Query$Staff.fromJson(
                        widget.request.variables,
                      ).copyWith(staffPage: nextPage).toJson(),
                      mergeResults: defaultMergeResults(
                        "Staff.staffMedia.edges",
                      ),
                    );
                  },
                  child: TabBarView(
                    physics: widget.staff != null && hasTabs(widget.staff!)
                        ? null
                        : const NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: [
                      StaffVARolesScreen(
                        medias: widget.staff!.characterMedia!,
                        sort: fromJson$Enum$MediaSort(
                          widget.request.variables["sort"]?[0] ?? '',
                        ),
                      ),
                      StaffProductionRolesScreen(
                        staffRoles: widget.staff!.staffMedia!,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool hasTabs(Query$Staff$Staff staff) {
    return staff.characterMedia!.edges!.isNotEmpty == true &&
        staff.staffMedia!.edges!.isNotEmpty == true;
  }
}

class StaffFilters extends ConsumerStatefulWidget {
  const StaffFilters({
    super.key,
    required this.request,
    required this.fetchMore,
  });

  final GQLRequest request;
  final QueryHookFetchMore fetchMore;

  @override
  ConsumerState<StaffFilters> createState() => _StaffFiltersState();
}

class _StaffFiltersState extends ConsumerState<StaffFilters> {
  late Variables$Query$Staff vars = .fromJson(widget.request.variables);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CheckboxSettingsTile(
          title: "On My List",
          value: vars.onList ?? false,
          onChanged: (value) {
            setState(() {
              vars = vars.copyWith(onList: value == true ? true : null);
            });
            widget.fetchMore(
              variables: {
                "id": vars.id,
                "onList": value == true ? true : null,
                "sort": [
                  toJson$Enum$MediaSort(
                    vars.sort?.firstOrNull ?? Enum$MediaSort.START_DATE_DESC,
                  ),
                ],
              },
            );
          },
        ),
        PopupSettingsTile(
          title: "Sort",
          subtitle: vars.sort?.isNotEmpty == true
              ? Text(vars.sort!.first!.name.capitalize())
              : null,
          value: vars.sort?.firstOrNull,
          onSelected: (value) {
            setState(() {
              final userTitleLang = ref.read(
                userProvider.select(
                  (s) => s.value?.parsedData?.Viewer?.options?.titleLanguage,
                ),
              );
              if (value == .TITLE_NATIVE && userTitleLang != null) {
                vars = vars.copyWith(
                  sort: switch (userTitleLang!) {
                    .ROMAJI || .ROMAJI_STYLISED => [.TITLE_ROMAJI],
                    .ENGLISH || .ENGLISH_STYLISED => [.TITLE_ENGLISH],
                    .NATIVE || .NATIVE_STYLISED => [.TITLE_NATIVE],
                    _ => [.TITLE_NATIVE],
                  },
                );
              } else {
                vars = vars.copyWith(sort: [value]);
              }
            });
            widget.fetchMore(
              variables: {
                "id": vars.id,
                "onList": vars.onList == true ? true : null,
                "sort": [
                  toJson$Enum$MediaSort(
                    vars.sort?.firstOrNull ?? Enum$MediaSort.START_DATE_DESC,
                  ),
                ],
              },
            );
          },
          items: [
            for (var entry in staffSortFilters.entries)
              PopupSettingItem(label: entry.value, value: entry.key),
          ],
        ),
      ],
    );
  }
}

class _InfoText extends StatelessWidget {
  const _InfoText({required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "$title ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: text),
        ],
      ),
    );
  }
}
