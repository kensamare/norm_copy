// Package imports:
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/users_repository.dart';
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/interfaces/initializable.dart';
import 'package:norm/internal/utils/infrastructure.dart';

part 'connect_telegram_and_phone_state.g.dart';

class ConnectTelegramAndPhoneState = _ConnectTelegramAndPhoneStateBase with _$ConnectTelegramAndPhoneState;

abstract class _ConnectTelegramAndPhoneStateBase with Store implements Initializable {
  /// Telegram code for telegram bot.
  String? tgCode;

  /// Users repository.
  UsersRepository get _usersRepository => service<UsersRepository>();

  String get url => 'https://t.me/norm_ai_bot?start=$tgCode';

  @observable
  bool connectedTelegram = false;

  @observable
  bool connectedPhone = false;

  Future<void> connectTelegram() async {
    if (tgCode == null) return;

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: LaunchMode.externalNonBrowserApplication);

      // A bit of delay.
      await Future.delayed(NConstants.aSecond * 1.5);
      connectedTelegram = true;
    }
  }

  Future<void> _loadTgCode() async {
    final BaseResponse<User?> response = await _usersRepository.fetchCurrentUser();

    // If response is successful.
    if (response.successful) {
      tgCode = response.data!.telegramCode;
    }
  }

  @override
  Future<void> initialize() async {
    if (tgCode == null) await _loadTgCode();
  }
}
