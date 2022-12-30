import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_frontend/app.dart';
import 'package:weather_frontend/domain/activity_repository/activity_repository.dart';
import 'package:weather_frontend/activity_frontend_observer.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_frontend/domain/weather_repository/weather_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = ActivityBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  runApp(ActivityApp(
    weatherRepository: WeatherRepository(),
    activityRepository: ActivityRepository(),
  ));
}
