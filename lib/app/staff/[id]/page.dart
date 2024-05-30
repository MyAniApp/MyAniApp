import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myaniapp/app/media/__generated__/media.req.gql.dart';
import 'package:myaniapp/app/staff/__generated__/staff.data.gql.dart';
import 'package:myaniapp/app/staff/__generated__/staff.req.gql.dart';
import 'package:myaniapp/common/cached_image.dart';
import 'package:myaniapp/common/hiding_floating_button.dart';
import 'package:myaniapp/common/image_viewer.dart';
import 'package:myaniapp/common/ink_well_image.dart';
import 'package:myaniapp/common/invisible_expanded_title.dart';
import 'package:myaniapp/common/markdown/markdown.dart';
import 'package:myaniapp/common/media_cards/grid_card.dart';
import 'package:myaniapp/common/media_cards/sheet.dart';
import 'package:myaniapp/common/pagination.dart';
import 'package:myaniapp/common/show.dart';
import 'package:myaniapp/common/sliver_tabbar_view.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/fragments/__generated__/staff.data.gql.dart';
import 'package:myaniapp/graphql/widget.dart';
import 'package:myaniapp/main.dart';

final _extractInfo = RegExp(r"^((?:(?:\*\*)|(?:__))[^]*?\n\n)");

class StaffPage extends StatefulWidget {
  const StaffPage({super.key, required this.id});

