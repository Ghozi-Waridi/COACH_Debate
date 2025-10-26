import 'package:choach_debate/features/Auth/data/datasources/auth_remote_data_source.dart';
import 'package:choach_debate/features/Auth/data/repositories/auth_repository_impl.dart';
import 'package:choach_debate/features/Auth/domain/repositories/auth_repository.dart';
import 'package:choach_debate/features/Auth/domain/usecases/getCurrentUser_usecase.dart';
import 'package:choach_debate/features/Auth/domain/usecases/singIn_usecase.dart';
import 'package:choach_debate/features/Auth/domain/usecases/singOut_usecase.dart';
import 'package:choach_debate/features/Auth/domain/usecases/singUp_usecase.dart';
import 'package:choach_debate/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:choach_debate/features/Debate/data/datasources/chat_datasource.dart';
import 'package:choach_debate/features/Debate/data/repositories/chat_repository_impl.dart';
import 'package:choach_debate/features/Debate/domain/repositories/chat_repository.dart';
import 'package:choach_debate/features/Debate/domain/usecases/create_session_usecase.dart';
import 'package:choach_debate/features/Debate/domain/usecases/send_message_usecase.dart';
import 'package:choach_debate/features/Debate/presentation/bloc/debate_bloc.dart';
import 'package:choach_debate/features/Profile/data/datasources/profile_remote_data_source.dart';
import 'package:choach_debate/features/Profile/data/repositories/profile_repository_impl.dart';
import 'package:choach_debate/features/Profile/domain/repositories/profile_repository.dart';
import 'package:choach_debate/features/Profile/domain/usecases/fetchProfile_usecase.dart';
import 'package:choach_debate/features/Profile/domain/usecases/updateProfile_usecase.dart';
import 'package:choach_debate/features/Profile/presentation/bloc/profile_bloc.dart';
import 'package:choach_debate/features/Stt/data/datasources/stt_datasource.dart';
import 'package:choach_debate/features/Stt/data/repositories/stt_repository_impl.dart';
import 'package:choach_debate/features/Stt/domain/repositories/stt_repository.dart';
import 'package:choach_debate/features/Stt/domain/usecases/initSpeechToText_usecase.dart';
import 'package:choach_debate/features/Stt/domain/usecases/startListening_usecase.dart';
import 'package:choach_debate/features/Stt/domain/usecases/stopListening_usecase.dart';
import 'package:choach_debate/features/Stt/presentation/bloc/stt_bloc.dart';
import 'package:choach_debate/features/Topics/data/datasources/topic_datasource.dart';
import 'package:choach_debate/features/Topics/data/repositories/topic_repository_impl.dart';
import 'package:choach_debate/features/Topics/domain/repositories/topic_repository.dart';
import 'package:choach_debate/features/Topics/domain/usecases/get_categori_usecase.dart';
import 'package:choach_debate/features/Topics/domain/usecases/get_topic_usecase.dart';
import 'package:choach_debate/features/Topics/presentation/bloc/topics_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Debate
  sl.registerFactory(() => DebateBloc(sendMessage: sl(), createSession: sl()));
  sl.registerLazySingleton(() => SendmessageUsecase(repository: sl()));
  sl.registerLazySingleton(() => CreateSessionUsecase(repository: sl()));
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(datasource: sl()),
  );
  sl.registerLazySingleton<ChatDatasource>(() => ChatDatasourceImpl(dio: sl()));

  // Topics
  sl.registerFactory(() => TopicsBloc(getTopicUsecase: sl(), getCategoriUsecase: sl()));
  sl.registerLazySingleton(() => GetTopicUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetCategoriUsecase(repository: sl()));
  sl.registerLazySingleton<TopicRepository>(
    () => TopicRepositoryImpl(topicDatasource: sl()),
  );
  sl.registerLazySingleton<TopicDatasource>(
    () => TopicDatasourceImpl(dio: sl()),
  );

  // STT
  sl.registerFactory(
    () => SttBloc(
      startListeningUsecase: sl(),
      initspeechtotextUsecase: sl(),
      stopListeningUsecase: sl(),
      getspeeshstreamUsecase: sl(),
    ),
  );

  sl.registerLazySingleton(() => StartListeningUsecase(sl()));
  sl.registerLazySingleton(() => StoplisteningUsecase(sl()));
  sl.registerLazySingleton(() => InitspeechtotextUsecase(sl()));

  sl.registerLazySingleton<SttRepository>(
    () => SttRepositoryImpl(datasource: sl()),
  );
  sl.registerLazySingleton<SttDatasource>(() => SttDatasourceImpl(sl()));

  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 60);
    dio.options.receiveTimeout = const Duration(seconds: 60);
    dio.options.sendTimeout = const Duration(seconds: 6);
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        requestHeader: true,
        error: true,
      ),
    );
    return dio;
  });

  // Auth
  sl.registerFactory(
    () => AuthBloc(
      singinUsecase: sl(),
      singupUsecase: sl(),
      singOutUsecase: sl(),
      getCurrentUsecase: sl(),
    ),
  );
  sl.registerLazySingleton(() => SinginUsecase(sl()));
  sl.registerLazySingleton(() => SingupUsecase(sl()));
  sl.registerLazySingleton(() => SingoutUsecase(sl()));
  sl.registerLazySingleton(() => GetcurrentuserUsecase(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(supabaseClient: sl()),
  );

  // Profile
  sl.registerFactory(
    () => ProfileBloc(fetchProfileUseCase: sl(), updateProfileUseCase: sl()),
  );
  sl.registerLazySingleton(() => FetchprofileUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdateprofileUsecase(repository: sl()));
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ProfileDataSource>(
    () => ProfileRemoteDataSourceImpl(supabaseClient: sl()),
  );

  // Supabase
  sl.registerLazySingleton(() => Supabase.instance.client);
}
