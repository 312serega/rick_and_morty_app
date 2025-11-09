import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/resources/svgs_src.dart';
import 'package:rick_and_morty/screens/users_filter/users_filter.dart';
import 'package:flutter_svg/svg.dart';

import '../bloc/users_bloc.dart';
import '../resources/app_colors.dart';
import '../screens/main_screen/widget/main_vm.dart';

// ignore: must_be_immutable
class SearchBar extends StatelessWidget {
  SearchBar({super.key, required this.userCount});

  int userCount;
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MainVm>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: AppColors.colorGray,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            children: [
              SvgPicture.asset(SvgsSrc.search),
              const SizedBox(width: 10),
              Flexible(
                child: TextField(
                  controller: vm.searchController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    hintText: 'Найти персонажа',
                    hintStyle: const TextStyle(
                      color: AppColors.colorSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onChanged: (value) {
                    vm.updateSearch(value);
                    vm.name = value;
                    vm.i = 1;
                    BlocProvider.of<UsersBloc>(context).add(
                      GetUsersEvent(
                        name: value,
                        page: 1,
                        isSearch: true,
                        status: vm.statusText,
                        gender: vm.genderText,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 49,
                child: VerticalDivider(
                  color: AppColors.colorSecondary,
                  indent: 12,
                  endIndent: 12,
                  width: 1,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 24,
                height: 24,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UsersFilter()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.colorGray,
                    padding: EdgeInsets.zero,
                  ),
                  child: SvgPicture.asset(SvgsSrc.filter),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Всего персонажей: $userCount',
                style: const TextStyle(color: AppColors.colorSecondary),
              ),
              SizedBox(
                width: 24,
                height: 24,
                child: ElevatedButton(
                  onPressed: () {
                    vm.type = !vm.type;
                    vm.updateStat();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.colorPrimary,
                    padding: EdgeInsets.zero,
                  ),
                  child: SvgPicture.asset(vm.type ? SvgsSrc.grid : SvgsSrc.list),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
