library;

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

part 'watch_and_listen.dart';
part 'provider_methods.dart';

// This is the entrypoint of our custom linter
PluginBase createPlugin() => _MeeduLinter();

class _MeeduLinter extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) {
    return [
      _FinalsRule(),
      _ListenAndWatchNoFiltersRule(),
      _ListenAndWatchFiltersRule(),
      _NoTagsRule(),
      _ProviderMethodsNoTagsRule(),
      _ProviderMethodsTagsRule(),
    ];
  }
}

class _FinalsRule extends DartLintRule {
  _FinalsRule() : super(code: _code);

  /// Metadata about the warning that will show-up in the IDE.
  /// This is used for `// ignore: code` and enabling/disabling the lint
  static const _code = LintCode(
    name: 'meedu_final_providers',
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
        packageName: 'meedu',
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

bool hasMatch({
  required MethodInvocation node,
  required List<String> types,
  required List<String> methods,
  String? packageName,
}) {
  final methodName = node.methodName.name;
  if (!methods.contains(methodName)) {
    return false;
  }

  final args = node.argumentList.arguments;
  if (args.isEmpty) {
    return false;
  }

  return types.any(
    (type) {
      final providerOrFilterChecker = TypeChecker.fromName(
        type,
        packageName: packageName ?? 'meedu',
      );
      final firstArgumentType = args.first.staticType;

      if (firstArgumentType == null) {
        return false;
      }

      return providerOrFilterChecker.isExactlyType(firstArgumentType);
    },
  );
}

bool hasTags(NodeList<Expression> arguments) {
  /// check if tag is defined
  return arguments.any(
    (e) {
      if (e is NamedExpression && e.name.label.name == 'tag') {
        if (e.expression is NullLiteral) {
          return false;
        }

        if (e.expression.staticType.toString() == 'String?') {
          return false;
        }
        return true;
      }
      return false;
    },
  );
}

bool noHasTags(NodeList<Expression> arguments) {
  /// check if tag is defined
  return !arguments.any(
    (e) {
      if (e is NamedExpression && e.name.label.name == 'tag') {
        return true;
      }
      return false;
    },
  );
}
