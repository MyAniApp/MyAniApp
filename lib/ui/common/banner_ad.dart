import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myaniapp/providers/banner_ad.dart';

class BannerAdWidget extends ConsumerStatefulWidget {
  const BannerAdWidget({super.key});

  @override
  ConsumerState<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends ConsumerState<BannerAdWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref
          .read(bannerAdsProvider.notifier)
          .load(MediaQuery.of(context).size.width.truncate());
    });
  }

  @override
  Widget build(BuildContext context) {
    var ad = ref.watch(bannerAdsProvider);

    if (ad.currentAd == null || ad.widget == null) {
      return const SizedBox();
    }

    return SafeArea(
      child: SizedBox(
        height: ad.currentAd!.size.height.toDouble(),
        width: ad.currentAd!.size.width.toDouble(),
        child: ad.widget,
      ),
    );
  }
}

class BannerAdSafeArea extends ConsumerWidget {
  const BannerAdSafeArea({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var ad = ref.watch(bannerAdsProvider);

    if (ad.currentAd == null) return child;

    return Padding(
      padding:
          EdgeInsets.only(bottom: ad.currentAd?.size.height.toDouble() ?? 0),
      child: child,
    );
  }
}
