import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart';

import '../../../domain/student/models/i_student_repository.dart';
import '../../../domain/student/models/profile_image/i_profile_image_repository.dart';
import '../../../domain/student/models/profile_image/profile_image.dart';
import '../../../domain/student/models/profile_image/profile_image_path.dart';
import '../../../domain/student/models/student_id.dart';
import '../../shared/session/i_session.dart';
import '../exception/student_use_case_exception.dart';
import '../exception/student_use_case_exception_detail.dart';

class ProfileImageUpdateUseCase {
  final ISession _session;
  final IStudentRepository _repository;
  final IProfileImageRepository _profileImageRepository;

  ProfileImageUpdateUseCase({
    required final ISession session,
    required final IStudentRepository repository,
    required final IProfileImageRepository profileImageRepository,
  })  : _session = session,
        _repository = repository,
        _profileImageRepository = profileImageRepository;

  void execute(final String localImagePath) async {
    final studentId = _session.studentId;

    final String fileName = _createFileName(studentId);
    final path = ProfileImagePath('images/profile_image/$fileName.jpeg');
    final data = await _convertToJpegAndResize(localImagePath);
    final image = decodeImage(data);
    if (image == null) {
      throw const StudentUseCaseException(
          StudentUseCaseExceptionDetail.failedInImageProcessing);
    }
    final profileImage = ProfileImage(path: path, image: image);
    _profileImageRepository.save(profileImage);

    final student = _repository.findById(studentId);
    if (student == null) {
      throw const StudentUseCaseException(
          StudentUseCaseExceptionDetail.notFound);
    }
    final oldImagePath = student.profileImagePath;
    student.changeProfileImage(path);
    _repository.save(student);

    _profileImageRepository.delete(oldImagePath);
  }
}

String _createFileName(final StudentId studentId) {
  final now = DateTime.now();

  final year = now.year;
  final month = now.month;
  final date = now.day;
  final hour = now.hour;
  final minute = now.minute;
  final second = now.second;
  final fileName =
      '${studentId.value}-$year-${month.toString().padLeft(2, '0')}-${date.toString().padLeft(2, '0')}-${hour.toString().padLeft(2, '0')}-${minute.toString().padLeft(2, '0')}-${second.toString().padLeft(2, '0')}.jpg';
  return fileName;
}

Future<Uint8List> _convertToJpegAndResize(String imagePath) async {
  final file = File(imagePath);
  final originalImageBytes = await file.readAsBytes();
  final originalImage = decodeImage(originalImageBytes);
  if (originalImage == null) {
    throw const StudentUseCaseException(
        StudentUseCaseExceptionDetail.failedInImageProcessing);
  }
  final croppedImage =
      copyResizeCropSquare(originalImage, size: ProfileImage.height);
  return encodeJpg(croppedImage);
}
