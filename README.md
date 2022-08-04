# taxi_app

Il s'agit d'un projet open source pour créer et déployer une application de transport (Taxi-App) utilisant
[FLUTTER](https://docs.flutter.dev) et [FIREBASE](https://firebase.google.com/) comme backend.

Ceci est entièrement ouvert aux contributions car il est destiné à des fins d'apprentissage. La révision du code, les suggestions et les idées sont les bienvenues.

## Demo

## Prérequis 
Pour démarrer ce projet;

- Vous devez avoir quelques connaissances de base sur DART/FLUTTER et FIREBASE car c'est l'essentiel.
- FOURCHE⑂ et ÉTOILE⭐️ce référentiel. Git Clone sur votre ordinateur local.

## Configuration 
- Tout d'abord, accédez à[GoogleMap](https://console.cloud.google.com/)pour activer Map SDK et obtenir la clé API. Créez le nouveau projet et accédez à Google Maps Platform :
- Accédez à la console Google > Google Maps Platform et récupérez la clé API de votre carte Google. Après avoir obtenu la clé d'API Google Maps, activez le SDK pour Android et iOS à partir de la section "API".
- [Android] Ajoutez la clé d'API Google à AndroidManifest.xml

        <meta-data android:name="com.google.android.geo.API_KEY"  
             android:value="YOUR MAP API KEY"/>
Remplacez la clé API dans le code ci-dessus :
- [Ios]
Dans iOS, ajoutez votre code comme ci-dessous dans  ios/Runner/AppDelegate.swift

            import UIKit
            import Flutter
            import GoogleMaps

        @UIApplicationMain
        @objc class AppDelegate: FlutterAppDelegate {
          override func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
          ) -> Bool {
            GMSServices.provideAPIKey("YOUR KEY HERE")
            GeneratedPluginRegistrant.register(with: self)
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
          }
        }


- Ajoutez le package Google Maps dans le projet Flutter :

Dans la partie Flutter, ajoutez[google_maps_flutter](https://pub.dev/packages/google_maps_flutter)Flutter Package dans votre dépendance en ajoutant la ligne suivante dans le fichier pubspect.yaml :

    dependencies:
        flutter:
            sdk: flutter
        google_maps_flutter: ^2.0.4
