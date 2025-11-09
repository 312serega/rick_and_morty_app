import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/bloc/users_bloc.dart';
import 'package:rick_and_morty/resources/app_colors.dart';
import 'package:rick_and_morty/screens/main_screen/widget/main_vm.dart';
import 'package:rick_and_morty/screens/main_screen/widget/user_item.dart';
import 'package:rick_and_morty/widgets/search_bar.dart';

class CharacterList extends StatelessWidget {
  CharacterList({super.key});
  final userCount = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MainVm>();

    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(54),
          child: ValueListenableBuilder(
            valueListenable: userCount,
            builder: (context, a, b) {
              return SearchBar(userCount: userCount.value);
            },
          ),
        ),
      ),
      body: BlocConsumer<UsersBloc, UsersState>(
        listener: (context, state) {
          if (state is UsersSuccessState) {
            if (userCount.value == 0) {
              userCount.value = state.userCount;
            }
          }
        },
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(backgroundColor: Colors.green),
            );
          }
          if (state is UsersSuccessState) {
            vm.scrollController.addListener(vm.nextPage);
            if (vm.goNext && vm.i < state.pageLength) {
              vm.i++;
              BlocProvider.of<UsersBloc>(context).add(
                GetUsersEvent(
                  page: vm.i,
                  name: vm.name,
                  isSearch: false,
                  status: vm.statusText,
                  gender: vm.genderText,
                ),
              );
              vm.goNext = false;
            }

            return Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
              child: CustomScrollView(
                controller: vm.scrollController,
                slivers: [
                  SliverGrid(
                    delegate: SliverChildListDelegate([
                      ...List.generate(
                        state.model.length,
                        (index) => UserItem(character: state.model[index], type: vm.type, vm: vm),
                      ),
                    ]),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: vm.type ? 1 : 2,
                      mainAxisExtent: vm.type ? 74 : 195,
                      mainAxisSpacing: 24,
                      // crossAxisSpacing: 17,
                    ),
                  ),
                  if (state.isLoading)
                    const SliverPadding(
                      sliver: SliverToBoxAdapter(
                        child: Center(
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: AppColors.colorSuccess,
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorGray),
                            ),
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                ],
              ),
            );
          }
          if (state is UserErrorState) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    state.searchType
                        ? 'assets/images/error_filter.png'
                        : 'assets/images/error_img.png',
                    width: 150,
                  ),
                  const SizedBox(height: 28),
                  state.searchType
                      ? const Text(
                          'По данным фильтра ничего не найдено',
                          style: TextStyle(color: Colors.white),
                        )
                      : const Text(
                          'Персонаж с таким именем не найден',
                          style: TextStyle(color: Colors.white),
                        ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
