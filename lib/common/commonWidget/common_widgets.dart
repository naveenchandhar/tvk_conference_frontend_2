import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../appstaticdata/staticdata.dart';
import '../../theme/color.dart';

commonTitleShowingWidget(String title, FontWeight fontWeight, Color color,
    double textSize, FontStyle fontStyle) {
  return AutoSizeText(
    title,
    // maxLines: 1,
    style: TextStyle(
      fontWeight: fontWeight,
      color: color,
      fontSize: textSize,
      fontStyle: fontStyle,
    ),
    // textAlign: TextAlign.justify,
  );
}

commonTitleBottomBarWidget(String title, FontWeight fontWeight, Color color,
    double textSize, FontStyle fontStyle, String fontFamilyName) {
  return AutoSizeText(
    title,
    // maxLines: 1,
    style: TextStyle(
        fontWeight: fontWeight,
        color: color,
        fontSize: textSize,
        fontStyle: fontStyle,
        fontFamily: fontFamilyName),
    // textAlign: TextAlign.justify,
  );
}

commonTitleShowingWithElipseWidget(
  String title,
  FontWeight fontWeight,
  Color color,
  double textSize,
  FontStyle fontStyle,
) {
  return AutoSizeText(
    title,
    style: TextStyle(
      fontWeight: fontWeight,
      color: color,
      fontSize: textSize,
      fontStyle: fontStyle,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

singleTitleShowingWidget(String title, FontWeight fontWeight, Color color,
    double textSize, FontStyle fontStyle) {
  return AutoSizeText(
    title,
    style: TextStyle(
      fontWeight: fontWeight,
      color: color,
      fontSize: textSize,
      fontStyle: fontStyle,
    ),
  );
}

Container circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 10.0),
    child: Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 100.0,
          height: 100.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          ),
        ),
        Positioned(
          width: 60,
          height: 60,
          child: Image.asset(
            "assets/img/tvk-logo-new.png",
            fit: BoxFit.fill,
          ),
        ),
      ],
    ),
  );
}

passwordDecorationInputDecorationWidget(String hintName) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,

    hintText: hintName,
    counterText: "",
    contentPadding:
        const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(210, 248, 248, 1)),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: notifire!.getfiltextcolors, width: 3.0),
    ),
    hintStyle: const TextStyle(
        color: Color.fromRGBO(128, 128, 128, 1),
        fontStyle: FontStyle.normal,
        fontSize: 14.0),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 3, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        width: 3,
        color: Color.fromRGBO(255, 0, 0, 1),
      ),
    ),
  );
}

inputDecorationWidget(String? hintName) {
  return InputDecoration(
    filled: true,
    fillColor: notifire!.getcontiner,

    hintText: hintName,
    counterText: "",
    contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: notifire!.getfiltextcolors,
      ),
      // borderRadius: BorderRadius.circular(30.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 3.0),
      // borderRadius: BorderRadius.circular(30.0),
    ),
    hintStyle: const TextStyle(
        color: Color.fromRGBO(128, 128, 128, 1),
        fontStyle: FontStyle.normal,
        fontSize: 14.0),
    errorBorder: OutlineInputBorder(
      // borderRadius: BorderRadius.circular(30.0),
      borderSide: const BorderSide(width: 3, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      // borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        width: 3,
        color: Color.fromRGBO(255, 0, 0, 1),
      ),
    ),
  );
}

issueInputDecorationWidget(String? hintName) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: hintName,
    counterText: "",
    contentPadding:
        const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color.fromRGBO(210, 248, 248, 1)),
      // borderRadius: BorderRadius.circular(30.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 3.0),
      // borderRadius: BorderRadius.circular(30.0),
    ),
    hintStyle: const TextStyle(
        color: Color.fromRGBO(128, 128, 128, 1),
        fontStyle: FontStyle.normal,
        fontSize: 14.0),
    errorBorder: OutlineInputBorder(
      // borderRadius: BorderRadius.circular(30.0),
      borderSide: const BorderSide(width: 3, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      // borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        width: 3,
        color: Color.fromRGBO(255, 0, 0, 1),
      ),
    ),
  );
}

