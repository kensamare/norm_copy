// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gms;

// Project imports:
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/domain/models/career/career.dart';
import 'package:norm/domain/models/circle/circle.dart';
import 'package:norm/domain/models/contact/contact.dart';
import 'package:norm/domain/models/create_entity_result/create_entity_result.dart';
import 'package:norm/domain/models/interfaces/profile.dart';
import 'package:norm/domain/models/item/item.dart';
import 'package:norm/domain/models/picked_location/picked_location.dart';
import 'package:norm/domain/models/portfolio/portfolio.dart';
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/page_providers/brand_page/brand_page.dart';
import 'package:norm/internal/page_providers/catalog_page/catalog_page.dart';
import 'package:norm/internal/page_providers/create_brand_page/create_brand_page.dart';
import 'package:norm/internal/page_providers/create_item_page/create_item_page.dart';
import 'package:norm/internal/page_providers/create_portfolio_page/create_portfolio_page.dart';
import 'package:norm/internal/page_providers/create_profession_page/create_profession_page.dart';
import 'package:norm/internal/page_providers/edit_brand_contacts_page/edit_brand_contacts_page.dart';
import 'package:norm/internal/page_providers/edit_brand_initial_page/edit_brand_initial_page.dart';
import 'package:norm/internal/page_providers/edit_brand_main_information_page/edit_brand_main_information_page.dart';
import 'package:norm/internal/page_providers/edit_brand_page/edit_brand_page.dart';
import 'package:norm/internal/page_providers/edit_brand_portfolio_page/edit_brand_portfolio_page.dart';
import 'package:norm/internal/page_providers/edit_brand_shop_page/edit_brand_shop_page.dart';
import 'package:norm/internal/page_providers/edit_contacts_page/edit_contacts_page.dart';
import 'package:norm/internal/page_providers/edit_extended_information_animals_page/edit_extended_information_animals_page.dart';
import 'package:norm/internal/page_providers/edit_extended_information_career_page/edit_extended_information_career_page.dart';
import 'package:norm/internal/page_providers/edit_extended_information_education_page/edit_extended_information_education_page.dart';
import 'package:norm/internal/page_providers/edit_extended_information_hobby_page/edit_extended_information_hobby_page.dart';
import 'package:norm/internal/page_providers/edit_extended_information_initial_page/edit_extended_information_initial_page.dart';
import 'package:norm/internal/page_providers/edit_extended_information_languages_page/edit_extended_information_languages_page.dart';
import 'package:norm/internal/page_providers/edit_extended_information_page/edit_extended_information_page.dart';
import 'package:norm/internal/page_providers/edit_main_information_page/edit_main_information_page.dart';
import 'package:norm/internal/page_providers/edit_phone_number_page/edit_phone_number_page.dart';
import 'package:norm/internal/page_providers/edit_portfolio_page/edit_portfolio_page.dart';
import 'package:norm/internal/page_providers/edit_profile_page/edit_profile_page.dart';
import 'package:norm/internal/page_providers/edit_shop_page/edit_shop_page.dart';
import 'package:norm/internal/page_providers/edit_specialities_page/edit_specialities_page.dart';
import 'package:norm/internal/page_providers/edit_speciality_contacts_page/edit_speciality_contacts_page.dart';
import 'package:norm/internal/page_providers/edit_speciality_initial_page/edit_speciality_initial_page.dart';
import 'package:norm/internal/page_providers/edit_speciality_main_information_page/edit_speciality_main_information_page.dart';
import 'package:norm/internal/page_providers/edit_speciality_page/edit_speciality_page.dart';
import 'package:norm/internal/page_providers/edit_speciality_portfolio_page/edit_speciality_portfolio_page.dart';
import 'package:norm/internal/page_providers/edit_speciality_shop_page/edit_speciality_shop_page.dart';
import 'package:norm/internal/page_providers/empty_page/empty_page.dart';
import 'package:norm/internal/page_providers/extended_information_page/extended_information_page.dart';
import 'package:norm/internal/page_providers/feed_page/feed_page.dart';
import 'package:norm/internal/page_providers/karma_history_page/karma_history_page.dart';
import 'package:norm/internal/page_providers/karma_initial_page/karma_initial_page.dart';
import 'package:norm/internal/page_providers/karma_page_wrapper/karma_page_wrapper.dart';
import 'package:norm/internal/page_providers/grade_person_page/grade_person_page.dart';
import 'package:norm/internal/page_providers/login_page/login_page.dart';
import 'package:norm/internal/page_providers/main_page/main_page.dart';
import 'package:norm/internal/page_providers/profile_circles_page/profile_circles_page.dart';
import 'package:norm/internal/page_providers/profile_circles_page_wrapper/profile_circles_page_wrapper.dart';
import 'package:norm/internal/page_providers/profile_circles_users_page/profile_circles_users_page.dart';
import 'package:norm/internal/page_providers/profile_page/profile_page.dart';
import 'package:norm/internal/page_providers/profile_page_wrapper/profile_page_wrapper.dart';
import 'package:norm/internal/page_providers/registration_invitation_code_page/registration_invitation_code_page.dart';
import 'package:norm/internal/page_providers/registration_phone_code_confirmation_page/registration_phone_code_confirmation_page.dart';
import 'package:norm/internal/page_providers/registration_phone_confirmation_page/registration_phone_confirmation_page.dart';
import 'package:norm/internal/page_providers/registration_request_page/registration_request_page.dart';
import 'package:norm/internal/page_providers/registration_request_page_wrapper/registration_request_page_wrapper.dart';
import 'package:norm/internal/page_providers/request_confirmation_page/request_confirmation_page.dart';
import 'package:norm/internal/page_providers/request_email_page/request_email_page.dart';
import 'package:norm/internal/page_providers/request_speciality_page/request_speciality_page.dart';
import 'package:norm/internal/page_providers/self_profile_page/self_profile_page.dart';
import 'package:norm/internal/page_providers/speciality_page/speciality_page.dart';
import 'package:norm/internal/page_providers/splash_screen/splash_screen_page.dart';
import 'package:norm/internal/page_providers/user_connect_telegram_and_phone_page/user_connect_telegram_and_phone_page.dart';
import 'package:norm/internal/page_providers/user_invitation_access_contacts_page/user_invitation_access_contacts_page.dart';
import 'package:norm/internal/page_providers/user_invitation_confirmation_page/user_invitation_confirmation_page.dart';
import 'package:norm/internal/page_providers/user_invitation_form_page/user_invitation_form_page.dart';
import 'package:norm/internal/page_providers/user_invitation_form_wrapper/user_invitation_form_wrapper.dart';
import 'package:norm/internal/page_providers/user_invitation_registration_page/user_invitation_registration_page.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/contacts_popup/contacts_popup.dart';
import 'package:norm/presentation/global/create_popups/career_popup/career_popup.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/options_bottom_sheet/bottom_sheet_option.dart';
import 'package:norm/presentation/global/options_bottom_sheet/options_bottom_sheet.dart';
import 'package:norm/presentation/global/pick_image_popup/pick_image_popup.dart';
import 'package:norm/presentation/global/pick_image_popup/state/pick_image_state.dart';
import 'package:norm/presentation/global/pick_location_popup/pick_location_popup.dart';

