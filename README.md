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

Smooth Flutter Rating Bar with SVG icons.

## Features

Set your own design as rating icons and color them. 

## Getting started


## Usage

First, you'll have to add to your pubspec.yaml the corresponding assets:

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
