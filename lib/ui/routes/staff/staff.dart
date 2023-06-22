import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:myaniapp/constants.dart';
import 'package:myaniapp/extensions.dart';
import 'package:myaniapp/graphql/__generated/ui/routes/staff/staff.graphql.dart';
import 'package:myaniapp/ui/common/graphql_error.dart';
import 'package:myaniapp/ui/common/image.dart';
import 'package:myaniapp/ui/common/pagination.dart';
import 'package:myaniapp/ui/routes/media/overview.dart';
import 'package:myaniapp/ui/routes/staff/voice.dart';

@RoutePage()
class StaffPage extends StatelessWidget {
  const StaffPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Query$Staff$Widget(
      options: Options$Query$Staff(
        variables: Variables$Query$Staff(id: id),
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading && result.parsedData == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (result.hasException) {
          return Scaffold(
            appBar: AppBar(),
            body: GraphqlError(exception: result.exception!),
          );
        }

        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                expandedHeight: 145,
                pinned: true,
                flexibleSpace: SafeArea(
                  child: FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 5),
                            child: SizedBox(
                              width: 90,
                              child: AspectRatio(
                                aspectRatio: 2 / 3,
                                child: ClipRRect(
                                  borderRadius: imageRadius,
                                  child: CImage(
                                    imageUrl:
                                        result.parsedData!.Staff!.image!.large!,
                                    viewer: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Text(
                                  result
                                      .parsedData!.Staff!.name!.userPreferred!,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (result.parsedData!.Staff!.dateOfBirth !=
                                        null &&
                                    result.parsedData!.Staff!.dateOfBirth!
                                            .toDateString() !=
                                        null)
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Birthday: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: result
                                              .parsedData!.Staff!.dateOfBirth!
                                              .toDateString()!,
                                        )
                                      ],
                                    ),
                                  ),
                                if (result.parsedData!.Staff!.age != null)
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Age: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: result.parsedData!.Staff!.age!
                                              .toString(),
                                        )
                                      ],
                                    ),
                                  ),
                                if (result.parsedData!.Staff!.gender != null)
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Gender: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              result.parsedData!.Staff!.gender,
                                        )
                                      ],
                                    ),
                                  ),
                                if (result.parsedData!.Staff!.bloodType != null)
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Blood Type: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: result
                                              .parsedData!.Staff!.bloodType,
                                        )
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
            body: Pagination(
              fetchMore: fetchMore!,
              pageInfo: result.parsedData!.Staff!.characterMedia!.pageInfo!,
              opts: FetchMoreOptions$Query$Staff(
                variables: Variables$Query$Staff(
                    characterPage: result.parsedData!.Staff!.characterMedia!
                            .pageInfo!.currentPage! +
                        1),
                updateQuery: (previousResultData, fetchMoreResultData) {
                  var list = [
                    ...previousResultData!['Staff']!['characterMedia']['edges'],
                    ...fetchMoreResultData!['Staff']!['characterMedia']
                        ['edges'],
                  ];
                  fetchMoreResultData['Staff']!['characterMedia']['edges'] =
                      list;
                  return fetchMoreResultData;
                },
              ),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Description(result.parsedData!.Staff!.description),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Voice(staff: result.parsedData!.Staff!),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