part 'app_router.gr.dart';

const List<AutoRoute<dynamic>> _profileSubroutes = [
  AutoRoute(page: ProfilePage, initial: true),
  AutoRoute(
    page: KarmaPageWrapper,
    path: KarmaPageWrapper.routeName,
    children: [
      AutoRoute(page: KarmaInitialPage, initial: true),
      AutoRoute(page: KarmaHistoryPage, path: KarmaHistoryPage.routeName),
    ],
  ),
];

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: SplashScreenPage, initial: true),
    AutoRoute(page: LoginPage, path: LoginPage.routeName),
    AutoRoute(page: RegistrationInvitationCodePage, path: RegistrationInvitationCodePage.routeName),

    // Request form wrapper.
    AutoRoute(
      page: RegistrationRequestPageWrapper,
      path: RegistrationRequestPageWrapper.routeName,
      children: [
        AutoRoute(page: RegistrationRequestPage, path: RegistrationRequestPage.routeName, initial: true),
        AutoRoute(page: RequestEmailPage, path: RequestEmailPage.routeName),
        AutoRoute(page: RequestSpecialityPage, path: RequestSpecialityPage.routeName),
      ],
    ),

    AutoRoute(page: RequestConfirmationPage, path: RequestConfirmationPage.routeName),
    AutoRoute(page: UserInvitationConfirmationPage, path: UserInvitationConfirmationPage.routeName),

    AutoRoute(
      page: UserInvitationFormPageWrapper,
      path: UserInvitationFormPageWrapper.routeName,
      children: [
        AutoRoute(page: UserInvitationFormPage, path: UserInvitationFormPage.routeName, initial: true),
        AutoRoute(page: UserInvitationRegistrationPage, path: UserInvitationRegistrationPage.routeName),
      ],
    ),

    AutoRoute(page: UserConnectTelegramAndPhonePage, path: UserConnectTelegramAndPhonePage.routeName),
    AutoRoute(page: UserInvitationAccessContactsPage, path: UserInvitationAccessContactsPage.routeName),
    AutoRoute<bool>(page: RegistrationPhoneConfirmationPage, path: RegistrationPhoneConfirmationPage.routeName),
    AutoRoute<bool>(page: RegistrationPhoneCodeConfirmationPage, path: RegistrationPhoneCodeConfirmationPage.routeName),

    // Main page route.
    AutoRoute(
      page: MainPage,
      path: MainPage.routeName,
      children: [
        AutoRoute(page: FeedPage, path: FeedPage.routeName, initial: true),
        AutoRoute(page: CatalogPage, path: CatalogPage.routeName),
        AutoRoute(
          page: SelfProfilePage,
          path: SelfProfilePage.routeName,
          maintainState: false,
          children: _profileSubroutes,
        ),
      ],
    ),

    // Profile route.
    AutoRoute(
      page: ProfilePageWrapper,
      path: '${ProfilePageWrapper.routeName}/:username',
      children: _profileSubroutes,
    ),

    // Edit profile route.
    AutoRoute(
      page: EditProfilePage,
      path: EditProfilePage.routeName,
    ),
    AutoRoute(
      page: EditMainInformationPage,
      path: EditMainInformationPage.routeName,
    ),
    AutoRoute(
      page: EditPhoneNumberPage,
      path: EditPhoneNumberPage.routeName,
    ),
    AutoRoute(
      page: EditContactsPage,
      path: EditContactsPage.routeName,
    ),
    AutoRoute(
      page: EditSpecialitiesPage,
      path: EditSpecialitiesPage.routeName,
    ),
    AutoRoute(
      page: EditPortfolioPage,
      path: EditPortfolioPage.routeName,
    ),
    AutoRoute(
      page: EditShopPage,
      path: EditShopPage.routeName,
    ),

    // Edit brand information.
    AutoRoute<Brand>(
      page: EditBrandPage,
      path: EditBrandPage.routeName,
      children: [
        AutoRoute<Brand>(page: EditBrandInitialPage, initial: true),
        AutoRoute<Brand>(page: EditBrandMainInformationPage, path: EditBrandMainInformationPage.routeName),
        AutoRoute<Brand>(page: EditBrandContactsPage, path: EditBrandContactsPage.routeName),
        AutoRoute<Brand>(page: EditBrandPortfolioPage, path: EditBrandPortfolioPage.routeName),
        AutoRoute<Brand>(page: EditBrandShopPage, path: EditBrandShopPage.routeName),
      ],
    ),

    // Edit speciality information.
    AutoRoute<Speciality>(
      page: EditSpecialityPage,
      path: EditSpecialityPage.routeName,
      children: [
        AutoRoute<Speciality>(page: EditSpecialityInitialPage, initial: true),
        AutoRoute<Speciality>(
            page: EditSpecialityMainInformationPage, path: EditSpecialityMainInformationPage.routeName),
        AutoRoute<Speciality>(page: EditSpecialityContactsPage, path: EditSpecialityContactsPage.routeName),
        AutoRoute<Speciality>(page: EditSpecialityPortfolioPage, path: EditSpecialityPortfolioPage.routeName),
        AutoRoute<Speciality>(page: EditSpecialityShopPage, path: EditSpecialityShopPage.routeName),
      ],
    ),

    // Extended information.
    AutoRoute(
      page: ExtendedInformationPage,
      path: ExtendedInformationPage.routeName,
    ),

    AutoRoute(
      page: EditExtendedInformationPage,
      path: EditExtendedInformationPage.routeName,
      children: [
        AutoRoute(page: EditExtendedInformationInitialPage, initial: true),
        AutoRoute(page: EditExtendedInformationLanguagesPage, path: EditExtendedInformationLanguagesPage.routeName),
        AutoRoute(page: EditExtendedInformationEducationPage, path: EditExtendedInformationEducationPage.routeName),
        AutoRoute(page: EditExtendedInformationCareerPage, path: EditExtendedInformationCareerPage.routeName),
        AutoRoute(page: EditExtendedInformationHobbyPage, path: EditExtendedInformationHobbyPage.routeName),
        AutoRoute(page: EditExtendedInformationAnimalsPage, path: EditExtendedInformationAnimalsPage.routeName),
      ],
    ),

    // Extended information redirect routes.
    RedirectRoute(
        path: EditExtendedInformationLanguagesPage.routeName,
        redirectTo: '${EditExtendedInformationPage.routeName}/${EditExtendedInformationLanguagesPage.routeName}'),
    RedirectRoute(
        path: EditExtendedInformationEducationPage.routeName,
        redirectTo: '${EditExtendedInformationPage.routeName}/${EditExtendedInformationEducationPage.routeName}'),
    RedirectRoute(
        path: EditExtendedInformationCareerPage.routeName,
        redirectTo: '${EditExtendedInformationPage.routeName}/${EditExtendedInformationCareerPage.routeName}'),
    RedirectRoute(
        path: EditExtendedInformationHobbyPage.routeName,
        redirectTo: '${EditExtendedInformationPage.routeName}/${EditExtendedInformationHobbyPage.routeName}'),
    RedirectRoute(
        path: EditExtendedInformationAnimalsPage.routeName,
        redirectTo: '${EditExtendedInformationPage.routeName}/${EditExtendedInformationAnimalsPage.routeName}'),

    // Profile circles.
    AutoRoute(
      page: ProfileCirclesPageWrapper,
      path: ProfileCirclesPageWrapper.routeName,
      children: [
        AutoRoute(page: ProfileCirclesPage, initial: true),
        AutoRoute(page: ProfileCirclesUsersPage, path: ProfileCirclesUsersPage.routeName),
      ],
    ),

    // Create profession.
    AutoRoute(page: CreateProfessionPage, path: CreateProfessionPage.routeName),

    // Create brand.
    AutoRoute(page: CreateBrandPage, path: CreateBrandPage.routeName),

    // Create portfolio.
    AutoRoute<Portfolio>(page: CreatePortfolioPage, path: CreatePortfolioPage.routeName),

    // Create item.
    AutoRoute<Item>(page: CreateItemPage, path: CreateItemPage.routeName),

    // Brand route.
    AutoRoute(page: BrandPage, path: '${BrandPage.routeName}/:id'),

    // Speciality route.
    AutoRoute(page: SpecialityPage, path: '${SpecialityPage.routeName}/:id'),

    // Grade/Rate person route.
    AutoRoute(page: GradePersonPage, path: GradePersonPage.routeName),

    // Empty page route.
    AutoRoute(page: EmptyPage, path: EmptyPage.routeName),
  ],
)
class AppRouter extends _$AppRouter {
  void replaceWithSplashScreen() {
    popUntilRoot();
    replace(const SplashScreenRoute());
  }

