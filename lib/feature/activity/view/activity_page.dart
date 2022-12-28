// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:weather_frontend/domain/activity_repository/activity_repository.dart';
// import 'package:weather_frontend/domain/weather_repository/src/weather_repository.dart';
// import 'package:weather_frontend/feature/search/search.dart';
// import 'package:weather_frontend/feature/settings/settings.dart';
// import 'package:weather_frontend/feature/activity/activity.dart';
// import 'package:weather_frontend/feature/weather/cubit/weather_cubit.dart';
//
// import '../widgets/activity_list_populated.dart';
//
// class ActivityPage extends StatelessWidget {
//   const ActivityPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (_) => WeatherCubit(
//             context.read<WeatherRepository>(),
//           ),
//         ),
//         BlocProvider(
//           create: (_) => ActivityCubit(context.read<ActivityRepository>()),
//         ),
//       ],
//       child: const ActivityView(),
//     );
//   }
// }
//
// class ActivityView extends StatefulWidget {
//   const ActivityView({super.key});
//
//   @override
//   State<ActivityView> createState() => _ActivityViewState();
// }
//
// class _ActivityViewState extends State<ActivityView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter Activity'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.settings),
//             onPressed: () {
//               Navigator.of(context).push<void>(
//                 SettingsPage.route(
//                   context.read<WeatherCubit>(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: BlocConsumer<ActivityCubit, ActivityState>(
//           listener: (context, state) {
//             if (state.status.isSuccess) {
//               // context.read<ThemeCubit>().updateTheme(state.weather);
//             }
//           },
//           builder: (context, state) {
//             switch (state.status) {
//               case ActivityStatus.initial:
//                 return const ActivityEmpty();
//               case ActivityStatus.loading:
//                 return const ActivityLoading();
//               case ActivityStatus.success:
//                 return ActivityListPopulated(
//                   activityList: state.activityList,
//                 );
//               case ActivityStatus.failure:
//                 return const ActivityError();
//             }
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.search, semanticLabel: 'Search'),
//         onPressed: () async {
//           final city = await Navigator.of(context).push(SearchPage.route());
//           if (!mounted) return;
//           await context.read<ActivityCubit>().fetchActivityList();
//         },
//       ),
//     );
//   }
// }