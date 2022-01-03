import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  final GibsonifyRepository _gibsonifyRepository;

  CollectionBloc({required GibsonifyRepository gibsonifyRepository})
      : _gibsonifyRepository = gibsonifyRepository,
        super(CollectionState()) {
    on<HouseholdIdChanged>(_onHouseholdIdChanged);
    on<RespondentNameChanged>(_onRespondentNameChanged);
    on<RespondentTelNumberChanged>(_onRespondentTelNumberChanged);
    on<InterviewDateChanged>(_onInterviewDateChanged);
    on<InterviewStartTimeChanged>(_onInterviewStartTimeChanged);
    on<FoodItemAdded>(_onFoodItemAdded);
    on<FoodItemDeleted>(_onFoodItemDeleted);
    on<FoodItemNameChanged>(_onFoodItemNameChanged);
    on<FoodItemTimePeriodChanged>(_onFoodItemTimePeriodChanged);
    on<FoodItemSourceChanged>(_onFoodItemSourceChanged);
    on<FoodItemDescriptionChanged>(_onFoodItemDescriptionChanged);
    on<FoodItemPreparationMethodChanged>(_onFoodItemPreparationMethodChanged);
    on<FoodItemMeasurementMethodChanged>(_onFoodItemMeasurementMethodChanged);
    on<FoodItemMeasurementValueChanged>(_onFoodItemMeasurementValueChanged);
    on<FoodItemMeasurementUnitChanged>(_onFoodItemMeasurementUnitChanged);
    on<FoodItemConfirmationChanged>(_onFoodItemConfirmationChanged);
    on<GibsonsFormSaved>(_onGibsonsFormSaved);
    on<GibsonsFormLoaded>(_onGibsonsFormLoaded);
    on<GibsonsFormCreated>(_onGibsonsFormCreated);
  }

  void _onHouseholdIdChanged(
      HouseholdIdChanged event, Emitter<CollectionState> emit) {
    final householdId = HouseholdId.dirty(event.householdId);
    GibsonsForm changedGibsonsForm = state.gibsonsForm.copyWith(
        householdId: householdId,
        sensitizationStatus: Formz.validate([
          householdId,
          state.gibsonsForm.respondentName,
          state.gibsonsForm.respondentTelNumber,
          state.gibsonsForm.interviewDate,
          state.gibsonsForm.interviewStartTime
        ]) // TODO: validate other sensitization fields once added
        );

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onRespondentNameChanged(
      RespondentNameChanged event, Emitter<CollectionState> emit) {
    final respondentName = RespondentName.dirty(event.respondentName);
    GibsonsForm changedGibsonsForm = state.gibsonsForm.copyWith(
        respondentName: respondentName,
        sensitizationStatus: Formz.validate([
          state.gibsonsForm.householdId,
          respondentName,
          state.gibsonsForm.respondentTelNumber,
          state.gibsonsForm.interviewDate,
          state.gibsonsForm.interviewStartTime
        ]));

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onRespondentTelNumberChanged(
      RespondentTelNumberChanged event, Emitter<CollectionState> emit) {
    final respondentTelNumber =
        RespondentTelNumber.dirty(event.respondentTelNumber);
    GibsonsForm changedGibsonsForm = state.gibsonsForm.copyWith(
        respondentTelNumber: respondentTelNumber,
        sensitizationStatus: Formz.validate([
          state.gibsonsForm.householdId,
          state.gibsonsForm.respondentName,
          respondentTelNumber,
          state.gibsonsForm.interviewDate,
          state.gibsonsForm.interviewStartTime
        ]));

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onInterviewDateChanged(
      InterviewDateChanged event, Emitter<CollectionState> emit) {
    final interviewDate = InterviewDate.dirty(event.interviewDate);
    GibsonsForm changedGibsonsForm = state.gibsonsForm.copyWith(
        interviewDate: interviewDate,
        sensitizationStatus: Formz.validate([
          state.gibsonsForm.householdId,
          state.gibsonsForm.respondentName,
          state.gibsonsForm.respondentTelNumber,
          interviewDate,
          state.gibsonsForm.interviewStartTime
        ]));

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onInterviewStartTimeChanged(
      InterviewStartTimeChanged event, Emitter<CollectionState> emit) {
    final interviewStartTime =
        InterviewStartTime.dirty(event.interviewStartTime);
    GibsonsForm changedGibsonsForm = state.gibsonsForm.copyWith(
        interviewStartTime: interviewStartTime,
        sensitizationStatus: Formz.validate([
          state.gibsonsForm.householdId,
          state.gibsonsForm.respondentName,
          state.gibsonsForm.respondentTelNumber,
          state.gibsonsForm.interviewDate,
          interviewStartTime
        ]));

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemAdded(FoodItemAdded event, Emitter<CollectionState> emit) {
    final foodItem = FoodItem();
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);
    foodItems.add(foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemDeleted(
      FoodItemDeleted event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    foodItems.remove(event.foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemNameChanged(
      FoodItemNameChanged event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    FoodItem foodItem = foodItems[changedFoodItemIndex].copyWith(
        name: Name.dirty(event.foodItemName),
        confirmed: false); // any change to FoodItem unconfirms it

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemTimePeriodChanged(
      FoodItemTimePeriodChanged event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    FoodItem foodItem = foodItems[changedFoodItemIndex].copyWith(
        timePeriod: TimePeriod.dirty(event.foodItemTimePeriod),
        confirmed: false);

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemSourceChanged(
      FoodItemSourceChanged event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    FoodItem foodItem = foodItems[changedFoodItemIndex]
        .copyWith(source: Source.dirty(event.foodItemSource), confirmed: false);

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemDescriptionChanged(
      FoodItemDescriptionChanged event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    FoodItem foodItem = foodItems[changedFoodItemIndex].copyWith(
        description: Description.dirty(event.foodItemDescription),
        confirmed: false);

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemPreparationMethodChanged(
      FoodItemPreparationMethodChanged event, Emitter<CollectionState> emit) {
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    FoodItem foodItem = foodItems[changedFoodItemIndex].copyWith(
        preparationMethod:
            PreparationMethod.dirty(event.foodItemPreparationMethod),
        confirmed: false);

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemMeasurementMethodChanged(
      FoodItemMeasurementMethodChanged event, Emitter<CollectionState> emit) {
    // TODO: refactor all of this finding an item and changing
    // it logic to one reusable function, probably a method of the GibsonsForm
    // class
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    FoodItem foodItem = foodItems[changedFoodItemIndex].copyWith(
        measurementMethod:
            MeasurementMethod.dirty(event.foodItemMeasurementMethod),
        confirmed: false);

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemMeasurementValueChanged(
      FoodItemMeasurementValueChanged event, Emitter<CollectionState> emit) {
    // TODO: refactor all of this finding an item and changing
    // it logic to one reusable function, probably a method of the GibsonsForm
    // class
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    FoodItem foodItem = foodItems[changedFoodItemIndex].copyWith(
        measurementValue:
            MeasurementValue.dirty(event.foodItemMeasurementValue),
        confirmed: false);

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemMeasurementUnitChanged(
      FoodItemMeasurementUnitChanged event, Emitter<CollectionState> emit) {
    // TODO: refactor all of this finding an item and changing
    // it logic to one reusable function, probably a method of the GibsonsForm
    // class
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    FoodItem foodItem = foodItems[changedFoodItemIndex].copyWith(
        measurementUnit: MeasurementUnit.dirty(event.foodItemMeasurementUnit),
        confirmed: false);

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  void _onFoodItemConfirmationChanged(
      FoodItemConfirmationChanged event, Emitter<CollectionState> emit) {
    // TODO: refactor all of this finding an item and changing
    // it logic to one reusable function, probably a method of the GibsonsForm
    // class
    List<FoodItem> foodItems = List.from(state.gibsonsForm.foodItems);

    // TODO: change into UUID-based indexing
    int changedFoodItemIndex = foodItems.indexOf(event.foodItem);

    FoodItem foodItem = foodItems[changedFoodItemIndex]
        .copyWith(confirmed: event.foodItemConfirmed);

    foodItems.removeAt(changedFoodItemIndex);
    foodItems.insert(changedFoodItemIndex, foodItem);

    GibsonsForm changedGibsonsForm =
        state.gibsonsForm.copyWith(foodItems: foodItems);

    emit(state.copyWith(gibsonsForm: changedGibsonsForm));
  }

  // or Future<void> ?
  void _onGibsonsFormSaved(
      GibsonsFormSaved event, Emitter<CollectionState> emit) async {
    await _gibsonifyRepository.saveForm(state.gibsonsForm);
    emit(state);
  }

  void _onGibsonsFormLoaded(
      GibsonsFormLoaded event, Emitter<CollectionState> emit) async {
    GibsonsForm gibsonsFormLoaded = _gibsonifyRepository.loadForm();
    emit(state.copyWith(gibsonsForm: gibsonsFormLoaded));
  }

  void _onGibsonsFormCreated(
      GibsonsFormCreated event, Emitter<CollectionState> emit) {
    GibsonsForm gibsonsFormCreated = GibsonsForm();
    emit(state.copyWith(gibsonsForm: gibsonsFormCreated));
  }
}
