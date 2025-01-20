import 'package:equatable/equatable.dart';

class AddDevicePlantState extends Equatable {
  const AddDevicePlantState({
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

  AddDevicePlantState copyWith({
    String? nameTextField,
    String? ctrlTypeTextField,
  }) {
    return AddDevicePlantState(
      nameTextField: nameTextField ?? this.nameTextField,
      ctrlTypeTextField: ctrlTypeTextField ?? this.ctrlTypeTextField,
    );
  }
}