  /// Replaces current route with workspace (main page).
  ///
  /// *profile* arguments means that it is necessary to initialize main page with profile page.
  void replaceWithMainPage({bool profile = false}) {
    popUntilRoot();
    replaceNamed(MainPage.routeName + (profile ? '/${SelfProfilePage.routeName}' : ''));
  }

  /// Goes to karma page.
  void goToKarmaPage() => pushNamed(KarmaPageWrapper.routeName);

  /// Goes to karma history page.
  void goToKarmaHistoryPage() => pushNamed(KarmaHistoryPage.routeName);

  /// Goes to create brand page.
  void goToCreateBrandPage() => pushNamed(CreateBrandPage.routeName);

  /// Goes to create profession page.
  void goToCreateProfessionPage() => pushNamed(CreateProfessionPage.routeName);

  /// Goes to create portfolio page.
  Future<Portfolio?> goToCreatePortfolioPage() => pushNamed(CreatePortfolioPage.routeName);

  /// Goes to create item page.
  Future<Item?> goToCreateItemPage() => pushNamed(CreateItemPage.routeName);

  /// Goes to extended information page.
  void goToExtendedInformationPage(Profile fromProfile) => push(
        ExtendedInformationRoute(fromProfile: fromProfile),
      );

  /// Goes to edit extended information page.
  void goToEditExtendedInformationPage() => push(const EditExtendedInformationRoute());

