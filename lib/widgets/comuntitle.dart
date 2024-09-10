// ignore_for_file: deprecated_member_use


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../appstaticdata/staticdata.dart';

import '../provider/provide_colors.dart';
import '../staticdata.dart';

class ComunTitle extends StatefulWidget {
  final String title;
  final String path;
  const ComunTitle({super.key, required this.title, required this.path});

  @override
  State<ComunTitle> createState() => _ComunTitleState();
}

class _ComunTitleState extends State<ComunTitle> {
  final AppConst controller = Get.put(AppConst());
  @override
  Widget build(BuildContext context) {
    return   LayoutBuilder(
        builder: (context, constraints){
          return Consumer<ColorNotifire>(
            builder: (context, value, child) => GetBuilder<AppConst>(
                builder: (context) {
                  return Padding(
                    padding:  const EdgeInsets.only(left: 15,right: 15),
                    child:  Container(
                      // color: Colors.blue,
                      height: 25,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Wrap(
                                runSpacing: 5,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller.changePage(0);
                                    },
                                    child: SvgPicture.asset("assets/home.svg",height: constraints.maxWidth < 600 ? 14:16,width: constraints.maxWidth < 600 ? 14:16,color: notifire?.getMainText ),),
                                  Text('   /   ${widget.path}   /  ',style: mediumBlackTextStyle.copyWith(color: notifire?.getMainText,fontSize: constraints.maxWidth < 600 ? 12:14),overflow: TextOverflow.ellipsis),
                                  Text(widget.title,style: mediumGreyTextStyle.copyWith(color: appMainColor,fontSize: constraints.maxWidth < 600 ? 12:14),overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                            Text("",style: constraints.maxWidth < 600 ?
                            mainTextStyle.copyWith(fontSize: 12,color: notifire?.getMainText) :
                            mainTextStyle.copyWith(fontSize: 14,color: notifire?.getMainText),overflow: TextOverflow.ellipsis,),

                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          );
        }
    );

  }

  _getAlertFontSize(AppConst context) {
    var currentLocale = Get.locale;
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 15;
    } else {
      // Font size for English
      return 20;
    }
  }

  _getAlertFontMobileSize(AppConst context) {
    var currentLocale = Get.locale;
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 7;
    } else {
      // Font size for English
      return 12;
    }
  }

}
