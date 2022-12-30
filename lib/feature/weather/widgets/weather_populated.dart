import 'package:flutter/material.dart';
// import 'package:weather_frontend/weather/weather.dart';
import 'package:weather_frontend/data/weather_api/collectapi_weather.dart';

class WeatherPopulated extends StatelessWidget {
  const WeatherPopulated({
    super.key,
    required this.weather,
  });
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        _WeatherBackground(),
        SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          clipBehavior: Clip.none,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 48),
                Text(
                  weather.day,
                  style: theme.textTheme.headline4,
                ),
                const SizedBox(height: 48),
                Text(
                  '${weather.description}',
                  style: theme.textTheme.headline2,
                ),
                // _WeatherIcon(condition: weather.condition),
                // Text(
                //   weather.formattedTemperature(units),
                //   style: theme.textTheme.headline3?.copyWith(
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // Text(
                //   '''Last Updated at ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}''',
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _WeatherBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.25, 0.75, 0.90, 1.0],
            colors: [
              color,
              color.brighten(),
              color.brighten(33),
              color.brighten(50),
            ],
          ),
        ),
      ),
    );
  }
}

extension on Color {
  Color brighten([int percent = 10]) {
    assert(
      1 <= percent && percent <= 100,
      'percentage must be between 1 and 100',
    );
    final p = percent / 100;
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }
}
