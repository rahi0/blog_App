import 'package:blogApp/Screens/HomePage.dart';
import 'package:blogApp/Screens/UpdateBlogPage.dart';
import 'package:blogApp/customPlugins/RouteAnimation/RouteAnimation.dart';
import 'package:flutter/material.dart';

import 'FavoritePage.dart';

class NoConnectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8FA),
      //backgroundColor: Colors.tealAccent[700],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.tealAccent[700],
        title: Text("No Connection"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width/2,
              width: MediaQuery.of(context).size.width/2,
              decoration: BoxDecoration(
                //color: Colors.red,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                            'assets/img/nonet.png',
                          ),
                )
              ),
            ),

            Container(
              //color: Colors.red,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
              child: Text(
                "Oops! No Connection",
                style: TextStyle(
                    color: Color(0xff003A5B),
                    fontFamily: 'quicksand',
                    fontSize: 19,
                    fontWeight: FontWeight.w600),
              ),
            ),


            Container(
              margin: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   //////////////////////// Reload Button /////////////////////
            GestureDetector(
              onTap:(){
                Navigator.pushReplacement(context, SlideLeftRoute(page: MyHomePage()));
              },
              child: Container(
                child: Container(
                  width: MediaQuery.of(context).size.width/3,
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  margin: EdgeInsets.only(top: 0),
                  decoration: BoxDecoration(
                      color:  Colors.tealAccent[700],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.tealAccent[700])),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                         "Reload",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "quicksand",
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //////////////////////// Reload Button /////////////////////
            SizedBox(width: 30,),
            //////////////////////// Fav Button /////////////////////
            GestureDetector(
              onTap:(){
                Navigator.push(context, SlideLeftRoute(page: FavoritePage()));
              },
              child: Container(
                child: Container(
                  width: MediaQuery.of(context).size.width/3,
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  margin: EdgeInsets.only(top: 0),
                  decoration: BoxDecoration(
                      color:  Colors.tealAccent[700],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.tealAccent[700])),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                         "Go to Favorite",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "quicksand",
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            )
            //////////////////////// Fav Button /////////////////////
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}