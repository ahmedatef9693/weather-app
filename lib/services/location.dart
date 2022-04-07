import 'package:location/location.dart';




class LocationAccess{
  Location? _location = Location();
  LocationData? _locationData;
  PermissionStatus? _permissionGranted;
  bool? _serviceEnabled;
  double? longitude;
  double? latitude;


  Future<void> getCurrentLocation() async {
    try{
      //checking location service part
       _serviceEnabled = await _location!.serviceEnabled();
       if(!_serviceEnabled!){
         _serviceEnabled = await _location!.requestService();
         if(!_serviceEnabled!)
           return;
       }
       //permission for our app part
       _permissionGranted = await _location!.hasPermission();
       if(_permissionGranted == PermissionStatus.denied)
         {
           _permissionGranted = await _location!.requestPermission();
           if(_permissionGranted != PermissionStatus.granted)
             return;
         }
       _locationData = await _location!.getLocation();
       this.longitude = _locationData!.longitude;
       this.latitude = _locationData!.latitude;
       print('longitude = '+longitude.toString());
       print('latitude = '+latitude.toString());
       _location!.onLocationChanged.listen((LocationData currentLocation){

       });

    }catch(exception){
      print('Exception Name : '+exception.toString());
    }


  }



}