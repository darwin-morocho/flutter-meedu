part of 'meedu_lints.dart';

class _ListenAndWatchNoFiltersRule extends DartLintRule {
  _ListenAndWatchNoFiltersRule() : super(code: _code);

  /// Metadata about the warning that will show-up in the IDE.
  /// This is used for `// ignore: code` and enabling/disabling the lint
  static const _code = LintCode(
    name: 'flutter_meedu_tags_on_watch_or_listen',
    problemMessage:
        '`watch` or `listen` functions must have a valid tag, if one instance of `StateNotifierTagProvider` or `StateNotifierTagArgumentsProvider` is used.'
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
        if (!hasMatch(
          node: node,
          types: [
            'StateNotifierTagProvider',
            'StateNotifierTagArgumentsProvider',
          ],
          methods: [
            'watch',
            'listen',
          ],
        )) {
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

class _ListenAndWatchFiltersRule extends DartLintRule {
  _ListenAndWatchFiltersRule() : super(code: _code);

  /// Metadata about the warning that will show-up in the IDE.
  /// This is used for `// ignore: code` and enabling/disabling the lint
  static const _code = LintCode(
    name: 'flutter_meedu_no_tags_on_watch_or_listen_when_use_filters',
    problemMessage:
        '`watch` or `listen` functions should not have a `tag`, if you are using .select or .when filters.'
        '\n\n\n'
        'To fix this, remove the tag parameter',
    errorSeverity: ErrorSeverity.INFO,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation(
      (node) {
        if (!hasMatch(
          node: node,
          types: [
            'SelectFilteredProvider',
            'WhenFilteredProvider',
          ],
          methods: [
            'watch',
            'listen',
          ],
          packageName: 'flutter_meedu',
        )) {
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

class _NoTagsRule extends DartLintRule {
  _NoTagsRule() : super(code: _code);

  /// Metadata about the warning that will show-up in the IDE.
  /// This is used for `// ignore: code` and enabling/disabling the lint
  static const _code = LintCode(
    name: 'flutter_meedu_no_tags_on_watch_or_listen',
    problemMessage:
        'The `tag` parameter should not be used because your provider is not allowed to use Tags.'
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
        if (!hasMatch(
          node: node,
          types: [
            'StateNotifierProvider',
            'StateNotifierArgumentsProvider',
          ],
          methods: [
            'watch',
            'listen',
          ],
        )) {
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
