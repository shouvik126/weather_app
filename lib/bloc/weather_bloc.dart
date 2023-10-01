import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_data.dart'; // Import the http package

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) {});

    on<WeatherEventFetch>(weatherEventFetch);
  }

  FutureOr<void> weatherEventFetch(
      WeatherEventFetch event, Emitter<WeatherState> emit) async {
    emit(WeatherStateLoading());
    try {
      // Make an API request using the city and country from the event
      final city = event.city;
      final country = event.country;
      const apiKey =
          'e330c31863ad4ba492fb854313a2d654'; // Replace with your actual API key
      final apiUrl =
          'https://api.weatherbit.io/v2.0/current?city=$city&country=$country&key=$apiKey';

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final weatherData = parseWeatherData(data);

        // Emit a WeatherStateSuccess state with the fetched data
        emit(WeatherStateFetched(weatherData: weatherData));
      } else {
        // Handle API request error
        emit(WeatherStateEmptyFetched(
            message: 'Failed to fetch weather data. Please try again.'));
      }
    } catch (e) {
      // Handle other errors (e.g., network issues)
      emit(WeatherStateError(
          message: 'An error occurred while fetching weather data.'));
    }
  }

  WeatherData parseWeatherData(Map<String, dynamic> data) {
    final weatherInfo = data['data'][0];
    final cityName = weatherInfo['city_name'];
    final temperature = weatherInfo['temp'];
    final humidity = weatherInfo['rh'];
    final weatherCondition = weatherInfo['weather']['description'];
    //final weatherCode = weatherInfo['weather']['code'];
    //final weatherIcon = weatherInfo['weather']['icon'];

    return WeatherData(
      cityName: cityName,
      temperature: temperature.toDouble(),
      humidity: humidity.toDouble(),
      weatherCondition: weatherCondition,
      //weatherCode: weatherCode,
      //weatherIcon: weatherIcon,
    );
  }
}
