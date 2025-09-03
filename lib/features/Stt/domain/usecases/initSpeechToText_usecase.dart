import 'package:choach_debate/features/Stt/domain/repositories/stt_repository.dart';

class InitspeechtotextUsecase {
  final SttRepository repository;

  InitspeechtotextUsecase(this.repository);

  Future<bool> call() async {
    return await repository.initSpeechToText();
  }
}
