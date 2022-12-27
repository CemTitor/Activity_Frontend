import 'package:weather_frontend/data/weather_api/collectapi_weather.dart';
import 'package:flutter/material.dart';

import 'bottom_loader.dart';

class WeatherListPopulated extends StatelessWidget {
  const WeatherListPopulated({
    super.key,
    required this.weatherList,
    // required this.movieName,
  });

  final List<Weather> weatherList;
  // final String movieName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int movieIndex) {
        return movieIndex >= weatherList.length
            ? const BottomLoader()
            : Column(
                children: [
                  Text(
                    weatherList[movieIndex].day,
                    style: theme.textTheme.headline4,
                  ),
                  Text(
                    weatherList[movieIndex].humidity,
                    style: theme.textTheme.headline2,
                  ),
                ],
              );
      },
      itemCount: weatherList.length + 1,
      // controller: _scrollController,
    );
  }
}
