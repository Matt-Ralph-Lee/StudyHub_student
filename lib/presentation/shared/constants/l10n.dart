import 'package:studyhub/application/favorite_teachers/exception/favorite_teachers_use_case_exception_detail.dart';

import '../../../application/question/exception/question_use_case_exception_detail.dart';
import '../../../application/student/exception/student_use_case_exception_detail.dart';
import '../../../application/teacher_evaluation/exception/teacher_evaluation_use_case_exception_detail.dart';
import '../../../domain/question/models/question_photo.dart';
import '../../../domain/question/models/selected_teacher_list.dart';
import '../../../domain/student_auth/exception/student_auth_domain_exception_detail.dart';
import '../../../domain/student_auth/models/password.dart';

class L10n {
  //auth_page
  static const loginToggleText = "ログイン";
  static const signUpToggleText = "サインアップ";
  static const emailTextFieldHintText = "メールアドレス";
  static const passwordTextFieldHintText = "パスワード";
  static const loginButtonText = "ログイン";
  static const signUpButtonText = "サインアップ";
  static const resetPasswordTextButtonText = "パスワードを忘れた方はこちら";
  static const loginByGoogleButtonText = "Goggleでログイン";
  static const singUpErrorText = "サインアップ中にエラーが生じました。\nもう一度やり直してください。";
  static const emailIsEmptyText = "メールアドレスが空です";
  static const notContainAtText = "@が含まれておらず、メールアドレスの形式ではありません";
  static const notContainDotText = ".が含まれておらず、メールアドレスの形式ではありません";
  static const invalidEmailText = "メールアドレスの形式ではありません";
  static const isPasswordEmptyText = "パスワードが空です";

  //error系
  static String getStudentAuthExceptionMessage(
      StudentAuthDomainExceptionDetail detail) {
    switch (detail) {
      case StudentAuthDomainExceptionDetail.invalidCharacter:
        return "使用できない文字が含まれています。再度やり直してください";
      case StudentAuthDomainExceptionDetail.invalidEmailFormat:
        return "メールアドレスの形式ではありません。再度やり直してください";
      case StudentAuthDomainExceptionDetail.shortPassword:
        return "パスワードが短すぎます。${Password.minLength}文字以上にしてください";
      case StudentAuthDomainExceptionDetail.longPassword:
        return "パスワードが長すぎます。${Password.maxLength}文字以下にしてください";
    }
  }

  static String getStudentUseCaseExceptionMessage(
      StudentUseCaseExceptionDetail detail) {
    switch (detail) {
      case StudentUseCaseExceptionDetail.notFound:
        return "見つかりませんでした。再度やり直してください。";
      case StudentUseCaseExceptionDetail.failedInImageProcessing:
        return "画像の読み込みに失敗しました。再度やり直してください";
      case StudentUseCaseExceptionDetail.noSchoolFound:
        return "学校名が見つかりませんでした。";
      case StudentUseCaseExceptionDetail.noProfileFound:
        return "プロフィールが見つかりませんでした。";
      case StudentUseCaseExceptionDetail.photoNotFound:
        return "画像が見つかりませんでした。";
    }
  }

  static String favoriteTeacherUseCaseExceptionMessage(
      FavoriteTeachersUseCaseExceptionDetail detail) {
    switch (detail) {
      case FavoriteTeachersUseCaseExceptionDetail.favoriteTeacherNotFound:
        return "フォロー中の講師が見つかりませんでした。";
    }
  }

  static String evaluationUseCaseExceptionMessage(
      EvaluationUseCaseExceptionDetail detail) {
    switch (detail) {
      case EvaluationUseCaseExceptionDetail.favoriteTeacherNotFound:
        return "フォロー中の講師が見つかりませんでした。"; //これfavoriteTeacherNotFoundではないよね？元書き換えて
    }
  }

