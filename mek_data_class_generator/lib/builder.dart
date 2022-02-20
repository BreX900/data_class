import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:mek_data_class_generator/src/configs.dart';
import 'package:mek_data_class_generator/src/data_class_generator.dart';
import 'package:source_gen/source_gen.dart';

/// Dart entry point for building a DataClass generated files
Builder dataClass(BuilderOptions options) {
  final config = Config.from(options.config);

  return SharedPartBuilder(
    [DataClassGenerator(config: config)],
    'data_class',
    formatOutput: DartFormatter(
      pageWidth: config.pageWidth,
      fixes: {StyleFix.singleCascadeStatements},
    ).format,
  );
}
