import '../../../application/blockings/exception/blockings_use_case_exception_detail.dart';
import '../../../application/bookmarks/exception/bookmarks_use_case_exception_detail.dart';
import '../../../application/favorite_teachers/exception/favorite_teachers_use_case_exception_detail.dart';
import '../../../application/notification/exception/notification_use_case_exception_detail.dart';
import '../../../application/question/exception/question_use_case_exception_detail.dart';
import '../../../application/student/exception/student_use_case_exception_detail.dart';
import '../../../application/student_auth/exception/student_auth_use_case_exception_detail.dart';
import '../../../application/teacher_evaluation/exception/teacher_evaluation_use_case_exception_detail.dart';
import '../../../domain/blockings/exception/blockings_domain_exception_detail.dart';
import '../../../domain/bookmarks/exception/bookmarks_domain_exception_detail.dart';
import '../../../domain/favorite_teachers/exception/favorite_teachers_domain_exception_detail.dart';
import '../../../domain/notification/exception/notification_domain_exception_detail.dart';
import '../../../domain/notification/models/notification_id.dart';
import '../../../domain/notification/models/notification_text.dart';
import '../../../domain/notification/models/notification_title.dart';
import '../../../domain/question/exception/question_domain_exception_detail.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/question/models/question_photo.dart';
import '../../../domain/question/models/question_photo_path_list.dart';
import '../../../domain/question/models/question_text.dart';
import '../../../domain/question/models/question_title.dart';
import '../../../domain/question/models/selected_teacher_list.dart';
import '../../../domain/report/exception/report_domain_exception_detail.dart';
import '../../../domain/report/models/report_text.dart';
import '../../../domain/shared/name.dart';
import '../../../domain/shared/profile_photo.dart';
import '../../../domain/student/exception/student_domain_exception_detail.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../domain/student_auth/exception/student_auth_domain_exception_detail.dart';
import '../../../domain/student_auth/models/password.dart';
import '../../../domain/teacher_evaluation/exception/teacher_evaluation_domain_exception_detail.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation_comment.dart';
import '../../../domain/teacher_evaluation/models/teacher_evaluation_rating.dart';
import '../../../infrastructure/exceptions/blockings/blockings_infrastructure_exception_detail.dart';
import '../../../infrastructure/exceptions/bookmarks/bookmarks_infrastructure_exception_detail.dart';
import '../../../infrastructure/exceptions/favorite_teachers/favorite_teachers_infrastructure_exception_detail.dart';
import '../../../infrastructure/exceptions/notification/notification_infrastructure_exception_detail.dart';
import '../../../infrastructure/exceptions/question/question_infrastructure_exception_detail.dart';
import '../../../infrastructure/exceptions/student/student_infrastructure_exception_detail.dart';
import '../../../infrastructure/exceptions/student_auth/student_auth_infrastructure_exception_detail.dart';

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
  static const termsOfUseText = "利用規約";
  static const privacyPolicyText = "プライバシーポリシー";
  static const douisuruText = "に同意する";

  //error系
  static String getStudentAuthDomainExceptionMessage(
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

  static String getStudentAuthUseCaseExceptionMessage(
      StudentAuthUseCaseExceptionDetail detail) {
    switch (detail) {
      case StudentAuthUseCaseExceptionDetail.alreadyExists:
        return "メールアドレスは既に存在しています";
      case StudentAuthUseCaseExceptionDetail.notFound:
        return "アカウントが見つかりません。";
    }
  }

  static String getStudentAuthInfrastructureExceptionMessage(
      StudentAuthInfrastructureExceptionDetail detail) {
    switch (detail) {
      case StudentAuthInfrastructureExceptionDetail.emailAddressAlreadyInUse:
        return "メールアドレスは既に存在しています";
      case StudentAuthInfrastructureExceptionDetail.invalidEmailAddress:
        return "メールアドレスが正しくありません";
      case StudentAuthInfrastructureExceptionDetail.noRecentSignIn:
        return "直近のサインインがありません";
      case StudentAuthInfrastructureExceptionDetail.notSignedIn:
        return "サインインしていません";
      case StudentAuthInfrastructureExceptionDetail.studentDisabled:
        return "生徒のアカウントが削除されています";
      case StudentAuthInfrastructureExceptionDetail.studentNotFound:
        return "生徒のアカウントが見つかりません";
      case StudentAuthInfrastructureExceptionDetail.unexpected:
        return "想定外のエラーです、、";
      case StudentAuthInfrastructureExceptionDetail.weakPassword:
        return "パスワードが弱いです。";
      case StudentAuthInfrastructureExceptionDetail.wrongPassword:
        return "パスワードが誤っています。";
      case StudentAuthInfrastructureExceptionDetail.invalidCredential:
        return "メールアドレスかパスワードが間違っています。";
    }
  }

  static String studentUseCaseExceptionMessage(
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
      case StudentUseCaseExceptionDetail.notSignedIn:
        return "サインインしてません。サインインしてからやり直してください。";
    }
  }

  static String studentDomainExceptionMessage(
      StudentDomainExceptionDetail detail) {
    switch (detail) {
      case StudentDomainExceptionDetail.nameInvalidLength:
        return "ユーザー名は${Name.minLength}字以上${Name.maxLength}字以下にしてください。";
      case StudentDomainExceptionDetail.idInvalidLength:
        return "Idは${StudentId.minLength}字以上にしてください。";
      case StudentDomainExceptionDetail.invalidPhotoPath:
        return "画像パスが不正です。";
      case StudentDomainExceptionDetail.invalidPhotoSize:
        return "プロフィール画像の大きさは${ProfilePhoto.avaliableHeight}x${ProfilePhoto.availableWidth}にしてください";
      case StudentDomainExceptionDetail.invalidQuestionCount:
        return "質問数が不正です。";
      case StudentDomainExceptionDetail.invalidCombination:
        return "属性と職業が合っていません。";
    }
  }

  static String studentInfrastructureExceptionMessage(
      StudentInfrastructureExceptionDetail detail) {
    switch (detail) {
      case StudentInfrastructureExceptionDetail.studentNotFound:
        return "生徒が見つかりませんでした。";
    }
  }

  static String favoriteTeacherUseCaseExceptionMessage(
      FavoriteTeachersUseCaseExceptionDetail detail) {
    switch (detail) {
      case FavoriteTeachersUseCaseExceptionDetail.favoriteTeacherNotFound:
        return "フォロー中の講師が見つかりませんでした。";
    }
  }

  static String favoriteTeacherDomainExceptionMessage(
      FavoriteTeachersDomainExceptionDetail detail) {
    switch (detail) {
      case FavoriteTeachersDomainExceptionDetail.invalidIndex:
        return "indexが不正です。";
      case FavoriteTeachersDomainExceptionDetail.invalidTeacherLength:
        return "お気に入りの講師の数が多すぎます。";
      case FavoriteTeachersDomainExceptionDetail.duplicateTeacher:
        return "お気に入り済みの講師が選択されています。";
      case FavoriteTeachersDomainExceptionDetail.teacherNotFound:
        return "講師が見つかりませんでした。";
    }
  }

  static String favoriteTeacherInfrastructureExceptionMessage(
      FavoriteTeachersInfrastructureExceptionDetail detail) {
    switch (detail) {
      case FavoriteTeachersInfrastructureExceptionDetail.docNotFound:
        return "お気に入りの講師の情報が見つかりませんでした。";
    }
  }

  static String evaluationUseCaseExceptionMessage(
      EvaluationUseCaseExceptionDetail detail) {
    switch (detail) {
      case EvaluationUseCaseExceptionDetail.favoriteTeacherNotFound:
        return "フォロー中の講師が見つかりませんでした。";
    }
  }

  static String evaluationDomainExceptionMessage(
      TeacherEvaluationDomainExceptionDetail detail) {
    switch (detail) {
      case TeacherEvaluationDomainExceptionDetail.invalidCommentLength:
        return "評価は${TeacherEvaluationComment.minLength}以上${TeacherEvaluationComment.maxLength}以下にしてください";
      case TeacherEvaluationDomainExceptionDetail.invalidId:
        return "idが正しくありません";
      case TeacherEvaluationDomainExceptionDetail.invalidRatingValue:
        return "評価の値は${TeacherEvaluationRating.minValue}以上${TeacherEvaluationRating.maxValue}以下にしてください。";
    }
  }

  static String questionExceptionMessage(
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
      case QuestionUseCaseExceptionDetail.notAllowedToResolve:
        return "Questionを解決する権限がありませんでした。";
    }
  }

  static String questionDomainExceptionMessage(
      QuestionDomainExceptionDetail detail) {
    switch (detail) {
      case QuestionDomainExceptionDetail.idInvalidLength:
        return "${QuestionId.minLength}字以上にしてください";
      case QuestionDomainExceptionDetail.invalidIndex:
        return "不正なindexです";
      case QuestionDomainExceptionDetail.invalidPhotoLength:
        return "画像は${QuestionPhotoPathList.maxLength}枚までです。";
      case QuestionDomainExceptionDetail.invalidPhotoPath:
        return "画像パスが不正です";
      case QuestionDomainExceptionDetail.invalidPhotoSize:
        return "画像の大きさは${QuestionPhoto.dataSize}以下にしてください。";
      case QuestionDomainExceptionDetail.invalidSeenCount:
        return "閲覧数が不正です。";
      case QuestionDomainExceptionDetail.invalidTeacherLength:
        return "'先生の指定数が多すぎます。${SelectedTeacherList.maxLength}人以内にしてください。";
      case QuestionDomainExceptionDetail.textEmptyLength:
        return "質問を入力してください。";
      case QuestionDomainExceptionDetail.textInvalidLength:
        return "質問は${QuestionText.maxLength}字以上にしてください。";
      case QuestionDomainExceptionDetail.textInvalidLineLength:
        return "質問は${QuestionText.maxLine}行以内にしてください。";
      case QuestionDomainExceptionDetail.titleInvalidLength:
        return "タイトルは${QuestionTitle.minLength}字以上${QuestionTitle.maxLength}字以下にしてください。";
    }
  }

  static String questionInfrastructureExceptionMessage(
      QuestionInfrastructureExceptionDetail detail) {
    switch (detail) {
      case QuestionInfrastructureExceptionDetail.studentNotFound:
        return "生徒が見つかりませんでした。";
      case QuestionInfrastructureExceptionDetail.teacherNotFound:
        return "講師が見つかりませんでした。";
      case QuestionInfrastructureExceptionDetail.questionNotFound:
        return "質問が見つかりませんでした。";
    }
  }

  static String bookmarkUseCaseExceptionMessage(
      BookmarksUseCaseExceptionDetail detail) {
    switch (detail) {
      case BookmarksUseCaseExceptionDetail.bookmarksNotFound:
        return "Bookmarksが見つかりませんでした。";
    }
  }

  static String bookmarkInfrastructureExceptionMessage(
      BookmarksInfrastructureExceptionDetail detail) {
    switch (detail) {
      case BookmarksInfrastructureExceptionDetail.studentNotFound:
        return "生徒が見つかりませんでした。";
      case BookmarksInfrastructureExceptionDetail.teacherNotFound:
        return "講師が見つかりませんでした。";
      case BookmarksInfrastructureExceptionDetail.bookmarkNotFound:
        return "ブックマークが見つかりませんでした。";
    }
  }

  static String bookmarkDomainExceptionMessage(
      BookmarksDomainExceptionDetail detail) {
    switch (detail) {
      case BookmarksDomainExceptionDetail.duplicateQuestion:
        return "ブックマーク済みの質問です。";
      case BookmarksDomainExceptionDetail.questionNotFound:
        return "該当する質問が見つかりませんでした。";
    }
  }

  static String blockingsUseCaseExceptionMessage(
      BlockingsUseCaseExceptionDetail detail) {
    switch (detail) {
      case BlockingsUseCaseExceptionDetail.blockingsNotFound:
        return "ブロック中の講師が見つかりませんでした。";
    }
  }

  static String blockingsInfrastructureExceptionMessage(
      BlockingsInfrastructureExceptionDetail detail) {
    switch (detail) {
      case BlockingsInfrastructureExceptionDetail.studentNotFound:
        return "生徒が見つかりませんでした。";
    }
  }

  static String blockingsDomainExceptionMessage(
      BlockingsDomainExceptionDetail detail) {
    switch (detail) {
      case BlockingsDomainExceptionDetail.duplicateTeacher:
        return "ブロック済みの講師です。";
      case BlockingsDomainExceptionDetail.teacherNotFound:
        return "講師が見つかりません。";
    }
  }

  static String reportDomainExceptionMessage(
      ReportDomainExceptionDetail detail) {
    switch (detail) {
      case ReportDomainExceptionDetail.textInvalidLength:
        return "${ReportText.maxLength}字以下にしてください。";
      case ReportDomainExceptionDetail.textInvalidLineLength:
        return "${ReportText.maxLine}行以内にしてください。";
    }
  }

  //password_reset_page
  static const passwordResetTitle = "パスワード再設定";
  static const passwordResetMailAddressInputExplanationText =
      "登録されているメールアドレスを入力してください";
  static const passwordResetButtonText = "再設定用のメールを送信";
  static const resendedPasswordEmail = "再設定用のメールを送信しました";

  //mail_verification_page
  static const emailVerificationTitleText = "メール認証";
  static const emailVerificationSubtitleText =
      "入力されたメールアドレスに認証メールを送りました。\n認証後、以下の「認証しました」ボタンを押してください";
  static const emailVerificationButtonText = "メールを再送信";
  static const resendEmailVerificationText = "メールを再送信しました";
  static const haveVerified = "認証しました";

  //profile_input_page
  static const indicatorTextOneThird = "1/3";
  static const userProfileImageAndNameInputExplanationText =
      "アイコンとユーザー名を入力してください";
  static const userProfileImageInputLabelText = "アイコン";
  static const usernameTextFieldLabelText = "ユーザ名";
  static const userNameErrorText = "ユーザ名は${Name.maxLength}字以下にしてください";

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
  static const notSelectText = "選択しない";

  static const academicHistoryInputExplanationText = "最終学歴を入力してください";

  static const academicHistoryTextFieldLabelText = "最終学歴";
  static const academicHistoryRadioBoxLabelText = "学年";
  static const academicHistoryOptionGraduate = "卒業";
  static const academicHistoryOptionOther = "その他";

  static const indicatorTextFin = "Fin.";
  static const welcomeText = "ようこそ〜！🥳";

  static const skipButtonText = "スキップ";
  static const backButtonText = "戻る";
  static const nextButtonText = "次へ";

  //menu_page
  static const menuText = "メニュー";
  static const otherFunctionsButtonExplanationText = "その他の機能";
  static const searchTeachersButtonText = "講師検索ページ";
  static const checkBlockingTeachersButtonText = "ブロック中の講師を確認する";
  static const inquiryButtonText = "お問い合わせはこちら";
  static const inquiryUrlText =
      "https://docs.google.com/forms/d/e/1FAIpQLSdRR5KTIlTp2c5ijBXGOieGswcvzL6n0L0qdjEMv-GxT-F4HQ/viewform?usp=sf_link";

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
  static const editSuccessText = "プロフィールを変更しました！";

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
  static const rankDescriptionText =
      "質問数に応じて、Beginner/Novice/Advanced/Expertのいずれかのランクが付与されます。高ランクを目指して沢山質問しましょう！";
  static const expertDesuyoText = "最高ランクです！";
  static const noBookmarksFound = "ブックマークはありません";

  //question_and_answer_card_widget
  static const questionIconText = "Q.";
  static const answerIconText = "A.";
  static const noAnswerText = "回答までしばらくお待ちください";
  static const addBookmarkButtonText = "ブックマーク";
  static const deleteBookmarkButtonText = "ブックマーク中";
  static const addBookmarkText = "ブックマークに追加しました";
  static const deleteBookmarkText = "ブックマークから削除しました";

  //add_question_page
  static const questionTitleHintText = "タイトルを入力してください";
  static const questionTitleMaxLengthOverErrorText =
      "タイトルは${QuestionTitle.maxLength}以下にしてください";
  static const questionHintText = "質問を入力してください";
  static const questionMaxLengthOverErrorText =
      "質問は${QuestionText.maxLength}以下にしてください";
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
  static const maxImagesErrorText =
      "写真は${QuestionPhotoPathList.maxLength}枚までです！";
  static const maxTeachersErrorText =
      "希望できる講師は${SelectedTeacherList.maxLength}までです！";

  //evaluationPage
  static const evaluationText = "評価する";
  static const evaluationStarsText = "5段階で評価してください";
  static const evaluationContentText = "ご自由にコメントしてください！";
  static const evaluationInputHintText = "分かりやすいご説明ありがとうございます！";
  static const dateFormat = "yyyy/MM/dd";
  static const evaluationSnackBarText = "講師を評価しました！";
  static const confirmResolveQuestionModalTitleText = "質問を解決済みにしますか？";
  static const confirmResolveQuestionModalDescriptionText =
      "未解決にした場合、引き続き他の講師の回答を受け付けます。";
  static const resolveQuestionText = "解決済みにする";
  static const unResolveQuestionText = "未解決にする";
  static const resolveQuestionSnackbarText = "質問を解決済みにしました！";

  //shared
  static const defaultErrorText = "時間をおいてから再度お試しください";
  static const errorModalTitleText = "エラーです！";
  static const confirmModalTitleText = "以下の内容でよろしいですか？";
  static const modalOkText = "ok";
  static const cancelText = "キャンセル";
  static const closeText = "閉じる";
  static const followButtonText = "フォロー";
  static const unFollowButtonText = "フォロー中";
  static const unFollowButtonTextForAnswerCardMenu = "フォローから外す";
  static const addFavoriteTeacherText = "フォローしました！";
  static const deleteFavoriteTeacherText = "フォローから外しました、、";
  static const favoriteTeacherTextForSelectTeachersPage = "フォロー中の講師";
  static const popularTeachersText = "人気の講師";
  static const noTeachersFoundText = "該当する講師は見つかりませんでした。";
  static const reportText = "報告する";
  static const reportReason = "報告理由";
  static const reportContent = "報告内容";
  static const reportSnackBarText = "報告しました";
  static const blockText = "ブロックする";
  static const unBlockText = "ブロックを解除する";
  static const blockSnackBarText = "ブロックしました";
  static const deleteBlockSnackBarText = "ブロックを解除しました";
  static const confirmAddBlockingModalTitleText = "ブロックします。よろしいですか？";
  static const confirmAddBlockingModalDescriptionText =
      "ブロックした講師からは回答が付きません。なおブロックしたことは講師には伝わらないのでご安心ください";
  static const confirmDeleteBlockingModalTitleText = "ブロックから外します。よろしいですか？";
  static const confirmDeleteBlockingModalDescriptionText =
      "ブロックを外した講師からは回答が付く可能性があります。なおブロックを解除したことは講師には伝わらないのでご安心ください";
  static const termsOfUseUrlText =
      "https://studyhub.hatenablog.com/entry/2023/10/10/190449?_gl=1*1v37cxu*_gcl_au*MTQ2Nzk4ODQ4LjE3MTM0Mjk5Njg.";
  static const privacyPolicyUrlText =
      "https://studyhub.hatenablog.com/entry/2023/10/10/185904?_gl=1*s0mjtx*_gcl_au*MTQ2Nzk4ODQ4LjE3MTM0Mjk5Njg.";

  //questionPage
  static const questionAndAnswerPageTitleText = "Q&A";
  static const answersTitleText = "講師からの回答";
  static const navigateToEvaluationPage = "この教師を評価する";

  //teacher_profile_page
  static const teacherProfilePageTitle = "教師のプロフィール";
  static const evaluationsTitleText = "生徒からの評価";
  static const careerText = "経歴";
  static const fromText = "出身";
  static const enrollmentText = "在籍";
  static const favoriteSubjectText = "得意科目";
  static const bioText = "ひとこと";
  static const selfIntroductionText = "自己紹介";
  static const noTeacherProfileFoundText = "講師のプロフィールが見つかりませんでした。";

  //home_page
  static const titleText = "StudyHub";
  static const allTabText = "全て";
  static const middleSchoolMathTabText = "中学数学";
  static const middleSchoolEnglishTabText = "中学英語";
  static const highSchoolMathTabText = "高校数学";
  static const highSchoolEnglishTabText = "高校英語";

  //notification_page
  static const notificationTitleText = "お知らせ";
  static const todayText = "今日";
  static const thisWeekText = "今週";
  static const beforeText = "先週以前"; //「それ以前」は相対的なもので、前者２つがなかった時に成立しない気がしたので
  static const noNotificationFound = "お知らせがありません";
  static const answeredNotificationTest = "回答が付きました！";
  static const infoText = "運営からのお知らせ";

  static String notificationInfrastructureExceptionMessage(
      NotificationInfrastructureExceptionDetail detail) {
    switch (detail) {
      case NotificationInfrastructureExceptionDetail.idAlreadyExist:
        return "通知は既読です";
      case NotificationInfrastructureExceptionDetail.notificationNotFound:
        return "通知が見つかりませんでした";
      case NotificationInfrastructureExceptionDetail.invalidReceiverType:
        return "開発側でのエラーが発生しました";
      case NotificationInfrastructureExceptionDetail.invalidSenderType:
        return "開発側でのエラーが発生しました";
      case NotificationInfrastructureExceptionDetail.invalidTargetType:
        return "開発側でのエラーが発生しました";
    }
  }

  static String notificationUseCaseExceptionMessage(
      NotificationUseCaseExceptionDetail detail) {
    switch (detail) {
      case NotificationUseCaseExceptionDetail.invalidDtoConstruction:
        return "Dtoが正しくありません。";
    }
  }

  static String notificationDomainExceptionMessage(
      NotificationDomainExceptionDetail detail) {
    switch (detail) {
      case NotificationDomainExceptionDetail.invalidNotificationIdLength:
        return "通知Idは${NotificationId.minLength}以上にしてください";
      case NotificationDomainExceptionDetail.invalidPhotoPath:
        return "写真のパスが正しくありません";
      case NotificationDomainExceptionDetail.invalidTitleLength:
        return "通知タイトルは${NotificationTitle.minLength}-${NotificationTitle.maxLength}である必要があります。";
      case NotificationDomainExceptionDetail.invalidTextLength:
        return "通知内容は ${NotificationText.maxLength} 以下である必要があります。";
      case NotificationDomainExceptionDetail.empty:
        return "空白です。";
      case NotificationDomainExceptionDetail.invalidTextLine:
        return "通知は ${NotificationText.maxLine} 行以下である必要があります。";
      case NotificationDomainExceptionDetail.senderTypeMismatched:
        return "通知者が正しくありません。";
      case NotificationDomainExceptionDetail.receiverTypeMismatched:
        return "受け取り側が正しくありません。";
      case NotificationDomainExceptionDetail.targetTypeMismatched:
        return "送信先が正しくありません。";
    }
  }

  //search_question_page
  static const noQuestionsFound = "該当する質問がありません";

  //blockings_page
  static const blockingPageTitleText = "ブロック中の講師";
  static const noBlockingTeacherFound = "ブロック中の講師はいません";
}
