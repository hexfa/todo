import 'package:equatable/equatable.dart';

class Attachment extends Equatable {
  final String fileName;
  final String fileType;
  final String fileUrl;
  final String resourceType;

  const Attachment({
    required this.fileName,
    required this.fileType,
    required this.fileUrl,
    required this.resourceType,
  });

  @override
  List<Object?> get props => [fileName, fileType, fileUrl, resourceType];
}
