import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:activity_frontend/data/activity_api/src/models/activity.dart';
import 'package:activity_frontend/feature/activity/bloc/activity_bloc.dart';
import 'package:activity_frontend/feature/activity/widgets/activity_list_tile.dart';
import 'package:activity_frontend/feature/update_activity/view/update_activity_page.dart';

class ActivityList extends StatelessWidget {
  const ActivityList(this.activityList);
  final List<Activity> activityList;

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      child: ListView.builder(
          itemCount: activityList.length,
          itemBuilder: (context, index) {
            return ActivityListTile(
              activity: activityList[index],
              onDismissed: (_) {
                context
                    .read<ActivityBloc>()
                    .add(ActivityRemoved(activityList[index]));
                // context.read<ActivityBloc>().add(
                //       ActivityRemoved(activityList[index]),
                //     );
              },
              onTap: () {
                Navigator.of(context).push(
                  UpdateActivityPage.route(
                    initialActivity: activityList[index],
                  ),
                );
              },
            );
          }),
    );
  }
}
