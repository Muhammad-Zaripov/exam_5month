import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/history_repository.dart';
import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository repository;

  HistoryBloc(this.repository) : super(HistoryInitial()) {
    on<LoadHistoryEvent>((event, emit) async {
      emit(HistoryLoading());
      try {
        final history = await repository.getHistory();
        emit(HistoryLoaded(history));
      } catch (e) {
        emit(HistoryError(e.toString()));
      }
    });

    on<AddHistoryEvent>((event, emit) async {
      try {
        await repository.addToHistory(event.foodItem);
        add(LoadHistoryEvent());
      } catch (e) {
        emit(HistoryError(e.toString()));
      }
    });
  }
}
