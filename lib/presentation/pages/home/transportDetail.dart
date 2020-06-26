import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
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
                                  //Navigator.popUntil(context, ModalRoute.withName(MainPage.PATH));
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
