import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../components/parts/text_for_error.dart';
import '../components/parts/text_for_no_blocking_teacher_found.dart';
import '../components/widgets/teacher_small_card_skeleton_widget.dart';
import '../components/widgets/teacher_small_card_widget.dart';
import '../controllers/get_my_blockings_controller/get_my_blockings_controller.dart';
import '../controllers/get_teacher_profile_controller/get_teacher_profile_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';
import '../shared/constants/padding_set.dart';
import '../shared/constants/page_path.dart';

class BlockingTeachersPage extends ConsumerWidget {
  const BlockingTeachersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blockingsState = ref.watch(getBlockingsControllerProvider);

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
            L10n.blockingPageTitleText,
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
          child: blockingsState.when(
            data: (blockings) => blockings.isNotEmpty
                ? ListView.builder(
                    itemCount: blockings.length,
                    itemBuilder: (context, index) {
                      final blockingTeacher = blockings[index];
                      final blockingsTeacherProfileState =
                          ref.watch(getTeacherProfileControllerProvider(
                        blockingTeacher.teacherId,
                      ));
                      return blockingsTeacherProfileState.when(
                        data: (teacherProfile) => teacherProfile != null
                            ? TeacherSmallCardWidget(
                                name: teacherProfile.name,
                                bio: teacherProfile.bio,
                                iconUrl: teacherProfile.profilePhotoPath,
                                isSelected: false,
                                onTap: () => context.push(
                                    PageId.teacherProfile.path,
                                    extra: blockingTeacher.teacherId),
                              )
                            : const TeacherSmallCardSkeletonWidget(),
                        loading: () => const TeacherSmallCardSkeletonWidget(),
                        error: (error, stack) {
                          return const Center(
                              child: Column(
                            children: [
                              TextForError(),
                            ],
                          ));
                        },
                      );
                    },
                  )
                : const Center(
                    child: TextForNoBlockingsTeacherFound(),
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
