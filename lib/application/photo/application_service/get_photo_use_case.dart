import 'package:flutter/material.dart';

import '../../../domain/photo/models/photo_path.dart';
import '../../interfaces/i_logger.dart';
import 'i_get_photo_query_service.dart';

class _PhotoPath extends PhotoPath {
  _PhotoPath(super.value);
  @override
  void validate(final String value) {}
}

class GetPhotoUseCase {
  final IGetPhotoQueryService _queryService;
  final ILogger _logger;

  GetPhotoUseCase({
    required final IGetPhotoQueryService queryService,
    required final ILogger logger,
  })  : _queryService = queryService,
        _logger = logger;

  Future<ImageProvider> execute(final String photoPathData) async {
    _logger.info('BEGIN $GetPhotoUseCase.execute()');

    final photoPath = _PhotoPath(photoPathData);

    final image = await _queryService.get(photoPath);

    _logger.info('END $GetPhotoUseCase.execute()');
    return image;
  }
}
