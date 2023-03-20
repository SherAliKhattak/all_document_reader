import 'dart:developer';
import 'package:all_document_reader/ui/components/file_card.dart';
import 'package:all_document_reader/ui/components/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/favorites_controller.dart';
import '../../language_Constants/language_constants.dart';
import '../../local_storage/local_db.dart';
import 'flutter_toast.dart';

class BottomSheets {
  static favoritesBottomSheet({
    String? file,
  }) {
    return Get.bottomSheet(
        GetBuilder<FavoritesController>(builder: (favoritesController) {
      return StatefulBuilder(builder: (context, StateSetter setState) {
        return Container(
          height: Get.height * 0.35,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35))),
          child: ListView(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    height: Get.height * 0.08,
                    width: Get.width * 0.15,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Images.pdf), fit: BoxFit.cover)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width * 0.65,
                        child: Text(
                          file!.split('/').last.toString(),
                          style: TextStyle(
                              fontFamily: 'fonts/Roboto-Medium.ttf',
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).secondaryHeaderColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Row(
                        children: [
                          Text(
                            DateFormat.yMMMMEEEEd().format(DateTime.now()),
                            style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              IconTextListTile(
                  onTap: () async {
                    if (favoritesController.favoriteFiles.contains(file)) {
                      favoritesController.removefromFavorites(file);

                      Get.back();

                      showToast(
                          label: 'File removed from Favorites',
                          backgroundColor: Colors.red);
                    } else {}
                    await Preferences()
                        .saveFavoritesList(favoritesController.favoriteFiles);

                    log(favoritesController.favoriteFiles.toString());
                    setState(
                      () {},
                    );
                  },
                  icon: Icons.favorite,
                  text: translation(context).removeFromFavorites,
                  iconColor: Colors.red),
              SizedBox(
                height: Get.height * 0.01,
              ),
              GestureDetector(
                onTap: () {
                  // HomePageUtils.sharePDF(fileName: file.split('/').last.toString());
                },
                child: IconTextListTile(
                  icon: Icons.share,
                  text: translation(context).share,
                ),
              ),
            ],
          ),
        );
      });
    }));
  }
}