alertDialogueBoxInputDecorationWidget(String? hintName) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: hintName,
    counterText: "",
    contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color.fromRGBO(128, 128, 128, 1)),
      // borderRadius: BorderRadius.circular(30.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 3.0),
      // borderRadius: BorderRadius.circular(30.0),
    ),
    hintStyle: const TextStyle(
        color: Color.fromRGBO(128, 128, 128, 1),
        fontStyle: FontStyle.normal,
        fontSize: 12.0),
    errorBorder: OutlineInputBorder(
      // borderRadius: BorderRadius.circular(30.0),
      borderSide: const BorderSide(width: 3, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      // borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        width: 3,
        color: Color.fromRGBO(255, 0, 0, 1),
      ),
    ),
  );
}

createLocalDialogueBoxInputDecorationWidget(String? hintName) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: hintName,
    counterText: "",
    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color.fromRGBO(128, 128, 128, 1)),
      // borderRadius: BorderRadius.circular(30.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 3.0),
      // borderRadius: BorderRadius.circular(30.0),
    ),
    hintStyle: const TextStyle(
        color: Color.fromRGBO(128, 128, 128, 1),
        fontStyle: FontStyle.normal,
        fontSize: 12.0),
    errorBorder: OutlineInputBorder(
      // borderRadius: BorderRadius.circular(30.0),
      borderSide: const BorderSide(width: 3, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      // borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        width: 3,
        color: Color.fromRGBO(255, 0, 0, 1),
      ),
    ),
  );
}

tweedleAlertDialogueBoxInputDecorationWidget(String? hintName) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: hintName,
    counterText: "",
    contentPadding:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color.fromRGBO(128, 128, 128, 1)),
      // borderRadius: BorderRadius.circular(30.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 3.0),
      // borderRadius: BorderRadius.circular(30.0),
    ),
    hintStyle: const TextStyle(
        color: Color.fromRGBO(128, 128, 128, 1),
        fontStyle: FontStyle.normal,
        fontSize: 12.0),
    errorBorder: OutlineInputBorder(
      // borderRadius: BorderRadius.circular(30.0),
      borderSide: const BorderSide(width: 3, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      // borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        width: 3,
        color: Color.fromRGBO(255, 0, 0, 1),
      ),
    ),
  );
}

suffixedAlertDialogueBoxInputDecorationWidget(
    String? hintName, IconData person_outlined) {
  return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hintName,
      counterText: "",
      contentPadding:
          const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromRGBO(128, 128, 128, 1)),
        // borderRadius: BorderRadius.circular(30.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 3.0),
        // borderRadius: BorderRadius.circular(30.0),
      ),
      hintStyle: const TextStyle(
          color: Color.fromRGBO(128, 128, 128, 1),
          fontStyle: FontStyle.normal,
          fontSize: 12.0),
      errorBorder: OutlineInputBorder(
        // borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(width: 3, color: Colors.red),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        // borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(
          width: 3,
          color: Color.fromRGBO(255, 0, 0, 1),
        ),
      ),
      suffixIcon: InkWell(onTap: () {}, child: Icon(person_outlined)));
}

mobileAlertDialogueBoxInputDecorationWidget(String? hintName) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: hintName,
    counterText: "",
    contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color.fromRGBO(128, 128, 128, 1),
      ),
      // borderRadius: BorderRadius.circular(30.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 3.0),
      // borderRadius: BorderRadius.circular(30.0),
    ),
    hintStyle: const TextStyle(
        color: Color.fromRGBO(128, 128, 128, 1),
        fontStyle: FontStyle.normal,
        fontSize: 10.0),
    errorBorder: OutlineInputBorder(
      // borderRadius: BorderRadius.circular(30.0),
      borderSide: const BorderSide(width: 3, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      // borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        width: 3,
        color: Color.fromRGBO(255, 0, 0, 1),
      ),
    ),
  );
}

