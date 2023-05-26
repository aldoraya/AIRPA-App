import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:penyewaan_gedung_app/constants/helper.dart';
import 'package:penyewaan_gedung_app/constants/text_styles.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/models/gedung_list_data.dart';
import 'package:penyewaan_gedung_app/widgets/common_card.dart';
import 'package:penyewaan_gedung_app/constants/currency_format.dart';

class MapGedungListView extends StatelessWidget {
  final VoidCallback callback;
  final GedungListData gedungData;

  const MapGedungListView(
      {Key? key, required this.gedungData, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 8, top: 8, bottom: 16),
      child: CommonCard(
        color: AppTheme.scaffoldBackgroundColor,
        radius: 16,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          child: AspectRatio(
            aspectRatio: 2.7,
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 0.90,
                      child: Image.asset(
                        gedungData.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              gedungData.titleTxt,
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              style:
                                  TextStyles(context).getBoldStyle().copyWith(
                                        fontSize: 16,
                                      ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              gedungData.subTxt,
                              style: TextStyles(context)
                                  .getDescriptionStyle()
                                  .copyWith(
                                    fontSize: 14,
                                  ),
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.locationDot,
                                          size: 12,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        Text(
                                          " ${gedungData.dist.toStringAsFixed(1)}",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyles(context)
                                              .getDescriptionStyle()
                                              .copyWith(
                                                fontSize: 14,
                                              ),
                                        ),
                                        Text(
                                          Locs.alized.km_to_city,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyles(context)
                                              .getDescriptionStyle()
                                              .copyWith(
                                                fontSize: 14,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Helper.ratingStar(),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                         CurrencyFormat.convertToIdr((gedungData.perDay)),
                                        textAlign: TextAlign.left,
                                        style: TextStyles(context)
                                            .getBoldStyle()
                                            .copyWith(
                                              fontSize: 14,
                                            ),
                                      ),
                                      Text(
                                        Locs.alized.per_day,
                                        style: TextStyles(context)
                                            .getDescriptionStyle()
                                            .copyWith(
                                              fontSize: 14,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor:
                        Theme.of(context).primaryColor.withOpacity(0.1),
                    onTap: () {
                      callback();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}