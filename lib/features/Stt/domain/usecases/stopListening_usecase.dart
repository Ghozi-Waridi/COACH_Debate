import 'package:choach_debate/features/Stt/domain/repositories/stt_repository.dart';

class StoplisteningUsecase {
  final SttRepository repository;

  StoplisteningUsecase(this.repository);

  void call() {
    repository.stopListening();
  }
}
