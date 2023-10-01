part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherStateFetched extends WeatherState {
  final WeatherData weatherData;

  WeatherStateFetched({required this.weatherData});
}

final class WeatherStateEmptyFetched extends WeatherState {
  final String message;

  WeatherStateEmptyFetched({required this.message});
}

final class WeatherStateError extends WeatherState {
  final String message;

  WeatherStateError({required this.message});
}

final class WeatherStateLoading extends WeatherState {}
