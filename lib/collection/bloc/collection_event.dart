part of 'collection_bloc.dart';

abstract class CollectionEvent extends Equatable {
  const CollectionEvent();

  @override
  List<Object> get props => [];
}

class HouseholdIdChanged extends CollectionEvent {
  final String householdId;

  const HouseholdIdChanged({required this.householdId});

  @override
  List<Object> get props => [householdId];
}

class RespondentNameChanged extends CollectionEvent {
  final String respondentName;

  const RespondentNameChanged({required this.respondentName});

  @override
  List<Object> get props => [respondentName];
}

class RespondentTelNumberChanged extends CollectionEvent {
  final String respondentTelNumber;

  const RespondentTelNumberChanged({required this.respondentTelNumber});

  @override
  List<Object> get props => [respondentTelNumber];
}

class SensitizationDateChanged extends CollectionEvent {
  final String sensitizationDate;

  const SensitizationDateChanged({required this.sensitizationDate});

  @override
  List<Object> get props => [sensitizationDate];
}

class RecallDayChanged extends CollectionEvent {
  final String recallDay;

  const RecallDayChanged({required this.recallDay});

  @override
  List<Object> get props => [recallDay];
}

class InterviewDateChanged extends CollectionEvent {
  final String interviewDate;

  const InterviewDateChanged({required this.interviewDate});

  @override
  List<Object> get props => [interviewDate];
}

class InterviewStartTimeChanged extends CollectionEvent {
  final String interviewStartTime;

  const InterviewStartTimeChanged({required this.interviewStartTime});

  @override
  List<Object> get props => [interviewStartTime];
}

class InterviewEndTimeChanged extends CollectionEvent {
  final String interviewEndTime;

  const InterviewEndTimeChanged({required this.interviewEndTime});

  @override
  List<Object> get props => [interviewEndTime];
}

class InterviewOutcomeChanged extends CollectionEvent {
  final String interviewOutcome;

  const InterviewOutcomeChanged({required this.interviewOutcome});

  @override
  List<Object> get props => [interviewOutcome];
}

class CommentsChanged extends CollectionEvent {
  final String comments;

  const CommentsChanged({required this.comments});

  @override
  List<Object> get props => [comments];
}

class FoodItemAdded extends CollectionEvent {}

class FoodItemDeleted extends CollectionEvent {
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;
  const FoodItemDeleted({required this.foodItem});

  @override
  List<Object> get props => [foodItem];
}

class FoodItemNameChanged extends CollectionEvent {
  final String foodItemName;
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;

  const FoodItemNameChanged(
      {required this.foodItemName, required this.foodItem});

  @override
  List<Object> get props => [foodItemName, foodItem];
}

class FoodItemTimePeriodChanged extends CollectionEvent {
  final String foodItemTimePeriod; // TODO: change to an enum?
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;

  const FoodItemTimePeriodChanged(
      {required this.foodItemTimePeriod, required this.foodItem});

  @override
  List<Object> get props => [foodItemTimePeriod, foodItem];
}

class FoodItemSourceChanged extends CollectionEvent {
  final String foodItemSource; // TODO: change to an enum?
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;

  const FoodItemSourceChanged(
      {required this.foodItemSource, required this.foodItem});

  @override
  List<Object> get props => [foodItemSource, foodItem];
}

class FoodItemDescriptionChanged extends CollectionEvent {
  final String foodItemDescription;
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;

  const FoodItemDescriptionChanged(
      {required this.foodItemDescription, required this.foodItem});

  @override
  List<Object> get props => [foodItemDescription, foodItem];
}

class FoodItemPreparationMethodChanged extends CollectionEvent {
  final String foodItemPreparationMethod; // TODO: change to an enum?
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;

  const FoodItemPreparationMethodChanged(
      {required this.foodItemPreparationMethod, required this.foodItem});

  @override
  List<Object> get props => [foodItemPreparationMethod, foodItem];
}

class FoodItemMeasurementMethodChanged extends CollectionEvent {
  final String foodItemMeasurementMethod; // TODO: change to an enum?
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;

  const FoodItemMeasurementMethodChanged(
      {required this.foodItemMeasurementMethod, required this.foodItem});

  @override
  List<Object> get props => [foodItemMeasurementMethod, foodItem];
}

class FoodItemMeasurementValueChanged extends CollectionEvent {
  final String foodItemMeasurementValue; // TODO: change to an enum?
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;

  const FoodItemMeasurementValueChanged(
      {required this.foodItemMeasurementValue, required this.foodItem});

  @override
  List<Object> get props => [foodItemMeasurementValue, foodItem];
}

class FoodItemMeasurementUnitChanged extends CollectionEvent {
  final String foodItemMeasurementUnit; // TODO: change to an enum?
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;

  const FoodItemMeasurementUnitChanged(
      {required this.foodItemMeasurementUnit, required this.foodItem});

  @override
  List<Object> get props => [foodItemMeasurementUnit, foodItem];
}

class FoodItemConfirmationChanged extends CollectionEvent {
  final bool foodItemConfirmed;
  // TODO: delete foodItem and pass only uuid instead
  final FoodItem foodItem;
  // TODO: implement
  // final String foodItemUuid;

  const FoodItemConfirmationChanged(
      {required this.foodItemConfirmed, required this.foodItem});

  @override
  List<Object> get props => [foodItemConfirmed, foodItem];
}

class FoodItemRecipeChanged extends CollectionEvent {
  final Recipe foodItemRecipe;
  final String foodItemId;

  const FoodItemRecipeChanged(
      {required this.foodItemId, required this.foodItemRecipe});

  @override
  List<Object> get props => [foodItemId, foodItemRecipe];
}

class GibsonsFormSaved extends CollectionEvent {
  const GibsonsFormSaved();

  @override
  List<Object> get props => [];
}

class GibsonsFormProvided extends CollectionEvent {
  final GibsonsForm gibsonsForm;
  const GibsonsFormProvided({required this.gibsonsForm});

  @override
  List<Object> get props => [gibsonsForm];
}

// TODO: This event is temporary until it is implemented that CollectionBloc
// takes a GibsonsForm when instantiated — if none is passed, it creates a new
// one
class GibsonsFormCreated extends CollectionEvent {
  const GibsonsFormCreated();

  @override
  List<Object> get props => [];
}
