// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../../data/local/data_sources/local_data_source.dart' as _i9;
import '../../data/local/data_sources/preference_data_source.dart' as _i11;
import '../../data/local/database/app_database.dart' as _i3;
import '../../data/local/database/fav_dao.dart' as _i5;
import '../../data/local/database/user_dao.dart' as _i7;
import '../../data/remote/data_sources/movies_remote_data_source.dart' as _i10;
import '../../data/remote/service/web_service.dart' as _i8;
import '../../data/repository/database_repository_impl.dart' as _i16;
import '../../data/repository/movie_repository_impl.dart' as _i21;
import '../../data/repository/preference_repository_impl.dart' as _i13;
import '../../domain/repository/database_repository.dart' as _i15;
import '../../domain/repository/movie_repository.dart' as _i20;
import '../../domain/repository/preference_repository.dart' as _i12;
import '../../domain/usecases/account/login_usecase.dart' as _i18;
import '../../domain/usecases/account/profile_usecase.dart' as _i22;
import '../../domain/usecases/account/registration_usecase.dart' as _i23;
import '../../domain/usecases/movie/favorite_mapper_usecase.dart' as _i17;
import '../../domain/usecases/movie/get_cast_usecase.dart' as _i26;
import '../../domain/usecases/movie/get_latest_movies_usecase.dart' as _i27;
import '../../domain/usecases/movie/get_movie_detail_usecase.dart' as _i28;
import '../../domain/usecases/movie/get_movie_photos_usecase.dart' as _i29;
import '../../domain/usecases/movie/get_top_rated_movies_usecase.dart' as _i30;
import '../../domain/usecases/movie/manage_favorites_usecase.dart' as _i19;
import '../../ui/features/account/bloc/account_bloc.dart' as _i24;
import '../../ui/features/detail/bloc/detail_bloc.dart' as _i34;
import '../../ui/features/favorite/bloc/favorite_bloc.dart' as _i25;
import '../../ui/features/home/bloc/home_bloc.dart' as _i31;
import '../../ui/features/login/bloc/login_bloc.dart' as _i32;
import '../../ui/features/registration/bloc/registration_bloc.dart' as _i33;
import '../../ui/features/splash/bloc/splash_bloc.dart' as _i14;
import 'network_module.dart' as _i36;
import 'storage_module.dart' as _i35;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final storageModule = _$StorageModule();
    final networkModule = _$NetworkModule();
    await gh.singletonAsync<_i3.AppDatabase>(
      () => storageModule.provideDatabase(),
      preResolve: true,
    );
    gh.singleton<_i4.Dio>(networkModule.provideDio());
    gh.singleton<_i5.FavDao>(
        storageModule.provideFavDao(gh<_i3.AppDatabase>()));
    await gh.singletonAsync<_i6.SharedPreferences>(
      () => storageModule.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i7.UserDao>(
        storageModule.provideUserDao(gh<_i3.AppDatabase>()));
    gh.lazySingleton<_i8.WebService>(
        () => _i8.WebService.create(gh<_i4.Dio>()));
    gh.lazySingleton<_i9.LocalDataSource>(() => _i9.LocalDataSourceImpl(
          gh<_i7.UserDao>(),
          gh<_i5.FavDao>(),
        ));
    gh.lazySingleton<_i10.MoviesRemoteDataSource>(
        () => _i10.MoviesRemoteDataSourceImpl(gh<_i8.WebService>()));
    gh.singleton<_i11.PreferenceDataSource>(
        _i11.PreferenceDataSourceImpl(gh<_i6.SharedPreferences>()));
    gh.singleton<_i12.PreferenceRepository>(
        _i13.PreferenceRepositoryImpl(gh<_i11.PreferenceDataSource>()));
    gh.factory<_i14.SplashBloc>(
        () => _i14.SplashBloc(gh<_i12.PreferenceRepository>()));
    gh.lazySingleton<_i15.DatabaseRepository>(
        () => _i16.DatabaseRepositoryImpl(gh<_i9.LocalDataSource>()));
    gh.factory<_i17.FavoriteMapperUseCase>(
        () => _i17.FavoriteMapperUseCase(gh<_i15.DatabaseRepository>()));
    gh.factory<_i18.LoginUseCase>(
        () => _i18.LoginUseCase(gh<_i15.DatabaseRepository>()));
    gh.factory<_i19.ManageFavoritesUseCase>(
        () => _i19.ManageFavoritesUseCase(gh<_i15.DatabaseRepository>()));
    gh.lazySingleton<_i20.MovieRepository>(
        () => _i21.MovieRepositoryImpl(gh<_i10.MoviesRemoteDataSource>()));
    gh.factory<_i22.ProfileUseCase>(
        () => _i22.ProfileUseCase(gh<_i15.DatabaseRepository>()));
    gh.factory<_i23.RegistrationUseCase>(
        () => _i23.RegistrationUseCase(gh<_i15.DatabaseRepository>()));
    gh.factory<_i24.AccountBloc>(() => _i24.AccountBloc(
          gh<_i22.ProfileUseCase>(),
          gh<_i12.PreferenceRepository>(),
        ));
    gh.factory<_i25.FavoriteBloc>(
        () => _i25.FavoriteBloc(gh<_i19.ManageFavoritesUseCase>()));
    gh.factory<_i26.GetCastUseCase>(
        () => _i26.GetCastUseCase(gh<_i20.MovieRepository>()));
    gh.factory<_i27.GetLatestMoviesUseCase>(
        () => _i27.GetLatestMoviesUseCase(gh<_i20.MovieRepository>()));
    gh.factory<_i28.GetMovieDetailUseCase>(
        () => _i28.GetMovieDetailUseCase(gh<_i20.MovieRepository>()));
    gh.factory<_i29.GetMoviePhotosUseCase>(
        () => _i29.GetMoviePhotosUseCase(gh<_i20.MovieRepository>()));
    gh.factory<_i30.GetTopRatedMoviesUseCase>(
        () => _i30.GetTopRatedMoviesUseCase(gh<_i20.MovieRepository>()));
    gh.factory<_i31.HomeBloc>(() => _i31.HomeBloc(
          gh<_i27.GetLatestMoviesUseCase>(),
          gh<_i30.GetTopRatedMoviesUseCase>(),
          gh<_i17.FavoriteMapperUseCase>(),
        ));
    gh.factory<_i32.LoginBloc>(() => _i32.LoginBloc(
          gh<_i12.PreferenceRepository>(),
          gh<_i18.LoginUseCase>(),
        ));
    gh.factory<_i33.RegistrationBloc>(() => _i33.RegistrationBloc(
          gh<_i23.RegistrationUseCase>(),
          gh<_i12.PreferenceRepository>(),
        ));
    gh.factory<_i34.DetailBloc>(() => _i34.DetailBloc(
          gh<_i28.GetMovieDetailUseCase>(),
          gh<_i29.GetMoviePhotosUseCase>(),
          gh<_i26.GetCastUseCase>(),
        ));
    return this;
  }
}

class _$StorageModule extends _i35.StorageModule {}

class _$NetworkModule extends _i36.NetworkModule {}
