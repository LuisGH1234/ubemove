import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ubermove/common/constants/colors.dart';
import 'package:ubermove/domain/models/company.dart';
import 'package:ubermove/presentation/blocs/user/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubermove/presentation/blocs/user/state.dart';
import 'package:ubermove/presentation/pages/home/paymentMethod.dart';
import 'package:ubermove/presentation/widgets/button.dart';

class TransportDetail extends StatefulWidget {
  static const PATH = "/transportDetail";

  @override
  State<StatefulWidget> createState() => _TransportDetailState();
}

class _TransportDetailState extends State<TransportDetail> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCompanyString;
  Company _currentCompany;
  int totalPrice = 0;
  PolylinePoints polylinePoints;
  String googleMapsApiKey = "AIzaSyDYGiwEMi6u7dvyWQKMZ4j7kyqJVq7h4zs";

  List<LatLng> polylineCoordinates = [];

  Map<PolylineId, Polyline> polylines = {};

  _createPolylines(Position start, Position destination) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapsApiKey, // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.transit,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
  }

  @override
  void initState() {
    context.bloc<UserBloc>().getMyCompanies();
    //_dropDownMenuItems = getDropDownMenuItems();
    //_currentCompany = _dropDownMenuItems[0].value;
    super.initState();
  }

  void showSnackbarError(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: $Colors.ACCENT_RED,
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void changedDropDownItem(String selectedCompany) {
    setState(() {
      _currentCompanyString = selectedCompany;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> arguments =
        ModalRoute.of(context).settings.arguments;
    print(arguments);
    DateTime date = arguments["date"];
    int weight = arguments["weight"];
    LatLng originLatLng = arguments["originPoint"];
    LatLng destinationLatLng = arguments["destinationPoint"];
    String originAddress = arguments["originAddress"];
    String destinationAddress = arguments["destinationAddress"];

    final Position start = Position(
        latitude: originLatLng.latitude, longitude: originLatLng.longitude);

    final Position destination = Position(
        latitude: destinationLatLng.latitude,
        longitude: destinationLatLng.longitude);

    final Set<Marker> _markers = Set();
    _createPolylines(start, destination);

    // Define two position variables

    Position _northeastCoordinates;
    Position _southwestCoordinates;


    if (start.latitude <= destination.latitude) {
      _southwestCoordinates = start;
      _northeastCoordinates = destination;
    } else {
      _southwestCoordinates = destination;
      _northeastCoordinates = start;
    }


    void setMarkers() {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId('origin'),
            position: LatLng(originLatLng.latitude, originLatLng.longitude),
          ),
        );
        _markers.add(Marker(
          markerId: MarkerId('destination'),
          position:
              LatLng(destinationLatLng.latitude, destinationLatLng.longitude),
        ));
      });
    }


    CameraPosition _initialLocation = CameraPosition(target: originLatLng, zoom: 12);

    setMarkers();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Transporte')),
      backgroundColor: $Colors.BACKGROUD,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (state.companyListEvent.loading == true) return;
              if (state.companyListEvent.error == true)
                showSnackbarError(state.companyListEvent.message);
            },
            builder: (context, state) {
              return Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Costo total',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      'S/. $totalPrice',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      'Tiempo estimado',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      '45 - 50 minutos',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: DropdownButton(
                        hint: Text(
                          'Escoja la compañia',
                          style: TextStyle(color: Colors.black),
                        ),
                        value: _currentCompany,
                        items: state.companyListEvent.data
                            .map((e) => DropdownMenuItem<Company>(
                                  child: Text(e.businessName +
                                      "     " +
                                      e.fare.toString()),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: state.companyListEvent.error ||
                                state.companyListEvent.loading
                            ? null
                            : (Company selectedCompany) => setState(() {

                          _currentCompany = selectedCompany;
                          totalPrice = (selectedCompany.fare * weight * 0.55).round() ;
                          print(_currentCompany.businessName);
                        }),
                      )),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: _initialLocation,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          markers: _markers,
                          polylines: Set<Polyline>.of(polylines.values),
                        ),
                        Positioned(
                          bottom: 0,
                          width: MediaQuery.of(context).size.width - 25,
                          child: Center(
                            child: Container(
                              width: 200,
                              padding: EdgeInsets.only(
                                  left: 30, bottom: 20), //.only(bottom: 20),
                              child: Button(
                                "CONTINUAR",
                                onPressed: () {
                                  if (_currentCompany == null) {
                                    showSnackbarError(
                                        "Es obligatorio seleccionar una compañia");
                                    return;
                                  }
                                  print(arguments["originAddress"]);
                                  print(arguments["destinationAddress"]);
                                  print(arguments["originPoint"]);
                                  print(totalPrice);
                                  Navigator.of(context).pushNamed(
                                      PaymentTMethodList.PATH,
                                      arguments: {
                                        "date": date,
                                        "weight": weight,
                                        "originAddress": originAddress,
                                        "destinationAddress":
                                            destinationAddress,
                                        "originPoint": originLatLng,
                                        "destinationPoint": destinationLatLng,
                                        "company": _currentCompany,
                                        "totalPrice": totalPrice,
                                      });
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
