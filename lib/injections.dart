import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:project_initiative_club_app/features/Maps/data/datasources/maps_local_data_source.dart';
import 'package:project_initiative_club_app/features/Maps/data/datasources/maps_remote_data_source.dart';
import 'package:project_initiative_club_app/features/Maps/data/repositories/maps_repository.dart';
import 'package:project_initiative_club_app/features/Maps/domain/repositories/maps_repository.dart';
import 'package:project_initiative_club_app/features/Maps/domain/usecases/itinerary.dart';
import 'package:project_initiative_club_app/features/Maps/domain/usecases/maps_data.dart';
import 'package:project_initiative_club_app/features/Maps/presentation/blocs/maps_data/mapsdata_bloc.dart';
import 'package:project_initiative_club_app/features/News/data/datasources/news_local_data_source.dart';
import 'package:project_initiative_club_app/features/News/data/datasources/news_remote_data_source.dart';
import 'package:project_initiative_club_app/features/News/data/repository/news_repository.dart';
import 'package:project_initiative_club_app/features/News/domain/repository/news_repository.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/add_news_usecase.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/pi_news_usecase.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/usthb_news_usecase.dart';
import 'package:project_initiative_club_app/features/News/presentation/blocs/news/newsbloc_bloc.dart';
import 'package:project_initiative_club_app/features/Scolarity/presentation/blocs/scolarity_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Lost
  sl.registerFactory(
      () => MapsdataBloc(itineraryCase: sl(), mapsDataCase: sl()));

  sl.registerFactory(() => NewsblocBloc(
      clubNewsUsecase: sl(), usthbNewsUsecase: sl(), addNewsUseCase: sl()));

  sl.registerFactory(() => ScolarityBloc());

  //* UseCase
  sl.registerLazySingleton(() => MapsDataCase(mapsRepository: sl()));
  sl.registerLazySingleton(() => ItineraryCase(mapsRepository: sl()));
  sl.registerLazySingleton(() => AddNewsUseCase(newsRepository: sl()));
  sl.registerLazySingleton(() => PiNewsUseCase(newsRepository: sl()));
  sl.registerLazySingleton(() => UsthbNewsCase(newsRepository: sl()));

  //* Repository
  sl.registerLazySingleton<MapsRepository>(
      () => MapsRepositoryImpl(localDataSource: sl(), remoteDataSource: sl()));

  sl.registerLazySingleton<NewsRepository>(
      () => NewsRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()));

  //*DataSources
  sl.registerLazySingleton<MapsRemoteDataSource>(
      () => MapsRemoteDataSourceImpl());

  sl.registerLazySingleton<MapsLocalDataSource>(
      () => MapsLocalDataSourceImpl());

  sl.registerLazySingleton<NewsLocalDataSource>(
      () => NewsLocalDataSourceImpl());
  sl.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl(firestore: sl(), storage: sl()));

  //* Other
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
}
