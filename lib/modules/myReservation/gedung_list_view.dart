import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:penyewaan_gedung_app/constants/helper.dart';
import 'package:penyewaan_gedung_app/constants/text_styles.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/models/gedung_list_data.dart';
import 'package:penyewaan_gedung_app/widgets/common_card.dart';
import 'package:penyewaan_gedung_app/widgets/list_cell_animation_view.dart';
import 'package:penyewaan_gedung_app/constants/currency_format.dart';

class GedungListView extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final GedungListData gedungData;
  final AnimationController animationController;
  final Animation<double> animation;

  const GedungListView(
      {Key? key,
      required this.gedungData,
      required this.animationController,
      required this.animation,
      required this.callback,
      this.isShowDate = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

  var reviewList = GedungListData.reviewsList;
  int jumlahreview = reviewList.length;

    return ListCellAnimationView(
      animation: animation,
      animationController: animationController,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
        child: Column(
          children: <Widget>[
            isShowDate
                ? Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${Helper.getDateText(gedungData.date!)}, ',
                          style: TextStyles(context)
                              .getRegularStyle()
                              .copyWith(fontSize: 14),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 2.0),
                        //   child: Text(
                        //     Helper.getRoomText(gedungData.roomData!),
                        //     style: TextStyles(context)
                        //         .getRegularStyle()
                        //         .copyWith(fontSize: 14),
                        //   ),
                        // ),
                      ],
                    ),
                  )
                : const SizedBox(),
            CommonCard(
              color: AppTheme.backgroundColor,
              radius: 16,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 2,
                          child: Image.asset(
                            gedungData.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, top: 8, bottom: 8, right: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      gedungData.titleTxt,
                                      textAlign: TextAlign.left,
                                      style: TextStyles(context)
                                          .getBoldStyle()
                                          .copyWith(fontSize: 22),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          gedungData.subTxt,
                                          style: TextStyles(context)
                                              .getDescriptionStyle(),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.locationDot,
                                          size: 12,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        Text(
                                          gedungData.dist.toStringAsFixed(1),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyles(context)
                                              .getDescriptionStyle(),
                                        ),
                                        Expanded(
                                          child: Text(
                                            Locs.alized.km_to_city,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyles(context)
                                                .getDescriptionStyle()
                                                .copyWith(
                                                  fontSize: 14,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Row(
                                        children: <Widget>[
                                          Helper.ratingStar(),
                                          Text(
                                            jumlahreview.toString(),
                                            style: TextStyles(context)
                                                .getDescriptionStyle().
                                                copyWith(fontSize: 14),
                                          ),
                                          Text(
                                            Locs.alized.reviews,
                                            style: TextStyles(context)
                                                .getDescriptionStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 16, top: 8, left: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                   CurrencyFormat.convertToIdr((gedungData.perDay)),
                                    textAlign: TextAlign.left,
                                    style: TextStyles(context)
                                        .getBoldStyle()
                                        .copyWith(fontSize: 14),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: Get.find<Locs>().isRTL ? 2.0 : 0.0),
                                    child: Text(
                                      Locs.alized.per_day,
                                      style: TextStyles(context)
                                          .getDescriptionStyle(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      bottom: 0,
                      left: 0,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor:
                                Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                            onTap: () {
                              try {
                                callback();
                              } catch (_) {}
                            }),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            shape: BoxShape.circle),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(32.0),
                            ),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.favorite_border,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}