import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myaniapp/providers/settings.dart';
import 'package:myaniapp/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class TokenLoginScreen extends ConsumerStatefulWidget {
  const TokenLoginScreen({super.key});

  @override
  ConsumerState<TokenLoginScreen> createState() => _TokenLoginScreenState();
}

class _TokenLoginScreenState extends ConsumerState<TokenLoginScreen> {
  final Uri authUri = Uri(
    scheme: 'https',
    host: 'anilist.co',
    path: '/api/v2/oauth/authorize',
    query: 'client_id=42628&response_type=token',
  );

  @override
  void initState() {
    super.initState();
    launchUrl(authUri, mode: .externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            TextField(
              maxLength: null,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  ref
                      .read(settingsProvider.notifier)
                      .updateToken(value)
                      .then((value) => context.go(Routes.home));
                }
              },
            ),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () => launchUrl(authUri, mode: .externalApplication),
                child: Text("Click to get pin"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
