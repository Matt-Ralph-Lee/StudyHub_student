import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studyhub/presentation/components/parts/text_for_error.dart';
import 'package:studyhub/presentation/components/parts/text_for_no_favorite_teacher_found.dart';
import 'package:studyhub/presentation/shared/constants/color_set.dart';

import '../components/widgets/favorite_teacher_card_widget.dart';
import '../components/widgets/loading_overlay_widget.dart';
import '../controllers/favorite_teachers_controller/favorite_teachers_controller.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';

class FavoriteTeachersPage extends ConsumerWidget {
  const FavoriteTeachersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.1;
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalPadding = screenHeight * 0.05;

    final favoriteTeachersState = ref.watch(favoriteTeacherControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: ColorSet.of(context).icon,
            size: FontSizeSet.getFontSize(context, FontSizeSet.header1),
          ),
          onPressed: () => context.pop(),
        ),
        backgroundColor: ColorSet.of(context).background,
        centerTitle: true,
        title: Text(
          'お気に入りの講師',
          style: TextStyle(
              fontWeight: FontWeightSet.normal,
              fontSize: FontSizeSet.getFontSize(context, FontSizeSet.header3),
              color: ColorSet.of(context).text),
        ),
      ),
      backgroundColor: ColorSet.of(context).background,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        child: favoriteTeachersState.when(
          data: (teachers) => teachers.isNotEmpty
              ? ListView.builder(
                  itemCount: teachers.length,
                  itemBuilder: (context, index) {
                    final teacher = teachers[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: FavoriteTeacherCardWidget(
                        name: teacher.teacherName,
                        bio: teacher.bio,
                        iconUrl: teacher.profilePhotoPath,
                      ),
                    );
                  },
                )
              : const Center(
                  child: TextForNoFavoriteTeacherFound(),
                ),
          //ログイン時のやつ使い回すor専用に作る？
          loading: () => const LoadingOverlay(),
          //エラーときはテキストだけじゃなくてステップアップのログとかと一緒に表示するのもありかも？
          error: (error, _) => const Center(child: TextForError()),
        ),
      ),
    );
  }
}
