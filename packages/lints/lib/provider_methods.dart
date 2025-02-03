part of 'meedu_lints.dart';

class _ProviderMethodsTagsRule extends DartLintRule {
  _ProviderMethodsTagsRule() : super(code: _code);

  /// Metadata about the warning that will show-up in the IDE.
  /// This is used for `// ignore: code` and enabling/disabling the lint
  static const _code = LintCode(
    name: 'meedu_missing_tag',
    problemMessage:
        'The `tag` parameter must be defined, due to your provider uses Tags.'
        '\n\n\n'
        'To fix this, add the tag parameter',
    errorSeverity: ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation(
      (node) {
        if (!_isAssignable(node, tags: true)) {
          return;
        }

        if (hasTags(node.argumentList.arguments)) {
          return;
        }

        reporter.atNode(node, _code);
      },
    );
  }
}

class _ProviderMethodsNoTagsRule extends DartLintRule {
  _ProviderMethodsNoTagsRule() : super(code: _code);

  /// Metadata about the warning that will show-up in the IDE.
  /// This is used for `// ignore: code` and enabling/disabling the lint
  static const _code = LintCode(
    name: 'meedu_no_tags',
    problemMessage:
        'The `tag` parameter should not be used, due to your `provider` is not allowed to use Tags'
        '\n\n\n'
        'To fix this, remove the tag parameter',
    errorSeverity: ErrorSeverity.WARNING,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation(
      (node) {
        if (!_isAssignable(node, tags: false)) {
          return;
        }

        if (noHasTags(node.argumentList.arguments)) {
          return;
        }

        reporter.atNode(node, _code);
      },
    );
  }
}

bool _isAssignable(
  MethodInvocation node, {
  required bool tags,
}) {
  final methodName = node.methodName.name;

  const methods = [
    'read',
    'dispose',
    'mounted',
    'setArguments',
    'select',
    'when',
  ];

  if (!methods.contains(methodName)) {
    return false;
  }
  final nodeType = node.realTarget?.staticType;
  if (nodeType == null) {
    return false;
  }

  final isAssignable = TypeChecker.fromName(
    'BaseTagProvider',
    packageName: 'meedu',
  ).isAssignableFromType(nodeType);

  if (tags) {
    return isAssignable;
  }
  return !isAssignable;
}
