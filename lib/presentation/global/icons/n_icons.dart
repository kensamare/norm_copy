// ignore_for_file: non_constant_identifier_names

class NIcons {
  static const String _path = 'assets/icons';

  /// Standart icons path.
  static String path(String name) => '$_path/$name.svg';

  /// Flags path.
  static String flagPath(String country) => '$_path/flags/$country.svg';

  /// Contact type path.
  static String contactPath(String contactType) => '$_path/contacts/$contactType.svg';

  // a.
  static final String add = path('add');
  static final String add_circle = path('add_circle');
  static final String arrow_dropdown = path('arrow_dropdown');
  static final String arrow_down = path('arrow_down');
  static final String arrow_left = path('arrow_left');
  static final String arrow_right = path('arrow_right');
  static final String arrow_right_2 = path('arrow_right_2');

  // b.
  static final String bag_2 = path('bag_2');
  static final String briefcase = path('briefcase');

  // c.
  static final String camera = path('camera');
  static final String calendar = path('calendar');
  static final String checkbox = path('checkbox');
  static final String checkbox_on = path('checkbox_on');
  static final String copy = path('copy');
  static final String complain = path('complain');

  // d.

  // e.
  static final String edit_2 = path('edit_2');
  static final String eye = path('eye');
  static final String eye_closed = path('eye_closed');

  // f.

  // g.
  static final String gallery = path('gallery');
  static final String gallery_add = path('gallery_add');
  static final String grid_2 = path('grid_2');

  // j.

  // h.
  static final String home_2 = path('home_2');

  // k.
  static final String karma_up = path('karma_up');
  static final String karma_down = path('karma_down');

  // l.
  static final String lock = path('lock');
  static final String location = path('location');
  static final String link = path('link');

  // m.
  static final String message = path('message');
  static final String more = path('more');
  static final String more_2 = path('more_2');

  // n.
  static final String notification = path('notification');

  // o.

  // p.
  static final String phone = path('phone');
  static final String profile = path('profile');

  // q.

  // r.
  static final String rating = path('rating');

  // s.
  static final String search = path('search');
  static final String settings = path('settings');
  static final String share = path('share');
  static final String shop = path('shop');
  static final String shop_add = path('shop_add');
  static final String star = path('star');

  // t.
  static final String teacher = path('teacher');
  static final String telegram = path('telegram');
  static final String trash = path('trash');

  // u.
  static final String user_add = path('user_add');
  static final String user_square = path('user_square');
}
