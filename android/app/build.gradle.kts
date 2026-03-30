plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val releaseTaskRequested = gradle.startParameter.taskNames.any {
    it.contains("Release", ignoreCase = true)
}

val configuredApplicationId = (project.findProperty("APP_APPLICATION_ID") as String?)
    ?.takeIf { it.isNotBlank() }
    ?: "com.example.my_app"

val debugFallbackAdmobAppId = "ca-app-pub-3940256099942544~3347511713"
val releaseAdmobAppId = (project.findProperty("ADMOB_APP_ID_RELEASE") as String?)
    ?.takeIf { it.isNotBlank() }
val effectiveAdmobAppId = releaseAdmobAppId ?: debugFallbackAdmobAppId

val releaseStoreFile = (project.findProperty("MYAPP_UPLOAD_STORE_FILE") as String?)
    ?.takeIf { it.isNotBlank() }
val releaseStorePassword = (project.findProperty("MYAPP_UPLOAD_STORE_PASSWORD") as String?)
    ?.takeIf { it.isNotBlank() }
val releaseKeyAlias = (project.findProperty("MYAPP_UPLOAD_KEY_ALIAS") as String?)
    ?.takeIf { it.isNotBlank() }
val releaseKeyPassword = (project.findProperty("MYAPP_UPLOAD_KEY_PASSWORD") as String?)
    ?.takeIf { it.isNotBlank() }
val hasReleaseSigning = releaseStoreFile != null &&
    releaseStorePassword != null &&
    releaseKeyAlias != null &&
    releaseKeyPassword != null

if (releaseTaskRequested && configuredApplicationId == "com.example.my_app") {
    throw GradleException(
        "Set APP_APPLICATION_ID in android/gradle.properties for release builds.",
    )
}

if (releaseTaskRequested && releaseAdmobAppId == null) {
    throw GradleException(
        "Set ADMOB_APP_ID_RELEASE in android/gradle.properties for release builds.",
    )
}

if (releaseTaskRequested && !hasReleaseSigning) {
    throw GradleException(
        "Set MYAPP_UPLOAD_* signing properties in android/gradle.properties for release builds.",
    )
}

android {
    namespace = "com.example.my_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    signingConfigs {
        if (hasReleaseSigning) {
            create("release") {
                storeFile = file(releaseStoreFile!!)
                storePassword = releaseStorePassword
                keyAlias = releaseKeyAlias
                keyPassword = releaseKeyPassword
            }
        }
    }

    defaultConfig {
        applicationId = configuredApplicationId
        manifestPlaceholders["admobAppId"] = effectiveAdmobAppId
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        debug {
            manifestPlaceholders["admobAppId"] = effectiveAdmobAppId
        }
        release {
            signingConfig = if (hasReleaseSigning) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
            manifestPlaceholders["admobAppId"] = effectiveAdmobAppId
        }
    }
}

flutter {
    source = "../.."
}
