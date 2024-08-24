import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;

  static LatLng universityLatLng = const LatLng(
    37.3047, // 위도
    127.9226, // 경도
  );

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: FutureBuilder(
          future: checkPermission(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // data가 '위치권한이 허용되었습니다.'면 지도 리턴해줌
            if (snapshot.data == '위치권한이 허용되었습니다.') {
              return GoogleMap(
                //onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: universityLatLng,
                  zoom: 11.0,
                ),
                myLocationEnabled: true,
              );
            }

            return Center(
              child: Text(snapshot.data!),
            );
          },
        ),
      ),
    );
  }

  Future<String> checkPermission() async {
    // 로케이션 서비스가 활성화가 돼있는지 확인
    final isLocationEnbled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnbled) {
      return '위치 서비스를 활성화 해주세요.';
    }

    //현재 앱이 갖고 있는 위치서비스에 대한 권한이 어떻게 되는지 가져옴
    LocationPermission checkedPermision = await Geolocator.checkPermission();

    print(checkedPermision == LocationPermission.denied);
    if (checkedPermision == LocationPermission.denied) {
      //denied면 초기상태로 한번은 request해주지만
      checkedPermision = await Geolocator.requestPermission();
      print(checkedPermision);

      //그래도 denied면 텍스트 띄움
      if (checkedPermision == LocationPermission.denied) {
        return '위치권한을 허용해주세요.';
      }
    }

    print("hello2");
    print(checkedPermision);
    if (checkedPermision == LocationPermission.deniedForever) {
      return '앱의 위치 권한을 세팅에서 허가해주세요.';
    }

    return '위치권한이 허용되었습니다.';
  }
}
