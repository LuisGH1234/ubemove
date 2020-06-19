import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ubermove/common/constants/colors.dart';
import 'package:ubermove/presentation/pages/home/transportDetail.dart';
import 'package:ubermove/presentation/widgets/button.dart';
import 'package:ubermove/presentation/widgets/date_picker.dart';
import 'package:ubermove/presentation/widgets/input.dart';
import 'package:geocoder/geocoder.dart';

class SpecifyDestination extends StatefulWidget {
  static const PATH = "/specifyDestination";
  @override
  State<StatefulWidget> createState() => _SpecifyDestinationState();
}

class _SpecifyDestinationState extends State<SpecifyDestination> {
  Completer<GoogleMapController> _controller = Completer();
  static const kGoogleApiKey = "AIzaSyC7UgtaZmkYji_zhlKK_7EsI5v-EluJWzc";
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

  Future navigateToTransportDetail(context) async {
    Navigator.pushNamed(context, TransportDetail.PATH);
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);

      print(lat);
      print(lng);
    }
  }

  Future<Position> displayPredictionAndGetPlace(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);

      return Position(latitude: lat, longitude: lng);
      print(lat);
      print(lng);
    }
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition origin = ModalRoute.of(context).settings.arguments;

    Future<List<CameraPosition>> getCameraView (String address) async {
      List<Placemark> placemark = await Geolocator().placemarkFromAddress(address);
      CameraPosition destinationPosition = CameraPosition(
        target: LatLng(placemark[0].position.latitude, placemark[0].position.longitude),
      );

      return [origin, destinationPosition];
    }

    Future<Prediction> getPrediction() async {
      Prediction p = await PlacesAutocomplete.show(
          context: context, apiKey: kGoogleApiKey);
      return p;
    }

    Future<Position> getPosition() async {
      Prediction p = await getPrediction();
      if (p != null) {
        PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p.placeId);

        var placeId = p.placeId;
        double lat = detail.result.geometry.location.lat;
        double lng = detail.result.geometry.location.lng;

        var address = await Geocoder.local.findAddressesFromQuery(p.description);
        return Position(latitude: lat,longitude: lng);
      }
    }

    Future<List<CameraPosition>> getMiddleCameraView (String address) async {
      List<Placemark> placemark = await Geolocator().placemarkFromAddress(address);
      CameraPosition destinationPosition = CameraPosition(
        target: LatLng(placemark[0].position.latitude, placemark[0].position.longitude),
      );
      CameraPosition middleCameraPosition = CameraPosition(
          target: LatLng((origin.target.latitude + destinationPosition.target.latitude)/2, (origin.target.longitude+destinationPosition.target.longitude)/2),
          zoom: 4
      );
      return [middleCameraPosition, origin, destinationPosition];
    }

    Future<String> getAddress() async {
      List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(origin.target.latitude, origin.target.longitude);
      print(placemark[0].name.toString());
      return placemark[0].thoroughfare + " " + placemark[0].name;
    }

    return Scaffold(
        appBar: AppBar(title: Text('Transporte')),
        backgroundColor: $Colors.BACKGROUD,
        body: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            FutureBuilder<String>(
              future: getAddress(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Input(
                    keyboardType: TextInputType.text,
                    hintText: snapshot.data,
                  );
                }
                return Input(
                  keyboardType: TextInputType.text,
                  hintText: "Dirección de origen",
                );
              }
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, top: 15),
              child: Input(
                keyboardType: TextInputType.text,
                hintText: "¿A dónde vas?",
              ),
            ),

            Container(
                alignment: Alignment.center,
                child: RaisedButton(
                  onPressed: () async {
                    // show input autocomplete with selected mode
                    // then get the Prediction selected

                    displayPrediction(await getPrediction());
                  },
                  child: Text('Find address'),
                )),
            Expanded(
                child: Stack(
                  children: <Widget>[
                    FutureBuilder<List<CameraPosition>>(
                      future: getMiddleCameraView("Rio de Janeiro 391"),
                      builder: (constext, snapshot) {
                        if (snapshot.hasData) {
                          return GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: snapshot.data[0],
                            // myLocationButtonEnabled: false,
                            // zoomControlsEnabled: false,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                            markers: Set<Marker>.of([
                              Marker(
                                  markerId: MarkerId("dasss"),
                                  position: snapshot.data[1].target),
                              Marker(
                                  markerId: MarkerId("sssad"),
                                  position: snapshot.data[2].target)
                            ]),
                            // onMapCreated: _onMapCreated,
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                                "No se puede mostrar el mapa porque faltan permisos"),
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      width: MediaQuery.of(context).size.width,
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
        )
    );
  }
}