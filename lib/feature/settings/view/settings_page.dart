import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_frontend/feature/weather/weather.dart';

///The settings page allows users to update their preferences for the temperature units.
class SettingsPage extends StatelessWidget {
  const SettingsPage._();

  static Route<void> route(WeatherCubit weatherCubit) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider.value(
        value: weatherCubit,
        child: const SettingsPage._(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: <Widget>[
          // BlocBuilder<WeatherCubit, WeatherState>(
          //   buildWhen: (previous, current) =>
          //       previous.degreeUnits != current.degreeUnits,
          //   builder: (context, state) {
          //     return ListTile(
          //       title: const Text('Temperature Units'),
          //       isThreeLine: true,
          //       subtitle: const Text(
          //         'Use metric measurements for temperature units.',
          //       ),
          //       trailing: Switch(
          //         value: state.degreeUnits.isCelsius,
          //         onChanged: (_) => context.read<WeatherCubit>().toggleUnits(),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}