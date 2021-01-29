import 'dart:convert';
import 'dart:io';
import 'package:blogApp/Screens/HomePage.dart';
import 'package:blogApp/api/api.dart';
import 'package:blogApp/customPlugins/RouteAnimation/RouteAnimation.dart';
import 'package:blogApp/main.dart';
import 'package:blogApp/redux/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; // for date format

class UpdateBlogPage extends StatefulWidget {
  var blog;
  var index;
  UpdateBlogPage(this.blog, this.index);
  @override
  _UpdateBlogPageState createState() => _UpdateBlogPageState();
}

class _UpdateBlogPageState extends State<UpdateBlogPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool isPressed = false;
 // var userData;
  var roleIndex;
  List<DropdownMenuItem<String>> _dropDownRoleItems;
  List arrRole = [
    "Technology",
    "Sports",
    "World",
    "Other",
  ];
  String blogType = "",titleType = "",description;
  bool isTitleEmpty = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  DateTime selectedDateTo = DateTime.now();
  

  @override
  initState() {
    super.initState();

    // _dropDownRoleItems = getDropDownRoleItems();
    // blogType = _dropDownRoleItems[3].value ; 
    _getBlogData();
  }


  void _getBlogData() async {
    setState(() {
      isLoading = true;
      //currentDrawer = 'profile';
    });
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var userJson = localStorage.getString('user');
    // var user = json.decode(userJson);
    // //print(user);
    // setState(() {
    //  // userData = user;
    //   userData = store.state.userInfoState;
    // });
    // print(userData);

    desController = TextEditingController(text:'${widget.blog['description']}');
    titleController = TextEditingController(text: widget.blog['title']);
    _dropDownRoleItems = getDropDownRoleItems();
    blogType = "${widget.blog['type']}";
    setState(() {
      isLoading = false;
    });
  }

  List<DropdownMenuItem<String>> getDropDownRoleItems() {
    ////////drop down button
    List<DropdownMenuItem<String>> items = new List();
    for (String roleList in arrRole) {
      items.add(new DropdownMenuItem(
          value: roleList,
          child: new Text(
            roleList,
            textAlign: TextAlign.end,
            style: TextStyle(
                color: Color(0xff000000),
                fontFamily: 'quicksand',
                fontSize: 15,
                fontWeight: FontWeight.w400),
          )));
    }
    return items;
  }

  ////////////////// Error Container Start //////////////
    Container errorCon(String title){
        return Container(
                      margin: EdgeInsets.only(
                          left: 22, right: 20, top: 5, bottom: 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.error,
                            color: Colors.redAccent,
                            size: 14,
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 3),
                              child: Text(
                                title,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontFamily: "quicksand",
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
      }
//////////////Error container end //////////////


  @override
  Widget build(BuildContext context) {
    return isLoading ? Container(
      child: Center(child: CircularProgressIndicator(),),
    ) : Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFF8F8FA),
      //backgroundColor: Colors.tealAccent[700],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.tealAccent[700],
        title: Text('Update Blog'),
        centerTitle: true,
      ),
    //  drawer: Drawerr(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width/2,
              decoration: BoxDecoration(
                //color: Colors.red,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                            blogType == 'Technology' ?
                            'assets/img/tech.jpg' :
                            blogType == 'World' ?
                            'assets/img/other.jpg' :
                            blogType == 'Sports' ?
                            'assets/img/sport.jpg':
                            'assets/img/blog.jpg',
                          ),
                )
              ),
            ),

            
            Container(
              color: Color(0xFFF8F8FA),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.15),
                    borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                padding: EdgeInsets.only(top: 5, bottom: 5, right: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 12, right: 10, top: 5),
                      child: Text(
                        "Blog Type",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff959595),
                            fontSize: 11.5,
                            fontFamily: 'quicksand',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      height: 33,
                      padding: EdgeInsets.only(left: 12, right: 12),
                      child: DropdownButtonHideUnderline(
                        child: Container(
                          child: DropdownButton(
                            //icon: Icon(Icons.arrow_drop_down),
                            isExpanded: true,
                            // iconDisabledColor:
                            //     Color(0xFF008990),
                            iconEnabledColor: Color(0xff003A5B),
                            // iconSize: 40,

                            //hint: Text('Select Situation'),
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff003A5B),
                            ),
                            value: blogType,
                            items: _dropDownRoleItems,
                            icon: Icon(
                              Icons.expand_more,
                              size: 15,
                              color: Color(0xff707070),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                blogType = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              color: Color(0xFFF8F8FA),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.15),
                    borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                padding: EdgeInsets.only(top: 5, bottom: 5, right: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                titleType = value;
                                if (titleType == ""){
                              setState(() {
                                isTitleEmpty = true;
                              });
                                }else{
                                  isTitleEmpty = false;
                                }
                              });
                            },
                            controller: titleController,
                            autofocus: false,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                color: Color(0xff003A5B).withOpacity(0.6),
                                fontFamily: 'quicksand',
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              hintText: "Enter The Blog Title",
                              hintStyle: TextStyle(
                                  color: Color(0xff003A5B).withOpacity(0.6),
                                  fontSize: 15,
                                  fontFamily: 'quicksand',
                                  fontWeight: FontWeight.w600),
                              labelStyle:TextStyle(
                            color: Color(0xff959595),
                            fontSize: 15,
                            fontFamily: 'quicksand',
                            fontWeight: FontWeight.w400),
                              labelText: "Title",
                              contentPadding:
                                  EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    )
                    ),
                  ],
                ),
              ),
            ),
