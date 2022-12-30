import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:activity_frontend/data/activity_api/src/models/activity.dart';
import 'package:activity_frontend/domain/activity_repository/activity_repository.dart';
import 'package:activity_frontend/feature/update_activity/update_activity.dart';
import 'package:activity_frontend/feature/update_activity/widgets/activity_text_field.dart';

class UpdateActivityPage extends StatelessWidget {
  const UpdateActivityPage({super.key});

  ///Unlike the other features, the UpdateActivitysPage is a separate route which is why it exposes a static route method. This makes it EASY to push the UpdateActivitysPage onto the navigation stack via Navigator.of(context).push(...).
  static Route<void> route({Activity? initialActivity}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => UpdateActivityBloc(
          activityRepository: context.read<ActivityRepository>(),
          initialActivity: initialActivity,
        ),
        child: const UpdateActivityPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateActivityBloc, UpdateActivityState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == UpdateActivityStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const UpdateActivityView(),
    );
  }
}

class UpdateActivityView extends StatelessWidget {
  const UpdateActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    final status =
        context.select((UpdateActivityBloc bloc) => bloc.state.status);
    final isNewActivity = context.select(
      (UpdateActivityBloc bloc) => bloc.state.isNewActivity,
    );
    final theme = Theme.of(context);
    final floatingActionButtonTheme = theme.floatingActionButtonTheme;
    final fabBackgroundColor = floatingActionButtonTheme.backgroundColor ??
        theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewActivity ? 'Add Activity' : 'Update Activity',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Save changes',
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        backgroundColor: status.isLoadingOrSuccess
            ? fabBackgroundColor.withOpacity(0.5)
            : fabBackgroundColor,
        onPressed: status.isLoadingOrSuccess
            ? null
            : () => context
                .read<UpdateActivityBloc>()
                .add(const UpdateActivitySubmitted()),
        child: status.isLoadingOrSuccess
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.check_rounded),
      ),
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ActivityTextField(),
          ),
        ),
      ),
    );
  }
}
