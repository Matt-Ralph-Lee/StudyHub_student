import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studyhub/presentation/components/widgets/answer_card_widget.dart';
import '../../application/favorite_teachers/exception/favorite_teachers_use_case_exception.dart';
import '../../application/favorite_teachers/exception/favorite_teachers_use_case_exception_detail.dart';
import '../../application/shared/application_service/question_card_dto.dart';
import '../../domain/teacher/models/teacher_id.dart';
import '../components/parts/completion_snack_bar.dart';
import '../components/parts/text_button_for_navigating_to_evaluatin_page.dart';
import '../components/widgets/question_card_widget.dart';
import '../components/widgets/question_pictures_widget.dart';
import '../components/widgets/specific_exception_modal_widget.dart';
import '../components/widgets/show_error_modal_widget.dart';
import '../controllers/add_favorite_teacher_controller/add_favorite_teacher_controller.dart';
import '../controllers/delete_favorite_teacher_controller/delete_favorite_teacher_controller.dart';
import '../shared/constants/color_set.dart';
import '../shared/constants/font_size_set.dart';
import '../shared/constants/font_weight_set.dart';
import '../shared/constants/l10n.dart';

class QuestionAndAnswerPage extends ConsumerWidget {
  final QuestionCardDto questionCardDto;
  final bool isMyQuestionNoEvaluated;
  const QuestionAndAnswerPage({
    super.key,
    required this.questionCardDto,
    required this.isMyQuestionNoEvaluated,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addFavoriteTeacherControllerState =
        ref.watch(addFavoriteTeacherControllerProvider);
    final deleteFavoriteTeacherControllerState =
        ref.watch(deleteFavoriteTeacherControllerProvider);

    void addFavoriteTeacher() async {
      ref
          .read(addFavoriteTeacherControllerProvider.notifier)
          .addFavoriteTeacher(
            TeacherId(
                '00000000000000000001'), //getTeacherProfileDtoではteacherIDを取得できない。
            //teacherIDを取得できるのはsearchTeachersDtoの方だが
            //これ使うにはそのユースケースが必要でそのためには検索ワードが必要で本来の使い方とは違うので、、
            //getTeacherProfileDtoにteacherIdをもたせるのがいい？と思うけどどうします？
          )
          .then((_) {
        if (addFavoriteTeacherControllerState is AsyncError) {
          final error = addFavoriteTeacherControllerState.error;
          if (error is FavoriteTeachersUseCaseException) {
            final errorText = L10n.favoriteTeacherUseCaseExceptionMessage(
                error.detail as FavoriteTeachersUseCaseExceptionDetail);
            SpecificExceptionModalWidget(context, errorText);
          } else {
            showErrorModalWidget(context);
          }
        } else {
          HapticFeedback.lightImpact();
          ScaffoldMessenger.of(context).showSnackBar(
            CompletionSnackBar(context, "お気に入りに追加しました"),
          );
        }
      });
    }

    void deleteFavoriteTeacher() async {
      ref
          .read(deleteFavoriteTeacherControllerProvider.notifier)
          .deleteFavoriteTeacher(
            TeacherId(
                '00000000000000000001'), //getTeacherProfileDtoではteacherIDを取得できない。
            //teacherIDを取得できるのはsearchTeachersDtoの方だが
            //これ使うにはそのユースケースが必要でそのためには検索ワードが必要で本来の使い方とは違うので、、
            //getTeacherProfileDtoにteacherIdをもたせるのがいい？と思うけどどうします？
          )
          .then((_) {
        if (deleteFavoriteTeacherControllerState is AsyncError) {
          final error = deleteFavoriteTeacherControllerState.error;
          if (error is FavoriteTeachersUseCaseException) {
            final errorText = L10n.favoriteTeacherUseCaseExceptionMessage(
                error.detail as FavoriteTeachersUseCaseExceptionDetail);
            SpecificExceptionModalWidget(context, errorText);
          } else {
            showErrorModalWidget(context);
          }
        } else {
          HapticFeedback.lightImpact();
          ScaffoldMessenger.of(context).showSnackBar(
            CompletionSnackBar(context, "お気に入りから削除しました"),
          );
        }
      });
    }

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
            "Q&A",
            style: TextStyle(
                fontWeight: FontWeightSet.normal,
                fontSize: FontSizeSet.getFontSize(context, FontSizeSet.header3),
                color: ColorSet.of(context).text),
          ),
        ),
        backgroundColor: ColorSet.of(context).background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              QuestionCardWidget(
                questionCardDto: questionCardDto,
              ),
              const SizedBox(
                height: 30,
              ),
              QuestionPicturesWidget(
                  photoPaths: "質問の写真達はどこから取得する？少なくともquestionDtoからは取得できなさそう"),
              const SizedBox(
                height: 50,
              ),
              AnswerCardWidget(
                questionCardDto: questionCardDto,
                isFollowed: null,
                followFunction: addFavoriteTeacher,
                unFollowFunction: deleteFavoriteTeacher,
              ),
              if (isMyQuestionNoEvaluated)
                const TextButtonForNavigatingToEvaluationPage()
            ],
          ),
        ));
  }
}
