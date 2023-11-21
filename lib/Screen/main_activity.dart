import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_saver/Provider/bottom_nav_provider.dart';
import 'package:status_saver/Screen/BottomNavPages/Image/image.dart';
import 'package:status_saver/Screen/BottomNavPages/Video/video.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({Key? key}) : super(key: key);

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  List<Widget> pages = const [ImageHomePage(), VideoHomePage()];
  final items = [
    (const Icon(Icons.image_outlined, size: 30, color: Colors.white)),
    (const Icon(Icons.video_call, size: 30, color: Colors.white))
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(builder: (context, nav, child) {
      return Scaffold(
        backgroundColor: Color(0xff2B3047),
        drawer: const SizedBox(
          height: 300,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                topRight: Radius.circular(30)),
            child: Drawer(
              backgroundColor: Color(0xff2B3047),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.black,
          toolbarHeight: 90,
          elevation: 14,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50))),
          title: const Text(
            'Status Saver',
          ),
          actions: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      showAlertDialog(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(boxShadow: const [
                        BoxShadow(
                            blurRadius: 7, spreadRadius: 3, color: Colors.pink)
                      ], shape: BoxShape.circle, color: Colors.pink.shade400),
                      child: const Text(
                        'i',
                        style: TextStyle(
                            fontFamily: "Georgia",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            )
          ],
        ),
        body: pages[nav.currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          onTap: (value) {
            nav.changeIndex(value);
          },
          index: nav.currentIndex,
          items: items,
          height: 60,
          backgroundColor: Colors.white,
          color: Colors.black,
          buttonBackgroundColor: Colors.pink,
          animationDuration: const Duration(milliseconds: 300),
        ),
      );
    });
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.pink,
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // create AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      icon: const Icon(
        Icons.info_outline_rounded,
        color: Colors.green,
        size: 25,
      ),
      title: const Text("How it works?"),
      content: const Text(
          "You just need to view your WhatsApp status and come back to download it easy."),
      actions: [
        Center(child: okButton),
      ],
      backgroundColor: const Color(0xff2B3047),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
