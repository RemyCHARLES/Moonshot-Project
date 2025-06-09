// lib/core/navigation/route_observer.dart
// ------------------------------------------------------------
// Beatquest – Global Route Observer
// ------------------------------------------------------------
// This file defines a globally accessible RouteObserver used to
// track navigation events across the app. It allows any widget
// (typically screens) to subscribe to lifecycle transitions such as
// didPush, didPop, and didPopNext.
//
// This is especially useful for triggering screen refreshes or
// analytics events when navigating between pages.
// ------------------------------------------------------------

import 'package:flutter/material.dart';

/// A global RouteObserver to track navigation changes across screens.
///
/// To use this in a widget:
///   1. Extend `RouteAware` in your State class.
///   2. Subscribe to `routeObserver` in `didChangeDependencies`.
///   3. Override `didPopNext` or `didPush` to refresh screen.
final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();