issueAlertDialogueBoxInputDecorationWidget(String? hintName) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: hintName,
    counterText: "",
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color.fromRGBO(210, 248, 248, 1)),
      // borderRadius: BorderRadius.circular(30.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 3.0),
      // borderRadius: BorderRadius.circular(30.0),
    ),
    hintStyle: const TextStyle(
        color: Color.fromRGBO(128, 128, 128, 1),
        fontStyle: FontStyle.normal,
        fontSize: 14.0),
    errorBorder: OutlineInputBorder(
      // borderRadius: BorderRadius.circular(30.0),
      borderSide: const BorderSide(width: 3, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      // borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        width: 3,
        color: Color.fromRGBO(255, 0, 0, 1),
      ),
    ),
  );
}

inputDecorationDropDownWidget() {
  return InputDecoration(
    filled: true,
    fillColor: notifire!.getcontiner,
    // hintText: hintName,
    counterText: "",
    contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
    enabledBorder: OutlineInputBorder(
      borderSide:  BorderSide(
        color: notifire!.getfiltextcolors,
      ),
      // borderRadius: BorderRadius.circular(30.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 3.0),
      // borderRadius: BorderRadius.circular(30.0),
    ),
    hintStyle: const TextStyle(
        color: Color.fromRGBO(128, 128, 128, 1),
        fontStyle: FontStyle.normal,
        fontSize: 14.0),
    errorBorder: OutlineInputBorder(
      // borderRadius: BorderRadius.circular(30.0),
      borderSide: const BorderSide(width: 3, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      // borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        width: 3,
        color: Color.fromRGBO(255, 0, 0, 1),
      ),
    ),
  );
}

inputMobileDecorationDropDownWidget() {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    // hintText: hintName,
    counterText: "",
    contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color.fromRGBO(210, 248, 248, 1)),
      borderRadius: BorderRadius.circular(30.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 3.0),
      borderRadius: BorderRadius.circular(30.0),
    ),
    hintStyle: const TextStyle(
        color: Color.fromRGBO(128, 128, 128, 1),
        fontStyle: FontStyle.normal,
        fontSize: 12.0),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: const BorderSide(width: 3, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        width: 3,
        color: Color.fromRGBO(255, 0, 0, 1),
      ),
    ),
  );
}

issueInputDecorationDropDownWidget() {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    // hintText: hintName,
    counterText: "",
    contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.lightBlueAccent),
      // borderRadius: BorderRadius.circular(30.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 3.0),
      // borderRadius: BorderRadius.circular(30.0),
    ),
    hintStyle: const TextStyle(
        color: Color.fromRGBO(128, 128, 128, 1),
        fontStyle: FontStyle.normal,
        fontSize: 14.0),
    errorBorder: OutlineInputBorder(
      // borderRadius: BorderRadius.circular(30.0),
      borderSide: const BorderSide(width: 3, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      // borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        width: 3,
        color: Color.fromRGBO(255, 0, 0, 1),
      ),
    ),
  );
}

loader() {
  return Container(
    width: 200,
    height: 40,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/prod_loading.gif'),
        fit: BoxFit.cover,
        // alignment: Alignment.center,
      ),
    ),
  );
}

Widget buildTextFilde(
    {required String hinttext,
    required String prefixicon,
    String? suffix,
    required bool suffixistrue,
    TextEditingController? controller}) {
  return TextFormField(
    style: TextStyle(
        color: notifire!.getMainText
        ),
    controller: controller,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
              color: notifire!.isDark
                  ? notifire!.geticoncolor
                  : Colors.grey.shade200
              )),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
              color: notifire!.isDark
                  ? notifire!.geticoncolor
                  : Colors.grey.shade200
              )),
      hintText: hinttext,
      hintStyle: mediumGreyTextStyle,
      prefixIcon: SizedBox(
        height: 20,
        width: 50,
        child: Center(
            child: SvgPicture.asset(
          prefixicon,
          height: 18,
          width: 18,
          color: notifire!.geticoncolor,
        )),
      ),
      suffixIcon: suffixistrue
          ? SizedBox(
              height: 20,
              width: 50,
              child: Center(
                  child: SvgPicture.asset(
                suffix!,
                height: 18,
                width: 18,
                color: notifire?.geticoncolor,
              )),
            )
          : const SizedBox(),
    ),
  );
}
