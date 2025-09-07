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

// حالات تحديث الحالة
class ContractStatusUpdateLoading extends ContractState {}
class ContractStatusUpdateSuccess extends ContractState {
  final String message;
  const ContractStatusUpdateSuccess(this.message);
  @override
  List<Object> get props => [message];
}
class ContractStatusUpdateFailure extends ContractState {
  final String message;
  const ContractStatusUpdateFailure(this.message);
  @override
  List<Object> get props => [message];
}

// ✅ 3. إضافة حالات جديدة لعملية الإرجاع
class ReturnItemLoading extends ContractState {}
class ReturnItemSuccess extends ContractState {
  final String message;
  const ReturnItemSuccess(this.message);
  @override
  List<Object> get props => [message];
}
class ReturnItemFailure extends ContractState {
  final String message;
  const ReturnItemFailure(this.message);
  @override
  List<Object> get props => [message];
}