  static String getQuestionExceptionMessage(
      QuestionUseCaseExceptionDetail detail) {
    switch (detail) {
      case QuestionUseCaseExceptionDetail.failedDeleting:
        return "Questionを削除する権限がありませんでした。";
      case QuestionUseCaseExceptionDetail.failedEditing:
        return "'Questionを編集する権限がありませんでした。";
      case QuestionUseCaseExceptionDetail.questionNotFound:
        return "Questionが見つかりません。";
      case QuestionUseCaseExceptionDetail.imageNotFound:
        return "画像が見つかりませんでした。";
      case QuestionUseCaseExceptionDetail.failedImageProcessing:
        return "画像の処理に失敗しました。";
    }
  }

  //password_reset_page
  static const passwordResetTitle = "パスワード再設定";
  static const passwordResetMailAddressInputExplanationText =
      "登録されているメールアドレスを入力してください";
  static const passwordResetButtonText = "再設定用のメールを送信";

  //mail_verification_page
  static const emailVerificationTitleText = "メール認証";
  static const emailVerificationSubtitleText = "入力されたメールアドレスに認証メールを送りました";
  static const emailVerificationButtonText = "メールを再送信";

  //profile_input_page
  static const indicatorTextOneThird = "1/3";
  static const usernameInputExplanationText = "ユーザー名を入力してください";
  static const usernameTextFieldLabelText = "ユーザ名";

  static const indicatorTextTwoThirds = "2/3";
  static const genderAndJobInputExplanationText = "性別と職業を選択してください";

  static const genderRadioBoxLabelText = "性別";
  static const genderOptionNoAnswer = "回答しない";
  static const genderOptionMan = "男";
  static const genderOptionWomen = "女";
  static const genderOptionOther = "その他";

  static const jobRadioBoxLabelText = "職業";
  static const jobOptionStudent = "学生";
  static const jobOptionOfficeWorker = "会社員";
  static const jobOptionTeacher = "教師";
  static const jobOptionOther = "その他";

  static const indicatorTextThreeThirds = "3/3";
  static const schoolAndGradeInputExplanationText = "学校名と学年を入力してください";

  static const schoolTextFieldLabelText = "学校名";
  static const gradeRadioBoxLabelText = "学年";
  static const gradeOptionFirstGrade = "1年";
  static const gradeOptionSecondGrade = "2年";
  static const gradeOptionThirdGrade = "3年";
  static const gradeOptionForthGrade = "4年";

  static const academicHistoryInputExplanationText = "最終学歴を入力してください";

  static const academicHistoryTextFieldLabelText = "学校名";
  static const academicHistoryRadioBoxLabelText = "学年";
  static const academicHistoryOptionGraduate = "卒業";
  static const academicHistoryOptionOther = "その他";

  static const indicatorTextFin = "Fin.";
  static const welcomeText = "ようこそ";

  static const skipButtonText = "スキップ";
  static const backButtonText = "戻る";
  static const nextButtonText = "次へ";

  //menu_page
  static const menuText = "メニュー";
  static const otherFunctionsButtonExplanationText = "その他の機能";
  static const searchTeachersButtonText = "講師検索ページ";

  static const termsOfServiceInformationButtonExplanationText = "規約情報など";
  static const termsOfServiceButtonText = "利用規約";
  static const privacyPolicyButtonText = "個人情報保護規約";

  static const accountRelatedButtonExplanationText = "アカウント関連";
  static const editAccountInformationButtonText = "アカウント情報編集";
  static const logoutButtonText = "ログアウト";
  static const logoutSnackBarText = "ログアウトしました";
  static const deleteAccountButtonText = "アカウント削除";
  static const confirmDeleteAccount = "アカウントを削除します\nよろしいですか？";
  static const deleteAccountSnackBarText = "アカウントを削除しました";

  //favorite_teacher_page
  static const favoriteTeacherText = "フォロー中の講師";
  static const noFavoriteTeacherFoundText = "フォロー中の講師はいません";

  //profile_edit_page
  static const saveText = "保存する";
  static const takePictureText = "写真を撮る";
  static const selectPictureFromGalleryText = "ギャラリーから選ぶ";
  static const editSuccessText = "プロフィールを変更しました!";

  //my_page
  static const myQuestionTabText = "MyQuestion";
  static const bookmarkTabText = "BookMark";
  static const madeText = "まで";
  static const beginnerText = "beginner";
  static const noviceText = "novice";
  static const advancedText = "advanced";
  static const expertText = "expert";
  static const questionsText = "questions";
  static const colorText = "colorText";
  static const nextRankText = "nextRank";
  static const questionsForNextRankText = "questionsForNextRank";

