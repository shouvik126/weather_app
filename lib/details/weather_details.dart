import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';

import 'package:weather_icons/weather_icons.dart';

class WeatherDetailPage extends StatefulWidget {
  final String city;
  final String country;
  final BuildContext context;
  const WeatherDetailPage({
    super.key,
    required this.city,
    required this.country,
    required this.context,
  });

  @override
  State<WeatherDetailPage> createState() => _WeatherDetailPageState();
}

class _WeatherDetailPageState extends State<WeatherDetailPage> {
  late String city;
  late String country;
  late BuildContext yocontext;
  @override
  void initState() {
    city = widget.city;
    country = widget.country;
    yocontext = widget.context;
    yocontext.read<WeatherBloc>().add(WeatherEventFetch(
          city: city,
          country: country,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Details'),
      ),
      body: Center(
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: BlocProvider.of<WeatherBloc>(yocontext),
            ),
          ],
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherStateFetched) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'City: $city, $country',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Temperature: ${state.weatherData.temperature}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Humidity: ${state.weatherData.humidity}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Weather Condition: ${state.weatherData.weatherCondition}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      // Weather icon (replace with actual weather icons)
                      const BoxedIcon(WeatherIcons.day_sunny),
                    ],
                  ),
                );
              } else if (state is WeatherStateEmptyFetched) {
                return Text(
                  state.message,
                  style: const TextStyle(fontSize: 18),
                );
              } else if (state is WeatherStateError) {
                return Text(
                  state.message,
                  style: const TextStyle(fontSize: 18),
                );
              } else {
                return const CircularProgressIndicator.adaptive();
              }
            },
          ),
        ),
      ),
    );
  }
}