  /// Goes to edit languages page.
  void goToEditLanguagesPage() => pushNamed(EditExtendedInformationLanguagesPage.routeName);

  /// Goes to edit education page.
  void goToEditEducationPage() => pushNamed(EditExtendedInformationEducationPage.routeName);

  /// Goes to edit career page.
  void goToEditCareerPage() => pushNamed(EditExtendedInformationCareerPage.routeName);

  /// Goes to edit career page.
  void goToEditHobbyPage() => pushNamed(EditExtendedInformationHobbyPage.routeName);

  /// Goes to edit career page.
  void goToEditAnimalsPage() => pushNamed(EditExtendedInformationAnimalsPage.routeName);

  /// Goes to edit profile page.
  void goToEditProfilePage() => pushNamed(EditProfilePage.routeName);

  /// Goes to edit main information page.
  void goToEditMainInformationPage() => pushNamed(EditMainInformationPage.routeName);

  /// Goes to edit phone number page.
  void goToEditPhoneNumberPage() => pushNamed(EditPhoneNumberPage.routeName);

  /// Goes to edit contacts page.
  void goToEditContactsPage() => pushNamed(EditContactsPage.routeName);

  /// Goes to edit specialities page.
  void goToEditSpecialitiesPage() => pushNamed(EditSpecialitiesPage.routeName);

