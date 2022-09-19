abstract class BaseUseCase<Type, Params> {
  Type execute(Params params);
  const BaseUseCase();
}
