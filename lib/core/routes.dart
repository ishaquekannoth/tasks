import 'package:get/get.dart';
import 'package:task/presentation/pages/categories/binding/category_binding.dart';
import 'package:task/presentation/pages/categories/category_view.dart';
import 'package:task/presentation/pages/category_listing/binding/category_listing_binding.dart';
import 'package:task/presentation/pages/category_listing/category_listing_screen.dart';
import 'package:task/presentation/pages/edit_profile/binding/edit_profile_binding.dart';
import 'package:task/presentation/pages/edit_profile/edit_profile_screen.dart';
import 'package:task/presentation/pages/home_screen/bindings/home_binding.dart';
import 'package:task/presentation/pages/home_screen/home_view.dart';
import 'package:task/presentation/pages/home_screen/product_details.dart';
import 'package:task/presentation/pages/login/binding/login_binding.dart';
import 'package:task/presentation/pages/login/login_view.dart';
import 'package:task/presentation/pages/main_displayer/binding/main_screen_binding.dart';
import 'package:task/presentation/pages/main_displayer/main_displayer_view.dart';
import 'package:task/presentation/pages/on_boarding/bindings/on_board_binding.dart';
import 'package:task/presentation/pages/profile/binding/profile_binding.dart';
import 'package:task/presentation/pages/profile/profile_view.dart';
import 'package:task/presentation/pages/sign_up/binding/sign_up_binding.dart';
import 'package:task/presentation/pages/sign_up/sign_up_view.dart';

import '../presentation/pages/on_boarding/onboarding.dart';
import '../presentation/pages/splash_screen/splash_screen.dart';

class Routes {
  static const splashScreen = '/splashScreen';
  static const onBoard = '/onBoard';
  static const homeScreen = '/homeScreen';
  static const loginScreen = '/loginScreen';
  static const signUpScreen = '/signUpScreen';
  static const mainDisplayer = '/mainDisplayer';
  static const productDetails = '/productDetails';
  static const profileScreen = '/profileScreen';
  static const editProfileScreen = '/editProfileScreen';
  static const categoryView = '/categoryView';
  static const categoryListingScreen = '/categoryListingScreen';
}

class AppPages {
  static var pages = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
        name: Routes.onBoard,
        page: () => const OnBoard(),
        binding: OnBoardBinding()),
    GetPage(
        name: Routes.homeScreen,
        page: () => const HomeView(),
        binding: HomeBinding()),
    GetPage(
        name: Routes.loginScreen,
        page: () => const LoginScreen(),
        binding: LoginBinding()),
    GetPage(
        name: Routes.signUpScreen,
        page: () => const SignUpScreen(),
        binding: SignUpBinding()),
    GetPage(
        name: Routes.mainDisplayer,
        page: () => const MainDisplayerView(),
        binding: MainDisplayerBinding()),
    GetPage(
      name: Routes.productDetails,
      page: () => const ProductDetailsPage(),
    ),
    GetPage(
        name: Routes.profileScreen,
        page: () => ProfileView(),
        binding: ProfileBinding()),
    GetPage(
        name: Routes.editProfileScreen,
        page: () => const EditProfileView(),
        binding: EditProfileBinding()),
    GetPage(
        name: Routes.categoryView,
        page: () => const CategoryView(),
        binding: CategoryBinding()),
    GetPage(
        name: Routes.categoryListingScreen,
        page: () => const CategoryListingView(),
        binding: CategoryListingBinding()),
  ];
}
