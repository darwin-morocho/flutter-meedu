abstract class BaseFilter {}

class SimpleFilter extends BaseFilter {
  final List<String> ids;
  SimpleFilter(this.ids);
}

class StateFilter<S> extends BaseFilter {
  final bool Function(S oldState, S newState) buildWhen;
  StateFilter(this.buildWhen);
}
