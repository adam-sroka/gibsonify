part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GibsonsFormsLoaded extends HomeEvent {
  const GibsonsFormsLoaded();

  @override
  List<Object> get props => [];
}

class GibsonsFormDeleted extends HomeEvent {
  final String id;
  const GibsonsFormDeleted({required this.id});

  @override
  List<Object> get props => [id];
}

class CollectionDuplicationModeToggled extends HomeEvent {
  const CollectionDuplicationModeToggled();

  @override
  List<Object> get props => [];
}

class FinishedGibsonsFormsSavedToFile extends HomeEvent {
  final RecipesExportStatus recipesExportStatus;
  final int exportedRecipesNumber;
  const FinishedGibsonsFormsSavedToFile(
      {required this.recipesExportStatus, required this.exportedRecipesNumber});

  @override
  List<Object> get props => [recipesExportStatus, exportedRecipesNumber];
}

class FinishedGibsonsFormsShared extends HomeEvent {
  const FinishedGibsonsFormsShared();

  @override
  List<Object> get props => [];
}
