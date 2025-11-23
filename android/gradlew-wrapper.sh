#!/bin/bash
# Wrapper script that builds React Native Gradle plugin before running Gradle

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PLUGIN_DIR="$PROJECT_ROOT/node_modules/@react-native/gradle-plugin"
PLUGIN_JAR="$PLUGIN_DIR/react-native-gradle-plugin/build/libs/react-native-gradle-plugin.jar"

# Build plugin if needed
if [ -d "$PLUGIN_DIR" ]; then
    if [ ! -f "$PLUGIN_JAR" ] || [ "$PLUGIN_DIR/react-native-gradle-plugin/build.gradle.kts" -nt "$PLUGIN_JAR" ]; then
        echo "Building React Native Gradle plugin..."
        cd "$PLUGIN_DIR"
        chmod +x gradlew
        ./gradlew :react-native-gradle-plugin:build --no-daemon > /dev/null 2>&1
        cd - > /dev/null
    fi
fi

# Run the actual gradlew
exec "$SCRIPT_DIR/gradlew" "$@"

