import 'package:equatable/equatable.dart';
import '../../domain/entities/contract-entity.dart';

abstract class ContractState extends Equatable {
  const ContractState();

  @override
  List<Object> get props => [];
}

class ContractInitial extends ContractState {}

class ContractLoading extends ContractState {}

class ContractSuccess extends ContractState {
  final List<ContractEntity> contracts;
  const ContractSuccess(this.contracts);
  @override
  List<Object> get props => [contracts];
}

class ContractFailure extends ContractState {
  final String errMessage;
  const ContractFailure(this.errMessage);
  @override
  List<Object> get props => [errMessage];
}

// ✅✅✅ الحالات الجديدة ✅✅✅
class ContractStatusUpdateLoading extends ContractState {}

class ContractStatusUpdateSuccess extends ContractState {
  final String successMessage;
  const ContractStatusUpdateSuccess(this.successMessage);
  @override
  List<Object> get props => [successMessage];
}

class ContractStatusUpdateFailure extends ContractState {
  final String errMessage;
  const ContractStatusUpdateFailure(this.errMessage);
  @override
  List<Object> get props => [errMessage];
}
