import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
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
  static const kGoogleApiKey = "AIzaSyDYGiwEMi6u7dvyWQKMZ4j7kyqJVq7h4zs";
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

  Future navigateToTransportDetail(context, originPoint, destinationPoint, originAddress, destinationAddress) async {
    Navigator.pushNamed(context, TransportDetail.PATH,
        arguments: {"originPoint": originPoint, "destinationPoint": destinationPoint, "originAddress": originAddress, "destinationAddress": destinationAddress });
  }


  @override
  Widget build(BuildContext context) {
    CameraPosition origin = ModalRoute.of(context).settings.arguments;
    LatLng originPoint = LatLng(origin.target.latitude, origin.target.longitude);
    String originAddress;
    LatLng destinationPoint;
    String destinationAddress;
    Future<String> getAddressFromCoordinates() async {
      List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(originPoint.latitude, originPoint.longitude);
      return placemark[0].thoroughfare + " " + placemark[0].name;
    }

    Future<LatLng> getLatLngFromAddress(String address) async {
      List<Placemark> placemark = await Geolocator().placemarkFromAddress(address);
      return LatLng(placemark[0].position.latitude, placemark[0].position.longitude);
    }

    return Scaffold(
        appBar: AppBar(title: Text('Transporte')),
        backgroundColor: $Colors.BACKGROUD,
        body: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
                child: Stack(
                  children: <Widget>[

                    PlacePicker(
                      apiKey: kGoogleApiKey,   // Put YOUR OWN KEY here.
                      onPlacePicked: (result) async {
                        originAddress = await getAddressFromCoordinates();
                        destinationAddress = result.formattedAddress;
                        destinationPoint = await getLatLngFromAddress(destinationAddress);
                        print(originAddress);
                        print(destinationAddress);
                        navigateToTransportDetail(context, originPoint, destinationPoint, originAddress, destinationAddress);
                        //Navigator.of(context).pop();
                      },
                      /*selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
                        return isSearchBarFocused
                            ? Container()
                        // Use FloatingCard or just create your own Widget.
                            : FloatingCard(
                          bottomPosition: MediaQuery.of(context).size.height * 0.05,
                          leftPosition: MediaQuery.of(context).size.width * 0.05,
                          width: MediaQuery.of(context).size.width * 0.9,
                          borderRadius: BorderRadius.circular(12.0),
                          child: state == SearchingState.Searching ?
                          Center(child: CircularProgressIndicator()) :
                          RaisedButton(onPressed: () { print("do something with [selectedPlace] data"); },),
                        );
                      },*/
                      initialPosition: LatLng(origin.target.latitude, origin.target.longitude),
                      useCurrentLocation: true,
                    ),
                  ],
                )),
            SizedBox(height: 20)
          ],
        )
    );
  }
}