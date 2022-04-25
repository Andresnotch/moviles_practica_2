import 'dart:async';
import 'dart:io';
import 'package:findtrackapp/utils/secret.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

part 'listen_event.dart';
part 'listen_state.dart';

final record = Record();

class ListenBloc extends Bloc<ListenEvent, ListenState> {
  ListenBloc() : super(ListenInitial()) {
    on<ListenNowEvent>(listenNow);
  }

  FutureOr<void> listenNow(event, emit) async {
    emit(ListeningState());
    bool permission = await record.hasPermission();
    Directory temp = await getTemporaryDirectory();
    await record.start(
      path: temp.path + 'record.m4a',
    );
    await Future.delayed(Duration(seconds: 5), () {});
    String? spath = await record.stop();

    var url =
        Uri.parse('https://api.audd.io/?return=spotify,lyrics,apple_music');
    try {
      //var response = await post(url, headers: {'api_token': API_KEY});
      var request = new MultipartRequest('POST', url);
      request.headers['api_token'] = API_KEY;
      request.headers['Content-Type'] = 'multipart/form-data';
      MultipartFile file = await MultipartFile.fromPath(
        'file',
        spath!,
      );
      request.files.add(file);
      StreamedResponse val;
      var res = await Response.fromStream(await request.send());
      String body = res.body;
      if (res.statusCode == 200) print('Uploaded!');
    } catch (e) {
      print('Error: ' + e.toString());
    }
    emit(ListenInitial());
  }
}
