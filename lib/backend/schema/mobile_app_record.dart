import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'mobile_app_record.g.dart';

abstract class MobileAppRecord
    implements Built<MobileAppRecord, MobileAppRecordBuilder> {
  static Serializer<MobileAppRecord> get serializer =>
      _$mobileAppRecordSerializer;

  @BuiltValueField(wireName: 'project_name')
  String? get projectName;

  String? get description;

  @BuiltValueField(wireName: 'number_tasks')
  int? get numberTasks;

  @BuiltValueField(wireName: 'completed_tasks')
  int? get completedTasks;

  @BuiltValueField(wireName: 'last_edited')
  DateTime? get lastEdited;

  @BuiltValueField(wireName: 'time_created')
  DateTime? get timeCreated;

  String? get link;

  String? get image;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(MobileAppRecordBuilder builder) => builder
    ..projectName = ''
    ..description = ''
    ..numberTasks = 0
    ..completedTasks = 0
    ..link = ''
    ..image = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('MobileApp');

  static Stream<MobileAppRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<MobileAppRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  MobileAppRecord._();
  factory MobileAppRecord([void Function(MobileAppRecordBuilder) updates]) =
      _$MobileAppRecord;

  static MobileAppRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createMobileAppRecordData({
  String? projectName,
  String? description,
  int? numberTasks,
  int? completedTasks,
  DateTime? lastEdited,
  DateTime? timeCreated,
  String? link,
  String? image,
}) {
  final firestoreData = serializers.toFirestore(
    MobileAppRecord.serializer,
    MobileAppRecord(
      (m) => m
        ..projectName = projectName
        ..description = description
        ..numberTasks = numberTasks
        ..completedTasks = completedTasks
        ..lastEdited = lastEdited
        ..timeCreated = timeCreated
        ..link = link
        ..image = image,
    ),
  );

  return firestoreData;
}
