import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:activity_frontend/domain/activity_repository/activity_repository.dart';
import 'package:activity_frontend/feature/activity/activity.dart';
import 'package:activity_frontend/feature/update_activity/view/update_activity_page.dart';
import 'package:activity_frontend/feature/weather/view/weather_page.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ActivityBloc(
        activityRepository: context.read<ActivityRepository>(),
      )..add(const ActivitySubscriptionRequested()),
      child: const ActivityView(),
    );
  }
}

class ActivityView extends StatefulWidget {
  const ActivityView({super.key});

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity API'),
        actions: [
          CupertinoButton.filled(
            onPressed: () async {
              await context.read<ActivityBloc>()
                ..add(ActivityListFetched());
            },
            child: Row(
              children: [
                Icon(Icons.refresh),
                Text('Refresh Activity List'),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.cloud),
            onPressed: () => Navigator.of(context).push(WeatherPage.route()),
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          ///First BlocListener that listens for errors
          BlocListener<ActivityBloc, ActivityState>(
            ///The listener will only be called when listenWhen returns true
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == ActivityStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(ActivityStatus.failure.toString()),
                    ),
                  );
              }
            },
          ),

          ///Second BlocListener that listens for deletions
          BlocListener<ActivityBloc, ActivityState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedActivity != current.lastDeletedActivity &&
                current.lastDeletedActivity != null,
            listener: (context, state) {
              final deletedActivity = state.lastDeletedActivity!;
              final messenger = ScaffoldMessenger.of(context);
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content:
                        Text('Activity \"${deletedActivity.title}\" deleted.'),
                  ),
                );
            },
          ),
        ],
        child: BlocBuilder<ActivityBloc, ActivityState>(
          builder: (context, state) {
            if (state.activityList.isEmpty) {
              if (state.status == ActivityStatus.loading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status != ActivityStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    'No activity found. 🙈',
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                );
              }
            }
            return ActivityList(state.activityList);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('homeView_addTodo_floatingActionButton'),
        onPressed: () => Navigator.of(context).push(UpdateActivityPage.route()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
