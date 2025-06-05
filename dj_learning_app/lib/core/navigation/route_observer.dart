import 'package:flutter/material.dart';

/// A global [RouteObserver] to track navigation and enable screens to refresh when resumed.
final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();