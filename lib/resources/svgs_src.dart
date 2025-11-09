import 'dart:ui';

import 'package:flutter_svg/svg.dart';

import 'app_colors.dart';

class SvgsSrc {
  static const search = 'assets/svgs/search.svg';
  static const filter = 'assets/svgs/filter.svg';
  static const filterClear = 'assets/svgs/filter_clear.svg';
  static const grid = 'assets/svgs/grid.svg';
  static const list = 'assets/svgs/list.svg';
  static const palette = 'assets/svgs/palette.svg';

  static final SvgPicture character = SvgPicture.asset('assets/svgs/character.svg');
  static final SvgPicture characterActive = SvgPicture.asset(
    'assets/svgs/character.svg',
    colorFilter: ColorFilter.mode(AppColors.colorSuccess, BlendMode.srcIn),
  );
  static final SvgPicture location = SvgPicture.asset('assets/svgs/location.svg');
  static final SvgPicture locationActive = SvgPicture.asset(
    'assets/svgs/location.svg',
    colorFilter: ColorFilter.mode(AppColors.colorSuccess, BlendMode.srcIn),
  );

  static final SvgPicture favorite = SvgPicture.asset('assets/svgs/favorite.svg');
  static final SvgPicture favoriteActive = SvgPicture.asset(
    'assets/svgs/favorite.svg',
    colorFilter: ColorFilter.mode(AppColors.colorSuccess, BlendMode.srcIn),
  );
}
