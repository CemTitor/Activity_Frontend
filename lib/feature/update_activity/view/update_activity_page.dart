import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_frontend/data/activity_api/src/models/activity.dart';
import 'package:weather_frontend/feature/update_activity/update_activity.dart';
import 'package:weather_frontend/domain/activity_repository/src/activity_repository.dart';

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
            child: Column(
              children: const [
                _TitleField(),
                _DescriptionField(),
                _CategoryField(),
                _CityField(),
                _VenueField()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<UpdateActivityBloc>().state;
    final hintText = state.initialActivity?.title ?? '';

    return TextFormField(
      key: const Key('editActivityView_title_textFormField'),
      initialValue: state.title,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Title',
        hintText: hintText,
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context
            .read<UpdateActivityBloc>()
            .add(UpdateActivityTitleChanged(value));
      },
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<UpdateActivityBloc>().state;
    final hintText = state.initialActivity?.description ?? '';

    return TextFormField(
      key: const Key('editActivityView_description_textFormField'),
      initialValue: state.description,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Description',
        hintText: hintText,
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(300),
      ],
      onChanged: (value) {
        context
            .read<UpdateActivityBloc>()
            .add(UpdateActivityDescriptionChanged(value));
      },
    );
  }
}

class _CategoryField extends StatelessWidget {
  const _CategoryField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<UpdateActivityBloc>().state;
    final hintText = state.initialActivity?.category ?? '';

    return TextFormField(
      key: const Key('editActivityView_category_textFormField'),
      initialValue: state.category,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Category',
        hintText: hintText,
      ),
      onChanged: (value) {
        context
            .read<UpdateActivityBloc>()
            .add(UpdateActivityCategoryChanged(value));
      },
    );
  }
}

class _CityField extends StatelessWidget {
  const _CityField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<UpdateActivityBloc>().state;
    final hintText = state.initialActivity?.city ?? '';

    return TextFormField(
      key: const Key('editActivityView_city_textFormField'),
      initialValue: state.city,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'City',
        hintText: hintText,
      ),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context
            .read<UpdateActivityBloc>()
            .add(UpdateActivityCityChanged(value));
      },
    );
  }
}

class _VenueField extends StatelessWidget {
  const _VenueField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<UpdateActivityBloc>().state;
    final hintText = state.initialActivity?.venue ?? '';

    return TextFormField(
      key: const Key('editActivityView_venue_textFormField'),
      initialValue: state.venue,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Venue',
        hintText: hintText,
      ),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context
            .read<UpdateActivityBloc>()
            .add(UpdateActivityVenueChanged(value));
      },
    );
  }
}
