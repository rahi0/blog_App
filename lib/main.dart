import 'package:blogApp/redux/reducer.dart';
import 'package:blogApp/redux/states.dart';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'Screens/FavoritePage.dart';
import 'Screens/HomePage.dart';
import 'Screens/NoConnectionPage.dart';
import 'customPlugins/RouteAnimation/RouteAnimation.dart';



///////  store initialization///////////////
final store = Store<AppState>(
  reducer,
  initialState: AppState(
      homeInfoState: {},
     ),
);


// Future<bool> isInternet(context) async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.mobile) {
//       // I am connected to a mobile network, make sure there is actually a net connection.
//       if (await DataConnectionChecker().hasConnection) {
//         // Mobile data detected & internet connection confirmed.
//         print("object1");
//         return true;
//       } else {
//         // Mobile data detected but no internet connection found.
//         print("object2");
//         Navigator.pushReplacement(context, SlideLeftRoute(page: NoConnectionPage()));
//         return false;
//       }
//     } else if (connectivityResult == ConnectivityResult.wifi) {
//       // I am connected to a WIFI network, make sure there is actually a net connection.
//       if (await DataConnectionChecker().hasConnection) {
//         // Wifi detected & internet connection confirmed.
//         print("object3");
//         return true;
//       } else {
//         // Wifi detected but no internet connection found.
//         print("object4");
//          Navigator.pushReplacement(context, SlideLeftRoute(page: NoConnectionPage()));
//         return false;
//       }
//     } else {
//       // Neither mobile data or WIFI detected, not internet connection found.
//       print("nai");
//        Navigator.pushReplacement(context, SlideLeftRoute(page: NoConnectionPage()));
//       return false;
//     }
//   }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, AppState>(  ////// this is the connector which mainly changes state/ui
            converter: (store) => store.state,
            builder: (context, items) {
        return MaterialApp(
      title: 'BlogApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    ); }
      ),
    );
  }
}


