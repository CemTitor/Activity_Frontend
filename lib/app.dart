import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_frontend/domain/activity_repository/src/activity_repository.dart';
import 'package:weather_frontend/domain/weather_repository/src/weather_repository.dart';
import 'package:weather_frontend/feature/activity/view/activity_page.dart';
import 'package:weather_frontend/feature/activity/activity.dart';
import 'package:google_fonts/google_fonts.dart';

///Our app.dart widget will handle building the WeatherPage view we previously created and use BlocProvider to inject our ThemeCubit which handles theme data.
class WeatherApp extends StatelessWidget {
  final WeatherRepository _weatherRepository;
  final ActivityRepository _activityRepository;

  const WeatherApp(
      {super.key,
      required WeatherRepository weatherRepository,
      required ActivityRepository activityRepository})
      : _weatherRepository = weatherRepository,
        _activityRepository = activityRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _weatherRepository,
        ),
        RepositoryProvider.value(
          value: _activityRepository,
        ),
      ],
      child: WeatherAppView(),
    );
  }
}

class WeatherAppView extends StatelessWidget {
  const WeatherAppView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.rajdhaniTextTheme(),
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.rajdhaniTextTheme(textTheme)
              .apply(bodyColor: Colors.white)
              .headline6,
        ),
      ),
      // home: const WeatherPage(),
      home: const ActivityPage(),
    );
  }
}
