import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_frontend/app.dart';
import 'package:weather_frontend/domain/activity_repository/src/activity_repository.dart';
import 'package:weather_frontend/domain/weather_repository/src/weather_repository.dart';
import 'package:weather_frontend/weather_frontend_observer.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = WeatherBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  runApp(WeatherApp(
      weatherRepository: WeatherRepository(),
      activityRepository: ActivityRepository()));
}
