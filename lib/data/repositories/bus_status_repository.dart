import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

enum BusStatusError {
  permissionDenied,
  networkError,
  documentNotFound,
  unknown,
}

class BusStatusResult {
  final bool isSuccess;
  final BusStatusError? error;
  final String? errorMessage;

  const BusStatusResult._({
    required this.isSuccess,
    this.error,
    this.errorMessage,
  });

  static const BusStatusResult ok = BusStatusResult._(isSuccess: true);

  factory BusStatusResult.failure(BusStatusError error, [String? message]) {
    return BusStatusResult._(
      isSuccess: false,
      error: error,
      errorMessage: message,
    );
  }
}

class BusStatusData {
  final bool isRunning;
  final int currentStopIndex;
  final DateTime? lastUpdated;

  const BusStatusData({
    required this.isRunning,
    required this.currentStopIndex,
    this.lastUpdated,
  });

  factory BusStatusData.fromFirestore(Map<String, dynamic>? data) {
    if (data == null) {
      return const BusStatusData(isRunning: false, currentStopIndex: 0);
    }

    final isRunning = data['isRunning'] as bool? ?? false;

    final currentStopIndexRaw = data['currentStopIndex'];
    final currentStopIndex = currentStopIndexRaw is num
        ? currentStopIndexRaw.toInt()
        : (currentStopIndexRaw as int? ?? 0);

    final lastUpdatedRaw = data['lastUpdated'];
    final lastUpdated = lastUpdatedRaw is Timestamp
        ? lastUpdatedRaw.toDate()
        : null;

    return BusStatusData(
      isRunning: isRunning,
      currentStopIndex: currentStopIndex,
      lastUpdated: lastUpdated,
    );
  }
}

class BusStatusRepository {
  final CollectionReference _busStatusCollection = FirebaseFirestore.instance
      .collection('busStatus');

  Stream<BusStatusData> getBusStatus(String busTitle) {
    return _busStatusCollection
        .doc(busTitle)
        .snapshots()
        .map((doc) {
          if (!doc.exists) {
            debugPrint(
              '[BusStatusRepository] Document not found for bus: $busTitle',
            );
            return const BusStatusData(isRunning: false, currentStopIndex: 0);
          }
          return BusStatusData.fromFirestore(
            doc.data() as Map<String, dynamic>?,
          );
        })
        .handleError((error) {
          debugPrint('[BusStatusRepository] Stream error: $error');
        });
  }

  Future<BusStatusResult> updateBusStatus({
    required String busTitle,
    required bool isRunning,
    required int currentStopIndex,
  }) async {
    try {
      await _busStatusCollection.doc(busTitle).set({
        'isRunning': isRunning,
        'currentStopIndex': currentStopIndex,
        'lastUpdated': FieldValue.serverTimestamp(),
      });

      debugPrint(
        '[BusStatusRepository] Updated $busTitle: running=$isRunning, stop=$currentStopIndex',
      );
      return BusStatusResult.ok;
    } on FirebaseException catch (e) {
      debugPrint(
        '[BusStatusRepository] FirebaseException: ${e.code} - ${e.message}',
      );

      switch (e.code) {
        case 'permission-denied':
          return BusStatusResult.failure(
            BusStatusError.permissionDenied,
            'Permission denied. Check Firestore rules.',
          );
        case 'unavailable':
        case 'deadline-exceeded':
          return BusStatusResult.failure(
            BusStatusError.networkError,
            'Network error. Please check your connection.',
          );
        default:
          return BusStatusResult.failure(
            BusStatusError.unknown,
            'Failed to update: ${e.message}',
          );
      }
    } catch (e) {
      debugPrint('[BusStatusRepository] Unknown error: $e');
      return BusStatusResult.failure(
        BusStatusError.unknown,
        'An unexpected error occurred.',
      );
    }
  }

  Future<void> initializeBusStatus(String busTitle) async {
    try {
      final doc = await _busStatusCollection.doc(busTitle).get();
      if (!doc.exists) {
        await _busStatusCollection.doc(busTitle).set({
          'isRunning': false,
          'currentStopIndex': 0,
          'lastUpdated': FieldValue.serverTimestamp(),
        });
        debugPrint('[BusStatusRepository] Initialized status for: $busTitle');
      }
    } catch (e) {
      debugPrint('[BusStatusRepository] Failed to initialize: $e');
    }
  }
}
