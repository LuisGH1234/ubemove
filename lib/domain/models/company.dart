import 'package:ubermove/domain/core/base.domain.dart';

class Company extends Entity {
  final int id;
  final bool active;

  Company({this.id, this.active = true});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      active: json['active'],
    );
  }

  @override
  Map<String, dynamic> convertirJson() => {
        'id': id,
      };

  @override
  List<Object> get props => [id, active];
}
