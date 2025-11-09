import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/app_colors.dart';
import '../screens/main_screen/widget/main_vm.dart';

void showModal(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final vm = context.watch<MainVm>();

      return AlertDialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.all(10),
        content: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.colorGray,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Темная тема', style: TextStyle(color: Colors.white, fontSize: 20)),
                const SizedBox(height: 24),
                CustomRadioBtn(
                  index: 0,
                  currentIndex: vm.themeSelect,
                  title: 'Выключенна',
                  onTap: () {
                    vm.themeSelect = 0;
                    vm.themeTitle = 'Выключенна';
                    vm.updateVm();
                  },
                ),
                const SizedBox(height: 24),
                CustomRadioBtn(
                  index: 1,
                  currentIndex: vm.themeSelect,
                  title: 'Включенна',
                  onTap: () {
                    vm.themeSelect = 1;
                    vm.themeTitle = 'Включенна';
                    vm.updateVm();
                  },
                ),
                const SizedBox(height: 24),
                CustomRadioBtn(
                  index: 2,
                  currentIndex: vm.themeSelect,
                  title: 'Следовать настройкам системы',
                  onTap: () {
                    vm.themeSelect = 2;
                    vm.themeTitle = 'Следовать настройкам системы';
                    vm.updateVm();
                  },
                ),
                const SizedBox(height: 24),
                CustomRadioBtn(
                  index: 3,
                  currentIndex: vm.themeSelect,
                  title: 'В режиме энергосбережения',
                  onTap: () {
                    vm.themeSelect = 3;
                    vm.themeTitle = 'В режиме энергосбережения';
                    vm.updateVm();
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'ok'.toUpperCase(),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class CustomRadioBtn extends StatelessWidget {
  CustomRadioBtn({
    super.key,
    required this.currentIndex,
    required this.title,
    required this.onTap,
    required this.index,
  });
  int index;
  final int currentIndex;
  Function() onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 25,
            height: 24,
            child: SizedBox(
              width: 24,
              height: 24,
              child: Icon(
                currentIndex == index ? Icons.radio_button_on : Icons.radio_button_off,
                size: 24.0,
                color: currentIndex == index ? AppColors.colorBlue : AppColors.colorSecondary,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              height: 1.5,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
