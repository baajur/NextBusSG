import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nextbussg/components/core/buttons/button.dart';
import 'package:nextbussg/components/onboarding/page_view_model_template.dart';
import 'package:nextbussg/providers/location_perms.dart';
import 'package:nextbussg/routes/permission.dart';
import 'package:nextbussg/tabbed_app.dart';
import 'package:nextbussg/utils/route.dart';

class OnboardingView extends StatelessWidget {
  PageViewModel tutorial(BuildContext context) {
    return pageViewModelTemplate(
      context,
      "See bus arrival timings",
      "Tap on any **bus stop** to see a list of bus services and timings",
      Colors.white,
      imageUrl: 'assets/onboard/arrival-timings.png',
      // footer: LocationAccessButton()
    );
  }

  PageViewModel serviceTileTutorial(BuildContext context) {
    return pageViewModelTemplate(
      context,
      "See bus timings and crowd",
      // "For **Bus 9**,\n\n- The first bus is **not crowded**, and will arrive in 9 minutes,\n- The second bus is **crowded** and will arrive in 21 minutes, and\n- The third bus is **over crowded**, and will arrive in 29 minutes",
      "",
      Colors.white,
      imageUrl: 'assets/onboard/service-tile.png',
    );
  }

  PageViewModel favorites1(BuildContext context) {
    return pageViewModelTemplate(
      context,
      "Add bus services to your favorites ...",
      "Tap on a **bus service** to add or remove them to your favorites.",
      Colors.white,
      imageUrl: 'assets/onboard/favorites.png',
    );
  }

  PageViewModel search1(BuildContext context) {
    return pageViewModelTemplate(
      context,
      "Search for bus stops ...",
      "and view information about them.",
      Colors.white,
      imageUrl: 'assets/onboard/search.png',
    );
  }

  PageViewModel more(BuildContext context) {
    return pageViewModelTemplate(
      context,
      "More ...",
      "See the **MRT map**, use the **dark theme**, **rename** bus stops ...",
      Color(0xFF111111),
      imageUrl: 'assets/onboard/mrt.png',
      dark: true,
    );
  }

  TextStyle buttonTextStyle(context) => Theme.of(context).textTheme.body1.copyWith(
        color: Colors.black87,
        fontWeight: FontWeight.w700,
      );
  TextStyle doneButtonTextStyle(context) => Theme.of(context).textTheme.body1.copyWith(
        color: Colors.white70,
        fontWeight: FontWeight.w700,
      );

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        tutorial(context),
        serviceTileTutorial(context),
        // requestLocation(context),
        favorites1(context),
        search1(context),
        more(context),
      ],
      onDone: () => _finish(context),
      done: Text('Done', style: doneButtonTextStyle(context)),
      showSkipButton: true,
      skip: Text("Skip", style: buttonTextStyle(context)),
      next: Text("Next", style: buttonTextStyle(context)),
      onSkip: () => _finish(context),
      freeze: false,
    );
  }

  _finish(context) async {
    final bool status = await LocationPermsProvider.getPermStatus();

    if (status == true)
      Routing.openReplacementRoute(context, TabbedApp());
    else
      Routing.openReplacementRoute(context, PermissionRoute());
  }
}
