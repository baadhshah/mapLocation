#!/bin/bash
# Build React Native Gradle plugin if needed
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PLUGIN_DIR="$PROJECT_ROOT/node_modules/@react-native/gradle-plugin"
PLUGIN_JAR="$PLUGIN_DIR/react-native-gradle-plugin/build/libs/react-native-gradle-plugin.jar"

if [ ! -f "$PLUGIN_JAR" ] || [ "$PLUGIN_DIR/react-native-gradle-plugin/build.gradle.kts" -nt "$PLUGIN_JAR" ]; then
    echo "Building React Native Gradle plugin..."
    cd "$PLUGIN_DIR"
    chmod +x gradlew
    ./gradlew :react-native-gradle-plugin:build :react-native-gradle-plugin:publishToMavenLocal --no-daemon
    cd - > /dev/null
    echo "Plugin built and published to local repository"
else
    echo "React Native Gradle plugin already built"
fi

