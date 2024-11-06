import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final List<String> municipalitiesAklan = [
    'Altavas', 'Balete', 'Banga', 'Buruanga', 'Ibajay',
    'Kalibo', 'Lezo', 'Libacao', 'Madalag', 'Batan', 'Makato', 'Malay', 'Malinao', 'Nabas',
    'New Washington', 'Numancia', 'Tangalan'
  ];

  String? selectedMunicipality;
  String weatherData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 1,
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Theme.of(context).colorScheme.outline, const Color(0x80FEAE49), const Color(0xFF57BEE6)],
          ).createShader(bounds),
          child: const Text(
            "Weather Update",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: 20,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown to select municipality
            DropdownButton<String>(
              hint: Text('Select Municipality'),
              value: selectedMunicipality,
              onChanged: (String? newValue) {
                setState(() {
                  selectedMunicipality = newValue;
                });
                if (newValue != null) {
                  fetchWeather(newValue);
                }
              },
              items: municipalitiesAklan.map((String municipality) {
                return DropdownMenuItem<String>(
                  value: municipality,
                  child: Text(municipality),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Display weather data with icons and styling
            if (weatherData.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weather Data:',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    weatherData,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }



  // Method to fetch weather data
  Future<void> fetchWeather(String municipality) async {
    final apiUrl = 'https://api.weatherapi.com/v1/forecast.json?key=89e63ee9c6de4d14af551811240611&q=$municipality&days=4';  // Fetch 4-day forecast
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Extract current weather data
        final currentWeather = data['current'];
        final forecastData = data['forecast']['forecastday'];

        setState(() {
          weatherData = '''
            Current Temperature: ${currentWeather['temp_c']}°C
            Condition: ${currentWeather['condition']['text']}
            Wind: ${currentWeather['wind_kph']} km/h
            Humidity: ${currentWeather['humidity']}%

            Forecast:
            1st Day:
              Temp: ${forecastData[0]['day']['avgtemp_c']}°C
              Condition: ${forecastData[0]['day']['condition']['text']}
            2nd Day:
              Temp: ${forecastData[1]['day']['avgtemp_c']}°C
              Condition: ${forecastData[1]['day']['condition']['text']}
            3rd Day:
              Temp: ${forecastData[2]['day']['avgtemp_c']}°C
              Condition: ${forecastData[2]['day']['condition']['text']}
            4th Day:
              Temp: ${forecastData[3]['day']['avgtemp_c']}°C
              Condition: ${forecastData[3]['day']['condition']['text']}
          ''';
        });
      } else {
        setState(() {
          weatherData = 'Failed to load weather data (status code: ${response.statusCode})';
        });
      }
    } catch (e) {
      setState(() {
        weatherData = 'Error fetching weather data';
      });
    }
  }
}
