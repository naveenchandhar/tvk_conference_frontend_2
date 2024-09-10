import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'appstaticdata/colorfile.dart';
import 'appstaticdata/staticdata.dart';
// import 'provider/proviercolors.dart';

class ComunBottomBar extends StatefulWidget {
  const ComunBottomBar({super.key});

  @override
  State<ComunBottomBar> createState() => _ComunBottomBarState();
}

class _ComunBottomBarState extends State<ComunBottomBar> {
  String copyright =  "Copyright  " + DateTime.now().year.toString() + "  © Inforge Technologies Pvt Ltd.";
  @override
  Widget build(BuildContext context) {
    return  Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              boxShadow: boxShadow, color: notibackcolor),
          child: Center(
              child:  InkWell(
    child:Text(
                copyright,
                style: TextStyle(color: Colors.blue,overflow: TextOverflow.ellipsis,decoration: TextDecoration.underline),
              ),
                  onTap: () => launchUrl(Uri.parse("https://inforgetech.com"))
              ),
          ),

        );


  }
}
