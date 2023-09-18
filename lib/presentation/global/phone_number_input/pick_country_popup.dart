// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/country_code/country_code.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/country_codes_state/country_codes_state.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/search_field/search_field.dart';

class PickCountryPopup extends StatefulWidget {
  const PickCountryPopup({
    super.key,
    required this.code,
  });

  final CountryCode code;

  @override
  State<PickCountryPopup> createState() => _PickCountryPopupState();
}

class _PickCountryPopupState extends State<PickCountryPopup> {
  CountryCodesState get state => service<CountryCodesState>();

  /// Filtered country codes.
  List<CountryCode> get countryCodes => search.isBlank
      ? state.countryCodes
      : state.countryCodes
          .where((e) => e.names.values.any((e) => e.toLowerCase().contains(search!.toLowerCase())))
          .toList();

  String? search;

  Widget _buildSearchBar(BuildContext context) {
    return PaddedContent(
      child: SearchField(
        onChanged: (value) => setState(() => search = value),
      ),
    );
  }

  Widget _buildCountryCode(BuildContext context, {required CountryCode code}) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(code),
      child: Ink(
        height: 52.h,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              NIcon(
                NIcons.flagPath(code.id),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  code.names[L10n.of(context)!.localeName] ?? code.names.values.first,
                  style: NTypography.golosRegular14
                      .copyWith(height: 1.0, color: code == widget.code ? NColors.greenPrimary : null),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 14.w),
              Center(
                child: Icon(
                  Icons.done_rounded,
                  color: code == widget.code ? NColors.greenPrimary : Colors.transparent,
                  size: 24.r,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCountries(BuildContext context) {
    return SizedBox(
      height: 600.h,
      child: Align(
        alignment: Alignment.topCenter,
        child: ListView.separated(
          padding: EdgeInsets.only(bottom: 24.h, top: 12.h),
          itemBuilder: (context, index) {
            final CountryCode code = countryCodes.elementAt(index);

            return _buildCountryCode(context, code: code);
          },
          separatorBuilder: (_, __) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(height: 1.0, color: NColors.gray2),
          ),
          itemCount: countryCodes.length,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildSearchBar(context),
        SizedBox(height: 12.h),
        _buildCountries(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildContent(context),
    );
  }
}
