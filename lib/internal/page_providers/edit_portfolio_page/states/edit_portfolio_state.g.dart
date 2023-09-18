// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_portfolio_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditPortfolioState on _EditPortfolioStateBase, Store {
  Computed<User?>? _$userComputed;

  @override
  User? get user => (_$userComputed ??= Computed<User?>(() => super.user,
          name: '_EditPortfolioStateBase.user'))
      .value;
  Computed<List<Speciality>>? _$specialitiesComputed;

  @override
  List<Speciality> get specialities => (_$specialitiesComputed ??=
          Computed<List<Speciality>>(() => super.specialities,
              name: '_EditPortfolioStateBase.specialities'))
      .value;

  late final _$specialityAtom =
      Atom(name: '_EditPortfolioStateBase.speciality', context: context);

  @override
  Speciality? get speciality {
    _$specialityAtom.reportRead();
    return super.speciality;
  }

  @override
  set speciality(Speciality? value) {
    _$specialityAtom.reportWrite(value, super.speciality, () {
      super.speciality = value;
    });
  }

  late final _$portfolioAtom =
      Atom(name: '_EditPortfolioStateBase.portfolio', context: context);

  @override
  List<Portfolio> get portfolio {
    _$portfolioAtom.reportRead();
    return super.portfolio;
  }

  @override
  set portfolio(List<Portfolio> value) {
    _$portfolioAtom.reportWrite(value, super.portfolio, () {
      super.portfolio = value;
    });
  }

  @override
  String toString() {
    return '''
speciality: ${speciality},
portfolio: ${portfolio},
user: ${user},
specialities: ${specialities}
    ''';
  }
}
