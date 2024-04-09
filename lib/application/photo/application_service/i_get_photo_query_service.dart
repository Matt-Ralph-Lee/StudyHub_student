import 'package:flutter/material.dart';

import '../../../domain/photo/models/photo_path.dart';

abstract class IGetPhotoQueryService {
  Future<ImageProvider> get(final PhotoPath photoPath);
}
