import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_frontend/data/activity_api/activity_api.dart';
import 'package:weather_frontend/domain/activity_repository/activity_repository.dart';
import 'package:weather_frontend/domain/weather_repository/src/weather_repository.dart';
import 'package:weather_frontend/feature/activity/widgets/activity_list_tile.dart';
import 'package:weather_frontend/feature/search/search.dart';
import 'package:weather_frontend/feature/settings/settings.dart';
import 'package:weather_frontend/feature/activity/activity.dart';
import 'package:weather_frontend/feature/update_activity/view/update_activity_page.dart';
import 'package:weather_frontend/feature/weather/cubit/weather_cubit.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ActivityCubit(context.read<ActivityRepository>()),
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
        title: const Text('Flutter Activity'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push<void>(
                SettingsPage.route(
                  context.read<WeatherCubit>(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.get_app),
            onPressed: () async {
              await context.read<ActivityCubit>().fetchActivityList();
            },
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          ///The first is a BlocListener that listens for errors
          BlocListener<ActivityCubit, ActivityState>(
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
          BlocListener<ActivityCubit, ActivityState>(
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
        child: BlocBuilder<ActivityCubit, ActivityState>(
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
                    style: Theme.of(context).textTheme.caption,
                  ),
                );
              }
            }
            return CupertinoScrollbar(
              child: ListView.builder(
                  itemCount: state.activityList.length,
                  itemBuilder: (context, index) {
                    return ActivityListTile(
                      activity: state.activityList[index],
                      onDismissed: (_) {
                        context.read<ActivityCubit>().removeActivity(
                              state.activityList[index].id!,
                            );
                      },
                      onTap: () {
                        Navigator.of(context).push(
                          UpdateActivityPage.route(
                            initialActivity: state.activityList[index],
                          ),
                        );
                      },
                    );
                  }),
            );
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

  void _onListPressed() async {
    await context.read<ActivityCubit>().fetchActivityList();
  }
}
