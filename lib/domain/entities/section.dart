import 'package:equatable/equatable.dart';

class Section extends Equatable {
  final String id;
  final String name;

  const Section({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
