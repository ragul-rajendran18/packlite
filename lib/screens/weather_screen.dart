import 'package:flutter/material.dart';
import '../services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  TextEditingController cityController = TextEditingController();

  Map<String, dynamic>? weather;
  bool isLoading = false;

  String getWeatherEmoji(String condition) {

    condition = condition.toLowerCase();

    if (condition.contains("clear")) return "☀️";
    if (condition.contains("cloud")) return "☁️";
    if (condition.contains("rain")) return "🌧️";
    if (condition.contains("storm")) return "⛈️";
    if (condition.contains("snow")) return "❄️";

    return "🌤️";
  }

  /// Temperature based packing suggestion
  List<String> getPackingSuggestion(double temp) {

    if (temp < 15) {
      return [
        "🧥 Sweater",
        "🧣 Scarf",
        "🧤 Gloves"
      ];
    }

    if (temp >= 15 && temp <= 25) {
      return [
        "👕 Light Clothes",
        "👟 Comfortable Shoes"
      ];
    }

    if (temp > 25) {
      return [
        "🕶 Sunglasses",
        "🧴 Sunscreen",
        "🧢 Cap"
      ];
    }

    return ["🎒 Travel Essentials"];
  }

  void fetchWeather() async {

    if (cityController.text.isEmpty) return;

    setState(() {
      isLoading = true;
      weather = null;
    });

    try {

      final data =
          await WeatherService.getWeather(cityController.text);

      setState(() {
        weather = data;
      });

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Weather not found")),
      );

    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Weather Check"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            /// City input
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: "Enter Destination",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
            ),

            const SizedBox(height: 12),

            /// Button
            ElevatedButton.icon(
              onPressed: fetchWeather,
              icon: const Icon(Icons.cloud),
              label: const Text("Check Weather"),
            ),

            const SizedBox(height: 20),

            /// Loading
            if (isLoading)
              const Column(
                children: [

                  CircularProgressIndicator(),

                  SizedBox(height: 10),

                  Text("Checking weather... ⛅"),

                ],
              ),

            /// Weather result
            if (weather != null && !isLoading)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(

                    children: [

                      const SizedBox(height: 10),

                      Text(
                        getWeatherEmoji(
                          weather!["weather"][0]["description"],
                        ),
                        style: const TextStyle(fontSize: 70),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        weather!["name"],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      /// Temperature
                      Text(
                        "${weather!["main"]["temp"]} °C",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        weather!["weather"][0]["description"],
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Suggested Travel Items 🎒",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      ...getPackingSuggestion(
                        (weather!["main"]["temp"] as num).toDouble(),
                      ).map(
                        (item) => Card(
                          child: ListTile(
                            leading: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            title: Text(item),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              )

          ],
        ),
      ),
    );
  }
}