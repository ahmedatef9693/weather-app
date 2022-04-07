import 'package:flutter/material.dart';
import 'package:weather_flutter/utilities/constants.dart';
import 'package:weather_flutter/services/weather.dart';
import 'package:location/location.dart';
import 'city_screen.dart';
import 'package:weather_flutter/services/UserInterfaceUpdater.dart';


class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({this.locationWeather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  int? temperature;
  String? weatherIcon;
  String? weatherMessage;
  String? cityName;
  WeatherModel weatherModel = WeatherModel();


  @override
  void initState() {
    updateUi(widget.locationWeather,true);
    super.initState();
  }

  void updateUi(dynamic weatherData,bool beginning) {

    setState(() {
      UiUpdate ui = UiUpdate(weatherData: weatherData,beginningOrnot: beginning,weatherModel:weatherModel);
      ui.uiUpdateGenerator();
      this.temperature = ui.uiTemperature;
      this.weatherMessage = ui.uiWeatherMessage;
      this.cityName = ui.uiCityName;
      this.weatherIcon = ui.uiWeatherIcon;
      this.weatherModel = ui.weatherModel;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(primary: Colors.white),
                    onPressed: () async {
                        var weatherData = await weatherModel.getLocationWeather();
                        //false means we are in the middle of our program
                        updateUi(weatherData,false);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(primary: Colors.white),
                    onPressed: () async{
                      var typedName = await Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return CityScreen();
                        },
                      ));
                      if(typedName != null){
                        var weatherData = await weatherModel.setCity(typedName);
                        updateUi(weatherData,false);
                        print(this.cityName);

                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon!,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// print('temperature : '+temperature.toString());
// print('condition : '+condition.toString());
// print('city name : '+cityName);
