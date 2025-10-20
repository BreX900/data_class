import 'package:build/build.dart';
import 'package:mek_data_class_generator/mek_data_class_generator.dart';
import 'package:mek_data_class_generator/src/configs/options.dart';
import 'package:source_gen/source_gen.dart';

/// Dart entry point for building a DataClass generated files
Builder dataClass(BuilderOptions buildOptions) {
  final options = Options.fromJson(buildOptions.config);

  return SharedPartBuilder(
    [DataClassGenerator(options: options)],
    'data_class',
    allowSyntaxErrors: true,
  );
}
