import 'package:activity_frontend/data/weather_api/collectapi_weather.dart';
import 'package:flutter/material.dart';

class WeatherListPopulated extends StatelessWidget {
  const WeatherListPopulated({
    super.key,
    required this.weatherList,
  });

  final List<Weather> weatherList;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.builder(
      itemBuilder: (BuildContext context, int weatherIndex) {
        return Column(
          children: [
            ListTile(
              title: Text(
                weatherList[weatherIndex].day,
                style: theme.textTheme.headline4,
              ),
              subtitle: Text(
                '${weatherList[weatherIndex].degree}°C ',
                style: theme.textTheme.headline2,
              ),
              leading: Image.network(
                weatherList[weatherIndex].icon,
                width: 50,
                height: 50,
              ),
              trailing: Text(
                '${weatherList[weatherIndex].date}',
                style: theme.textTheme.headline5,
              ),
            ),
            const Divider(
              height: 4,
              thickness: 4,
            ),
          ],
        );
      },
      itemCount: weatherList.length,
      // controller: _scrollController,
    );
  }
}
