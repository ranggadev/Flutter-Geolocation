import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Geolocation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String currentPosition = "";
  String calculateDistance = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
        children: <Widget>[
          RaisedButton(
            child: Text("Current Position"),
            onPressed: (){
              getCurrentPosition();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(currentPosition, softWrap: true,),
          ),

          RaisedButton(
            child: Text("Calculate Distance"),
            onPressed: (){
              getCalculateDistance();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(calculateDistance, softWrap: true,),
          ),
        ],
      ),
    );
  }

  void getCurrentPosition() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentPosition = "lat : " + position.latitude.toString() + "\nlong : " + position.longitude.toString() + "\nalt : " + position.altitude.toString();
    });
  }

  void getCalculateDistance() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    double distanceInMeters = await Geolocator().distanceBetween(position.latitude, position.longitude, -0.026125, 109.315691);

    setState(() {
      calculateDistance = distanceInMeters.toString() + " Meter";
    });
  }
}