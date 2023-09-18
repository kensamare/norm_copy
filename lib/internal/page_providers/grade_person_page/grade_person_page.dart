// Flutter imports:
import 'package:flutter/material.dart';
import 'package:norm/domain/models/user/user.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/grade_person_page/states/grade_person_state.dart';
import 'package:norm/presentation/pages/grade_person_page/grade_person_page_view.dart';

class GradePersonPage extends StatelessWidget {
  const GradePersonPage({Key? key, required this.user}) : super(key: key);

  final User user;

  static const String routeName = '/grade-person-page';

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => GradePersonState(),
      child: GradePersonPageView(user: user),
    );
  }
}
