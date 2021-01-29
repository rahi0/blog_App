import 'package:blogApp/Screens/UpdateBlogPage.dart';
import 'package:blogApp/customPlugins/RouteAnimation/RouteAnimation.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  var blog;
  var index;
  bool isEdit;
  DetailsPage(this.blog, this.index, this.isEdit);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8FA),
      //backgroundColor: Colors.tealAccent[700],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.tealAccent[700],
        title: Text("${widget.blog['type']}"),
        centerTitle: true,
        actions: [
         widget.isEdit == false ? Container() : IconButton(
            icon: Icon(Icons.edit_rounded, color: Colors.white,), 
            onPressed: () {
              Navigator.push(context, ScaleRoute(page: UpdateBlogPage(widget.blog, widget.index)));
            },)
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: "${widget.blog['_id']}",
              child: Container(
                height: MediaQuery.of(context).size.width/2,
                decoration: BoxDecoration(
                  //color: Colors.red,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                               widget.blog['type'] == 'Technology' ?
                              'assets/img/tech.jpg' :
                              widget.blog['type'] == 'World' ?
                              'assets/img/other.jpg' :
                              widget.blog['type'] == 'Sports' ?
                              'assets/img/sport.jpg':
                              'assets/img/blog.jpg',
                            ),
                  )
                ),
              ),
            ),

            Container(
              //color: Colors.red,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Container(
                      child: Text(
                        "${widget.blog['title']}",
                        style: TextStyle(
                            color: Color(0xff003A5B),
                            fontFamily: 'quicksand',
                            fontSize: 19,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 15),
                    child: Text(
                      "${widget.blog['date']}",
                      style: TextStyle(
                          color: Color(0xff003A5B).withOpacity(0.9),
                          fontFamily: 'quicksand',
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),

                  Container(
                      child: Text(
                        "${widget.blog['description']}",
                        style: TextStyle(
                            color: Color(0xff003A5B),
                            fontFamily: 'quicksand',
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