  //question_and_answer_card_widget
  static const questionIconText = "Q.";
  static const answerIconText = "A.";
  static const noAnswerText = "回答までしばらくお待ちください";

  //add_question_page
  static const questionTitleHintText = "タイトルを入力してください";
  static const questionHintText = "質問を入力してください";
  static const selectSubject = "科目を選択してください";
  static const addImagesTextButtonText = "写真を追加";
  static const selectTeachersTextButtonText = "講師を希望する";
  static const changeTeachersTextButtonText = "講師を変更する";
  static const addQuestionButtonText = "質問する";
  static const addImagesButtonText = "写真を追加する";
  static const changeImagesButtonText = "写真を変更する";
  static const questionSnackBarText = "質問を投稿しました！";
  static const confirmQuestionModalTitleText = "以下の内容でよろしいですか？";
  static const subjectTextForConfirm = "科目";
  static const questionTitleTextForConfirm = "質問のタイトル";
  static const questionContentTextForConfirm = "質問内容";
  static const photosTextForConfirm = "関連する写真";
  static const selectedTeachersTextForConfirm = "希望する講師";

  //error系
  static const maxImagesErrorText = "写真は${QuestionPhoto.dataSize}枚まで！";
  static const maxTeachersErrorText =
      "希望できる講師は${SelectedTeacherList.maxLength}までです！";

  //evaluationPage
  static const evaluationText = "評価する";
  static const evaluationStarsText = "5段階で評価してください";
  static const evaluationContentText = "ご自由にコメントしてください";
  static const evaluationInputHintText = "分かりやすいお答えありがとうございます!";
  static const dateFormat = "yyyy/MM/dd";
  static const evaluationSnackBarText = "講師を評価しました!";

  //shared
  static const errorText = "エラーです。時間をおいてから再度お試しください";
  static const errorModalText = "エラーです！";
  static const confirmModalTitleText = "以下の内容でよろしいですか？";
  static const modalOkText = "ok";
  static const cancelText = "キャンセル";
  static const closeText = "閉じる";
  static const followButtonText = "フォローする";
  static const unFollowButtonText = "フォローから外す";
  static const addFavoriteTeacherText = "フォローしました";
  static const deleteFavoriteTeacherText = "フォローから外しました";
  static const favoriteTeacherTextForSelectTeachersPage = "フォロー中の講師";
  static const popularTeachersText = "人気の講師";
  static const noTeachersFoundText = "該当する講師は見つかりませんでした。";
  static const reportText = "投稿を報告する";
  static const reportReason = "報告理由";
  static const reportContent = "報告内容";
  static const reportSnackBarText = "投稿を報告しました";

  //questionPage
  static const questionAndAnswerPageTitleText = "Q&A";
  static const answersTitleText = "講師からの回答";
  static const navigateToEvaluationPage = "この教師を評価する";

  //teacher_profile_page
  static const teacherProfilePageTitle = "教師のプロフィール";
  static const evaluationsTitleText = "生徒からの評価";
  static const fromText = "出身";
  static const enrollmentText = "在籍";
  static const favoriteSubjectText = "得意科目";
  static const bioText = "ひとこと";
  static const selfIntroductionText = "自己紹介";
  static const noTeacherProfileFoundText = "講師のプロフィールが見つかりませんでした。";

  //home_page
  static const titleText = "StudyHub";
  static const allTabText = "全て";
  static const middleSchoolMathTabText = "中学英語";
  static const middleSchoolEnglishTabText = "中学数学";
  static const highSchoolMathTabText = "高校数学";
  static const highSchoolEnglishTabText = "高校英語";

  //notification_page
  static const notificationTitleText = "お知らせ";
  static const todayText = "今日";
  static const thisWeekText = "今週";
  static const beforeText = "それ以前";
  static const noNotificationFound = "お知らせがありません";

  //search_question_page
  static const noQuestionsFound = "該当する質問がありません";
}
