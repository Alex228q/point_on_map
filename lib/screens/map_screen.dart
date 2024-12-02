import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:point_on_map/model/marker_data.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final TextEditingController _messageController = TextEditingController();
  final MapController _mapController = MapController();
  LatLng? _myLocation;
  List<MarkerData> _markerData = [];
  List<Marker> _markers = [];

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission are permanently denied');
    }

    return Geolocator.getCurrentPosition();
  }

  void _showCurrentLocation() async {
    try {
      Position position = await _determinePosition();
      LatLng currentLatLng = LatLng(position.latitude, position.longitude);
      _mapController.move(currentLatLng, 16.7);
      setState(() {
        _myLocation = currentLatLng;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _showCurrentLocation();
    super.initState();
  }

  void _addMarker(LatLng position, String message) {
    final markerData = MarkerData(position: position, message: message);
    _markerData.add(markerData);
    _markers.add(
      Marker(
        point: position,
        width: 80,
        height: 80,
        child: GestureDetector(
          onTap: () {
            _mapController.move(position, 16.7);
          },
          child: Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 40,
          ),
        ),
      ),
    );
  }

  void _openChatModal(LatLng pointPosition) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'ПЕЧЯТАЙ В МЕНЯ!!!',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: TextField(
                    controller: _messageController,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _addMarker(pointPosition, _messageController.text);
                    _messageController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              interactionOptions:
                  InteractionOptions(flags: ~InteractiveFlag.rotate),
              initialZoom: 16.7,
              initialCenter: LatLng(59.444957, 32.026417),
              onPositionChanged: (camera, hasGesture) {
                setState(() {
                  _myLocation = camera.center;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.point_on_map.app',
              ),
              if (_myLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80,
                      height: 80,
                      point: _myLocation!,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              MarkerLayer(markers: _markers),
            ],
          ),
          Positioned(
            top: 35,
            left: 15,
            right: 15,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  _myLocation?.toSexagesimal() ?? 'Нет данных о локации',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 90,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo,
                  onPressed: _showCurrentLocation,
                  child: Icon(
                    Icons.location_searching_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 8,
            right: 8,
            child: TextButton(
              onPressed: () {
                _openChatModal(_myLocation!);
              },
              child: Container(
                height: 50,
                child: Center(
                  child: Text(
                    'Начать чат в этом месте',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
