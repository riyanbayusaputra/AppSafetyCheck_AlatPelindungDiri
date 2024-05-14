

import 'package:cp6_apd/bloc/register/register_event.dart';
import 'package:cp6_apd/bloc/register/register_state.dart';
import 'package:cp6_apd/data/datasources/auth_datasources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthDatasource datasource;
  RegisterBloc(
    this.datasource,
  ) : super(RegisterInitial()) {
    on<SaveRegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      final result = await datasource.register(event.request);
      print(result);
      emit(RegisterLoaded(model: result));
    });
  }
}
