import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:penyewaan_gedung_app/constants/helper.dart';
import 'package:penyewaan_gedung_app/constants/text_styles.dart';
import 'package:penyewaan_gedung_app/constants/themes.dart';
import 'package:penyewaan_gedung_app/language/app_localizations.dart';
import 'package:penyewaan_gedung_app/modules/gedung_detailes/review_data_view.dart';
import 'package:penyewaan_gedung_app/routes/route_names.dart';
import 'package:penyewaan_gedung_app/widgets/common_button.dart';
import 'package:penyewaan_gedung_app/widgets/common_card.dart';
import '../../models/gedung_list_data.dart';
import 'gedung_roome_list.dart';
import 'rating_view.dart';
import 'package:penyewaan_gedung_app/constants/currency_format.dart';

class GedungDetailes extends StatefulWidget {
  final GedungListData gedungData;

  const GedungDetailes({Key? key, required this.gedungData}) : super(key: key);
  
  @override
  State<GedungDetailes> createState() => _GedungDetailesState();
}

class _GedungDetailesState extends State<GedungDetailes>
    with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController(initialScrollOffset: 0);
  bool isFav = false;
  bool isReadless = false;
  late AnimationController animationController;
  var imageHieght = 0.0;
  late AnimationController _animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 0), vsync: this);
    animationController.forward();
    scrollController.addListener(() {
      if (mounted) {
        if (scrollController.offset < 0) {
          // we static set the just below half scrolling values
          _animationController.animateTo(0.0);
        } else if (scrollController.offset > 0.0 &&
            scrollController.offset < imageHieght) {
          // we need around half scrolling values
          if (scrollController.offset < ((imageHieght / 1.2))) {
            _animationController
                .animateTo((scrollController.offset / imageHieght));
          } else {
            // we static set the just above half scrolling values "around == 0.22"
            _animationController.animateTo((imageHieght / 1.2) / imageHieght);
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  imageHieght = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CommonCard(
            radius: 0,
            color: AppTheme.scaffoldBackgroundColor,
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.only(top: 24 + imageHieght),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  // Hotel title and animation view
                  child: getGedungDetails(isInList: true),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Divider(
                    height: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          Locs.alized.summary,
                          style: TextStyles(context).getBoldStyle().copyWith(
                                fontSize: 14,
                                letterSpacing: 0.5,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 4, bottom: 8),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: !isReadless ? widget.gedungData.desc1 : widget.gedungData.desc2,
                          style: TextStyles(context)
                              .getDescriptionStyle()
                              .copyWith(
                                fontSize: 14,
                              ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text: !isReadless
                              ? Locs.alized.read_more
                              : Locs.alized.less,
                          style: TextStyles(context).getRegularStyle().copyWith(
                              color: AppTheme.primaryColor, fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                isReadless = !isReadless;
                              });
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 8,
                    bottom: 16,
                  ),
                  // overall rating view
                  child: RatingView(gedungData: widget.gedungData),
                ),
                _getPhotoReviewUi(Locs.alized.room_photo, Locs.alized.view_all,
                    Icons.arrow_forward, () {
                  NavigationServices(context).gotoRoomBookingScreen();
                }),

                // Hotel inside photo view
                const GedungRoomeList(),
                _getPhotoReviewUi(Locs.alized.reviews, Locs.alized.view_all,
                    Icons.arrow_forward, () {
                  NavigationServices(context).gotoReviewsListScreen();
                }),

                // feedback&Review data view
                for (var i = 0; i < 2; i++)
                  ReviewsView(
                    reviewsList: GedungListData.reviewsList[i],
                    animation: animationController,
                    animationController: animationController,
                    callback: () {},
                  ),

                const SizedBox(
                  height: 16,
                ),
                 Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Detail Lokasi',
                          style: TextStyles(context).getBoldStyle().copyWith(
                                fontSize: 14,
                                letterSpacing: 0.5,
                              ),
                        ),
                      ),
                    ],
                  ),
                 ),
                 Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 4, bottom: 8),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.gedungData.locationTxt,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 16, top: 16),
                  child: CommonButton(
                    buttonText: Locs.alized.book_now,
                    onTap: () {
                      NavigationServices(context)
                          .gotoBookingScreen(GedungListData(subImage: []));
                    },
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                ),
              ],
            ),
          ),

          // backgrouund image and Hotel name and thier details and more details animation view
          _backgraoundImageUI(widget.gedungData),

          // Arrow back Ui
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: SizedBox(
              height: AppBar().preferredSize.height,
              child: Row(
                children: <Widget>[
                  _getAppBarUi(Theme.of(context).disabledColor.withOpacity(0.4),
                      Icons.arrow_back, AppTheme.backgroundColor, () {
                    if (scrollController.offset != 0.0) {
                      scrollController.animateTo(0.0,
                          duration: const Duration(milliseconds: 480),
                          curve: Curves.easeInOutQuad);
                    } else {
                      Navigator.pop(context);
                    }
                  }),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  // like and unlike view
                  _getAppBarUi(
                      AppTheme.backgroundColor,
                      isFav ? Icons.favorite : Icons.favorite_border,
                      AppTheme.primaryColor, () {
                    setState(() {
                      isFav = !isFav;
                    });
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getAppBarUi(
      Color color, IconData icon, Color iconcolor, VoidCallback onTap) {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: Container(
          width: AppBar().preferredSize.height - 8,
          height: AppBar().preferredSize.height - 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(
                Radius.circular(32.0),
              ),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon, color: iconcolor),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getPhotoReviewUi(
      String title, String view, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: TextStyles(context).getBoldStyle().copyWith(
                    fontSize: 14,
                  ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      view,
                      textAlign: TextAlign.left,
                      style: TextStyles(context).getBoldStyle().copyWith(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    SizedBox(
                      height: 38,
                      width: 26,
                      child: Icon(
                        icon,
                        //Icons.arrow_forward,
                        size: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _backgraoundImageUI(GedungListData gedungData) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          var opecity = 1.0 -
              (_animationController.value >= ((imageHieght / 1.2) / imageHieght)
                  ? 1.0
                  : _animationController.value);
          return SizedBox(
            height: imageHieght * (1.0 - _animationController.value),
            child: Stack(
              children: <Widget>[
                IgnorePointer(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        top: 0,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            gedungData.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).padding.bottom + 16,
                  left: 0,
                  right: 0,
                  child: Opacity(
                    opacity: opecity,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24)),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                color: Colors.black12,
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16, top: 8),
                                      child: getGedungDetails(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          bottom: 16,
                                          top: 16),
                                      child: CommonButton(
                                          buttonText: Locs.alized.book_now,
                                          onTap: () {
                                            NavigationServices(context)
                                                .gotoBookingScreen(GedungListData(subImage: []));
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24)),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                color: Colors.black12,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.2),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(38)),
                                    onTap: () {
                                      try {
                                        scrollController.animateTo(
                                            MediaQuery.of(context).size.height -
                                                MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    5,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.fastOutSlowIn);
                                      } catch (_) {}
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 4,
                                          bottom: 4),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            Locs.alized.more_details,
                                            style: TextStyles(context)
                                                .getBoldStyle()
                                                .copyWith(
                                                  color: Colors.white,
                                                ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(top: 2),
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget getGedungDetails({bool isInList = false}) {

  var reviewList = GedungListData.reviewsList;
  int jumlahreview = reviewList.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.gedungData.titleTxt,
                textAlign: TextAlign.left,
                style: TextStyles(context).getBoldStyle().copyWith(
                      fontSize: 22,
                      color: isInList ? AppTheme.fontcolor : Colors.white,
                    ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.gedungData.subTxt,
                    style: TextStyles(context).getRegularStyle().copyWith(
                          fontSize: 14,
                          color: isInList
                              ? Theme.of(context).disabledColor.withOpacity(0.5)
                              : Colors.white,
                        ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Icon(
                    FontAwesomeIcons.locationDot,
                    size: 12,
                    color: AppTheme.primaryColor,
                  ),
                  Text(
                    widget.gedungData.dist.toStringAsFixed(1),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles(context).getRegularStyle().copyWith(
                          fontSize: 14,
                          color: isInList
                              ? Theme.of(context).disabledColor.withOpacity(0.5)
                              : Colors.white,
                        ),
                  ),
                  Expanded(
                    child: Text(
                      Locs.alized.km_to_city,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles(context).getRegularStyle().copyWith(
                            fontSize: 14,
                            color: isInList
                                ? Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.5)
                                : Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
              isInList
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: <Widget>[
                          Helper.ratingStar(),
                          Text(
                            jumlahreview.toString(),
                            style:
                                TextStyles(context).getRegularStyle().copyWith(
                                      fontSize: 14,
                                      color: isInList
                                          ? Theme.of(context)
                                              .disabledColor
                                              .withOpacity(0.5)
                                          : Colors.white,
                                    ),
                          ),
                          Text(
                            Locs.alized.reviews,
                            style:
                                TextStyles(context).getRegularStyle().copyWith(
                                      fontSize: 14,
                                      color: isInList
                                          ? Theme.of(context).disabledColor
                                          : Colors.white,
                                    ),
                          ),
                        ],
                      ),
                    ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    CurrencyFormat.convertToIdr((widget.gedungData.perDay)),
                    textAlign: TextAlign.left,
                    style: TextStyles(context).getBoldStyle().copyWith(
                          fontSize: 22,
                          color: isInList
                              ? Theme.of(context).textTheme.bodyLarge!.color
                              : Colors.white,
                        ),
                  ),
                  Text(
                    Locs.alized.per_day,
                    style: TextStyles(context).getRegularStyle().copyWith(
                          fontSize: 22,
                          color: isInList
                              ? Theme.of(context).disabledColor
                              : Colors.white,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
