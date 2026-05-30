import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

enum BannerAdLocations { thread, activity, review, explore }

final Map<BannerAdLocations, String> unitIds = {
  BannerAdLocations.thread: "ca-app-pub-7032560703864826/9667422868",
  BannerAdLocations.activity: "ca-app-pub-7032560703864826/5972608484",
  BannerAdLocations.review: "ca-app-pub-7032560703864826/6821140350",
  BannerAdLocations.explore: "ca-app-pub-7032560703864826/4659526814",
};

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key, required this.location});

  final BannerAdLocations location;

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAd();
    });
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  void _loadAd() async {
    if (!(!kIsWeb && Platform.isAndroid)) return;
    BannerAd(
      adUnitId:
          unitIds[widget.location] ?? "ca-app-pub-7032560703864826/1568813679",
      request: const AdRequest(),
      size: .largeBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          // Called when an ad is successfully received.
          debugPrint("Ad was loaded.");
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          // Called when an ad request failed.
          debugPrint("Ad failed to load with error: $err");
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    if (_bannerAd != null) {
      return SizedBox(
        height: _bannerAd!.size.height.toDouble(),
        width: _bannerAd!.size.width.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      );
    }
    return SizedBox();
  }
}
