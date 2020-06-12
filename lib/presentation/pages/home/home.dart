import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ubermove/presentation/widgets/button.dart';
import 'package:ubermove/presentation/widgets/date_picker.dart';
import 'package:ubermove/presentation/widgets/input.dart';
import 'package:geolocator/geolocator.dart';
import 'transportDetail.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();
  Position _currentPosition;
  String _permissionStatus;
  // final LatLng _center = const LatLng(-12.0749822, -77.0449321);

  Future navigateToTransportDetail(context) async {
    Navigator.pushNamed(context, TransportDetail.PATH);
    //Navigator.push(context, MaterialPageRoute(builder: (context) => TransportDetail()));
  }


  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    getPermission();
    geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) => {
      setState((){
        _currentPosition = position;
      })
    }).catchError((e){
      print (e);
    });
  }


  void getPermission() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator.checkGeolocationPermissionStatus()
        .then((status) => {
      _permissionStatus = status.toString(),
      print(status.toString())
    }).catchError((e){
      print(e);
    });
  }

  CameraPosition setCameraPosition() {
    _getCurrentLocation();

    //if(_permissionStatus == "GeolocationStatus.denied") {
      _kGooglePlex = CameraPosition(
        target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        zoom: 17.4746,
      );
    //}

    return _kGooglePlex;
  }

  Future<GeolocationStatus> checkInternetStatus() async {
    GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();
    return geolocationStatus;
  }

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Text(
            'Transporte',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: RangeDatePicker(
            onSaveEndDate: (date) {},
            onSaveSartDate: (date) {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: RangeDatePicker(
            onSaveEndDate: (date) {},
            onSaveSartDate: (date) {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Input(
            keyboardType: TextInputType.number,
            hintText: "Peso de la carga",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Input(
            keyboardType: TextInputType.number,
            hintText: "¿A dónde vas?",
          ),
        ),
        Expanded(
            child: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: setCameraPosition(),
              // myLocationButtonEnabled: false,
              // zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              // onMapCreated: _onMapCreated,
            ),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width - 40,
              child: Center(
                child: Container(
                  width: 200,
                  padding: EdgeInsets.only(bottom: 20),
                  child: Button(
                    "CONTINUAR",
                    onPressed: () {
                      navigateToTransportDetail(context);
                    },
                  ),
                ),
              ),
            )
          ],
        )),
        SizedBox(height: 20)
      ],
    );
  }
}
