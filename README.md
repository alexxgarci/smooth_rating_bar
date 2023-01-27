<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

[![pub package](https://img.shields.io/pub/v/smooth_rating_bar.svg)](https://pub.dev/packages/smooth_rating_bar)

A Flutter plugin for launching a URL.

|             | Android | iOS  | Linux | macOS  | Web | Windows     |
| ----------- | ------- | ---- | ----- | ------ | --- | ----------- |
| **Support** | SDK 16+ | 9.0+ | Any   | 10.11+ | Any | Windows 10+ |

Smooth Flutter Rating Bar with SVG icons.

## Features

Set your own design as rating icons and color them.

## Usage

To use this plugin, add `smooth_rating_bar` as a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/).

Then, you'll have to add to assets the corresponding files to full icon, half full icon, and empty icon:

```yaml
assets:
  - assets/star/star.svg
  - assets/star/star_half.svg
  - assets/star/star_border.svg
  - assets/star/star_empty_gray.svg
```

```dart

double rating = 3.0;

SmoothRatingBar(
    rating: rating,
    starSize: 50,
    starCount: 5,
    color: Colors.yellow,
    borderColor: Colors.yellow,
    starPadding: const EdgeInsets.symmetric(horizontal: 7),
    onRatingCallback: (value) {
            setState(() {
                rating = value;
            });
        },
    ),
```