/////////////////////////////
                isTitleEmpty == true ? errorCon("Role type required") : Container(),
/////////////////////////////
            Container(
              color: Color(0xFFF8F8FA),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.15),
                      borderRadius: BorderRadius.circular(5)),
                  width: MediaQuery.of(context).size.width,
                  //height: 300,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                  padding: EdgeInsets.only(top: 15, bottom: 5, right: 10),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              description = value;
                            });
                          },
                          controller: desController,
                          autofocus: false,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 15,
                              fontFamily: 'quicksand',
                              fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            hintText: "Write Here.......",
                            hintStyle: TextStyle(
                                  color: Color(0xff003A5B).withOpacity(0.6),
                                  fontSize: 15,
                                  fontFamily: 'quicksand',
                                  fontWeight: FontWeight.w600),
                            labelStyle: TextStyle(
                                color: Color(0xff959595),
                                fontSize: 15,
                                fontFamily: 'quicksand',
                                fontWeight: FontWeight.w400),
                            labelText: "Description",
                            contentPadding:
                                EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),




            //////////////////////// Update Button /////////////////////
            GestureDetector(
              onTap: isPressed ? null: updateBlog,
              child: Container(
                margin: EdgeInsets.all(20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  margin: EdgeInsets.only(top: 0),
                  decoration: BoxDecoration(
                      color: isPressed ? Colors.grey : Colors.tealAccent[700],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.tealAccent[700])),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        isPressed ? "Updating..." : "Update",
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
            //////////////////////// Update Button /////////////////////

          ],
        ),
      ),
    );
  }


  void updateBlog() async {
    setState(() {
      isPressed = true;
     // emailBlank = true;
    });

    if(titleController.text == "") {
      setState(() {
         isTitleEmpty = true;
         isPressed = false;
      });
    } 
    else if(desController.text == "") {
      _errorDialog("Description required!");
      setState(() {
         isPressed = false;
      });
    } 
    else {
      setState(() {
        isTitleEmpty = false;
      });

      var data = {
          "type" : blogType,
          "title": titleController.text,
          "description": desController.text,
          "date": "${widget.blog['date']}",
        };
       print(data);

     var res = await CallApi().putData(data, 'resource/${widget.blog['_id']}');
      print("body");
      print(res.statusCode);

     if (res.statusCode != 200) {

      setState(() {
          isPressed = false;
        });

        _errorDialog("Something went wrong");
    }

    else  if (res.statusCode == 200){

     for(var d in store.state.homeInfoState){
        if(d['_id'] == widget.blog['_id']){
          //print(pendingCloseS['is_accept']);
          store.state.homeInfoState[widget.index] = data;
          store.dispatch(HomeInfoAction(store.state.homeInfoState));
          print(store.state.homeInfoState[widget.index]);
          //print(store.state.homepageCaseState['New_Case_Invite']);
          break;
        }
      }
      setState(() {
          isPressed = false;
        });
     Navigator.push(context, ScaleRoute(page: MyHomePage()));

    }

     
     }
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
