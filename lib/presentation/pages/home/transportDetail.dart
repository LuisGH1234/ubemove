import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/src/response.dart';
import 'package:ubermove/common/constants/colors.dart';
import 'package:ubermove/network/core/api_manager.dart';
import 'package:ubermove/presentation/blocs/user/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ubermove/presentation/blocs/user/state.dart';
import 'package:ubermove/presentation/pages/home/paymentMethod.dart';
import 'package:ubermove/presentation/pages/home/specifyDestination.dart';
import 'package:ubermove/presentation/widgets/button.dart';
import 'package:ubermove/presentation/widgets/date_picker.dart';
import 'package:ubermove/presentation/widgets/input.dart';

import '../main_page.dart';

class TransportDetail extends StatefulWidget {
  static const PATH = "/transportDetail";

  @override
  State<StatefulWidget> createState() => _TransportDetailState();
}

class _TransportDetailState extends State<TransportDetail> {
  Completer<GoogleMapController> _controller = Completer();

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCompany;
  PolylinePoints polylinePoints;
  String googleMapsApiKey = "AIzaSyDYGiwEMi6u7dvyWQKMZ4j7kyqJVq7h4zs";

  List<LatLng> polylineCoordinates = [];

  Map<PolylineId, Polyline> polylines = {};

  // final LatLng _center = const LatLng(-12.0749822, -77.0449321);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
/*
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    /*for (String company in _companies) {
      items.add(new DropdownMenuItem(value: company, child: new Text(company)));
    }*/
    return items;
  }
*/
  _createPolylines(Position start, Position destination) async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapsApiKey, // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.transit,
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Defining an ID
    PolylineId id = PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    polylines[id] = polyline;
  }


  @override
  void initState() {
    context.bloc<UserBloc>().getMyCompanies();
    //_dropDownMenuItems = getDropDownMenuItems();
    //_currentCompany = _dropDownMenuItems[0].value;
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    final  Map<String, Object> arguments = ModalRoute.of(context).settings.arguments;
    print(arguments);
    LatLng originLatLng = arguments["originPoint"];
    LatLng destinationLatLng = arguments["originPoint"];
    final Position start = Position(latitude: originLatLng.latitude , longitude : originLatLng.longitude);
    final Position destination = Position(latitude: destinationLatLng.latitude , longitude : destinationLatLng.longitude);
    _createPolylines(start, destination);
    
    void changedDropDownItem(String selectedCompany) {
      setState(() {
        _currentCompany = selectedCompany;
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text('Transporte')),
      backgroundColor: $Colors.BACKGROUD,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {

            },
            builder: (context, state) {
              return Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Costo total',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      'S/. 200.00',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      'Tiempo estimado',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      '45 - 50 minutos',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: DropdownButton(
                        value: _currentCompany,
                        items: state.companyListEvent.data.map((e) =>
                            DropdownMenuItem<String>(
                              child: Text(e.businessName + "     " + e.fare.toString()),
                        )).toList(),
                        onChanged: state.companyListEvent.error || state.companyListEvent.loading ?
                        null:  (selectedCompany) => setState(() {
                          _currentCompany = selectedCompany;
                        }),
                      )),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: _kGooglePlex,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
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
                                  Navigator.of(context)
                                      .pushNamed(PaymentTMethodList.PATH);
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
