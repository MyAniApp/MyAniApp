import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:myaniapp/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class AnilistLoginScreen extends StatefulWidget {
  const AnilistLoginScreen({super.key});

  @override
  State<AnilistLoginScreen> createState() => _AnilistLoginPageState();
}

class _AnilistLoginPageState extends State<AnilistLoginScreen> {
  final Uri authUri = Uri(
    scheme: 'https',
    host: 'anilist.co',
    path: '/api/v2/oauth/authorize',
    query: 'client_id=${kIsWeb ? '13163' : '11175'}&response_type=token',
  );

  @override
  void initState() {
    super.initState();

    launchUrl(authUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 10,
            children: [
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue[100]!),
                  ),
                  onPressed: () => launchUrl(authUri),
                  child: const Text(
                    "Open Anilist Auth",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () => context.push(Routes.tokenLogin),
                  child: Text("Not working? Try using a pin"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
