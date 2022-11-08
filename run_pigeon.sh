mkdir -p android/src/main/kotlin/io/flutter/plugins/ &&\
mkdir -p ios/Classes/io/flutter/plugins/ &&\
\
dart run pigeon \
\
--input                                .dart \
\
--dart_out                             lib/api_generated.dart \
\
--experimental_swift_out               ios/Classes/io/flutter/plugins/WeMeetApi.swift \
\
--experimental_kotlin_out              android/src/main/kotlin/io/flutter/plugins/WeMeetApi.kt \
\
--experimental_kotlin_package          "io.flutter.plugins" \
\
--cpp_namespace                        pigeon \
\
--experimental_cpp_header_out          windows/include/WeMeetApi.h \
\
--experimental_cpp_source_out          windows/include/WeMeetApi.cpp