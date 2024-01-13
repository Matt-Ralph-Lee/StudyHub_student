import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart';

import '../../../domain/student/models/i_student_repository.dart';
import '../../../domain/photo/models/i_profile_photo_repository.dart';
import '../../../domain/student/models/profile_photo.dart';
import '../../../domain/student/models/profile_photo_path.dart';
import '../../../domain/student/models/student_id.dart';
import '../../shared/session/i_session.dart';
import '../exception/student_use_case_exception.dart';
import '../exception/student_use_case_exception_detail.dart';

class ProfilePhotoUpdateUseCase {
  final ISession _session;
  final IStudentRepository _repository;
  final IPhotoRepository _photoRepository;

  ProfilePhotoUpdateUseCase({
    required final ISession session,
    required final IStudentRepository repository,
    required final IPhotoRepository photoRepository,
  })  : _session = session,
        _repository = repository,
        _photoRepository = photoRepository;

  Future<void> execute(final String localPhotoPath) async {
    final studentId = _session.studentId;

    final String fileName = _createFileName(studentId);
    final path = ProfilePhotoPath('photos/profile_photo/$fileName.jpeg');
    final data = await _convertToJpegAndResize(localPhotoPath);
    final image = decodeImage(data);
    if (image == null) {
      throw const StudentUseCaseException(
          StudentUseCaseExceptionDetail.failedInImageProcessing);
    }
    final profilePhoto = ProfilePhoto(path: path, image: image);
    _photoRepository.save(profilePhoto);

    final student = _repository.findById(studentId);
    if (student == null) {
      throw const StudentUseCaseException(
          StudentUseCaseExceptionDetail.notFound);
    }
    final oldPhotoPath = student.profilePhotoPath;
    student.changeProfilePhoto(path);
    _repository.save(student);

    _photoRepository.delete(oldPhotoPath);
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
      '${studentId.value}-$year-${month.toString().padLeft(2, '0')}-${date.toString().padLeft(2, '0')}-${hour.toString().padLeft(2, '0')}-${minute.toString().padLeft(2, '0')}-${second.toString().padLeft(2, '0')}';
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
      copyResizeCropSquare(originalImage, size: ProfilePhoto.height);
  return encodeJpg(croppedImage);
}
