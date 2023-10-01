import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/details/weather_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => WeatherBloc(),
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
      // routes: {
      //   weatherDetailsRoute: (context) => const WeatherDetailPage(),
      // },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController cityNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Enter City Name:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: cityNameController,
              decoration: const InputDecoration(
                hintText: 'E.g., New York',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter Country Name :',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: countryController,
              decoration: const InputDecoration(
                hintText: 'E.g., USA',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Get the entered city and country
                String cityName = cityNameController.text;
                String countryName = countryController.text;

                if (cityName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Center(child: Text('Enter City')),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                } else if (countryName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Center(child: Text('Enter Country')),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                } else {
                  // Navigate to the weather detail screen and pass both values as route parameters
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context2) => WeatherDetailPage(
                        city: cityName,
                        country: countryName,
                        context: context,
                      ),
                    ),
                  );
                }
              },
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
