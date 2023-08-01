import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/screens/scholarship.dart';

import 'Coursepage.dart';
import 'admission_screen.dart';
import 'authentication/login_screen.dart';
import 'listview.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Size? size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text(
            "Dashboard",
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.off(LoginScreen());
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              child: CustomPaint(
                painter: ShapesPainter(),
                child: Container(
                  height: size!.height / 2,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: GridView.count(
                  crossAxisCount: 2,
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          Get.to(CourseListScreen());
                        },
                        child: createGridItem(0, "Courses")),
                    InkWell(
                        onTap: () {
                          Get.to(ScholarshipListScreen());
                        },
                        child: createGridItem(2, "Scholorship")),
                    InkWell(
                        onTap: () {
                          Get.to(TransfterData());
                        },
                        child: createGridItem(3, "Admission")),
                    InkWell(
                      onTap: () {
                        Get.to(SearchListViewFromAPI());
                      },
                      child: createGridItem(5, "RESULT"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createGridItem(int position, String title) {
    var color = Colors.white;
    var icondata = Icons.add;

    switch (position) {
      case 0:
        color = Colors.cyan;
        icondata = Icons.book;
        break;
      case 1:
        color = Colors.deepPurple;

        icondata = Icons.add_location;
        break;
      case 2:
        color = Colors.orange;
        icondata = Icons.library_books;
        break;
      case 3:
        color = Colors.pinkAccent;
        icondata = Icons.punch_clock_rounded;
        break;
      case 4:
        color = Colors.teal;
        icondata = Icons.add_shopping_cart;
        break;
      case 5:
        color = Colors.green;
        icondata = Icons.list;
        break;
    }

    return Builder(builder: (context) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
        child: Card(
          elevation: 10,
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Colors.white),
          ),
          child: InkWell(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    icondata,
                    size: 40,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
      ;
    });
  }
}

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    // set the paint color to be white
    paint.color = Colors.white;
    // Create a rectangle with size and width same as the canvas
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // draw the rectangle using the paint
    canvas.drawRect(rect, paint);
    paint.color = Color.fromARGB(101, 46, 107, 240);
    // create a path
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, 0);
    // close the path to form a bounded shape
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