  /// Goes to edit portfolio page.
  ///
  /// As an argument we can provide initial speciality or brand.
  void goToEditPortfolioPage({Speciality? speciality, Brand? brand}) => push(
        EditPortfolioRoute(speciality: speciality, brand: brand),
      );

  /// Goes to edit shop page.
  ///
  /// As an argument we can provide initial speciality or brand.
  void goToEditShopPage({Speciality? speciality, Brand? brand}) => push(
        EditShopRoute(speciality: speciality, brand: brand),
      );

  /// Goes to edit brand page.
  Future<Brand?> goToEditBrandPage({required Brand brand}) async => await push(
        EditBrandRoute(brand: brand),
      );

  /// Jumps to edit brand main information page.
  Future<Brand?> jumpToEditBrandMainInformationPage({required Brand brand}) async {
    goToEditBrandPage(brand: brand);
    await Future.delayed(NConstants.aSecond * 0.1);

    return await goToEditBrandMainInformationPage();
  }

  /// Goes to edit brand main information page.
  Future<Brand?> goToEditBrandMainInformationPage() async => await pushNamed(EditBrandMainInformationPage.routeName);

  /// Goes to edit brand contacts page.
  Future<Brand?> goToEditBrandContactsPage() async => await pushNamed(EditBrandContactsPage.routeName);

  /// Jumps to edit brand contacts page.
  Future<Brand?> jumpToEditBrandContactsPage({required Brand brand}) async {
    goToEditBrandPage(brand: brand);
    await Future.delayed(NConstants.aSecond * 0.1);

    return await goToEditBrandContactsPage();
  }

  /// Goes to edit brand portfolio page.
  Future<Brand?> goToEditBrandPortfolioPage() async => await pushNamed(EditBrandPortfolioPage.routeName);

  /// Goes to edit brand shop page.
  Future<Brand?> goToEditBrandShopPage() async => await pushNamed(EditBrandShopPage.routeName);

  /// Goes to edit speciality page.
  Future<Speciality?> goToEditSpecialityPage({required Speciality speciality}) async => await push(
        EditSpecialityRoute(speciality: speciality),
      );

