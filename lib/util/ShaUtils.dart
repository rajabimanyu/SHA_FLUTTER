import "dart:async";

import 'package:sha/base/ShaConstants.dart';

Stream<T> mostRecentStream<T>(Stream<T> source) {
  var isDone = false;
  var hasEvent = false;
  T? mostRecentEvent;
  List<MultiStreamController>? pendingListeners;
  var listeners = <MultiStreamController>[];

  void forEachListener(void Function(MultiStreamController) action) {
    var active = 0;
    var originalLength = listeners.length;
    for (var i = 0; i < listeners.length; i++) {
      var controller = listeners[i];
      if (controller.hasListener) {
        listeners[active++] = controller;
        if (i < originalLength) action(controller);
      }
    }
    listeners.length = active;
  }

  source.listen((event) {
    mostRecentEvent = event;
    hasEvent = true;
    forEachListener((controller) {
      controller.addSync(event);
    });
  }, onError: (e, s) {
    forEachListener((controller) {
      controller.addErrorSync(e, s);
    });
  }, onDone: () {
    isDone = true;
    for (var controller in listeners) {
      controller.close();
    }
    listeners.clear();
  });

  return Stream<T>.multi((controller) {
    if (hasEvent) controller.add(mostRecentEvent as T);
    if (isDone) {
      controller.close();
    } else {
      listeners.add(controller);
    }
  });
}


String getSurroundingKey(String envId) {
  return '${envId}_$HIVE_SURROUNDINGS';
}