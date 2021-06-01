# Android Dependency Report

It visualizes the whole dependency tree for every [configuration](https://docs.gradle.org/current/userguide/declaring_dependencies.html#sec:what-are-dependency-configurations) available in the project.

Rendering the dependency tree is particularly useful if you’d like to identify which dependencies have been resolved at runtime. It also provides you with information about any dependency conflict resolution that occurred in the process and clearly indicates the selected version. The dependency report always contains declared and transitive dependencies.

#### Required Input Variables

 - `$AC_REPOSITORY_DIR`: Cloned git repository path.
 - `$AC_MODULE`: Project module to be built.
 - `$AC_PROJECT_PATH`: Specifies the project path.
 - `$AC_DEPENDENCY_CONFIGURATION`: To focus on the information about one configuration.

The output will place in the Output folder which is for the upload artifacts.
