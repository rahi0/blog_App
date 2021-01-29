import 'dart:async';
import 'dart:convert';

import 'package:blogApp/Screens/CreateBlogPage.dart';
import 'package:blogApp/Screens/DetailsPage.dart';
import 'package:blogApp/Screens/FavoritePage.dart';
import 'package:blogApp/Screens/NoConnectionPage.dart';
import 'package:blogApp/api/api.dart';
import 'package:blogApp/customPlugins/RouteAnimation/RouteAnimation.dart';
import 'package:blogApp/main.dart';
import 'package:blogApp/redux/actions.dart';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  bool isLoading = true;

//  List blogs;
  List favBlogList = [];

  @override
  initState() {
    super.initState();
    isInternet();
    // _getHomeData();
  }



  Future<Null> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network, make sure there is actually a net connection.
      if (await DataConnectionChecker().hasConnection) {
        // Mobile data detected & internet connection confirmed.
        print("object1");
       _getHomeData();
      } else {
        // Mobile data detected but no internet connection found.
        print("object2");
        Navigator.pushReplacement(context, SlideLeftRoute(page: NoConnectionPage()));
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a WIFI network, make sure there is actually a net connection.
      if (await DataConnectionChecker().hasConnection) {
        // Wifi detected & internet connection confirmed.
        print("object3");
        _getHomeData();
      } else {
        // Wifi detected but no internet connection found.
        print("object4");
         Navigator.pushReplacement(context, SlideLeftRoute(page: NoConnectionPage()));
      }
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      print("nai");
       Navigator.pushReplacement(context, SlideLeftRoute(page: NoConnectionPage()));
    }
  }


  Future<Null> _getHomeData() async {

    setState(() {
      isLoading = true;
     // currentDrawer = 'cases';
    });

    //isInternet();

    var res = await CallApi().withoutTokengetData('resource');
    final body = json.decode(res.body);
    print(body);
    print(res.statusCode);
      if (res.statusCode == 200) {
      if (body != null) {
       store.dispatch(HomeInfoAction(body)); // update data in store...
       print(store.state.homeInfoState);
       if (!mounted) return;
      //  setState(() {
      //    //blogs = store.state.homeInfoState;
      //  });

      //  SharedPreferences localStorage = await SharedPreferences.getInstance();
      // // fetch your string list      
      // List<String> mList = (localStorage.getStringList('stringList') ?? List<String>());
      // //convert your string list to your original int list
      // if(mList.length >= 1){
      // favBlogList = mList.map((i)=> json.decode(i)).toList();
      // print("seofurh");
      // print(favBlogList[0]['type']);
      // }else{
      //   print(" nai");
      // }
       
      }
      setState(() {
      isLoading = false;
      });
    }

    
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BlogApp'),
        backgroundColor: Colors.tealAccent[700],
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.white,), 
            onPressed: () {
              Navigator.push(context, SlideLeftRoute(page: FavoritePage()));
            },)
        ],
      ),
      body: 
      isLoading ? Center(child: CircularProgressIndicator(),):
     store.state.homeInfoState.length == 0 ? 
     Center(
       child: Text(
                                      "Press '+' to create a blog", 
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
       ) : Container(
        child: RefreshIndicator(
          onRefresh: _getHomeData,
          child: ListView.builder(
          scrollDirection: Axis.vertical,
     // controller: _scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: store.state.homeInfoState.length,
          itemBuilder: (BuildContext context, int index) {
            
            return GestureDetector(
              onTap: () {
                Navigator.push(context, SlideLeftRoute(page: DetailsPage(store.state.homeInfoState[index], index, true)));
              },
              child: Container(
                 margin: EdgeInsets.only(bottom: store.state.homeInfoState.length - 1 == index ? 90 :20, top: index == 0 ? 25 : 0,),
                 padding: EdgeInsets.only(left: 20, right: 20),
                 decoration: BoxDecoration(
                   color: Colors.grey[100],
                   borderRadius: BorderRadius.circular(15),
                  //  boxShadow: <BoxShadow>[
                  //   new BoxShadow(
                  //     color: Colors.black12,
                  //     blurRadius: 3.0,
                  //     offset: new Offset(0.0, 3.0),
                  //   ),
                  // ],
                 ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 140,
                          //color: Colors.red,
                          child:  Hero(
                            tag: "${store.state.homeInfoState[index]['_id']}",
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)
                              ),
                              child: 
                              Image.asset(
                                store.state.homeInfoState[index]['type'] == 'Technology' ?
                                'assets/img/tech.jpg' :
                                store.state.homeInfoState[index]['type'] == 'World' ?
                                'assets/img/other.jpg' :
                                store.state.homeInfoState[index]['type'] == 'Sports' ?
                                'assets/img/sport.jpg':
                                'assets/img/blog.jpg',
                              fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                   // SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.only(
                        left: 10, right: 0, bottom: 5
                      ),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Container(
                          //   child: CircleAvatar(
                          //     radius: 14,
                          //     child: Image.asset('assets/images/man1.png'),
                          //   ),
                          // ),
                          Expanded(
                            child: Container(
                             // color: Colors.red,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      "${store.state.homeInfoState[index]['title']}", 
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  Container(
                                    child: Text(
                                      "${store.state.homeInfoState[index]['date']}",
                                    //'Afsa uryithisru h',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                                  )
                                ],
                              ),
                            ),
                          ),



                          ///////////////// Menu Button ////////////////////
                          PopupMenuButton<int>(
                                            onSelected: (selected) {
                                             if(selected == 1){
                                               deleteBlog(store.state.homeInfoState[index]);
                                             } else{
                                               addToFevBlog(store.state.homeInfoState[index]);
                                             }
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0))),
                                            icon: Icon(
                                             Icons.more_vert,
                                              // color: Color(0xff707070)
                                              //     .withOpacity(0.3),
                                            ),
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                value: 1,
                                                child: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Color(0xFF5A5B5C),
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                              PopupMenuItem(
                                                value: 2,
                                                child: Text(
                                                  "Add Favourite",
                                                  style: TextStyle(
                                                      color: Color(0xFF5A5B5C),
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                            offset: Offset(0, 100),
                                          ),
                          ///////////////// Menu Button ////////////////////
                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
                      ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push( context, ScaleRoute(page: CreateBlogPage())).then((value){
            setState(() {
              
            });
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.tealAccent[700],
      ),
    );
  }



  void deleteBlog(blog) async {

    setState(() {
      isLoading = true;
    });

     var res = await CallApi().deleteData('resource/${blog['_id']}');
      print("body");
      print(res.statusCode);

     if (res.statusCode != 200) {

      setState(() {
          isLoading = false;
        });

        _errorDialog("Something went wrong");
    }

    else  if (res.statusCode == 200){

     for(var d in store.state.homeInfoState){
        if(d['_id'] == blog['_id']){
          //print(pendingCloseS['is_accept']);
          store.state.homeInfoState.remove(blog);
          store.dispatch(HomeInfoAction(store.state.homeInfoState));
          print(store.state.homeInfoState);
          break;
        }
      }

      setState(() {
          isLoading = false;
        });

    }
   }


    addToFevBlog(blog) async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
      // fetch your string list      
        List<String> mList = (localStorage.getStringList('stringList') ?? List<String>());
        //convert your string list to your original int list
        var mOriginaList = mList.map((i)=> json.decode(i)).toList();
        // print("seofurh");
        // print(mOriginaList[0]['type']);
        setState(() {
            favBlogList=mOriginaList;
          });
      
      
          //print(blog);
          favBlogList.add(blog);
          // SharedPreferences localStorage = await SharedPreferences.getInstance();
          // convert your custom list to string list
          List<dynamic> stringsList=  favBlogList.map((i)=>json.encode(i)).toList();
          // store your string list in shared prefs                
          localStorage.setStringList("stringList", stringsList);

          setState(() {
            favBlogList=[];
          });

        
      
   }


    ////////////// Error Dialog STart //////////
  Future<Null> _errorDialog(title) async {
    return showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        topLeft: Radius.circular(5),
                      ),
                      border: Border.all(color: Colors.white)),
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      margin: EdgeInsets.all(15),
                      child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'quicksand',
                        color: Color(0xff003A5B),
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                      ),
                ),
                
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                        border: Border.all(color: Colors.white)),
                    child: Container(
                        width: 100,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(
                            top: 0, bottom: 20, left: 30, right: 30),
                        decoration: BoxDecoration(
                          color: Colors.tealAccent[700],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text("Done",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                fontFamily: "quicksand"))),
                  ),
                ),
              ],
            ),
          );
        });
  }
////////////// Errort Dialog End /////////
 
}