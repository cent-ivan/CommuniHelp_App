import 'dart:convert';
import 'package:communihelp_app/Databases/FirebaseServices/FirestoreServices/get_user_data.dart';
import 'package:communihelp_app/Databases/HiveServices/hive_db_weather.dart';
import 'package:communihelp_app/ViewModel/Connection_Controller/Controller/network_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  Logger logger = Logger(); //diplay debug messages

  //user data
  final userData = GetUserData();

  final List<String> municipalitiesAklan = [
    'Altavas', 'Balete', 'Banga', 'Buruanga', 'Ibajay',
    'Kalibo', 'Lezo', 'Libacao', 'Madalag', 'Batan', 'Makato', 'Malay', 'Malinao', 'Nabas',
    'New Washington', 'Numancia', 'Tangalan'
  ];

  final dbWeather = HiveDbWeather(); 

  String? selectedMunicipality;

  final NetworkController network =  Get.put(NetworkController()); //checksconnction

  @override
  void initState() {
    super.initState();
    selectedMunicipality = userData.municipality;
    fetchWeather(selectedMunicipality!, true);
  }

  @override
  Widget build(BuildContext context) {   
    return Scaffold(
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
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFADADAD),
          image: DecorationImage(
            image: AssetImage('assets/images/background/weather_back.png'),
            fit: BoxFit.cover
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(16).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dropdown to select municipality
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<String>(
                    dropdownColor: Colors.white,
                    iconDisabledColor: Colors.grey,
                    hint: Text('Select Municipality'),
                    value: selectedMunicipality,
                    //disable if offline
                    onChanged: network.isOnline.value ? (String? newValue) {
                      setState(() {
                        selectedMunicipality = newValue;
                      });
                      if (newValue != null) {
                        //check if new value is Nabas to update at local
                        if (newValue.contains(userData.municipality)) {
                          fetchWeather(newValue, true);
                        }
                        else {
                          fetchWeather(newValue, false);
                        }
                        
                      }
                    } : null,
                    items: municipalitiesAklan.map((String municipality) {
                      return DropdownMenuItem<String>(
                        value: municipality,
                        child: Text(municipality, style: TextStyle(color: network.isOnline.value ? Colors.black: Colors.grey ) ,),
                      );
                    }).toList(),
                  ),

                  //Zoom earth button
                  MaterialButton(
                    height: 25.r,
                    minWidth: 55.r,
                    color: Color(0xFF57BEE6),
                    onPressed: () {
                      launchUrl(Uri.parse('https://zoom.earth/maps/satellite/#view=11.24,123.57,5z'));
                    },
                    child: Text(
                      "Open live earth",
                      style: TextStyle(
                        color: Color(0xFF3D424A),
                        fontSize: 12.r
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
          
              // Display weather data with icons and styling
              if (dbWeather.weatherData.isNotEmpty)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 16.r),


                    Center(
                      child: Image(
                        image: weatherSymbol(dbWeather.weatherData["Humidity"]),
                        height: 65.r,
                        width: 65.r,
                      )
                    ),

                    SizedBox(height: 12.r),

                    Center(
                      child: Text(
                        dbWeather.weatherData["CurTemp"],
                        style: TextStyle(
                          color: Color(0xFFEDEDED),
                          fontSize: 42.r,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ),


                    //Location
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, size: 20.r,color: Color(0xFFEDEDED)),

                         SizedBox(width: 4.r),
                    
                        Text(
                          dbWeather.weatherData["Municipality"],
                          style: TextStyle(
                            color: Color(0xFFEDEDED),
                            fontSize: 20.r,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.r),

                    //Humidity
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [ 
                        Text(
                          "Humidity: ${dbWeather.weatherData["Humidity"]}%",
                          style: TextStyle(
                            color: Color(0xFFEDEDED),
                            fontSize: 12.r,
                          ),
                        ),
                    
                        Icon(Icons.water_drop, size: 10.r,color: Color(0xFFEDEDED)),
                      ],
                    ),

                    Center(
                      child: Text(
                        "Windspeed: ${dbWeather.weatherData["Wind"]}",
                        style: TextStyle(
                          color: Color(0xFFEDEDED),
                          fontSize: 12.r,
                        ),
                      )
                    ),

                    SizedBox(height: 8.r),

                    Center(
                      child: Text(
                        dbWeather.weatherData["Condition"],
                        style: TextStyle(
                          color: Color(0xFFEDEDED),
                          fontSize: 12.r,
                        ),
                      )
                    ),

                    SizedBox(height: 28.r),

                    //Weekly forecast
                    Padding(
                      padding: EdgeInsets.all(12).r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "This Week's Forecast",
                            style: TextStyle(
                              fontSize: 16.r,
                              color: Color(0xFFEDEDED)
                            ),
                          ),

                          SizedBox(height: 8.r,),

                          Container(
                            decoration: BoxDecoration(
                              color: Color(0x40EFEFEF),
                              borderRadius: BorderRadius.circular(8).r
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6).r,
                              child: Column(
                                //forecast tiles
                                children: [
                                  //Tomorrow
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        returnWeekday(1),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFEDEDED)
                                        ),
                                      ),

                                      Image(
                                        image: weatherSymbol(dbWeather.weatherData["TomorrowHum"]),
                                        height: 25.r,
                                        width: 25.r,
                                      ),

                                      Row(
                                        children: [
                                          Text(
                                            "${dbWeather.weatherData["TomorrowTemp"]} / ${dbWeather.weatherData["TomorrowHum"].toString()}%",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFEDEDED)
                                            ),
                                          ),

                                          Icon(Icons.water_drop, size: 10.r,color: Color(0xFFEDEDED)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  
                                  Divider(thickness: 0.5,),

                                  //2nd day
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        returnWeekday(2),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFEDEDED)
                                        ),
                                      ),

                                      Image(
                                        image: weatherSymbol(dbWeather.weatherData["SecondDayHum"]),
                                        height: 25.r,
                                        width: 25.r,
                                      ),

                                      Row(
                                        children: [
                                          Text(
                                            "${dbWeather.weatherData["SecondDayTemp"]} / ${dbWeather.weatherData["SecondDayHum"].toString()}%",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFEDEDED)
                                            ),
                                          ),

                                          Icon(Icons.water_drop, size: 10.r,color: Color(0xFFEDEDED)),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Divider(thickness: 0.5,),

                                  //3rd day
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        returnWeekday(3),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFEDEDED)
                                        ),
                                      ),

                                      Image(
                                        image: weatherSymbol(dbWeather.weatherData["ThirdDayHum"]),
                                        height: 25.r,
                                        width: 25.r,
                                      ),

                                      Row(
                                        children: [
                                          Text(
                                            "${dbWeather.weatherData["ThirdDayTemp"]} / ${dbWeather.weatherData["ThirdDayHum"].toString()}%",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFEDEDED)
                                            ),
                                          ),

                                          Icon(Icons.water_drop, size: 10.r,color: Color(0xFFEDEDED)),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Divider(thickness: 0.5,),

                                  //4th day
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        returnWeekday(4),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFEDEDED)
                                        ),
                                      ),

                                      Image(
                                        image: weatherSymbol(dbWeather.weatherData["FourthDayHum"]),
                                        height: 25.r,
                                        width: 25.r,
                                      ),

                                      Row(
                                        children: [
                                          Text(
                                            "${dbWeather.weatherData["FourthDayTemp"]}  /  ${dbWeather.weatherData["FourthDayHum"].toString()}%",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFEDEDED)
                                            ),
                                          ),

                                          Icon(Icons.water_drop, size: 10.r,color: Color(0xFFEDEDED)),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Divider(thickness: 0.5,),

                                  //5th day
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        returnWeekday(5),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFEDEDED)
                                        ),
                                      ),

                                      Image(
                                        image: weatherSymbol(dbWeather.weatherData["FifthDayHum"]),
                                        height: 25.r,
                                        width: 25.r,
                                      ),

                                      Row(
                                        children: [
                                          Text(
                                            "${dbWeather.weatherData["FifthDayTemp"]}  /  ${dbWeather.weatherData["FifthDayHum"].toString()}%",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFEDEDED)
                                            ),
                                          ),

                                          Icon(Icons.water_drop, size: 10.r,color: Color(0xFFEDEDED)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }


  //widget methods----------------------------------------------------------------

  //format weekdays
  String returnWeekday(int day) {
    DateTime today = DateTime.now();
  
    // Add one day to get tomorrow
    DateTime tomorrow = today.add(Duration(days: day));
    
    // Format the date
    DateFormat formatter = DateFormat('E'); // EEEE gives full weekday name
    String formattedDate = formatter.format(tomorrow);
    
    return formattedDate;
  }

  //changes symbol
  AssetImage weatherSymbol(int humidity) {
    AssetImage returnedImage;
    if (humidity <= 69) {
      returnedImage = AssetImage('assets/images/weather/sun.png'); 
    }
    else if (humidity >= 70 && humidity <= 80) {
      returnedImage = AssetImage('assets/images/weather/partly-cloudy.png'); 
    }
    else if (humidity >= 81 && humidity <= 89) {
      returnedImage = AssetImage('assets/images/weather/cloudy.png'); 
    }
    else if (humidity >= 90) {
      returnedImage = AssetImage('assets/images/weather/rainy.png');
    }
    else {
      returnedImage = AssetImage('assets/images/weather/cloudy.png'); 
    }
    return returnedImage;
  }

  final apiKey = dotenv.env['WEATHER_API_KEY'];
  
  // Method to fetch weather data
  Future<void> fetchWeather(String municipality, bool isMuni) async {
    if (network.isOnline.value) {
      //get data from api if online
      final apiUrl = 'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$municipality,Aklan&days=5';  // Fetch 5-day forecast
      try {
        final response = await http.get(Uri.parse(apiUrl));
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);

          // Extract current weather data
          final currentWeather = data['current'];
          final forecastData = data['forecast']['forecastday'];

          setState(() {
            dbWeather.weatherData = {
              "CurTemp" : "${currentWeather['temp_c']}°C",
              "Condition": currentWeather['condition']['text'],
              "Wind" : "${currentWeather['wind_kph']} km/h",
              "Humidity" : currentWeather['humidity'],
              "Municipality": data["location"]["name"],
              "Country" : data["location"]["country"],

              //Forecast
              "TomorrowTemp" : "${forecastData[0]['day']['avgtemp_c']}°C",
              "TomorrowHum" : forecastData[0]['day']['avghumidity'],
              "SecondDayTemp" : "${forecastData[1]['day']['avgtemp_c']}°C",
              "SecondDayHum" : forecastData[1]['day']['avghumidity'],
              "ThirdDayTemp" : "${forecastData[2]['day']['avgtemp_c']}°C",
              "ThirdDayHum" : forecastData[2]['day']['avghumidity'],
              "FourthDayTemp" : "${forecastData[3]['day']['avgtemp_c']}°C",
              "FourthDayHum" : forecastData[3]['day']['avghumidity'],
              "FifthDayTemp" : "${forecastData[4]['day']['avgtemp_c']}°C",
              "FifthDayHum" : forecastData[4]['day']['avghumidity']
            };
  
          });

          if (isMuni) {
            dbWeather.updateData();
          }
          else {
            logger.e("Not municipality");
          }
          
        } else {
            logger.e('Failed to load weather data (status code: ${response.statusCode})');
        }
      } catch (e) {
          logger.e('Error fetching weather data ${e.toString()}');
        }
    }
    else {
      //else get from Hive
      dbWeather.loadData();
    }

    
    
  }
}
