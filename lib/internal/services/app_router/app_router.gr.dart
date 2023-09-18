// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const SplashScreenPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    RegistrationInvitationCodeRoute.name: (routeData) {
      final args = routeData.argsAs<RegistrationInvitationCodeRouteArgs>(
          orElse: () => const RegistrationInvitationCodeRouteArgs());
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: RegistrationInvitationCodePage(
          key: args.key,
          hasInvite: args.hasInvite,
        ),
      );
    },
    RegistrationRequestRouteWrapper.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const RegistrationRequestPageWrapper()),
      );
    },
    RequestConfirmationRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const RequestConfirmationPage(),
      );
    },
    UserInvitationConfirmationRoute.name: (routeData) {
      final args = routeData.argsAs<UserInvitationConfirmationRouteArgs>();
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: UserInvitationConfirmationPage(
          key: args.key,
          invitedBy: args.invitedBy,
        ),
      );
    },
    UserInvitationFormRouteWrapper.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const UserInvitationFormPageWrapper()),
      );
    },
    UserConnectTelegramAndPhoneRoute.name: (routeData) {
      final args = routeData.argsAs<UserConnectTelegramAndPhoneRouteArgs>(
          orElse: () => const UserConnectTelegramAndPhoneRouteArgs());
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: UserConnectTelegramAndPhonePage(
          key: args.key,
          invitation: args.invitation,
        ),
      );
    },
    UserInvitationAccessContactsRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const UserInvitationAccessContactsPage(),
      );
    },
    RegistrationPhoneConfirmationRoute.name: (routeData) {
      return CupertinoPageX<bool>(
        routeData: routeData,
        child: const RegistrationPhoneConfirmationPage(),
      );
    },
    RegistrationPhoneCodeConfirmationRoute.name: (routeData) {
      return CupertinoPageX<bool>(
        routeData: routeData,
        child: const RegistrationPhoneCodeConfirmationPage(),
      );
    },
    MainRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    ProfileRouteWrapper.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileRouteWrapperArgs>(
          orElse: () => ProfileRouteWrapperArgs(
              username: pathParams.getString('username')));
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: ProfilePageWrapper(
          key: args.key,
          username: args.username,
        )),
      );
    },
    EditProfileRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const EditProfilePage(),
      );
    },
    EditMainInformationRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const EditMainInformationPage(),
      );
    },
    EditPhoneNumberRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const EditPhoneNumberPage(),
      );
    },
    EditContactsRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const EditContactsPage(),
      );
    },
    EditSpecialitiesRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const EditSpecialitiesPage(),
      );
    },
    EditPortfolioRoute.name: (routeData) {
      final args = routeData.argsAs<EditPortfolioRouteArgs>(
          orElse: () => const EditPortfolioRouteArgs());
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: EditPortfolioPage(
          key: args.key,
          speciality: args.speciality,
          brand: args.brand,
        ),
      );
    },
    EditShopRoute.name: (routeData) {
      final args = routeData.argsAs<EditShopRouteArgs>(
          orElse: () => const EditShopRouteArgs());
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: EditShopPage(
          key: args.key,
          speciality: args.speciality,
          brand: args.brand,
        ),
      );
    },
    EditBrandRoute.name: (routeData) {
      final args = routeData.argsAs<EditBrandRouteArgs>();
      return CupertinoPageX<Brand>(
        routeData: routeData,
        child: WrappedRoute(
            child: EditBrandPage(
          key: args.key,
          brand: args.brand,
        )),
      );
    },
    EditSpecialityRoute.name: (routeData) {
      final args = routeData.argsAs<EditSpecialityRouteArgs>();
      return CupertinoPageX<Speciality>(
        routeData: routeData,
        child: WrappedRoute(
            child: EditSpecialityPage(
          key: args.key,
          speciality: args.speciality,
        )),
      );
    },
    ExtendedInformationRoute.name: (routeData) {
      final args = routeData.argsAs<ExtendedInformationRouteArgs>();
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: ExtendedInformationPage(
          key: args.key,
          fromProfile: args.fromProfile,
        ),
      );
    },
    EditExtendedInformationRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const EditExtendedInformationPage()),
      );
    },
    ProfileCirclesRouteWrapper.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileCirclesRouteWrapperArgs>(
          orElse: () => ProfileCirclesRouteWrapperArgs(
              userId: pathParams.getInt('userId')));
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: ProfileCirclesPageWrapper(
          key: args.key,
          userId: args.userId,
          currentUser: args.currentUser,
        )),
      );
    },
    CreateProfessionRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const CreateProfessionPage(),
      );
    },
    CreateBrandRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const CreateBrandPage(),
      );
    },
    CreatePortfolioRoute.name: (routeData) {
      return CupertinoPageX<Portfolio>(
        routeData: routeData,
        child: const CreatePortfolioPage(),
      );
    },
    CreateItemRoute.name: (routeData) {
      return CupertinoPageX<Item>(
        routeData: routeData,
        child: const CreateItemPage(),
      );
    },
    BrandRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<BrandRouteArgs>(
          orElse: () => BrandRouteArgs(id: pathParams.getInt('id')));
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: BrandPage(
          key: args.key,
          id: args.id,
          fromProfile: args.fromProfile,
        ),
      );
    },
    SpecialityRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SpecialityRouteArgs>(
          orElse: () => SpecialityRouteArgs(id: pathParams.getInt('id')));
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: SpecialityPage(
          key: args.key,
          id: args.id,
          fromProfile: args.fromProfile,
        ),
      );
    },
    GradePersonRoute.name: (routeData) {
      final args = routeData.argsAs<GradePersonRouteArgs>();
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: GradePersonPage(
          key: args.key,
          user: args.user,
        ),
      );
    },
    EmptyRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const EmptyPage(),
      );
    },
    RegistrationRequestRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const RegistrationRequestPage(),
      );
    },
    RequestEmailRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const RequestEmailPage(),
      );
    },
    RequestSpecialityRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const RequestSpecialityPage(),
      );
    },
    UserInvitationFormRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const UserInvitationFormPage(),
      );
    },
    UserInvitationRegistrationRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const UserInvitationRegistrationPage(),
      );
    },
    FeedRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const FeedPage(),
      );
    },
    CatalogRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const CatalogPage(),
      );
    },
    SelfProfileRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const SelfProfilePage()),
        maintainState: false,
      );
    },
    ProfileRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const ProfilePage(),
      );
    },
    KarmaRouteWrapper.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const KarmaPageWrapper()),
      );
    },
    KarmaInitialRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const KarmaInitialPage(),
      );
    },
    KarmaHistoryRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const KarmaHistoryPage(),
      );
    },
    EditBrandInitialRoute.name: (routeData) {
      return CupertinoPageX<Brand>(
        routeData: routeData,
        child: const EditBrandInitialPage(),
      );
    },
    EditBrandMainInformationRoute.name: (routeData) {
      return CupertinoPageX<Brand>(
        routeData: routeData,
        child: const EditBrandMainInformationPage(),
      );
    },
    EditBrandContactsRoute.name: (routeData) {
      return CupertinoPageX<Brand>(
        routeData: routeData,
        child: const EditBrandContactsPage(),
      );
    },
    EditBrandPortfolioRoute.name: (routeData) {
      return CupertinoPageX<Brand>(
        routeData: routeData,
        child: const EditBrandPortfolioPage(),
      );
    },
    EditBrandShopRoute.name: (routeData) {
      return CupertinoPageX<Brand>(
        routeData: routeData,
        child: const EditBrandShopPage(),
      );
    },
    EditSpecialityInitialRoute.name: (routeData) {
      return CupertinoPageX<Speciality>(
        routeData: routeData,
        child: const EditSpecialityInitialPage(),
      );
    },
    EditSpecialityMainInformationRoute.name: (routeData) {
      return CupertinoPageX<Speciality>(
        routeData: routeData,
        child: const EditSpecialityMainInformationPage(),
      );
    },
    EditSpecialityContactsRoute.name: (routeData) {
      return CupertinoPageX<Speciality>(
        routeData: routeData,
        child: const EditSpecialityContactsPage(),
      );
    },
    EditSpecialityPortfolioRoute.name: (routeData) {
      return CupertinoPageX<Speciality>(
        routeData: routeData,
        child: const EditSpecialityPortfolioPage(),
      );
    },
    EditSpecialityShopRoute.name: (routeData) {
      return CupertinoPageX<Speciality>(
        routeData: routeData,
        child: const EditSpecialityShopPage(),
      );
    },
    EditExtendedInformationInitialRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const EditExtendedInformationInitialPage(),
      );
    },
    EditExtendedInformationLanguagesRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const EditExtendedInformationLanguagesPage(),
      );
    },
    EditExtendedInformationEducationRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const EditExtendedInformationEducationPage(),
      );
    },
    EditExtendedInformationCareerRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const EditExtendedInformationCareerPage(),
      );
    },
    EditExtendedInformationHobbyRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const EditExtendedInformationHobbyPage(),
      );
    },
    EditExtendedInformationAnimalsRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const EditExtendedInformationAnimalsPage(),
      );
    },
    ProfileCirclesRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const ProfileCirclesPage(),
      );
    },
    ProfileCirclesUsersRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileCirclesUsersRouteArgs>();
      return CupertinoPageX<dynamic>(
        routeData: routeData,
        child: ProfileCirclesUsersPage(
          key: args.key,
          circle: args.circle,
        ),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          SplashScreenRoute.name,
          path: '/',
        ),
        RouteConfig(
          LoginRoute.name,
          path: '/login-page',
        ),
        RouteConfig(
          RegistrationInvitationCodeRoute.name,
          path: '/registration-invitation-code-page',
        ),
        RouteConfig(
          RegistrationRequestRouteWrapper.name,
          path: '/registration-request-page-wrapper',
          children: [
            RouteConfig(
              '#redirect',
              path: '',
              parent: RegistrationRequestRouteWrapper.name,
              redirectTo: 'registration-request-page',
              fullMatch: true,
            ),
            RouteConfig(
              RegistrationRequestRoute.name,
              path: 'registration-request-page',
              parent: RegistrationRequestRouteWrapper.name,
            ),
            RouteConfig(
              RequestEmailRoute.name,
              path: 'request-email-page',
              parent: RegistrationRequestRouteWrapper.name,
            ),
            RouteConfig(
              RequestSpecialityRoute.name,
              path: 'request-speciality-page',
              parent: RegistrationRequestRouteWrapper.name,
            ),
          ],
        ),
        RouteConfig(
          RequestConfirmationRoute.name,
          path: '/request-confirmation-page',
        ),
        RouteConfig(
          UserInvitationConfirmationRoute.name,
          path: '/invitation-confirmation-page',
        ),
        RouteConfig(
          UserInvitationFormRouteWrapper.name,
          path: '/user-invitation-form-page',
          children: [
            RouteConfig(
              '#redirect',
              path: '',
              parent: UserInvitationFormRouteWrapper.name,
              redirectTo: 'form',
              fullMatch: true,
            ),
            RouteConfig(
              UserInvitationFormRoute.name,
              path: 'form',
              parent: UserInvitationFormRouteWrapper.name,
            ),
            RouteConfig(
              UserInvitationRegistrationRoute.name,
              path: 'email',
              parent: UserInvitationFormRouteWrapper.name,
            ),
          ],
        ),
        RouteConfig(
          UserConnectTelegramAndPhoneRoute.name,
          path: '/user-connect-telegram-and-phone-page',
        ),
        RouteConfig(
          UserInvitationAccessContactsRoute.name,
          path: '/user-invitation-access-contacts-page',
        ),
        RouteConfig(
          RegistrationPhoneConfirmationRoute.name,
          path: '/registration-phone-confirmation-page',
        ),
        RouteConfig(
          RegistrationPhoneCodeConfirmationRoute.name,
          path: '/registration-phone-code-confirmation-page',
        ),
        RouteConfig(
          MainRoute.name,
          path: '/main-page',
          children: [
            RouteConfig(
              '#redirect',
              path: '',
              parent: MainRoute.name,
              redirectTo: 'feed',
              fullMatch: true,
            ),
            RouteConfig(
              FeedRoute.name,
              path: 'feed',
              parent: MainRoute.name,
            ),
            RouteConfig(
              CatalogRoute.name,
              path: 'catalog',
              parent: MainRoute.name,
            ),
            RouteConfig(
              SelfProfileRoute.name,
              path: 'self-profile-page',
              parent: MainRoute.name,
              children: [
                RouteConfig(
                  ProfileRoute.name,
                  path: '',
                  parent: SelfProfileRoute.name,
                ),
                RouteConfig(
                  KarmaRouteWrapper.name,
                  path: 'karma',
                  parent: SelfProfileRoute.name,
                  children: [
                    RouteConfig(
                      KarmaInitialRoute.name,
                      path: '',
                      parent: KarmaRouteWrapper.name,
                    ),
                    RouteConfig(
                      KarmaHistoryRoute.name,
                      path: 'history',
                      parent: KarmaRouteWrapper.name,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        RouteConfig(
          ProfileRouteWrapper.name,
          path: '/profile/:username',
          children: [
            RouteConfig(
              ProfileRoute.name,
              path: '',
              parent: ProfileRouteWrapper.name,
            ),
            RouteConfig(
              KarmaRouteWrapper.name,
              path: 'karma',
              parent: ProfileRouteWrapper.name,
              children: [
                RouteConfig(
                  KarmaInitialRoute.name,
                  path: '',
                  parent: KarmaRouteWrapper.name,
                ),
                RouteConfig(
                  KarmaHistoryRoute.name,
                  path: 'history',
                  parent: KarmaRouteWrapper.name,
                ),
              ],
            ),
          ],
        ),
        RouteConfig(
          EditProfileRoute.name,
          path: '/edit-profile-page',
        ),
        RouteConfig(
          EditMainInformationRoute.name,
          path: '/edit-main-information-page',
        ),
        RouteConfig(
          EditPhoneNumberRoute.name,
          path: '/edit-phone-number-page',
        ),
        RouteConfig(
          EditContactsRoute.name,
          path: '/edit-contacts-page',
        ),
        RouteConfig(
          EditSpecialitiesRoute.name,
          path: '/edit-specialities-page',
        ),
        RouteConfig(
          EditPortfolioRoute.name,
          path: '/edit-portfolio-page',
        ),
        RouteConfig(
          EditShopRoute.name,
          path: '/edit-shop-page',
        ),
        RouteConfig(
          EditBrandRoute.name,
          path: '/edit-brand-page',
          children: [
            RouteConfig(
              EditBrandInitialRoute.name,
              path: '',
              parent: EditBrandRoute.name,
            ),
            RouteConfig(
              EditBrandMainInformationRoute.name,
              path: 'main-information',
              parent: EditBrandRoute.name,
            ),
            RouteConfig(
              EditBrandContactsRoute.name,
              path: 'contacts',
              parent: EditBrandRoute.name,
            ),
            RouteConfig(
              EditBrandPortfolioRoute.name,
              path: 'portfolio',
              parent: EditBrandRoute.name,
            ),
            RouteConfig(
              EditBrandShopRoute.name,
              path: 'shop',
              parent: EditBrandRoute.name,
            ),
          ],
        ),
        RouteConfig(
          EditSpecialityRoute.name,
          path: '/edit-speciality-page',
          children: [
            RouteConfig(
              EditSpecialityInitialRoute.name,
              path: '',
              parent: EditSpecialityRoute.name,
            ),
            RouteConfig(
              EditSpecialityMainInformationRoute.name,
              path: 'main-information',
              parent: EditSpecialityRoute.name,
            ),
            RouteConfig(
              EditSpecialityContactsRoute.name,
              path: 'contacts',
              parent: EditSpecialityRoute.name,
            ),
            RouteConfig(
              EditSpecialityPortfolioRoute.name,
              path: 'portfolio',
              parent: EditSpecialityRoute.name,
            ),
            RouteConfig(
              EditSpecialityShopRoute.name,
              path: 'shop',
              parent: EditSpecialityRoute.name,
            ),
          ],
        ),
        RouteConfig(
          ExtendedInformationRoute.name,
          path: '/extended-information-page',
        ),
        RouteConfig(
          EditExtendedInformationRoute.name,
          path: '/edit-extended-information-page',
          children: [
            RouteConfig(
              EditExtendedInformationInitialRoute.name,
              path: '',
              parent: EditExtendedInformationRoute.name,
            ),
            RouteConfig(
              EditExtendedInformationLanguagesRoute.name,
              path: 'languages',
              parent: EditExtendedInformationRoute.name,
            ),
            RouteConfig(
              EditExtendedInformationEducationRoute.name,
              path: 'education',
              parent: EditExtendedInformationRoute.name,
            ),
            RouteConfig(
              EditExtendedInformationCareerRoute.name,
              path: 'career',
              parent: EditExtendedInformationRoute.name,
            ),
            RouteConfig(
              EditExtendedInformationHobbyRoute.name,
              path: 'hobby',
              parent: EditExtendedInformationRoute.name,
            ),
            RouteConfig(
              EditExtendedInformationAnimalsRoute.name,
              path: 'animals',
              parent: EditExtendedInformationRoute.name,
            ),
          ],
        ),
        RouteConfig(
          'languages#redirect',
          path: 'languages',
          redirectTo: '/edit-extended-information-page/languages',
          fullMatch: true,
        ),
        RouteConfig(
          'education#redirect',
          path: 'education',
          redirectTo: '/edit-extended-information-page/education',
          fullMatch: true,
        ),
        RouteConfig(
          'career#redirect',
          path: 'career',
          redirectTo: '/edit-extended-information-page/career',
          fullMatch: true,
        ),
        RouteConfig(
          'hobby#redirect',
          path: 'hobby',
          redirectTo: '/edit-extended-information-page/hobby',
          fullMatch: true,
        ),
        RouteConfig(
          'animals#redirect',
          path: 'animals',
          redirectTo: '/edit-extended-information-page/animals',
          fullMatch: true,
        ),
        RouteConfig(
          ProfileCirclesRouteWrapper.name,
          path: '/profile-circles-page/:userId',
          children: [
            RouteConfig(
              ProfileCirclesRoute.name,
              path: '',
              parent: ProfileCirclesRouteWrapper.name,
            ),
            RouteConfig(
              ProfileCirclesUsersRoute.name,
              path: 'information',
              parent: ProfileCirclesRouteWrapper.name,
            ),
          ],
        ),
        RouteConfig(
          CreateProfessionRoute.name,
          path: '/create-profession-page',
        ),
        RouteConfig(
          CreateBrandRoute.name,
          path: '/create-brand-page',
        ),
        RouteConfig(
          CreatePortfolioRoute.name,
          path: '/create-portfolio-page',
        ),
        RouteConfig(
          CreateItemRoute.name,
          path: '/create-item-page',
        ),
        RouteConfig(
          BrandRoute.name,
          path: '/brand/:id',
        ),
        RouteConfig(
          SpecialityRoute.name,
          path: '/speciality-page/:id',
        ),
        RouteConfig(
          GradePersonRoute.name,
          path: '/grade-person-page',
        ),
        RouteConfig(
          EmptyRoute.name,
          path: '/empty',
        ),
      ];
}

/// generated route for
/// [SplashScreenPage]
class SplashScreenRoute extends PageRouteInfo<void> {
  const SplashScreenRoute()
      : super(
          SplashScreenRoute.name,
          path: '/',
        );

  static const String name = 'SplashScreenRoute';
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login-page',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [RegistrationInvitationCodePage]
class RegistrationInvitationCodeRoute
    extends PageRouteInfo<RegistrationInvitationCodeRouteArgs> {
  RegistrationInvitationCodeRoute({
    Key? key,
    bool hasInvite = false,
  }) : super(
          RegistrationInvitationCodeRoute.name,
          path: '/registration-invitation-code-page',
          args: RegistrationInvitationCodeRouteArgs(
            key: key,
            hasInvite: hasInvite,
          ),
        );

  static const String name = 'RegistrationInvitationCodeRoute';
}

class RegistrationInvitationCodeRouteArgs {
  const RegistrationInvitationCodeRouteArgs({
    this.key,
    this.hasInvite = false,
  });

  final Key? key;

  final bool hasInvite;

  @override
  String toString() {
    return 'RegistrationInvitationCodeRouteArgs{key: $key, hasInvite: $hasInvite}';
  }
}

/// generated route for
/// [RegistrationRequestPageWrapper]
class RegistrationRequestRouteWrapper extends PageRouteInfo<void> {
  const RegistrationRequestRouteWrapper({List<PageRouteInfo>? children})
      : super(
          RegistrationRequestRouteWrapper.name,
          path: '/registration-request-page-wrapper',
          initialChildren: children,
        );

  static const String name = 'RegistrationRequestRouteWrapper';
}

/// generated route for
/// [RequestConfirmationPage]
class RequestConfirmationRoute extends PageRouteInfo<void> {
  const RequestConfirmationRoute()
      : super(
          RequestConfirmationRoute.name,
          path: '/request-confirmation-page',
        );

  static const String name = 'RequestConfirmationRoute';
}

/// generated route for
/// [UserInvitationConfirmationPage]
class UserInvitationConfirmationRoute
    extends PageRouteInfo<UserInvitationConfirmationRouteArgs> {
  UserInvitationConfirmationRoute({
    Key? key,
    required Profile invitedBy,
  }) : super(
          UserInvitationConfirmationRoute.name,
          path: '/invitation-confirmation-page',
          args: UserInvitationConfirmationRouteArgs(
            key: key,
            invitedBy: invitedBy,
          ),
        );

  static const String name = 'UserInvitationConfirmationRoute';
}

class UserInvitationConfirmationRouteArgs {
  const UserInvitationConfirmationRouteArgs({
    this.key,
    required this.invitedBy,
  });

  final Key? key;

  final Profile invitedBy;

  @override
  String toString() {
    return 'UserInvitationConfirmationRouteArgs{key: $key, invitedBy: $invitedBy}';
  }
}

/// generated route for
/// [UserInvitationFormPageWrapper]
class UserInvitationFormRouteWrapper extends PageRouteInfo<void> {
  const UserInvitationFormRouteWrapper({List<PageRouteInfo>? children})
      : super(
          UserInvitationFormRouteWrapper.name,
          path: '/user-invitation-form-page',
          initialChildren: children,
        );

  static const String name = 'UserInvitationFormRouteWrapper';
}

/// generated route for
/// [UserConnectTelegramAndPhonePage]
class UserConnectTelegramAndPhoneRoute
    extends PageRouteInfo<UserConnectTelegramAndPhoneRouteArgs> {
  UserConnectTelegramAndPhoneRoute({
    Key? key,
    bool invitation = false,
  }) : super(
          UserConnectTelegramAndPhoneRoute.name,
          path: '/user-connect-telegram-and-phone-page',
          args: UserConnectTelegramAndPhoneRouteArgs(
            key: key,
            invitation: invitation,
          ),
        );

  static const String name = 'UserConnectTelegramAndPhoneRoute';
}

class UserConnectTelegramAndPhoneRouteArgs {
  const UserConnectTelegramAndPhoneRouteArgs({
    this.key,
    this.invitation = false,
  });

  final Key? key;

  final bool invitation;

  @override
  String toString() {
    return 'UserConnectTelegramAndPhoneRouteArgs{key: $key, invitation: $invitation}';
  }
}

/// generated route for
/// [UserInvitationAccessContactsPage]
class UserInvitationAccessContactsRoute extends PageRouteInfo<void> {
  const UserInvitationAccessContactsRoute()
      : super(
          UserInvitationAccessContactsRoute.name,
          path: '/user-invitation-access-contacts-page',
        );

  static const String name = 'UserInvitationAccessContactsRoute';
}

/// generated route for
/// [RegistrationPhoneConfirmationPage]
class RegistrationPhoneConfirmationRoute extends PageRouteInfo<void> {
  const RegistrationPhoneConfirmationRoute()
      : super(
          RegistrationPhoneConfirmationRoute.name,
          path: '/registration-phone-confirmation-page',
        );

  static const String name = 'RegistrationPhoneConfirmationRoute';
}

/// generated route for
/// [RegistrationPhoneCodeConfirmationPage]
class RegistrationPhoneCodeConfirmationRoute extends PageRouteInfo<void> {
  const RegistrationPhoneCodeConfirmationRoute()
      : super(
          RegistrationPhoneCodeConfirmationRoute.name,
          path: '/registration-phone-code-confirmation-page',
        );

  static const String name = 'RegistrationPhoneCodeConfirmationRoute';
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/main-page',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [ProfilePageWrapper]
class ProfileRouteWrapper extends PageRouteInfo<ProfileRouteWrapperArgs> {
  ProfileRouteWrapper({
    Key? key,
    required String username,
    List<PageRouteInfo>? children,
  }) : super(
          ProfileRouteWrapper.name,
          path: '/profile/:username',
          args: ProfileRouteWrapperArgs(
            key: key,
            username: username,
          ),
          rawPathParams: {'username': username},
          initialChildren: children,
        );

  static const String name = 'ProfileRouteWrapper';
}

class ProfileRouteWrapperArgs {
  const ProfileRouteWrapperArgs({
    this.key,
    required this.username,
  });

  final Key? key;

  final String username;

  @override
  String toString() {
    return 'ProfileRouteWrapperArgs{key: $key, username: $username}';
  }
}

/// generated route for
/// [EditProfilePage]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute()
      : super(
          EditProfileRoute.name,
          path: '/edit-profile-page',
        );

  static const String name = 'EditProfileRoute';
}

/// generated route for
/// [EditMainInformationPage]
class EditMainInformationRoute extends PageRouteInfo<void> {
  const EditMainInformationRoute()
      : super(
          EditMainInformationRoute.name,
          path: '/edit-main-information-page',
        );

  static const String name = 'EditMainInformationRoute';
}

/// generated route for
/// [EditPhoneNumberPage]
class EditPhoneNumberRoute extends PageRouteInfo<void> {
  const EditPhoneNumberRoute()
      : super(
          EditPhoneNumberRoute.name,
          path: '/edit-phone-number-page',
        );

  static const String name = 'EditPhoneNumberRoute';
}

/// generated route for
/// [EditContactsPage]
class EditContactsRoute extends PageRouteInfo<void> {
  const EditContactsRoute()
      : super(
          EditContactsRoute.name,
          path: '/edit-contacts-page',
        );

  static const String name = 'EditContactsRoute';
}

/// generated route for
/// [EditSpecialitiesPage]
class EditSpecialitiesRoute extends PageRouteInfo<void> {
  const EditSpecialitiesRoute()
      : super(
          EditSpecialitiesRoute.name,
          path: '/edit-specialities-page',
        );

  static const String name = 'EditSpecialitiesRoute';
}

/// generated route for
/// [EditPortfolioPage]
class EditPortfolioRoute extends PageRouteInfo<EditPortfolioRouteArgs> {
  EditPortfolioRoute({
    Key? key,
    Speciality? speciality,
    Brand? brand,
  }) : super(
          EditPortfolioRoute.name,
          path: '/edit-portfolio-page',
          args: EditPortfolioRouteArgs(
            key: key,
            speciality: speciality,
            brand: brand,
          ),
        );

  static const String name = 'EditPortfolioRoute';
}

class EditPortfolioRouteArgs {
  const EditPortfolioRouteArgs({
    this.key,
    this.speciality,
    this.brand,
  });

  final Key? key;

  final Speciality? speciality;

  final Brand? brand;

  @override
  String toString() {
    return 'EditPortfolioRouteArgs{key: $key, speciality: $speciality, brand: $brand}';
  }
}

/// generated route for
/// [EditShopPage]
class EditShopRoute extends PageRouteInfo<EditShopRouteArgs> {
  EditShopRoute({
    Key? key,
    Speciality? speciality,
    Brand? brand,
  }) : super(
          EditShopRoute.name,
          path: '/edit-shop-page',
          args: EditShopRouteArgs(
            key: key,
            speciality: speciality,
            brand: brand,
          ),
        );

  static const String name = 'EditShopRoute';
}

class EditShopRouteArgs {
  const EditShopRouteArgs({
    this.key,
    this.speciality,
    this.brand,
  });

  final Key? key;

  final Speciality? speciality;

  final Brand? brand;

  @override
  String toString() {
    return 'EditShopRouteArgs{key: $key, speciality: $speciality, brand: $brand}';
  }
}

/// generated route for
/// [EditBrandPage]
class EditBrandRoute extends PageRouteInfo<EditBrandRouteArgs> {
  EditBrandRoute({
    Key? key,
    required Brand brand,
    List<PageRouteInfo>? children,
  }) : super(
          EditBrandRoute.name,
          path: '/edit-brand-page',
          args: EditBrandRouteArgs(
            key: key,
            brand: brand,
          ),
          initialChildren: children,
        );

  static const String name = 'EditBrandRoute';
}

class EditBrandRouteArgs {
  const EditBrandRouteArgs({
    this.key,
    required this.brand,
  });

  final Key? key;

  final Brand brand;

  @override
  String toString() {
    return 'EditBrandRouteArgs{key: $key, brand: $brand}';
  }
}

/// generated route for
/// [EditSpecialityPage]
class EditSpecialityRoute extends PageRouteInfo<EditSpecialityRouteArgs> {
  EditSpecialityRoute({
    Key? key,
    required Speciality speciality,
    List<PageRouteInfo>? children,
  }) : super(
          EditSpecialityRoute.name,
          path: '/edit-speciality-page',
          args: EditSpecialityRouteArgs(
            key: key,
            speciality: speciality,
          ),
          initialChildren: children,
        );

  static const String name = 'EditSpecialityRoute';
}

class EditSpecialityRouteArgs {
  const EditSpecialityRouteArgs({
    this.key,
    required this.speciality,
  });

  final Key? key;

  final Speciality speciality;

  @override
  String toString() {
    return 'EditSpecialityRouteArgs{key: $key, speciality: $speciality}';
  }
}

/// generated route for
/// [ExtendedInformationPage]
class ExtendedInformationRoute
    extends PageRouteInfo<ExtendedInformationRouteArgs> {
  ExtendedInformationRoute({
    Key? key,
    required Profile fromProfile,
  }) : super(
          ExtendedInformationRoute.name,
          path: '/extended-information-page',
          args: ExtendedInformationRouteArgs(
            key: key,
            fromProfile: fromProfile,
          ),
        );

  static const String name = 'ExtendedInformationRoute';
}

class ExtendedInformationRouteArgs {
  const ExtendedInformationRouteArgs({
    this.key,
    required this.fromProfile,
  });

  final Key? key;

  final Profile fromProfile;

  @override
  String toString() {
    return 'ExtendedInformationRouteArgs{key: $key, fromProfile: $fromProfile}';
  }
}

/// generated route for
/// [EditExtendedInformationPage]
class EditExtendedInformationRoute extends PageRouteInfo<void> {
  const EditExtendedInformationRoute({List<PageRouteInfo>? children})
      : super(
          EditExtendedInformationRoute.name,
          path: '/edit-extended-information-page',
          initialChildren: children,
        );

  static const String name = 'EditExtendedInformationRoute';
}

/// generated route for
/// [ProfileCirclesPageWrapper]
class ProfileCirclesRouteWrapper
    extends PageRouteInfo<ProfileCirclesRouteWrapperArgs> {
  ProfileCirclesRouteWrapper({
    Key? key,
    required int userId,
    bool currentUser = false,
    List<PageRouteInfo>? children,
  }) : super(
          ProfileCirclesRouteWrapper.name,
          path: '/profile-circles-page/:userId',
          args: ProfileCirclesRouteWrapperArgs(
            key: key,
            userId: userId,
            currentUser: currentUser,
          ),
          rawPathParams: {'userId': userId},
          initialChildren: children,
        );

  static const String name = 'ProfileCirclesRouteWrapper';
}

class ProfileCirclesRouteWrapperArgs {
  const ProfileCirclesRouteWrapperArgs({
    this.key,
    required this.userId,
    this.currentUser = false,
  });

  final Key? key;

  final int userId;

  final bool currentUser;

  @override
  String toString() {
    return 'ProfileCirclesRouteWrapperArgs{key: $key, userId: $userId, currentUser: $currentUser}';
  }
}

/// generated route for
/// [CreateProfessionPage]
class CreateProfessionRoute extends PageRouteInfo<void> {
  const CreateProfessionRoute()
      : super(
          CreateProfessionRoute.name,
          path: '/create-profession-page',
        );

  static const String name = 'CreateProfessionRoute';
}

/// generated route for
/// [CreateBrandPage]
class CreateBrandRoute extends PageRouteInfo<void> {
  const CreateBrandRoute()
      : super(
          CreateBrandRoute.name,
          path: '/create-brand-page',
        );

  static const String name = 'CreateBrandRoute';
}

/// generated route for
/// [CreatePortfolioPage]
class CreatePortfolioRoute extends PageRouteInfo<void> {
  const CreatePortfolioRoute()
      : super(
          CreatePortfolioRoute.name,
          path: '/create-portfolio-page',
        );

  static const String name = 'CreatePortfolioRoute';
}

/// generated route for
/// [CreateItemPage]
class CreateItemRoute extends PageRouteInfo<void> {
  const CreateItemRoute()
      : super(
          CreateItemRoute.name,
          path: '/create-item-page',
        );

  static const String name = 'CreateItemRoute';
}

/// generated route for
/// [BrandPage]
class BrandRoute extends PageRouteInfo<BrandRouteArgs> {
  BrandRoute({
    Key? key,
    required int id,
    Profile? fromProfile,
  }) : super(
          BrandRoute.name,
          path: '/brand/:id',
          args: BrandRouteArgs(
            key: key,
            id: id,
            fromProfile: fromProfile,
          ),
          rawPathParams: {'id': id},
        );

  static const String name = 'BrandRoute';
}

class BrandRouteArgs {
  const BrandRouteArgs({
    this.key,
    required this.id,
    this.fromProfile,
  });

  final Key? key;

  final int id;

  final Profile? fromProfile;

  @override
  String toString() {
    return 'BrandRouteArgs{key: $key, id: $id, fromProfile: $fromProfile}';
  }
}

/// generated route for
/// [SpecialityPage]
class SpecialityRoute extends PageRouteInfo<SpecialityRouteArgs> {
  SpecialityRoute({
    Key? key,
    required int id,
    Profile? fromProfile,
  }) : super(
          SpecialityRoute.name,
          path: '/speciality-page/:id',
          args: SpecialityRouteArgs(
            key: key,
            id: id,
            fromProfile: fromProfile,
          ),
          rawPathParams: {'id': id},
        );

  static const String name = 'SpecialityRoute';
}

class SpecialityRouteArgs {
  const SpecialityRouteArgs({
    this.key,
    required this.id,
    this.fromProfile,
  });

  final Key? key;

  final int id;

  final Profile? fromProfile;

  @override
  String toString() {
    return 'SpecialityRouteArgs{key: $key, id: $id, fromProfile: $fromProfile}';
  }
}

/// generated route for
/// [GradePersonPage]
class GradePersonRoute extends PageRouteInfo<GradePersonRouteArgs> {
  GradePersonRoute({
    Key? key,
    required User user,
  }) : super(
          GradePersonRoute.name,
          path: '/grade-person-page',
          args: GradePersonRouteArgs(
            key: key,
            user: user,
          ),
        );

  static const String name = 'GradePersonRoute';
}

class GradePersonRouteArgs {
  const GradePersonRouteArgs({
    this.key,
    required this.user,
  });

  final Key? key;

  final User user;

  @override
  String toString() {
    return 'GradePersonRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [EmptyPage]
class EmptyRoute extends PageRouteInfo<void> {
  const EmptyRoute()
      : super(
          EmptyRoute.name,
          path: '/empty',
        );

  static const String name = 'EmptyRoute';
}

/// generated route for
/// [RegistrationRequestPage]
class RegistrationRequestRoute extends PageRouteInfo<void> {
  const RegistrationRequestRoute()
      : super(
          RegistrationRequestRoute.name,
          path: 'registration-request-page',
        );

  static const String name = 'RegistrationRequestRoute';
}

/// generated route for
/// [RequestEmailPage]
class RequestEmailRoute extends PageRouteInfo<void> {
  const RequestEmailRoute()
      : super(
          RequestEmailRoute.name,
          path: 'request-email-page',
        );

  static const String name = 'RequestEmailRoute';
}

/// generated route for
/// [RequestSpecialityPage]
class RequestSpecialityRoute extends PageRouteInfo<void> {
  const RequestSpecialityRoute()
      : super(
          RequestSpecialityRoute.name,
          path: 'request-speciality-page',
        );

  static const String name = 'RequestSpecialityRoute';
}

/// generated route for
/// [UserInvitationFormPage]
class UserInvitationFormRoute extends PageRouteInfo<void> {
  const UserInvitationFormRoute()
      : super(
          UserInvitationFormRoute.name,
          path: 'form',
        );

  static const String name = 'UserInvitationFormRoute';
}

/// generated route for
/// [UserInvitationRegistrationPage]
class UserInvitationRegistrationRoute extends PageRouteInfo<void> {
  const UserInvitationRegistrationRoute()
      : super(
          UserInvitationRegistrationRoute.name,
          path: 'email',
        );

  static const String name = 'UserInvitationRegistrationRoute';
}

/// generated route for
/// [FeedPage]
class FeedRoute extends PageRouteInfo<void> {
  const FeedRoute()
      : super(
          FeedRoute.name,
          path: 'feed',
        );

  static const String name = 'FeedRoute';
}

/// generated route for
/// [CatalogPage]
class CatalogRoute extends PageRouteInfo<void> {
  const CatalogRoute()
      : super(
          CatalogRoute.name,
          path: 'catalog',
        );

  static const String name = 'CatalogRoute';
}

/// generated route for
/// [SelfProfilePage]
class SelfProfileRoute extends PageRouteInfo<void> {
  const SelfProfileRoute({List<PageRouteInfo>? children})
      : super(
          SelfProfileRoute.name,
          path: 'self-profile-page',
          initialChildren: children,
        );

  static const String name = 'SelfProfileRoute';
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: '',
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [KarmaPageWrapper]
class KarmaRouteWrapper extends PageRouteInfo<void> {
  const KarmaRouteWrapper({List<PageRouteInfo>? children})
      : super(
          KarmaRouteWrapper.name,
          path: 'karma',
          initialChildren: children,
        );

  static const String name = 'KarmaRouteWrapper';
}

/// generated route for
/// [KarmaInitialPage]
class KarmaInitialRoute extends PageRouteInfo<void> {
  const KarmaInitialRoute()
      : super(
          KarmaInitialRoute.name,
          path: '',
        );

  static const String name = 'KarmaInitialRoute';
}

/// generated route for
/// [KarmaHistoryPage]
class KarmaHistoryRoute extends PageRouteInfo<void> {
  const KarmaHistoryRoute()
      : super(
          KarmaHistoryRoute.name,
          path: 'history',
        );

  static const String name = 'KarmaHistoryRoute';
}

/// generated route for
/// [EditBrandInitialPage]
class EditBrandInitialRoute extends PageRouteInfo<void> {
  const EditBrandInitialRoute()
      : super(
          EditBrandInitialRoute.name,
          path: '',
        );

  static const String name = 'EditBrandInitialRoute';
}

/// generated route for
/// [EditBrandMainInformationPage]
class EditBrandMainInformationRoute extends PageRouteInfo<void> {
  const EditBrandMainInformationRoute()
      : super(
          EditBrandMainInformationRoute.name,
          path: 'main-information',
        );

  static const String name = 'EditBrandMainInformationRoute';
}

/// generated route for
/// [EditBrandContactsPage]
class EditBrandContactsRoute extends PageRouteInfo<void> {
  const EditBrandContactsRoute()
      : super(
          EditBrandContactsRoute.name,
          path: 'contacts',
        );

  static const String name = 'EditBrandContactsRoute';
}

/// generated route for
/// [EditBrandPortfolioPage]
class EditBrandPortfolioRoute extends PageRouteInfo<void> {
  const EditBrandPortfolioRoute()
      : super(
          EditBrandPortfolioRoute.name,
          path: 'portfolio',
        );

  static const String name = 'EditBrandPortfolioRoute';
}

/// generated route for
/// [EditBrandShopPage]
class EditBrandShopRoute extends PageRouteInfo<void> {
  const EditBrandShopRoute()
      : super(
          EditBrandShopRoute.name,
          path: 'shop',
        );

  static const String name = 'EditBrandShopRoute';
}

/// generated route for
/// [EditSpecialityInitialPage]
class EditSpecialityInitialRoute extends PageRouteInfo<void> {
  const EditSpecialityInitialRoute()
      : super(
          EditSpecialityInitialRoute.name,
          path: '',
        );

  static const String name = 'EditSpecialityInitialRoute';
}

/// generated route for
/// [EditSpecialityMainInformationPage]
class EditSpecialityMainInformationRoute extends PageRouteInfo<void> {
  const EditSpecialityMainInformationRoute()
      : super(
          EditSpecialityMainInformationRoute.name,
          path: 'main-information',
        );

  static const String name = 'EditSpecialityMainInformationRoute';
}

/// generated route for
/// [EditSpecialityContactsPage]
class EditSpecialityContactsRoute extends PageRouteInfo<void> {
  const EditSpecialityContactsRoute()
      : super(
          EditSpecialityContactsRoute.name,
          path: 'contacts',
        );

  static const String name = 'EditSpecialityContactsRoute';
}

/// generated route for
/// [EditSpecialityPortfolioPage]
class EditSpecialityPortfolioRoute extends PageRouteInfo<void> {
  const EditSpecialityPortfolioRoute()
      : super(
          EditSpecialityPortfolioRoute.name,
          path: 'portfolio',
        );

  static const String name = 'EditSpecialityPortfolioRoute';
}

/// generated route for
/// [EditSpecialityShopPage]
class EditSpecialityShopRoute extends PageRouteInfo<void> {
  const EditSpecialityShopRoute()
      : super(
          EditSpecialityShopRoute.name,
          path: 'shop',
        );

  static const String name = 'EditSpecialityShopRoute';
}

/// generated route for
/// [EditExtendedInformationInitialPage]
class EditExtendedInformationInitialRoute extends PageRouteInfo<void> {
  const EditExtendedInformationInitialRoute()
      : super(
          EditExtendedInformationInitialRoute.name,
          path: '',
        );

  static const String name = 'EditExtendedInformationInitialRoute';
}

/// generated route for
/// [EditExtendedInformationLanguagesPage]
class EditExtendedInformationLanguagesRoute extends PageRouteInfo<void> {
  const EditExtendedInformationLanguagesRoute()
      : super(
          EditExtendedInformationLanguagesRoute.name,
          path: 'languages',
        );

  static const String name = 'EditExtendedInformationLanguagesRoute';
}

/// generated route for
/// [EditExtendedInformationEducationPage]
class EditExtendedInformationEducationRoute extends PageRouteInfo<void> {
  const EditExtendedInformationEducationRoute()
      : super(
          EditExtendedInformationEducationRoute.name,
          path: 'education',
        );

  static const String name = 'EditExtendedInformationEducationRoute';
}

/// generated route for
/// [EditExtendedInformationCareerPage]
class EditExtendedInformationCareerRoute extends PageRouteInfo<void> {
  const EditExtendedInformationCareerRoute()
      : super(
          EditExtendedInformationCareerRoute.name,
          path: 'career',
        );

  static const String name = 'EditExtendedInformationCareerRoute';
}

/// generated route for
/// [EditExtendedInformationHobbyPage]
class EditExtendedInformationHobbyRoute extends PageRouteInfo<void> {
  const EditExtendedInformationHobbyRoute()
      : super(
          EditExtendedInformationHobbyRoute.name,
          path: 'hobby',
        );

  static const String name = 'EditExtendedInformationHobbyRoute';
}

/// generated route for
/// [EditExtendedInformationAnimalsPage]
class EditExtendedInformationAnimalsRoute extends PageRouteInfo<void> {
  const EditExtendedInformationAnimalsRoute()
      : super(
          EditExtendedInformationAnimalsRoute.name,
          path: 'animals',
        );

  static const String name = 'EditExtendedInformationAnimalsRoute';
}

/// generated route for
/// [ProfileCirclesPage]
class ProfileCirclesRoute extends PageRouteInfo<void> {
  const ProfileCirclesRoute()
      : super(
          ProfileCirclesRoute.name,
          path: '',
        );

  static const String name = 'ProfileCirclesRoute';
}

/// generated route for
/// [ProfileCirclesUsersPage]
class ProfileCirclesUsersRoute
    extends PageRouteInfo<ProfileCirclesUsersRouteArgs> {
  ProfileCirclesUsersRoute({
    Key? key,
    required Circle circle,
  }) : super(
          ProfileCirclesUsersRoute.name,
          path: 'information',
          args: ProfileCirclesUsersRouteArgs(
            key: key,
            circle: circle,
          ),
        );

  static const String name = 'ProfileCirclesUsersRoute';
}

class ProfileCirclesUsersRouteArgs {
  const ProfileCirclesUsersRouteArgs({
    this.key,
    required this.circle,
  });

  final Key? key;

  final Circle circle;

  @override
  String toString() {
    return 'ProfileCirclesUsersRouteArgs{key: $key, circle: $circle}';
  }
}
