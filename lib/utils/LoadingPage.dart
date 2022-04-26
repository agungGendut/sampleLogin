import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  final bool isPage;
  LoadingPage({this.isPage = true});
  @override
  LoadingPageState createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                ),
                Container(
                  child: Image.asset('assets/coreapps1.png', scale: 3,),
                ),
                Container(
                  child: Image.asset("assets/LoadingMerah.gif"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                ),
              ],
            ),
          ),
        ),
        onWillPop: null
    );
  }
}