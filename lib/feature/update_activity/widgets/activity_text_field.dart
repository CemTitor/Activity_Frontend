import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_frontend/feature/update_activity/bloc/update_activity_bloc.dart';

class ActivityTextField extends StatelessWidget {
  const ActivityTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _TitleField(),
        _DescriptionField(),
        _CategoryField(),
        _CityField(),
        _VenueField(),
      ],
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
