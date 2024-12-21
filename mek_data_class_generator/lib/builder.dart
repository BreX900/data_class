import 'package:build/build.dart';
import 'package:mek_data_class_generator/mek_data_class_generator.dart';
import 'package:mek_data_class_generator/src/configs.dart';
import 'package:source_gen/source_gen.dart';

/// Dart entry point for building a DataClass generated files
Builder dataClass(BuilderOptions options) {
  final config = Config.fromJson(options.config);
  final pageWidth = config.pageWidth;
  if (pageWidth != null) {
    log.warning('mek_data_class_generator: The "page_width: $pageWidth" option has been replaced '
        'by the "formatter: { page_width: 80 }" option in the "analysis_options.yaml" file');
  }

  return SharedPartBuilder([DataClassGenerator(config: config)], 'data_class');
}
