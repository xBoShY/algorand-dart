// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeStatus _$NodeStatusFromJson(Map<String, dynamic> json) => NodeStatus(
      catchupTime: (json['catchup-time'] as num).toInt(),
      lastRound: (json['last-round'] as num).toInt(),
      lastVersion: json['last-version'] as String,
      nextVersion: json['next-version'] as String,
      nextVersionRound: (json['next-version-round'] as num).toInt(),
      nextVersionSupported: json['next-version-supported'] as bool,
      stoppedAtUnsupportedRound: json['stopped-at-unsupported-round'] as bool,
      timeSinceLastRound: (json['time-since-last-round'] as num).toInt(),
      catchpoint: json['catchpoint'] as String?,
      catchpointAcquiredBlocks:
          (json['catchpoint-acquired-blocks'] as num?)?.toInt(),
      catchpointProcessedAccounts:
          (json['catchpoint-processed-accounts'] as num?)?.toInt(),
      catchpointTotalAccounts:
          (json['catchpoint-total-accounts'] as num?)?.toInt(),
      catchpointTotalBlocks: (json['catchpoint-total-blocks'] as num?)?.toInt(),
      catchpointVerifiedAccounts:
          (json['catchpoint-verified-accounts'] as num?)?.toInt(),
      lastCatchpoint: json['last-catchpoint'] as String?,
    );

Map<String, dynamic> _$NodeStatusToJson(NodeStatus instance) =>
    <String, dynamic>{
      'catchup-time': instance.catchupTime,
      'last-round': instance.lastRound,
      'last-version': instance.lastVersion,
      'next-version': instance.nextVersion,
      'next-version-round': instance.nextVersionRound,
      'next-version-supported': instance.nextVersionSupported,
      'stopped-at-unsupported-round': instance.stoppedAtUnsupportedRound,
      'time-since-last-round': instance.timeSinceLastRound,
      'catchpoint': instance.catchpoint,
      'catchpoint-acquired-blocks': instance.catchpointAcquiredBlocks,
      'catchpoint-processed-accounts': instance.catchpointProcessedAccounts,
      'catchpoint-total-accounts': instance.catchpointTotalAccounts,
      'catchpoint-total-blocks': instance.catchpointTotalBlocks,
      'catchpoint-verified-accounts': instance.catchpointVerifiedAccounts,
      'last-catchpoint': instance.lastCatchpoint,
    };
