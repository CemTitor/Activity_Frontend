import 'package:weather_frontend/data/activity_api/src/models/activity.dart';
import 'package:flutter/material.dart';

import 'bottom_loader.dart';

class ActivityListPopulated extends StatelessWidget {
  const ActivityListPopulated({
    super.key,
    required this.activityList,
  });

  final List<Activity> activityList;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.builder(
      // scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int movieIndex) {
        return movieIndex >= activityList.length
            ? const BottomLoader()
            : Text(
                '${activityList[movieIndex].city}',
                style: theme.textTheme.headline4,
              );
      },
      itemCount: activityList.length + 1,
      // controller: _scrollController,
    );
  }
}
