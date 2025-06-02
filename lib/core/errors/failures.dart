abstract class Failure{
  final String errmessage;
  const Failure({required this.errmessage});
}
class ServerFailure extends Failure{
  ServerFailure({required super.errmessage});

}