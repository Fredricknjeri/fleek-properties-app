import 'package:equatable/equatable.dart';
import '../models/property.dart';

abstract class PropertyEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProperties extends PropertyEvent {}

class AddProperty extends PropertyEvent {
  final Property property;

  AddProperty(this.property);

  @override
  List<Object> get props => [property];
}

class UpdateProperty extends PropertyEvent {
  final int id;
  final Property property;

  UpdateProperty(this.id, this.property);

  @override
  List<Object> get props => [id, property];
}

class DeleteProperty extends PropertyEvent {
  final int id;

  DeleteProperty(this.id);

  @override
  List<Object> get props => [id];
}
