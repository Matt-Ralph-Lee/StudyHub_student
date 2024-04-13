import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../components/parts/text_for_error.dart';
import '../components/parts/text_for_no_favorite_teacher_found.dart';
import '../components/widgets/teacher_small_card_skeleton_widget.dart';
import '../components/widgets/teacher_small_card_widget.dart';
import '../controllers/get_favorite_teacher_controller/get_favorite_teacher_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/padding_set.dart';
import '../shared/constants/page_path.dart';

class FavoriteTeachersPage extends ConsumerWidget {
  const FavoriteTeachersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalPadding = screenHeight * 0.05;

    final favoriteTeachersState =
        ref.watch(getFavoriteTeacherControllerProvider);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: ColorSet.of(context).icon,
              size: FontSizeSet.getFontSize(
                context,
                30,
              ),
            ),
            onPressed: () => context.pop(),
          ),
          backgroundColor: ColorSet.of(context).background,
          centerTitle: true,
          title: Text(
            L10n.favoriteTeacherText,
            style: TextStyle(
                fontWeight: FontWeightSet.normal,
                fontSize: FontSizeSet.getFontSize(
                  context,
                  FontSizeSet.body,
                ),
                color: ColorSet.of(context).text),
          ),
        ),
        backgroundColor: ColorSet.of(context).background,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: PaddingSet.getPaddingSize(
              context,
              PaddingSet.horizontalPadding,
            ),
            vertical: PaddingSet.getPaddingSize(
              context,
              20,
            ),
          ),
          child: favoriteTeachersState.when(
            data: (teachers) => teachers.isNotEmpty
                ? ListView.builder(
                    itemCount: teachers.length,
                    itemBuilder: (context, index) {
                      final teacher = teachers[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: PaddingSet.getPaddingSize(
                            context,
                            PaddingSet.pageViewItemLightPadding,
                          ),
                        ),
                        child: TeacherSmallCardWidget(
                          name: teacher.teacherName,
                          bio: teacher.bio,
                          iconUrl: teacher.profilePhotoPath,
                          isSelected: false,
                          onTap: () => context.push(PageId.teacherProfile.path,
                              extra: teacher.teacherId), //ここ変えた
                        ),
                      );
                    },
                  )
                : const Center(
                    child: TextForNoFavoriteTeacherFound(),
                  ),
            loading: () => ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: PaddingSet.getPaddingSize(
                      context,
                      PaddingSet.pageViewItemLightPadding,
                    ),
                  ),
                  child: const TeacherSmallCardSkeletonWidget(),
                );
              },
            ),
            error: (error, stack) {
              return const Center(
                  child: Column(
                children: [
                  TextForError(),
                ],
              ));
            },
          ),
        ));
  }
}
