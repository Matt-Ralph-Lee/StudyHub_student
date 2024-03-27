import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/teacher/models/teacher_id.dart';
import '../components/parts/text_for_error.dart';
import '../components/parts/text_for_no_favorite_teacher_found.dart';
import '../components/parts/text_form_field_for_search_teachers.dart';
import '../components/widgets/favorite_teacher_card_widget.dart';
import '../components/widgets/loading_overlay_widget.dart';
import '../controllers/get_favorite_teacher_controller/get_favorite_teacher_controller.dart';
import '../controllers/search_for_teachers_controller/search_for_teachers_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';

class SelectTeachersPage extends HookConsumerWidget {
  final void Function(TeacherId) onPressed;
  final ValueNotifier<List<TeacherId>> selectedTeachers;

  const SelectTeachersPage({
    super.key,
    required this.onPressed,
    required this.selectedTeachers,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.1;
    final searchTeachersController = useTextEditingController();
    final searchTerm = useState<String>("");

    final favoriteTeachersState =
        ref.watch(getFavoriteTeacherControllerProvider);

    final searchForTeachersState =
        ref.watch(searchForTeachersControllerProvider(searchTerm.value));

    void setSearchTerm(String text) {
      searchTerm.value = text;
    }

    final tapState = useState(true);

    return Scaffold(
        backgroundColor: ColorSet.of(context).background,
        // floatingActionButton: SizedBox(
        //   height: 70,
        //   width: 70,
        //   child: FloatingActionButton(
        //     onPressed: selectedTeachersIdList.value.isNotEmpty
        //         ? () => onPressed(selectedTeachersIdList.value)
        //         : null,
        //     backgroundColor: selectedTeachersIdList.value.isNotEmpty
        //         ? ColorSet.of(context).primary
        //         : ColorSet.of(context).greySurface,
        //     shape: const CircleBorder(),
        //     child: Icon(
        //       Icons.check,
        //       color: ColorSet.of(context).icon,
        //       size: FontSizeSet.getFontSize(context, FontSizeSet.header1),
        //     ),
        //   ),
        // ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  color: ColorSet.of(context).icon,
                  size: FontSizeSet.getFontSize(
                    context,
                    FontSizeSet.header1,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: ColorSet.of(context).background,
              pinned: false,
              centerTitle: true,
              title: TextFormFieldForSearchForTeachers(
                controller: searchTeachersController,
                onSearched: setSearchTerm,
              ),
            ),
            if (searchTerm.value.isEmpty) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        L10n.favoriteTeacherTextForSelectTeachersPage,
                        style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.annotation),
                            color: ColorSet.of(context).greyText),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                sliver: favoriteTeachersState.when(
                  data: (teachers) => teachers.isNotEmpty
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final teacher = teachers[index];
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: TeacherSmallCardWidget(
                                      name: teacher.teacherName,
                                      bio: teacher.bio,
                                      iconUrl: teacher.profilePhotoPath,
                                      isSelected: selectedTeachers.value
                                          .contains(teacher.teacherId),
                                      onTap: () {
                                        onPressed(teacher.teacherId);
                                        tapState.value = !tapState.value;
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                            childCount: teachers.length,
                          ),
                        )
                      : const SliverToBoxAdapter(
                          child:
                              Center(child: TextForNoFavoriteTeacherFound())),
                  loading: () =>
                      const SliverToBoxAdapter(child: LoadingOverlay()),
                  error: (error, stack) => const SliverToBoxAdapter(
                      child: Center(child: TextForError())),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        L10n.popularTeachersText,
                        style: TextStyle(
                            fontWeight: FontWeightSet.normal,
                            fontSize: FontSizeSet.getFontSize(
                                context, FontSizeSet.annotation),
                            color: ColorSet.of(context).greyText),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                //getPopularTeachersControllerを実装してウォッチするようにする
                sliver: favoriteTeachersState.when(
                  data: (teachers) => teachers.isNotEmpty
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final teacher = teachers[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: TeacherSmallCardWidget(
                                  name: teacher.teacherName,
                                  bio: teacher.bio,
                                  iconUrl: teacher.profilePhotoPath,
                                  isSelected: selectedTeachers.value
                                      .contains(teacher.teacherId),
                                  onTap: () {
                                    onPressed(teacher.teacherId);
                                    tapState.value = !tapState.value;
                                  },
                                ),
                              );
                            },
                            childCount: teachers.length,
                          ),
                        )
                      : const SliverToBoxAdapter(
                          child:
                              Center(child: TextForNoFavoriteTeacherFound())),
                  loading: () =>
                      const SliverToBoxAdapter(child: LoadingOverlay()),
                  error: (error, stack) => const SliverToBoxAdapter(
                      child: Center(child: TextForError())),
                ),
              ),
            ] else ...[
              SliverPadding(
                padding: EdgeInsets.only(
                    top: 30, right: horizontalPadding, left: horizontalPadding),
                sliver: searchForTeachersState.when(
                  data: (teachers) => teachers != null && teachers.isNotEmpty
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              final teacher = teachers[index];
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: TeacherSmallCardWidget(
                                      name: teacher.name,
                                      bio: teacher.bio,
                                      iconUrl: teacher.profilePhotoPath,
                                      isSelected: selectedTeachers.value
                                          .contains(teacher.teacherId),
                                      onTap: () {
                                        onPressed(teacher.teacherId);
                                        tapState.value = !tapState.value;
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                            childCount: teachers.length,
                          ),
                        )
                      : SliverFillRemaining(
                          child: Center(
                            child: Text(L10n.noTeachersFoundText,
                                style: TextStyle(
                                    fontWeight: FontWeightSet.normal,
                                    fontSize: FontSizeSet.getFontSize(
                                        context, FontSizeSet.header3),
                                    color: ColorSet.of(context).text)),
                          ),
                        ),
                  loading: () =>
                      const SliverToBoxAdapter(child: LoadingOverlay()),
                  error: (error, stack) {
                    print("エラーはこれです$error");
                    print(stack);
                    return const SliverToBoxAdapter(
                      child: Center(
                          child: Column(
                        children: [
                          TextForError(),
                        ],
                      )),
                    );
                  },
                ),
              ),
            ]
          ],
        ));
  }
}
