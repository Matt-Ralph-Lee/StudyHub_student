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
  static const otherFunctionsButtonExplanationText = "その他の機能";
  static const searchTeachersButtonText = "講師検索ページ";

  static const termsOfServiceInformationButtonExplanationText = "規約情報など";
  static const termsOfServiceButtonText = "利用規約";
  static const privacyPolicyButtonText = "個人情報保護規約";

  static const accountRelatedButtonExplanationText = "アカウント関連";
  static const editAccountInformationButtonText = "アカウント情報編集";
  static const logoutButtonText = "ログアウト";
  static const deleteAccountButtonText = "アカウント削除";

  //favorite_teacher_page
  static const favoriteTeacherText = "お気に入りの講師";
  static const noFavoriteTeacherFoundText = "お気に入りの講師はいません";

  //shared
  static const errorText = "エラーです。時間をおいてから再度お試しください";
  static const errorModalText = "エラーです！";
  static const modalBackText = "閉じる";

  //profile_edit_page
  static const cancelText = "キャンセル";
  static const saveText = "保存する";
  static const takePictureText = "写真を撮る";
  static const selectPictureFromGalleryText = "ギャラリーから選ぶ";

  //my_page
  static const myQuestionTabText = "MyQuestion";
  static const bookmarkTabText = "BookMark";

  //question_card_widget
  static const questionIconText = "Q.";
  static const answerIconText = "A.";
}