  /// Jumps to edit speciality main information page.
  void jumpToEditSpecialityMainInformationPage({required Speciality speciality}) async {
    goToEditSpecialityPage(speciality: speciality);
    await Future.delayed(NConstants.aSecond * 0.1);

    goToEditSpecialityMainInformationPage();
  }

  /// Goes to edit speciality main information page.
  Future<Speciality?> goToEditSpecialityMainInformationPage() async =>
      await pushNamed(EditSpecialityMainInformationPage.routeName);

  /// Goes to edit speciality contacts page.
  Future<Speciality?> goToEditSpecialityContactsPage() async => await pushNamed(EditSpecialityContactsPage.routeName);

  /// Jumps to edit speciality contacts page.
  Future<Speciality?> jumpToEditSpecialityContactsPage({required Speciality speciality}) async {
    goToEditSpecialityPage(speciality: speciality);
    await Future.delayed(NConstants.aSecond * 0.1);

    return await goToEditSpecialityContactsPage();
  }

  /// Goes to edit speciality portfolio page.
  Future<Speciality?> goToEditSpecialityPortfolioPage() async => await pushNamed(EditSpecialityPortfolioPage.routeName);

  /// Goes to edit speciality shop page.
  Future<Speciality?> goToEditSpecialityShopPage() async => await pushNamed(EditSpecialityShopPage.routeName);

  /// Handles profile model routing.
  Future<void> handleRouteToProfile(Profile profile, [Profile? fromProfile]) async {
    if (profile is User) {
      return await goToProfilePage(profile.nickname);
    } else if (profile is Brand) {
      return await goToBrandPage(profile.id, fromProfile);
    } else if (profile is Speciality) {
      return await goToSpecialityPage(profile.id, fromProfile);
    }
  }

  /// Handles profile model routing.
  Future<void> handleSpecialityRoute(Speciality speciality, [Profile? fromProfile]) async {
    if (speciality.type == SpecialityType.myBrand) {
      return await goToBrandPage(speciality.brandId, fromProfile);
    } else {
      return await goToSpecialityPage(speciality.id, fromProfile);
    }
  }

  /// Goes to profile page.
  Future<void> goToProfilePage(String? username) async => await pushNamed('${ProfilePageWrapper.routeName}/$username');

  /// Goes to profile circles page.
  Future<void> goToProfileCirclesPage(int userId, [bool currentUser = false]) async => await push(
        ProfileCirclesRouteWrapper(userId: userId, currentUser: currentUser),
      );

  /// Goes to profile circles users page.
  Future<void> goToProfileCirclesUsersPage(Circle circle) async => await push(
        ProfileCirclesUsersRoute(circle: circle),
      );

  /// Goes to brand page.
  Future<void> goToBrandPage(int id, [Profile? fromProfile]) async => await push(
        BrandRoute(id: id, fromProfile: fromProfile),
      );

  /// Goes to speciality page.
  Future<void> goToSpecialityPage(int id, [Profile? fromProfile]) async => await push(
        SpecialityRoute(id: id, fromProfile: fromProfile),
      );

  /// Goes to login page.
  Future<void> goToLoginPage() async => await pushNamed(LoginPage.routeName);

  /// Goes to registration with invitation code.
  Future<void> goToRegistrationWithInvitationCodePage({bool hasInvite = false}) async => await push(
        RegistrationInvitationCodeRoute(hasInvite: hasInvite),
      );

  /// Goes to registration request page.
  Future<void> goToRegistrationRequestPage() async => await pushNamed(RegistrationRequestPageWrapper.routeName);

  /// Goes to request email page.
  void goToRequestEmailPage() => pushNamed(RequestEmailPage.routeName);

  /// Replaces current route with invitation confirmation page.
  void replaceWithInvitationConfirmationPage({required Profile invitedBy}) {
    popUntilRoot();
    replace(
      UserInvitationConfirmationRoute(invitedBy: invitedBy),
    );
  }

  /// Replaces current route with invitation form page.
  Future<void> replaceWithInvitationFormPage() async {
    popUntilRoot();

    await replaceNamed(UserInvitationFormPageWrapper.routeName);
  }

  /// Goes to invitation registration page.
  Future<void> goToInvitationRegistrationPage() async => await pushNamed(UserInvitationRegistrationPage.routeName);

