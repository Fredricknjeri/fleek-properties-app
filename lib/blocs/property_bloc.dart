import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/property_repository.dart';
import 'property_event.dart';
import 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  final PropertyRepository repository;

  PropertyBloc(this.repository) : super(PropertyLoading()) {
    on<FetchProperties>((event, emit) async {
      try {
        final properties = await repository.fetchProperties();
        emit(PropertyLoaded(properties));
      } catch (e) {
        emit(PropertyError(e.toString()));
      }
    });

    on<AddProperty>((event, emit) async {
      try {
        await repository.createProperty(event.property);
        add(FetchProperties());
      } catch (e) {
        emit(PropertyError(e.toString()));
      }
    });

    on<UpdateProperty>((event, emit) async {
      try {
        await repository.updateProperty(event.id, event.property);
        add(FetchProperties());
      } catch (e) {
        emit(PropertyError(e.toString()));
      }
    });

    on<DeleteProperty>((event, emit) async {
      try {
        await repository.deleteProperty(event.id);
        add(FetchProperties());
      } catch (e) {
        emit(PropertyError(e.toString()));
      }
    });
  }
}
