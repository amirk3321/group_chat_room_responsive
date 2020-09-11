part of 'communication_cubit.dart';

abstract class CommunicationState extends Equatable {
  const CommunicationState();
}

class CommunicationInitial extends CommunicationState {
  @override
  List<Object> get props => [];
}

class CommunicationLoading extends CommunicationState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class CommunicationLoaded extends CommunicationState{
  final List<TextMessageEntity> messages;

  CommunicationLoaded({this.messages});
  @override
  // TODO: implement props
  List<Object> get props => [messages];
}