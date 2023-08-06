import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'banner_ad.g.dart';

const _bannerDuration = Duration(minutes: 1);

class _Ad {
  _Ad({
    required this.refreshBy,
    required this.currentAd,
    required this.widget,
  });

  final DateTime refreshBy;
  final BannerAd? currentAd;
  final Widget? widget;
}

@Riverpod(keepAlive: true)
class BannerAds extends _$BannerAds {
  @override
  _Ad build() {
    return _Ad(refreshBy: DateTime.now(), currentAd: null, widget: null);
  }

  void load(int width) async {
    if (!(!kIsWeb && Platform.isAndroid)) return;

    if (state.refreshBy.isAfter(DateTime.now())) {
      return;
    } else {
      state.currentAd?.dispose();
    }

    var size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(width);

    if (size == null) return;

    BannerAd(
      size: size,
      adUnitId: 'ca-app-pub-7032560703864826/7753708493',
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          state = _Ad(
              refreshBy: DateTime.now().add(_bannerDuration),
              currentAd: ad as BannerAd,
              widget: AdWidget(
                ad: ad,
              ));
        },
        onAdClosed: (ad) {
          state = _Ad(
            refreshBy: DateTime.now().add(_bannerDuration),
            currentAd: null,
            widget: null,
          );
        },
      ),
      request: const AdRequest(),
    ).load();
  }
}