  /// Replaces current route with request confirmation page.
  Future<void> replaceWithRequestConfirmationPage() {
    popUntilRoot();
    return replaceNamed(RequestConfirmationPage.routeName);
  }

  /// Goes to request speciality page.
  Future<void> goToRequestSpecialityPage() async => await pushNamed(RequestSpecialityPage.routeName);

  /// Goes to connect telegram and phone page.
  Future<void> goToConnectTelegramAndPhonePage({required String? tgCode, bool invitation = false}) async => await push(
        UserConnectTelegramAndPhoneRoute(invitation: invitation),
      );

  /// Replaces current route with connect telegram and phone page.
  Future<void> replaceWithConnectTelegramAndPhonePage({required String? tgCode, bool invitation = true}) async {
    popUntilRoot();
    await replace(
      UserConnectTelegramAndPhoneRoute(invitation: invitation),
    );
  }

  /// Goes to grade person(user) page.
  void goToGradePersonPage(User user) => push(
        GradePersonRoute(user: user),
      );

  /// Replaces current route with access contacts page.
  Future<void> replaceWithInvitationAccessContactsPage({bool invitation = true}) async {
    popUntilRoot();
    await replaceNamed(UserInvitationAccessContactsPage.routeName);
  }

  /// Goes to registration phone confirmation page.
  Future<bool?> goToRegistrationPhoneConfirmationPage<bool>() async =>
      await pushNamed<bool>(RegistrationPhoneConfirmationPage.routeName);

  /// Goes to registration phone code confirmation page.
  Future<bool?> goToRegistrationPhoneCodeConfirmationPage<bool>() async =>
      await pushNamed<bool>(RegistrationPhoneCodeConfirmationPage.routeName);

  /// Opens popup to pick needed location.
  Future<PickedLocation?> openPickLocationPopup(BuildContext context) async => await showBottomSheet(
        context,
        const PickLocationPopup(),
        // isScrollControlled: false,
        enableDrag: false,
      );

  Future<void> openCreateSpecialityTypePopup(BuildContext context) => showBottomSheet(
        context,
        OptionsBottomSheet(
          options: [
            BottomSheetOption(
              icon: NIcons.user_add,
              title: 'Добавить профессию',
              onTap: () => goToCreateProfessionPage(),
            ),
            BottomSheetOption(
              icon: NIcons.shop_add,
              title: 'Создать бренд',
              onTap: () => goToCreateBrandPage(),
            ),
          ],
        ),
      );

  /// Opens list of contacts popup.
  Future<void> openContactsPopup(BuildContext context, {required List<Contact> contacts}) => showBottomSheet(
        context,
        ContactsPopup(contacts: contacts),
      );

  Future<CreateEntityResult<Career?>?> showCareerPopup(BuildContext context,
          {Career? career, bool canDelete = false, bool includePeriod = true, bool includeDescription = true}) async =>
      await showBottomSheet(
        context,
        CareerPopup(
          career: career,
          canDelete: canDelete,
          includePeriod: includePeriod,
          includeDescription: includeDescription,
        ),
      );

  Future<PickImageResult> showPickImagePopup(BuildContext context,
      {bool canDelete = false, bool multiple = false}) async {
    final state = PickImageState();
    service.registerSingleton(state);

    final PickImageResult result = await showBottomSheet(
          context,
          PickImagePopup(canDelete: canDelete, multiple: multiple),
        ) ??
        PickImageResultNone();

    // Remove state from memory.
    service.unregister(instance: state);

    return result;
  }

  Future<dynamic> showBottomSheet(BuildContext context, Widget child,
          {bool isScrollControlled = true, bool enableDrag = true}) async =>
      await showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24.r),
          ),
        ),
        builder: (context) => SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20.h),
              Container(
                height: 4.h,
                width: 46.w,
                decoration: BoxDecoration(color: NColors.gray, borderRadius: BorderRadius.circular(2.r)),
              ),
              SizedBox(height: 24.h),
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 75.h),
                child: child,
              ),
            ],
          ),
        ),
        barrierColor: NColors.black.withOpacity(0.05),
        backgroundColor: NColors.white,
        isScrollControlled: isScrollControlled,
        enableDrag: enableDrag,
      );
}
