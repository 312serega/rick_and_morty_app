import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../resources/app_colors.dart';
import '../../resources/svgs_src.dart';
import '../../resources/text_style.dart';
import '../../widgets/buttons/outlie_btn.dart';
import '../../widgets/custom_chekbox.dart';
import '../main_screen/widget/main_vm.dart';

class FavoriteFilterScreen extends StatefulWidget {
  const FavoriteFilterScreen({super.key});

  @override
  State<FavoriteFilterScreen> createState() => _FavoriteFilterScreenState();
}

class _FavoriteFilterScreenState extends State<FavoriteFilterScreen> {
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

  late int statusSelected;
  late int genderSelected;

  @override
  void initState() {
    super.initState();
    final vm = context.read<MainVm>();
    // Получаем сохранённые значения из MainVm
    statusSelected = vm.statusSelected;
    genderSelected = vm.genderSelected;
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MainVm>();

    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        title: const Text('Фильтры', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (statusSelected != -1 || genderSelected != -1)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  statusSelected = -1;
                  genderSelected = -1;
                });
                // Очищаем фильтр в MainVm
                vm.clearFavoriteFilter();
                vm.statusSelected = -1;
                vm.genderSelected = -1;
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.colorGray,
                padding: EdgeInsets.zero,
              ),
              child: SvgPicture.asset(SvgsSrc.filterClear),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 35),
            Text(
              'Статус'.toUpperCase(),
              style: AppTextStyle.size10W500.copyWith(color: const Color(0xff5B6975)),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: statusList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, index) => CustomCheckBox(
                index: index,
                currentIndex: statusSelected,
                title: statusList[index][0],
                value: true,
                onTap: () {
                  setState(() {
                    statusSelected = statusSelected == index ? -1 : index;
                  });
                },
              ),
            ),
            const SizedBox(height: 35),
            const Divider(height: 2, thickness: 2, color: Color(0xff152A3A)),
            const SizedBox(height: 35),
            Text('Пол', style: AppTextStyle.size10W500.copyWith(color: const Color(0xff5B6975))),
            const SizedBox(height: 16),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: genderList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, index) => CustomCheckBox(
                index: index,
                currentIndex: genderSelected,
                title: genderList[index][0],
                value: true,
                onTap: () {
                  setState(() {
                    genderSelected = genderSelected == index ? -1 : index;
                  });
                },
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: OutlineBtn(
                text: 'Применить',
                onTap: () {
                  // Сохраняем выбранные индексы в MainVm
                  vm.statusSelected = statusSelected;
                  vm.genderSelected = genderSelected;

                  final status = statusSelected != -1 ? statusList[statusSelected][1] : '';
                  final gender = genderSelected != -1 ? genderList[genderSelected][1] : '';
                  vm.applyFavoriteFilter(status: status, gender: gender);

                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
