import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/resources/app_colors.dart';
import 'package:rick_and_morty/screens/user_screen/widgets/my_list_tile_episode.dart';

import '../../bloc/detail_bloc.dart';
import '../../widgets/my_list_tile.dart';
import 'widgets/my_sliver_app_bar.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DetailBloc>(context).add(GetDetailEvent(id: id.toString()));
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      body: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if (state is DetailLoadingState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(backgroundColor: Colors.green),
            );
          }

          if (state is DetailSuccessState) {
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: MySliverAppBar(
                    expandedHeight: 218,
                    networkImage: state.model.image!,
                    title: state.model.name!,
                  ),
                  pinned: true,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 120, 16, 0),
                      child: Column(
                        children: [
                          Text(
                            state.model.name!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.w500,
                              height: 1.14,
                            ),
                          ),
                          Text(
                            state.model.status!,
                            style: const TextStyle(
                              color: AppColors.colorSuccess,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Главный протагонист мультсериала «Рик и Морти». Безумный ученый, чей алкоголизм, безрассудность и социопатия заставляют беспокоиться семью его дочери.',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.5,
                              height: 1.53,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: MyListTile(title: 'Пол', subTitle: state.model.gender!),
                              ),
                              Expanded(
                                child: MyListTile(title: 'Раса', subTitle: state.model.species!),
                              ),
                            ],
                          ),
                          MyListTile(
                            title: 'Место рождения',
                            subTitle: state.model.origin!.name!,
                            iconName: Icons.arrow_forward_ios_rounded,
                          ),
                          MyListTile(
                            title: 'Местоположение',
                            subTitle: state.model.location!.name!,
                            iconName: Icons.arrow_forward_ios_rounded,
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    const Divider(height: 2, thickness: 2, color: Color(0xff152A3A)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Эпизоды',
                                style: TextStyle(color: Colors.white, fontSize: 20, height: 1.42),
                              ),
                              Text(
                                'Все эпизоды',
                                style: TextStyle(
                                  color: AppColors.colorSecondary,
                                  fontSize: 12,
                                  height: 1.33,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const MyListTileEpisode(
                            series: 'Серия 1',
                            title: 'Пилот',
                            subTitle: '2 декабря 2013',
                            iconName: Icons.arrow_forward_ios_rounded,
                          ),
                          const SizedBox(height: 14),
                          const MyListTileEpisode(
                            series: 'Серия 1',
                            title: 'Пилот',
                            subTitle: '2 декабря 2013',
                            iconName: Icons.arrow_forward_ios_rounded,
                          ),
                          const SizedBox(height: 14),
                          const MyListTileEpisode(
                            series: 'Серия 1',
                            title: 'Пилот',
                            subTitle: '2 декабря 2013',
                            iconName: Icons.arrow_forward_ios_rounded,
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            );
          }
          if (state is DetailErrorState) {
            return Center(
              child: Column(
                children: [
                  Image.network(
                    'https://s3-alpha-sig.figma.com/img/dc0c/4e75/4e17e96d57ba205ebfee7639eb7afa0e?Expires=1653264000&Signature=aYROGeaqbiyCu7kUDw1tVWmoEilkUWF2xxDnCYRKqrERGHuzMSKSYVewJIqFUn6ehUHiEINDa89PabD-eeilXsa~GIlqjorshCaaDxm2ZjjTvmB5A9sdcG5CvKmwCjnYnpxbi2oKKi-fxh1QBJbqkWSy4FJ68FY8glqQ7NzQe3Vpai65FlDPZcH2Y4niDfAM7D4aL27KnbXN7qPf-fUlQPPw0lil-nIQbBbO04rzveFGzsEe1lHC1Xc8jIr22ocQZDeSVUb~Y0NdSc06kDM8xrTl0MJz1FoeXrJwmSfmKXth9leQW03nneYexpRL7za4J~ka2SwW-mTriCjqBpLK0A__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA',
                    width: 100,
                    height: 100,
                  ),
                  const Text(
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
