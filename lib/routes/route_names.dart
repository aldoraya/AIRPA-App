import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_app/modules/login/login_screen.dart';
import 'package:penyewaan_gedung_app/modules/login/sign_up_screen.dart';
import 'package:penyewaan_gedung_app/modules/login/forgot_password.dart';
import 'package:penyewaan_gedung_app/modules/bottom_tab/bottom_tab_screen.dart';
import 'package:penyewaan_gedung_app/modules/gedung_detailes/search_screen.dart';
import 'package:penyewaan_gedung_app/modules/gedung_reservation/gedung_home_screen.dart';
import 'package:penyewaan_gedung_app/modules/gedung_reservation/filter_screen/filters_screen.dart';
import 'package:penyewaan_gedung_app/modules/gedung_detailes/review_list_screen.dart';
import 'package:penyewaan_gedung_app/models/gedung_list_data.dart';
import 'package:penyewaan_gedung_app/models/gedung_model.dart';
import 'package:penyewaan_gedung_app/modules/gedung_detailes/gedung_detailes.dart';
import 'package:penyewaan_gedung_app/modules/profile/edit_profile.dart';
import 'package:penyewaan_gedung_app/modules/profile/settings_screen.dart';
import 'package:penyewaan_gedung_app/modules/profile/help_center_screen.dart';
import 'package:penyewaan_gedung_app/modules/profile/invite_screen.dart';
import 'package:penyewaan_gedung_app/modules/profile/country_screen.dart';
import 'package:penyewaan_gedung_app/modules/profile/how_do_screen.dart';
import 'package:penyewaan_gedung_app/modules/login/change_password.dart';
import 'package:penyewaan_gedung_app/modules/forms_booking/booking_screen.dart';
import 'package:penyewaan_gedung_app/modules/gedung_detailes/room_booking_screen.dart';
import 'package:penyewaan_gedung_app/modules/splash/splash_screen.dart';
import 'package:penyewaan_gedung_app/modules/splash/introduction_screen.dart';
import 'package:penyewaan_gedung_app/modules/admin/users/users_screen.dart';
import 'package:penyewaan_gedung_app/modules/admin/gedung/gedung_screen.dart';
import 'package:penyewaan_gedung_app/modules/admin/booking/bookings_screen.dart';
import 'package:penyewaan_gedung_app/modules/admin/admin_screen.dart';
import 'package:penyewaan_gedung_app/modules/admin/login_screen.dart';

class NavigationServices {
  NavigationServices(this.context);

  final BuildContext context;

  Future<dynamic> _pushMaterialPageRoute(Widget widget,
      {bool fullscreenDialog = false}) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => widget, fullscreenDialog: fullscreenDialog),
    );
  }

  // void gotoSplashScreen() {
  //   Navigator.pushNamedAndRemoveUntil(
  //       context, RoutesName.splash, (Route<dynamic> route) => false);
  // }

  Future<dynamic> gotoSplashScreen() async {
    return await _pushMaterialPageRoute(const SplashScreen());
  }

  // void gotoIntroductionScreen() {
  //   Navigator.pushNamedAndRemoveUntil(context, RoutesName.introductionScreen,
  //       (Route<dynamic> route) => false);
  // }

  Future<dynamic> gotoIntroductionScreen() async {
    return await _pushMaterialPageRoute(const IntroductionScreen());
  }

  Future<dynamic> gotoLoginScreen() async {
    return await _pushMaterialPageRoute(const LoginScreen());
  }

  Future<dynamic> gotoSignScreen() async {
    return await _pushMaterialPageRoute(const SignUpScreen());
  }

  Future<dynamic> gotoForgotPassword() async {
    return await _pushMaterialPageRoute(const ForgotPasswordScreen());
  }

  Future<dynamic> gotoTabScreen() async {
    return await _pushMaterialPageRoute(const BottomTabScreen());
  }

  Future<dynamic> gotoSearchScreen() async {
    return await _pushMaterialPageRoute(const SearchScreen());
  }

  Future<dynamic> gotoGedungHomeScreen() async {
    return await _pushMaterialPageRoute(const GedungHomeScreen());
  }

  Future<dynamic> gotoFiltersScreen() async {
    return await _pushMaterialPageRoute(const FiltersScreen());
  }

  Future<dynamic> gotoGedungDetailes(GedungListData gedungData) async {
    return await _pushMaterialPageRoute(GedungDetailes(
      gedungData: gedungData,
    ));
  }

  Future<dynamic> gotoRoomBookingScreen() async {
    return await _pushMaterialPageRoute(const RoomBookingScreen());
  }

  Future<dynamic> gotoReviewsListScreen() async {
    return await _pushMaterialPageRoute(const ReviewsListScreen());
  }

  Future<dynamic> gotoEditProfile() async {
    return await _pushMaterialPageRoute(const EditProfile());
  }

  Future<dynamic> gotoSettingsScreen() async {
    return await _pushMaterialPageRoute(const SettingsScreen());
  }

  Future<dynamic> gotoHeplCenterScreen() async {
    return await _pushMaterialPageRoute(const HelpCenterScreen());
  }

  Future<dynamic> gotoChangepasswordScreen() async {
    return await _pushMaterialPageRoute(const ChangePasswordScreen());
  }

  Future<dynamic> gotoInviteFriend() async {
    return await _pushMaterialPageRoute(const InviteFriend());
  }

  Future<dynamic> gotoCountryScreen() async {
    return await _pushMaterialPageRoute(const CountryScreen(),
        fullscreenDialog: true);
  }

  Future<dynamic> gotoHowDoScreen() async {
    return await _pushMaterialPageRoute(const HowDoScreen());
  }

  Future<dynamic> gotoBookingScreen(GedungListData gedungData) async {
    return await _pushMaterialPageRoute(BookingScreen(
      gedungData: gedungData,
    ));
  }

  Future<dynamic> gotoUsersScreen() async {
    return await _pushMaterialPageRoute(const UsersScreen());
  }

  Future<dynamic> gotoAdminScreen() async {
    return await _pushMaterialPageRoute(const AdminScreen());
  }

   Future<dynamic> gotoGedungScreen() async {
    return await _pushMaterialPageRoute(const GedungScreen());
  }

   Future<dynamic> gotoLoginAdminScreen() async {
    return await _pushMaterialPageRoute(const AdminLoginScreen());
  }

  Future<dynamic> gotoBookingsScreen() async {
    return await _pushMaterialPageRoute(const BookingsScreen());
  }
}
