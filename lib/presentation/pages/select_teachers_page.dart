import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studyhub/presentation/controllers/get_favorite_teacher_controller/get_favorite_teacher_controller.dart';

import '../../domain/teacher/models/teacher_id.dart';
import '../components/parts/text_for_error.dart';
import '../components/parts/text_for_no_favorite_teacher_found.dart';
import '../components/parts/text_form_field_for_search_teachers.dart';
import '../components/widgets/favorite_teacher_card_widget.dart';
import '../components/widgets/loading_overlay_widget.dart';
import '../controllers/search_for_teachers_controller/search_for_teachers_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';

//①searchForTeachersControllerの実装→diの実装→インメモリのsearchForTeachersクエリサービスの実装
//②getPopularTeachersControllerの実装→getPopularTeacherのインターフェイスとインメモリのgetPopularTeacherクエリサービスの実装
//③createQuestionPageの方で、idためるリストと、リストをトグルずる関数を実装して渡す
//④検索されたときに、一枚目から検索結果に切り替えるロジック考える&実装する

class SelectTeachersPage extends ConsumerWidget {
  final void Function(List<TeacherId>) onPressed;
  const SelectTeachersPage({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.1;
    final searchTeachersController = useTextEditingController();
    final searchTerm = useState<String?>(null);
    final selectedTeachersIdList = useState<List<TeacherId>>([]);

    final favoriteTeachersState =
        ref.watch(getFavoriteTeacherControllerProvider);

    final searchForTeachersState = ref.watch(
        searchForTeachersControllerProvider(
            searchTerm.value)); //null受け取れないけどじゃあデフォはどうする？適当にユニークな値渡しておくとか？

    void setSearchTerm(String text) {
      searchTerm.value = text;
    }

    //カードタップされたらローカルのリストに該当するid保存
    //FTB押されたら受け取った関数（createQuestionPageのリストに追加する関数）を実行
    void addTeacherId(
      TeacherId teacherId,
    ) {
      if (selectedTeachersIdList.value == null) {
        selectedTeachersIdList.value = [teacherId];
      } else {
        final updatedList = List<TeacherId>.from(selectedTeachersIdList.value!);
        updatedList.add(teacherId);
        selectedTeachersIdList.value = updatedList;
      }
    }

    return Scaffold(
        backgroundColor: ColorSet.of(context).background,
        floatingActionButton: FloatingActionButton(
          onPressed: selectedTeachersIdList.value.isNotEmpty
              ? () => onPressed(selectedTeachersIdList.value)
              : null,
          backgroundColor: selectedTeachersIdList.value.isNotEmpty
              ? ColorSet.of(context).primary
              : ColorSet.of(context).greySurface,
          child: Icon(
            Icons.check,
            color: ColorSet.of(context).icon,
            size: FontSizeSet.getFontSize(context, FontSizeSet.header2),
          ),
        ),
        body: searchTerm.value != null
            ? CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    leading: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        color: ColorSet.of(context).icon,
                        size: FontSizeSet.getFontSize(
                            context, FontSizeSet.header1),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    backgroundColor: ColorSet.of(context).background,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: TextFormFieldForSearchForTeachers(
                        controller: searchTeachersController,
                        onSearched: setSearchTerm,
                      ),
                    ),
                    expandedHeight: 200,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "お気に入りの講師",
                            style: TextStyle(
                                fontWeight: FontWeightSet.normal,
                                fontSize: FontSizeSet.getFontSize(
                                    context, FontSizeSet.header3),
                                color: ColorSet.of(context).text),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    sliver: favoriteTeachersState.when(
                      data: (teachers) => teachers.isNotEmpty
                          ? SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final teacher = teachers[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: InkWell(
                                      //これ、カードウィジェット編集してあるのでそっちもコピペすること忘れずに。枠を追加してる
                                      child: teacherSmallCardWidget(
                                        name: teacher.teacherName,
                                        bio: teacher.bio,
                                        iconUrl: teacher.profilePhotoPath,
                                        isSelected: selectedTeachersIdList.value
                                                ?.contains(teacher.teacherId) ??
                                            false,
                                      ),
                                      onTap: () =>
                                          addTeacherId(teacher.teacherId),
                                    ),
                                  );
                                },
                                childCount: teachers.length,
                              ),
                            )
                          : const SliverToBoxAdapter(
                              child: Center(
                                  child: TextForNoFavoriteTeacherFound())),
                      loading: () =>
                          const SliverFillRemaining(child: LoadingOverlay()),
                      error: (error, stack) => const SliverFillRemaining(
                          child: Center(child: TextForError())),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("人気の講師"),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    //getPopularTeachersControllerを実装してウォッチするようにする
                    sliver: favoriteTeachersState.when(
                      data: (teachers) => teachers.isNotEmpty
                          ? SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final teacher = teachers[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: InkWell(
                                      //これ、カードウィジェット編集してあるのでそっちもコピペすること忘れずに。枠を追加してる
                                      child: teacherSmallCardWidget(
                                        name: teacher.teacherName,
                                        bio: teacher.bio,
                                        iconUrl: teacher.profilePhotoPath,
                                        isSelected: selectedTeachersIdList.value
                                                ?.contains(teacher.teacherId) ??
                                            false,
                                      ),
                                      onTap: () =>
                                          addTeacherId(teacher.teacherId),
                                    ),
                                  );
                                },
                                childCount: teachers.length,
                              ),
                            )
                          : const SliverToBoxAdapter(
                              child: Center(
                                  child: TextForNoFavoriteTeacherFound())),
                      loading: () =>
                          const SliverFillRemaining(child: LoadingOverlay()),
                      error: (error, stack) => const SliverFillRemaining(
                          child: Center(child: TextForError())),
                    ),
                  ),
                ],
              )
            : CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    sliver: searchForTeachersState.when(
                      data: (teachers) => teachers != null &&
                              teachers.isNotEmpty
                          ? ListView.builder(
                              itemCount: teachers.length,
                              itemBuilder: (context, index) {
                                final teacher = teachers[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: InkWell(
                                    child: teacherSmallCardWidget(
                                      name: teacher.name,
                                      bio: teacher.bio,
                                      iconUrl: teacher.profilePhotoPath,
                                      isSelected: selectedTeachersIdList.value
                                              ?.contains(teacher.teacherId) ??
                                          false,
                                    ),
                                    onTap: () =>
                                        addTeacherId(teacher.teacherId),
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: TextForNoFavoriteTeacherFound(),
                            ),
                      loading: () => const LoadingOverlay(),
                      error: (error, stack) {
                        print("エラーはこれです${error}");
                        print(stack);
                        return const Center(
                            child: Column(
                          children: [
                            TextForError(),
                          ],
                        ));
                      },
                    ),
                  ),
                ],
              ));
  }
}
