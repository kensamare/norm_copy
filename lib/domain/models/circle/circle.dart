class Circle {
  static const String INVITES_ID = 'invites';

  const Circle({
    required this.id,
    required this.title,
    required this.subtitle,
  });

  /// Circle ID.
  final String id;

  /// Circle title.
  final String title;

  /// Circle subtitle.
  final String subtitle;
}
