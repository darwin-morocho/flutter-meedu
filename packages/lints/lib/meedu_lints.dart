library;

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

// This is the entrypoint of our custom linter
PluginBase createPlugin() => _MeeduLinter();

class _MeeduLinter extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) {
    return [
      _FinalsRule(),
      _TagsRule(),
    ];
  }
}

class _FinalsRule extends DartLintRule {
  _FinalsRule() : super(code: _code);

  /// Metadata about the warning that will show-up in the IDE.
  /// This is used for `// ignore: code` and enabling/disabling the lint
  static const _code = LintCode(
    name: 'flutter_meedu_final_providers',
    problemMessage: 'Providers must be declared using the `final` keyword.',
    errorSeverity: ErrorSeverity.ERROR,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // Our lint will highlight all variable declarations with our custom warning.
    context.registry.addVariableDeclaration((node) {
      const providerBaseChecker = TypeChecker.fromName(
        'BaseProvider',
        packageName: 'flutter_meedu',
      );
      final element = node.declaredElement;
      if (element == null ||
          element.isFinal ||
          // We check that the variable is a Riverpod provider
          !providerBaseChecker.isAssignableFromType(element.type)) {
        return;
      }

      // This emits our lint warning at the location of the variable.
      reporter.reportErrorForElement(code, element);
    });
  }
}

class _TagsRule extends DartLintRule {
  _TagsRule() : super(code: _code);

  /// Metadata about the warning that will show-up in the IDE.
  /// This is used for `// ignore: code` and enabling/disabling the lint
  static const _code = LintCode(
    name: 'flutter_meedu_tags_on_watch_or_listen',
    problemMessage:
        '`watch` or `listen` functions must have a valid `tag` if one instance of `StateNotifierTagProvider` or `StateNotifierArgumentsTagProvider` is used.',
    errorSeverity: ErrorSeverity.ERROR,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addMethodInvocation(
      (node) {
        final methodName = node.methodName.name;
        if (methodName != 'watch' && methodName != 'listen') {
          return;
        }

        final args = node.argumentList.arguments;
        if (args.isEmpty) {
          return;
        }

        const providerOrFilterChecker = TypeChecker.fromName(
          'StateNotifierTagProvider',
          packageName: 'flutter_meedu',
        );

        final firstArgumentType = args.first.staticType;

        if (firstArgumentType == null) {
          return;
        }

        /// check if the first parameter is a filter omit checker
        if (!providerOrFilterChecker.isAssignableFromType(firstArgumentType)) {
          return;
        }

        final hasTag = args.length == 2 &&
            TypeChecker.fromName('String')
                .isAssignableFromType(args.last.staticType!);

        if (hasTag) {
          return;
        }

        reporter.reportErrorForNode(_code, node);
      },
    );
  }
}