  final String id;

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GQLRequest(
      key: Key(widget.id),
      operationRequest: GStaffReq(
        (b) => b
          ..requestId = "staffPage${widget.id}"
          ..vars.id = int.parse(widget.id),
      ),
      loading: null,
      error: (response) => Scaffold(
        appBar: AppBar(),
        body: GraphqlError(
          exception: (response!.graphqlErrors, response.linkException),
          req: response.operationRequest,
        ),
      ),
      builder: (context, response, error, refetch) {
        if (response?.loading == true &&
            (GoRouterState.of(context).extra as Map?)?["staff"]
                is! GStaffFragment) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }

        GStaffFragment? placeholder =
            (GoRouterState.of(context).extra as Map?)?["staff"];
        var data = response?.data?.Staff;

        if (data != null && hasTabs(data) && _tabController == null) {
          _tabController = TabController(length: 2, vsync: this);
        }

        return HidingFloatingButton(
          button: Show(
            when: data != null,
            child: () => FloatingActionButton.extended(
              heroTag: null,
              onPressed: data!.isFavouriteBlocked
                  ? null
                  : () => client
                      .request(GToggleFavoriteReq(
                        (b) => b..vars.staffId = data.id,
                      ))
                      .first
                      .then((_) => refetch()),
              label: Icon(
                Icons.favorite,
                color: data.isFavourite ? Colors.red[200] : null,
              ),
              backgroundColor: Colors.red[900],
            ),
          ),
          builder: (button) => Scaffold(
            floatingActionButton: button,
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  pinned: true,
                  title: InvisibleExpandedTitle(
                    child: Text(
                      (data ?? placeholder)!.name!.userPreferred!,
                      maxLines: 2,
                    ),
                  ),
                  expandedHeight: 182,
                  // snap: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: SafeArea(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16,
                              right: 8,
                              left: 8,
                            ),
                            child: InkWellImage(
                              onTap: () => ImageViewer.showImage(
                                context,
                                (data ?? placeholder)!.image!.large!,
                                tag: (data ?? placeholder)!.id,
                              ),
                              borderRadius: imageRadius,
                              child: ClipRRect(
                                borderRadius: imageRadius,
                                child: Hero(
                                  tag: (data ?? placeholder)!.id,
                                  child: CachedImage(
                                    (data ?? placeholder)!.image!.large!,
                                    height: 150,
                                    width: 106,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                (data ?? placeholder)!.name!.userPreferred!,
                                style: context.theme.textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Show(
                  when: data != null,
                  fallback: const SliverToBoxAdapter(
                    child: SizedBox(),
                  ),
                  child: () {
                    var metadata = _extractInfo
                        .firstMatch(data!.description ?? "")
                        ?.group(1);
                    var description = metadata != null
                        ? data.description?.replaceAll(metadata, "")
                        : data.description;

                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (data.dateOfBirth?.toDateString() != null)
                              _InfoText(
                                title: "Birth:",
                                text: data.dateOfBirth!.toDateString()!,
                              ),
                            if (data.dateOfDeath?.toDateString() != null)
                              _InfoText(
                                title: "Death:",
                                text: data.dateOfDeath!.toDateString()!,
                              ),
                            if (data.age != null)
                              _InfoText(
                                  title: "Age:", text: data.age!.toString()),
                            if (data.homeTown != null)
                              _InfoText(
                                title: "Hometown:",
                                text: data.homeTown!,
                              ),
                            if (data.gender != null)
                              _InfoText(
                                title: "Gender:",
                                text: data.gender!,
                              ),
                            if (data.yearsActive?.isNotEmpty == true)
                              _InfoText(
                                title: "Year Active:",
                                text:
                                    "${data.yearsActive![0]} - ${data.yearsActive?.elementAtOrNull(1) ?? "Present"}",
                              ),
                            if (data.bloodType != null)
                              _InfoText(
                                title: "Blood Type:",
                                text: data.bloodType!,
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
                  when: data != null && hasTabs(data),
                  fallback: const SliverToBoxAdapter(
                    child: SizedBox(),
                  ),
                  child: () => SliverPersistentHeader(
                    delegate: SliverTabBarViewDelegate(
                      child: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        tabs: const [
                          Tab(
                            text: "VA Roles",
                          ),
                          Tab(text: "Staff")
                        ],
                      ),
                    ),
                  ),
                )
              ],
              body: Show(
                when: data != null,
                fallback: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                child: () {
                  return StaffView(
                    controller: _tabController,
                    staff: data!,
                    operationRequest: response!.operationRequest as GStaffReq,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  bool hasTabs(GStaffData_Staff staff) {
    return staff.characterMedia!.edges!.isNotEmpty == true &&
        staff.staffMedia!.edges!.isNotEmpty == true;
  }
}

class StaffView extends StatefulWidget {
  const StaffView(
      {super.key,
      required this.controller,
      required this.staff,
      required this.operationRequest});

  final TabController? controller;
  final GStaffReq operationRequest;
  final GStaffData_Staff staff;

  @override
  State<StaffView> createState() => _StaffViewState();
}

class _StaffViewState extends State<StaffView> {
  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(listener);
  }

  void listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GraphqlPagination(
      pageInfo: widget.controller != null
          ? widget.controller!.index == 0
              ? widget.staff.characterMedia!.pageInfo!
              : widget.staff.staffMedia!.pageInfo!
          : widget.staff.staffMedia!.pageInfo!,
      req: (nextPage) {
        var isCharacter = widget.controller != null
            ? widget.controller!.index == 0
            : widget.staff.characterMedia!.edges!.isNotEmpty;

        if (isCharacter) {
          return (widget.operationRequest).rebuild(
            (p0) => p0
              ..vars.characterPage = nextPage
              ..updateResult = (previous, result) => result?.rebuild((p0) => p0
                ..Staff.characterMedia.edges.insertAll(
                    0,
                    previous?.Staff?.characterMedia?.edges?.whereNot((p0) =>
                            result.Staff?.characterMedia?.edges?.contains(p0) ??
                            false) ??
                        [])),
          );
        }

        return (widget.operationRequest).rebuild(
          (p0) => p0
            ..vars.staffPage = nextPage
            ..updateResult = (previous, result) => result?.rebuild((p0) => p0
              ..Staff.staffMedia.edges.insertAll(
                  0,
                  previous?.Staff?.staffMedia?.edges?.whereNot((p0) =>
                          result.Staff?.staffMedia?.edges?.contains(p0) ??
                          false) ??
                      [])),
        );
      },
      child: Show(
        when: widget.controller != null,
        fallback: Show(
          when: widget.staff.characterMedia!.edges!.isNotEmpty == true,
          fallback: StaffRoles(
            staffRoles: widget.staff.staffMedia!,
          ),
          child: () => StaffVARoles(
            medias: widget.staff.characterMedia!,
          ),
        ),
        child: () => ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: TabBarView(
            controller: widget.controller,
            children: [
              StaffVARoles(
                medias: widget.staff.characterMedia!,
              ),
              StaffRoles(
                staffRoles: widget.staff.staffMedia!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StaffRoles extends StatelessWidget {
  const StaffRoles({super.key, required this.staffRoles});

  final GStaffData_Staff_staffMedia staffRoles;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // primary: false,
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        childAspectRatio: GridCard.listRatio,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        var media = staffRoles.edges![index]!;

        return GridCard(
          image: media.node!.coverImage!.extraLarge!,
          title: media.node!.title!.userPreferred,
          blur: media.node!.isAdult ?? false,
          onTap: () => context.push("/media/${media.node!.id}/overview",
              extra: {"media": media.node}),
          onLongPress: () => MediaSheet.show(context, media.node!),
          underTitle: media.staffRole != null
              ? Text(
                  media.staffRole!,
                  style: context.theme.textTheme.labelSmall,
                )
              : null,
        );
      },
      itemCount: staffRoles.edges!.length,
    );
  }
}

class StaffVARoles extends StatelessWidget {
  const StaffVARoles({
    super.key,
    required this.medias,
  });

  final GStaffData_Staff_characterMedia medias;

  @override
  Widget build(BuildContext context) {
    var years = _Media.sort(medias.edges!);

    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        var year = years[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                year.year == 0 ? "TBA" : year.year.toString(),
                style: context.theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            GridView.builder(
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                childAspectRatio: GridCard.listRatio,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                var media = year.medias[index];

                return GridCard(
                  image: media.characters!.first!.image!.large!,
                  title: media.characters!.first!.name!.userPreferred,
                  blur: media.node!.isAdult ?? false,
                  onTap: () => context.push(
                      "/character/${media.characters!.first!.id}",
                      extra: {"character": media.characters!.first}),
                  chips: [
                    Positioned(
                      bottom: 15,
                      right: 0,
                      child: SizedBox(
                        height: 80,
                        width: 53,
                        child: InkWellImage(
                          onTap: () => context.push(
                              "/media/${media.node!.id}/overview",
                              extra: {
                                "media": media.node,
                                "tag":
                                    "${media.node!.id}-${media.characters!.first!.id}"
                              }),
                          onLongPress: () =>
                              MediaSheet.show(context, media.node!),
                          child: AspectRatio(
                            aspectRatio: GridCard.listRatio,
                            child: CachedImage(
                              media.node!.coverImage!.extraLarge!,
                              height: 50,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
              itemCount: year.medias.length,
            ),
          ],
        );
      },
      itemCount: years.length,
    );
  }
}

class _InfoText extends StatelessWidget {
  const _InfoText({
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "$title ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: text)
        ],
      ),
    );
  }
}

// used to sort media by year
class _Media {
  const _Media(this.medias, this.year);

  final List<GStaffData_Staff_characterMedia_edges> medias;
  final int year;

  static List<_Media> sort(
      Iterable<GStaffData_Staff_characterMedia_edges?> edges) {
    List<_Media> list = [];

    for (var edge in edges) {
      var index = list
          .indexWhere((element) => element.year == edge!.node!.startDate?.year);

      if (index != -1) {
        list[index].medias.add(edge!);
      } else if (edge!.node!.startDate?.year == null) {
        var tba = list.indexWhere((element) => element.year == 0);

        if (tba != -1) {
          list[tba].medias.add(edge);
        } else {
          list.insert(0, _Media([edge], 0));
        }

        continue;
      } else {
        // print(edge.node!.title!.userPreferred);
        list.add(_Media([edge], edge.node!.startDate!.year!));
      }
    }

    return list;
  }
}
