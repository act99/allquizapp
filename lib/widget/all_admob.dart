import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdMobService {
  String getAdMobAppId() {
    if (Platform.isAndroid) {
      return "ca-app-pub-6660347485032552~1725024957";
    }
    return null;
  }

  String getInterstitialAdId() {
    if (Platform.isAndroid) {
      return "ca-app-pub-6660347485032552/8644483062";
    }
    return null;
  }

  InterstitialAd getNewItemInterstitial() {
    return InterstitialAd(
      adUnitId: getInterstitialAdId(),
      listener: (MobileAdEvent event) {
        print("$event is event");
      },
    );
  }
}

class AllAdmob extends StatelessWidget {
  final ams = AdMobService();
  @override
  Widget build(BuildContext context) {
    InterstitialAd newItemAd = ams.getNewItemInterstitial();
    newItemAd.load();
    newItemAd.show(
      anchorType: AnchorType.bottom,
      anchorOffset: 0.0,
      horizontalCenterOffset: 0.0,
    );
  }
}

// class AllAdmob extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // String appId = "ca-app-pub-6660347485032552~1725024957";
//     // FirebaseAdMob.instance.initialize(appId: appId);
//     // MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//     //   keywords: <String>['flutterio', 'beautiful apps'],
//     //   contentUrl: 'https://flutter.io',
//     //   childDirected: false,
//     //   testDevices: <String>[], // Android emulators are considered test devices
//     // );

//     // InterstitialAd myInterstitial = InterstitialAd(
//     //   adUnitId: InterstitialAd.testAdUnitId,
//     //   targetingInfo: targetingInfo,
//     //   listener: (MobileAdEvent event) {},
//     // );
//     // myInterstitial
//     //   ..load()
//     //   ..show(
//     //     anchorType: AnchorType.bottom,
//     //     anchorOffset: 0.0,
//     //     horizontalCenterOffset: 0.0,
//     //   );
//   }
// }
