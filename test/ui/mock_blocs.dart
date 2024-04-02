import 'package:bloc_test/bloc_test.dart';
import 'package:flix/ui/features/detail/bloc/detail_bloc.dart';
import 'package:flix/ui/features/favorite/bloc/favorite_bloc.dart';
import 'package:flix/ui/features/registration/bloc/registration_bloc.dart';

class MockDetailBloc extends MockBloc<DetailEvent, DetailState>
    implements DetailBloc {}

class MockRegistrationBloc
    extends MockBloc<RegistrationEvent, RegistrationState>
    implements RegistrationBloc {}

class MockFavoriteBloc extends MockBloc<FavoriteEvent, FavoriteState>
    implements FavoriteBloc {}
