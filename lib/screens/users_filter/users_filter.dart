import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/resources/text_style.dart';
import 'package:rick_and_morty/widgets/buttons/outlie_btn.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/users_bloc.dart';
import '../../resources/app_colors.dart';
import '../../resources/svgs_src.dart';
import '../../widgets/custom_chekbox.dart';
import '../main_screen/widget/main_vm.dart';

class UsersFilter extends StatefulWidget {
  const UsersFilter({super.key});

  @override
  State<UsersFilter> createState() => _UsersFilterState();
}

class _UsersFilterState extends State<UsersFilter> {
  // Map<String, String> statusList2 = {
  //   'alive': 'Живой',
  //   'dead': 'Мертвый',
  //   'unknown': 'Неизвестно',
  // };
  final List statusList = [
    ['Живой', 'alive'],
    ['Мертвый', 'dead'],
    ['Неизвестно', 'unknown'],
  ];
  final List genderList = [
    ['Мужской', 'male'],
    ['Женский', 'female'],
    ['Бесполый', 'genderless'],
  ];
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MainVm>();

    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.colorPrimary,
        centerTitle: false,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
            color: AppColors.colorGray,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const Text(
                  'Фильтры',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    height: 0.75,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                if (vm.initFilter)
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        vm.genderSelected = -1;
                        vm.statusSelected = -1;
                        vm.statusText = '';
                        vm.genderText = '';
                        vm.updateVm();
                        BlocProvider.of<UsersBloc>(context).add(
                          GetUsersEvent(
                            name: vm.name,
                            page: 1,
                            status: vm.statusText,
                            gender: vm.genderText,
                            isSearch: true,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.colorGray,
                        padding: EdgeInsets.zero,
                      ),
                      child: SvgPicture.asset(SvgsSrc.filterClear),
                    ),
                  ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Сортировать'.toUpperCase(),
                style: AppTextStyle.size10W500.copyWith(color: const Color(0xff5B6975)),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('По алфавиту', style: AppTextStyle.size16W400.copyWith(color: Colors.white)),
                  Row(
                    children: [
                      SizedBox(
                        width: 25,
                        child: ElevatedButton(
                          onPressed: () {
                            vm.filterAZ = 0;
                            vm.updateVm();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            backgroundColor: AppColors.colorPrimary,
                            elevation: 0,
                          ),
                          child: SvgPicture.asset(
                            'assets/svgs/0.svg',
                            color: vm.filterAZ == 0
                                ? AppColors.colorBlue
                                : AppColors.colorSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      SizedBox(
                        width: 25,
                        child: ElevatedButton(
                          onPressed: () {
                            vm.filterAZ = 1;
                            vm.updateVm();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                            backgroundColor: AppColors.colorPrimary,
                            elevation: 0,
                          ),
                          child: SvgPicture.asset(
                            'assets/svgs/1.svg',
                            color: vm.filterAZ == 0
                                ? AppColors.colorSecondary
                                : AppColors.colorBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 35),
              const Divider(height: 2, thickness: 2, color: Color(0xff152A3A)),
              const SizedBox(height: 35),
              Text(
                'Статус'.toUpperCase(),
                style: AppTextStyle.size10W500.copyWith(color: const Color(0xff5B6975)),
              ),
              const SizedBox(height: 24),

              // ...statusList2.map((key, val) {
              //   return Text('$key -- $val');
              // }).toList(),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => CustomCheckBox(
                  index: index,
                  currentIndex: vm.statusSelected,
                  title: statusList[index][0],
                  value: true,
                  onTap: () {
                    if (vm.statusSelected == index) {
                      vm.statusSelected = -1;
                      vm.statusText = '';
                    } else {
                      vm.statusSelected = index;
                      vm.statusText = statusList[index][1];
                    }
                    vm.updateVm();
                  },
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 24),
                itemCount: statusList.length,
              ),

              const Divider(height: 2, thickness: 2, color: Color(0xff152A3A)),
              const SizedBox(height: 35),
              Text(
                'Пол'.toUpperCase(),
                style: AppTextStyle.size10W500.copyWith(color: const Color(0xff5B6975)),
              ),
              const SizedBox(height: 24),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => CustomCheckBox(
                  index: index,
                  currentIndex: vm.genderSelected,
                  title: genderList[index][0],
                  value: true,
                  onTap: () {
                    if (vm.genderSelected == index) {
                      vm.genderSelected = -1;
                      vm.genderText = '';
                    } else {
                      vm.genderSelected = index;
                      vm.genderText = genderList[index][1];
                    }
                    vm.updateVm();
                  },
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 24),
                itemCount: statusList.length,
              ),

              const SizedBox(height: 34),
              SizedBox(
                width: double.infinity,
                child: OutlineBtn(
                  text: 'Применить',
                  onTap: () {
                    BlocProvider.of<UsersBloc>(context).add(
                      GetUsersEvent(
                        name: vm.name,
                        page: 1,
                        status: vm.statusText,
                        gender: vm.genderText,
                        isSearch: true,
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
