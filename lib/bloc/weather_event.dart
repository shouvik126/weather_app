part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class WeatherEventFetch extends WeatherEvent {
  final String city;
  final String country;

  WeatherEventFetch({
    required this.city,
    required this.country,
  });
}
