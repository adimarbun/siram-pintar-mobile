import 'package:equatable/equatable.dart';

class AddPlantState extends Equatable {
  const AddPlantState({
    this.nameTextField,
    this.ctrlTypeTextField,
  });

  final String? nameTextField;
  final String? ctrlTypeTextField;

  @override
  List<Object?> get props => [
        nameTextField,
        ctrlTypeTextField,
      ];

  AddPlantState copyWith({
    String? nameTextField,
    String? ctrlTypeTextField,
  }) {
    return AddPlantState(
      nameTextField: nameTextField ?? this.nameTextField,
      ctrlTypeTextField: ctrlTypeTextField ?? this.ctrlTypeTextField,
    );
  }
}
