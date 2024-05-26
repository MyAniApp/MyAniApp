import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myaniapp/app/home/%5Btab%5D/page.dart';
import 'package:myaniapp/app/home/__generated__/overview.req.gql.dart';
import 'package:myaniapp/app/reviews/card.dart';
import 'package:myaniapp/common/media_cards/grid_card.dart';
import 'package:myaniapp/common/media_cards/sheet.dart';
import 'package:myaniapp/common/media_editor/media_editor.dart';
import 'package:myaniapp/common/thread_card.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/widget.dart';
import 'package:myaniapp/providers/user.dart';

class HomeLoggedInOverviewPage extends ConsumerStatefulWidget {
  const HomeLoggedInOverviewPage({super.key});

  @override
  ConsumerState<HomeLoggedInOverviewPage> createState() =>
      _HomeLoggedInOverviewPageState();
}

class _HomeLoggedInOverviewPageState
    extends ConsumerState<HomeLoggedInOverviewPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var user = ref.read(userProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const HomeLeadingIcon(),
        actions: [
          IconButton(
            onPressed: () => context.push("/notifications"),
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: GQLRequest(
        operationRequest: GHomeOverviewReq((b) => b
          ..requestId = "homeLoggedInPage"
          ..vars.userId = user.value!.data!.Viewer!.id),
        builder: (context, response, error, refetch) =>
            RefreshIndicator.adaptive(
          onRefresh: refetch,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Welcome ${user.value!.data!.Viewer!.name}!",
                  style: context.theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "In Progress",
                  style: context.theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 190,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    var entry = response.data!.list!.mediaList![index]!;
                    return GridCard(
                      image: entry.media!.coverImage!.extraLarge!,
                      title: entry.media!.title!.userPreferred,
                      blur: entry.media!.isAdult ?? false,
                      aspectRatio: GridCard.listRatio,
                      onDoubleTap: () => MediaEditorDialog.show(
                        context,
                        entry.media!,
                        user.value!.data!.Viewer!.id,
                        onSave: refetch,
                        onDelete: refetch,
                      ),
                      onTap: () => context.push(
                          "/media/${entry.media!.id}/overview",
                          extra: {"media": entry.media}),
                      onLongPress: () => MediaSheet.show(context, entry.media!),
                    );
                  },
                  itemCount: response!.data!.list!.mediaList!.length,
                ),
              ),
              // Threads
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "Forum Activity",
                      style: context.theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () => context.push('/forum/overview'),
                      child: const Text("All"),
                    )
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  var thread = response.data!.forums!.threads![index]!;

                  return ThreadCard(thread: thread);
                },
                itemCount: response.data!.forums!.threads!.length,
              ),
              // Reviews
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Recent Reviews",
                  style: context.theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              GridView.builder(
                primary: false,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  mainAxisExtent: 200,
                ),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var review = response.data!.reviews!.reviews![index]!;

                  return ReviewCard(review: review);
                },
                itemCount: response.data!.reviews!.reviews!.length,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
