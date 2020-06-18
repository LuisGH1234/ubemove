import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ubermove/common/constants/colors.dart';
import 'package:ubermove/presentation/pages/home/transportDetail.dart';
import 'package:ubermove/presentation/widgets/button.dart';
import 'package:ubermove/presentation/widgets/date_picker.dart';
import 'package:ubermove/presentation/widgets/input.dart';

class SpecifyDestination extends StatefulWidget {
  static const PATH = "/specifyDestination";
  @override
  State<StatefulWidget> createState() => _SpecifyDestinationState();
}

class _SpecifyDestinationState extends State<SpecifyDestination> {
  Completer<GoogleMapController> _controller = Completer();

  Future navigateToTransportDetail(context) async {
    Navigator.pushNamed(context, TransportDetail.PATH);
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

    return Scaffold(
        appBar: AppBar(title: Text('Transporte')),
        backgroundColor: $Colors.BACKGROUD,
        body: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 15, top: 15),
              child: Input(
                keyboardType: TextInputType.text,
                hintText: "Dirección de origen",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Input(
                keyboardType: TextInputType.text,
                hintText: "¿A dónde vas?",
              ),
            ),
            Expanded(
                child: Stack(
              children: <Widget>[
                FutureBuilder<List<CameraPosition>>(
            future: getCameraView("Rio de Janeiro 39100"),
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
                              position: snapshot.data[0].target),
                          Marker(
                              markerId: MarkerId("sssad"),
                              position: snapshot.data[1].target)
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
