import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Screen/searchScreen.dart';
import '../model/key.dart';
import 'package:google_maps_webservice/places.dart' as webservice;

class GoogleMapService extends StatefulWidget {
  GoogleMapService({Key? key}) : super(key: key);

  @override
  State<GoogleMapService> createState() => _GoogleMapServiceState();
}

class _GoogleMapServiceState extends State<GoogleMapService> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool drawerOpen = true;

  String googleApikey = keymap;
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = const LatLng(14.803739, -17.283244);
  LatLng? endLocation;
  String location = "Search Locatin";
  PolylinePoints polylinePoints = PolylinePoints();
  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  @override
  void initState() {
    markers.add(Marker(
      //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    //fetch direction polylines from Google API

    super.initState();
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApikey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation!.latitude, endLocation!.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              //Drawer header
              Container(
                height: 165.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/user_icon.png",
                        height: 65.0,
                        width: 65.0,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "nom d'utilisateur",
                            style: TextStyle(
                                fontSize: 16.0, fontFamily: "Oumar Fall"),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text("Visiter le profil"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Divider(),

              SizedBox(
                height: 12.0,
              ),

              //Drawer Body Contrller
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Icon(Icons.history),
                  title: Text("Historique"),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    "Visiter le profil",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text(
                    "Apropos",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    "Se déconnecter",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(children: [
        GoogleMap(
          //Map widget from google_maps_flutter package
          zoomGesturesEnabled: true, //enable Zoom in, out on map
          initialCameraPosition: CameraPosition(
            //innital position in map
            target: startLocation, //initial position
            zoom: 16.0, //initial zoom level
          ),
          //polylines
          markers: markers, //markers to show on map
          polylines: Set<Polyline>.of(polylines.values),
          mapType: MapType.normal, //map type
          onMapCreated: (controller) {
            //method called when map is created
            setState(() {
              mapController = controller;
            });
          },
        ),
        // POSITIONED

        Positioned(
          top: 36.0,
          left: 22.0,
          child: GestureDetector(
              onTap: () {
                if (drawerOpen) {
                  scaffoldKey.currentState?.openDrawer();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      ),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon((drawerOpen) ? Icons.menu : Icons.close,
                      color: Colors.yellow[700]),
                ),
              )),
        ),

        // position ui

        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: AnimatedSize(
            //vsync: this,
            curve: Curves.bounceIn,
            duration: new Duration(milliseconds: 160),
            child: Container(
              height: 280,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6.0),
                    Text(
                      "Bonjour,",
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Text(
                      "Où aller ?",
                      style:
                          TextStyle(fontSize: 20.0, fontFamily: "Brand Bold"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => SearchScreen()));
                        // webservice.Prediction? p =
                        //     await PlacesAutocomplete.show(
                        //   context: context,
                        //   apiKey: keymap,
                        //   // onError: onError,
                        //   mode: Mode.overlay,
                        //   language: "fr",
                        //   // decoration: InputDecoration(
                        //   //   hintText: 'Search',
                        //   //   focusedBorder: OutlineInputBorder(
                        //   //     borderRadius: BorderRadius.circular(20),
                        //   //     borderSide: BorderSide(
                        //   //       color: Colors.white,
                        //   //     ),
                        //   //   ),
                        //   // ),
                        //   components: [
                        //     webservice.Component(
                        //         webservice.Component.country, "sn")
                        //   ],
                        // );

                        // print(p);
                        var place = await PlacesAutocomplete.show(
                            context: context,
                            apiKey: googleApikey,
                            mode: Mode.overlay,
                            types: ["geocode"],
                            strictbounds: false,
                            components: [
                              webservice.Component(
                                  webservice.Component.country, 'sn')
                            ],
                            //google_map_webservice package
                            onError: (err) {
                              print(err);
                            });
                        if (place != null) {
                          setState(() {
                            location = place.description.toString();
                          });
                          final plist = webservice.GoogleMapsPlaces(
                            apiKey: keymap,
                            apiHeaders: await GoogleApiHeaders().getHeaders(),
                            //from google_api_headers package
                          );

                          String placeid = place.placeId ?? "0";
                          final detail =
                              await plist.getDetailsByPlaceId(placeid);
                          final geometry = detail.result.geometry!;
                          final lat = geometry.location.lat;
                          final lang = geometry.location.lng;
                          setState(() {
                            endLocation = LatLng(lat, lang);

                            markers.add(Marker(
                              //add distination location marker
                              markerId: MarkerId(endLocation.toString()),
                              position: endLocation!, //position of marker
                              infoWindow: InfoWindow(
                                //popup info
                                title: 'Destination Point ',
                                snippet: 'Destination Marker',
                              ),
                              icon: BitmapDescriptor
                                  .defaultMarker, //Icon for Marker
                            ));

                            getDirections();
                          });

                          //move map camera to selected place with animation
                          // mapController?.animateCamera(
                          //     CameraUpdate.newCameraPosition(CameraPosition(
                          //         target: newlatlang, zoom: 17)));

                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 15.0,
                                spreadRadius: 0.3,
                                offset: Offset(0.5, 0.5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(Icons.search, color: Colors.yellow[700]),
                                const SizedBox(width: 10.0),
                                const Text("Recherche"),
                              ],
                            ),
                          )),
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      children: [
                        Icon(Icons.home, color: Colors.yellow[700]),
                        const SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Maison"),
                            SizedBox(height: 4.0),
                            Text(
                              "L'adresse de votre domicile",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Icon(Icons.work, color: Colors.yellow[700]),
                        const SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Travail"),
                            SizedBox(height: 4.0),
                            Text(
                              "Adresse de votre bureau",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
