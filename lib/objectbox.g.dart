// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'model/card_model.dart';
import 'model/group_model.dart';
import 'model/password_model.dart';
import 'model/secret_note_model.dart';
import 'model/user_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 2379576262382179893),
      name: 'User',
      lastPropertyId: const IdUid(4, 1167460715826724220),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5352280719198626775),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 986270443974672897),
            name: 'pin',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 1167460715826724220),
            name: 'isBiometricEnabled',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 7022352903906742617),
      name: 'Group',
      lastPropertyId: const IdUid(3, 3294534142306290642),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4065844036565779166),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1664889290613067532),
            name: 'groupName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3294534142306290642),
            name: 'description',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[
        ModelBacklink(name: 'passwords', srcEntity: 'Password', srcField: '')
      ]),
  ModelEntity(
      id: const IdUid(3, 6243334753350276209),
      name: 'Password',
      lastPropertyId: const IdUid(8, 2322565834328061491),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5428819418602381393),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3932673885070513494),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 4755622282995748104),
            name: 'subTitle',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 4686609453007835310),
            name: 'userName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7205940068219850615),
            name: 'password',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 2104709478361974975),
            name: 'note',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 6132687139176641847),
            name: 'groupId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 2431947868288706786),
            relationTarget: 'Group'),
        ModelProperty(
            id: const IdUid(8, 2322565834328061491),
            name: 'createdDate',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 7319612359426061167),
      name: 'Card',
      lastPropertyId: const IdUid(6, 934914539446613746),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3923624425905033178),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1976595611956823025),
            name: 'bankAndCardName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5172812700472783797),
            name: 'cardNumber',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 9098147579021319787),
            name: 'cardHolderName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7283837161105017108),
            name: 'cvv',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 934914539446613746),
            name: 'cardPin',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(5, 4333211291667404215),
      name: 'SecretNote',
      lastPropertyId: const IdUid(2, 888198510703763420),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3886065542503847877),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 888198510703763420),
            name: 'note',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Shortcut for [Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [Store.new] for an explanation of all parameters.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// Returns the ObjectBox model definition for this project for use with
/// [Store.new].
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(5, 4333211291667404215),
      lastIndexId: const IdUid(1, 2431947868288706786),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [3417414018983795265],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    User: EntityDefinition<User>(
        model: _entities[0],
        toOneRelations: (User object) => [],
        toManyRelations: (User object) => {},
        getId: (User object) => object.id,
        setId: (User object, int id) {
          object.id = id;
        },
        objectToFB: (User object, fb.Builder fbb) {
          final pinOffset = fbb.writeString(object.pin);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, pinOffset);
          fbb.addBool(3, object.isBiometricEnabled);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final pinParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final isBiometricEnabledParam =
              const fb.BoolReader().vTableGet(buffer, rootOffset, 10, false);
          final object = User(
              id: idParam,
              pin: pinParam,
              isBiometricEnabled: isBiometricEnabledParam);

          return object;
        }),
    Group: EntityDefinition<Group>(
        model: _entities[1],
        toOneRelations: (Group object) => [],
        toManyRelations: (Group object) => {
              RelInfo<Password>.toOneBacklink(
                      7, object.id, (Password srcObject) => srcObject.group):
                  object.passwords
            },
        getId: (Group object) => object.id,
        setId: (Group object, int id) {
          object.id = id;
        },
        objectToFB: (Group object, fb.Builder fbb) {
          final groupNameOffset = fbb.writeString(object.groupName);
          final descriptionOffset = fbb.writeString(object.description);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, groupNameOffset);
          fbb.addOffset(2, descriptionOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final groupNameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final descriptionParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, '');
          final object = Group(
              id: idParam,
              groupName: groupNameParam,
              description: descriptionParam);
          InternalToManyAccess.setRelInfo<Group>(
              object.passwords,
              store,
              RelInfo<Password>.toOneBacklink(
                  7, object.id, (Password srcObject) => srcObject.group));
          return object;
        }),
    Password: EntityDefinition<Password>(
        model: _entities[2],
        toOneRelations: (Password object) => [object.group],
        toManyRelations: (Password object) => {},
        getId: (Password object) => object.id,
        setId: (Password object, int id) {
          object.id = id;
        },
        objectToFB: (Password object, fb.Builder fbb) {
          final titleOffset = fbb.writeString(object.title);
          final subTitleOffset = fbb.writeString(object.subTitle);
          final userNameOffset = fbb.writeString(object.userName);
          final passwordOffset = fbb.writeString(object.password);
          final noteOffset = fbb.writeString(object.note);
          fbb.startTable(9);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, titleOffset);
          fbb.addOffset(2, subTitleOffset);
          fbb.addOffset(3, userNameOffset);
          fbb.addOffset(4, passwordOffset);
          fbb.addOffset(5, noteOffset);
          fbb.addInt64(6, object.group.targetId);
          fbb.addInt64(7, object.createdDate.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final titleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final subTitleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final userNameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 10, '');
          final passwordParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 12, '');
          final noteParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 14, '');
          final createdDateParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 18, 0));
          final object = Password(
              id: idParam,
              title: titleParam,
              subTitle: subTitleParam,
              userName: userNameParam,
              password: passwordParam,
              note: noteParam,
              createdDate: createdDateParam);
          object.group.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 16, 0);
          object.group.attach(store);
          return object;
        }),
    Card: EntityDefinition<Card>(
        model: _entities[3],
        toOneRelations: (Card object) => [],
        toManyRelations: (Card object) => {},
        getId: (Card object) => object.id,
        setId: (Card object, int id) {
          object.id = id;
        },
        objectToFB: (Card object, fb.Builder fbb) {
          final bankAndCardNameOffset = fbb.writeString(object.bankAndCardName);
          final cardNumberOffset = fbb.writeString(object.cardNumber);
          final cardHolderNameOffset = fbb.writeString(object.cardHolderName);
          final cvvOffset = fbb.writeString(object.cvv);
          final cardPinOffset = fbb.writeString(object.cardPin);
          fbb.startTable(7);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, bankAndCardNameOffset);
          fbb.addOffset(2, cardNumberOffset);
          fbb.addOffset(3, cardHolderNameOffset);
          fbb.addOffset(4, cvvOffset);
          fbb.addOffset(5, cardPinOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final bankAndCardNameParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, '');
          final cardNumberParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final cardHolderNameParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, '');
          final cardPinParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 14, '');
          final cvvParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 12, '');
          final object = Card(
              id: idParam,
              bankAndCardName: bankAndCardNameParam,
              cardNumber: cardNumberParam,
              cardHolderName: cardHolderNameParam,
              cardPin: cardPinParam,
              cvv: cvvParam);

          return object;
        }),
    SecretNote: EntityDefinition<SecretNote>(
        model: _entities[4],
        toOneRelations: (SecretNote object) => [],
        toManyRelations: (SecretNote object) => {},
        getId: (SecretNote object) => object.id,
        setId: (SecretNote object, int id) {
          object.id = id;
        },
        objectToFB: (SecretNote object, fb.Builder fbb) {
          final noteOffset = fbb.writeString(object.note);
          fbb.startTable(3);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, noteOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final noteParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final object = SecretNote(id: idParam, note: noteParam);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [User] entity fields to define ObjectBox queries.
class User_ {
  /// see [User.id]
  static final id = QueryIntegerProperty<User>(_entities[0].properties[0]);

  /// see [User.pin]
  static final pin = QueryStringProperty<User>(_entities[0].properties[1]);

  /// see [User.isBiometricEnabled]
  static final isBiometricEnabled =
      QueryBooleanProperty<User>(_entities[0].properties[2]);
}

/// [Group] entity fields to define ObjectBox queries.
class Group_ {
  /// see [Group.id]
  static final id = QueryIntegerProperty<Group>(_entities[1].properties[0]);

  /// see [Group.groupName]
  static final groupName =
      QueryStringProperty<Group>(_entities[1].properties[1]);

  /// see [Group.description]
  static final description =
      QueryStringProperty<Group>(_entities[1].properties[2]);
}

/// [Password] entity fields to define ObjectBox queries.
class Password_ {
  /// see [Password.id]
  static final id = QueryIntegerProperty<Password>(_entities[2].properties[0]);

  /// see [Password.title]
  static final title =
      QueryStringProperty<Password>(_entities[2].properties[1]);

  /// see [Password.subTitle]
  static final subTitle =
      QueryStringProperty<Password>(_entities[2].properties[2]);

  /// see [Password.userName]
  static final userName =
      QueryStringProperty<Password>(_entities[2].properties[3]);

  /// see [Password.password]
  static final password =
      QueryStringProperty<Password>(_entities[2].properties[4]);

  /// see [Password.note]
  static final note = QueryStringProperty<Password>(_entities[2].properties[5]);

  /// see [Password.group]
  static final group =
      QueryRelationToOne<Password, Group>(_entities[2].properties[6]);

  /// see [Password.createdDate]
  static final createdDate =
      QueryIntegerProperty<Password>(_entities[2].properties[7]);
}

/// [Card] entity fields to define ObjectBox queries.
class Card_ {
  /// see [Card.id]
  static final id = QueryIntegerProperty<Card>(_entities[3].properties[0]);

  /// see [Card.bankAndCardName]
  static final bankAndCardName =
      QueryStringProperty<Card>(_entities[3].properties[1]);

  /// see [Card.cardNumber]
  static final cardNumber =
      QueryStringProperty<Card>(_entities[3].properties[2]);

  /// see [Card.cardHolderName]
  static final cardHolderName =
      QueryStringProperty<Card>(_entities[3].properties[3]);

  /// see [Card.cvv]
  static final cvv = QueryStringProperty<Card>(_entities[3].properties[4]);

  /// see [Card.cardPin]
  static final cardPin = QueryStringProperty<Card>(_entities[3].properties[5]);
}

/// [SecretNote] entity fields to define ObjectBox queries.
class SecretNote_ {
  /// see [SecretNote.id]
  static final id =
      QueryIntegerProperty<SecretNote>(_entities[4].properties[0]);

  /// see [SecretNote.note]
  static final note =
      QueryStringProperty<SecretNote>(_entities[4].properties[1]);
}
