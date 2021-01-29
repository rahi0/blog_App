import 'dart:convert';

import 'package:blogApp/Screens/CreateBlogPage.dart';
import 'package:blogApp/Screens/DetailsPage.dart';
import 'package:blogApp/customPlugins/RouteAnimation/RouteAnimation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FavoritePage extends StatefulWidget {

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  bool isLoading = true;
  bool noData = false;

//  List blogs;
  List<dynamic> favBlogList;

  @override
  initState() {
    super.initState();
   // isInternet(context);
    _getFavBlogData();
  }


  Future<Null> _getFavBlogData() async {

    setState(() {
      isLoading = true;
     // currentDrawer = 'cases';
    });

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    // fetch your string list      
    List<String> mList = (localStorage.getStringList('stringList') ?? List<String>());
    if(mList.length <= 0){
      print("seofur88h");
      setState(() {
        noData = true;
      });
      }else{
        //convert your string list to your original int list
        favBlogList = mList.map((i)=> json.decode(i)).toList();
        print("seofurh44");
       // print(favBlogList[0]['type']);
      }
    

    
      setState(() {
      isLoading = false;
      });


    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        centerTitle: true,
        backgroundColor: Colors.tealAccent[700],
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(),):
      //favBlogList.length == 0 ? Center(child: Text("No blog is saved"),) :
      noData == true ? Center(child: Text("No blog is saved"),) :
      Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: ListView.builder(
        scrollDirection: Axis.vertical,
     // controller: _scrollController,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: favBlogList.length,
        itemBuilder: (BuildContext context, int index) {
          
          return GestureDetector(
            onTap: () {
              Navigator.push(context, SlideLeftRoute(page: DetailsPage(favBlogList[index], index, false)));
            },
            child: Container(
               margin: EdgeInsets.only(bottom: 20, top: index == 0 ? 25 : 0),
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
                        child:  ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)
                          ),
                          child: 
                          Image.asset(
                            favBlogList[index]['type'] == 'Technology' ?
                                'assets/img/tech.jpg' :
                                favBlogList[index]['type'] == 'World' ?
                                'assets/img/other.jpg' :
                                favBlogList[index]['type'] == 'Sports' ?
                                'assets/img/sport.jpg':
                                'assets/img/blog.jpg',
                          fit: BoxFit.cover,
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
                                    "${favBlogList[index]['title']}",
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
                                    "${favBlogList[index]['date']}",
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
                                             removeBlog(favBlogList[index]);
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
                                                "Remove",
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
    );
  }


  removeBlog(blog) async {
      setState(() {
        isLoading = true;
      });
          //print(blog);
          favBlogList.remove(blog);
          SharedPreferences localStorage = await SharedPreferences.getInstance();
          // convert your custom list to string list
          List<String> stringsList=  favBlogList.map((i)=>json.encode(i)).toList();
          // store your string list in shared prefs                
          localStorage.remove("stringList");
          localStorage.setStringList("stringList", stringsList);

        // // fetch your string list      
        // List<String> mList = (localStorage.getStringList('stringList') ?? List<String>());
        // //convert your string list to your original int list
        // var mOriginaList = mList.map((i)=> json.decode(i)).toList();
        // print("seofurh");
        // print(mOriginaList[0]['type']);
      setState(() {
        isLoading = false;
      });
   }
}
