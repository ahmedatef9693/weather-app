import 'weather.dart';
// we have two cases if we are at the begining of our app we will use the beginning is true
//else that means that our app coming from the middle

class UiUpdate{
  var weatherData;
  bool? beginningOrnot;
  int? uiTemperature;
  String? uiWeatherIcon;
  String? uiCityName;
  String? uiWeatherMessage;
  WeatherModel weatherModel;
  UiUpdate({this.weatherData,this.beginningOrnot,required this.weatherModel});
  uiUpdateGenerator()
  {
    if (weatherData == null) {
      uiTemperature = 0;
      uiWeatherIcon = 'Error';
      uiCityName = '';
      uiWeatherMessage = 'Unable To Get Weather Data';
      return;
    }
      double temp = weatherData['main']['temp'];
      uiTemperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      uiCityName = weatherData['name'];
      uiWeatherIcon = weatherModel.getWeatherIcon(condition);
      uiWeatherMessage = weatherModel.getMessage(uiTemperature!);


    }
  }

