import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final fstore = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

class FSAccess {
  FutureOr<Map<String, dynamic>> getFavorites() async {
    // query para traer el documento con el id del usuario autenticado
    var queryUser =
        fstore.collection("songs").doc(auth.currentUser!.uid.toString());

    // query para sacar la data del documento
    var docsRef = await queryUser.get();
    var userFavorites = docsRef.data()?["songList"];

    return {'favorites': userFavorites};
  }

  FutureOr<void> addFavorite(String song) async {
    // query para traer el documento con el id del usuario autenticado
    var queryUser =
        fstore.collection("songs").doc(auth.currentUser!.uid.toString());

    var docsRef = await queryUser.get();
    List<String> userFavorites = docsRef.data()?['songlist'];

    if (userFavorites.contains(song)) {
      throw FirebaseException(
          plugin: 'firestore', message: 'This song is already a favorite');
    }

    await queryUser.set(
      {
        'songList': userFavorites + [song]
      },
      SetOptions(mergeFields: ['songList']),
    );
  }

  FutureOr<void> deleteFavorite(String song) async {
    // query para traer el documento con el id del usuario autenticado
    var queryUser =
        fstore.collection("songs").doc(auth.currentUser!.uid.toString());

    var docsRef = await queryUser.get();
    List<String> userFavorites = docsRef.data()?['songlist'];

    if (!(userFavorites.remove(song))) {
      throw FirebaseException(
          plugin: 'firestore', message: 'This song is not in favorites');
    }

    await queryUser.set(
      {'songList': userFavorites},
      SetOptions(mergeFields: ['songList']),
    );
  }
}
