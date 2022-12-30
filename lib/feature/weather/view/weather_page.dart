import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_frontend/domain/weather_repository/weather_repository.dart';
import 'package:weather_frontend/feature/search/search.dart';
import 'package:weather_frontend/feature/weather/weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  static Route<String> route() {
    return MaterialPageRoute(builder: (_) => const WeatherPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherCubit(
        context.read<WeatherRepository>(),
      ),
      child: const WeatherView(),
    );
  }
}

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather API'),
        actions: [],
      ),
      body: Center(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            switch (state.status) {
              case WeatherStatus.initial:
                return const WeatherEmpty();
              case WeatherStatus.loading:
                return const WeatherLoading();
              case WeatherStatus.success:
                // return WeatherPopulated(
                //   weather: state.weather,
                // );
                return WeatherListPopulated(
                  weatherList: state.weatherList,
                );
              case WeatherStatus.failure:
                return const WeatherError();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search, semanticLabel: 'Search'),
        onPressed: () async {
          final city = await Navigator.of(context).push(SearchPage.route());
          if (!mounted) return;
          await context.read<WeatherCubit>().fetchWeatherList(city!);
        },
      ),
    );
  }
}
