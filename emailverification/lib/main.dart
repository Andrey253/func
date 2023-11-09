import 'dart:async';
import 'dart:io';

import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';
import 'package:starter_template/style.dart';

// This is your Appwrite function
// It's executed each time we get a request
Future<dynamic> main(final context) async {
  // context.log(
  //     'bodyRaw ${context.req.bodyRaw}'); // Raw request body, contains request data
  // context.log(
  //     'body ${context.req.body}'); // Object from parsed JSON request body, otherwise string
  // context.log('headers---------------------');  // String key-value pairs of all request headers, keys are lowercase
  // (context.req.headers as Map).forEach((key, value) {

  //   context.log(key + ': ' + value);
  // });
  // context.log('-----------------------');
  // context.log(
  //     'scheme ${context.req.scheme}'); // Value of the x-forwarded-proto header, usually http or https

  // context.log(
  //     'url ${context.req.url}'); // Full URL, for example: http://awesome.appwrite.io:8000/v1/hooks?limit=12&offset=50

  // context.log(
  //     'host ${context.req.host}'); // Hostname from the host header, such as awesome.appwrite.io
  // context.log(
  //     'port ${context.req.port}'); // Port from the host header, for example 8000
  // context.log('path');
  // context.log(context.req.path); // Path part of URL, for example /v1/hooks
  // context.log(
  //     'queryString ${context.req.queryString} runtimeType ${context.req.queryString.runtimeType.toString()}'); // Raw query params string. For example "limit=12&offset=50"
  // context.log(
  //     'query ${json.encode(context.req.query)} runtimeType '); // Parsed query params. For example, req.query.limit

  final token = await accountverfication(context.req.query, context);
  final html = '''<!DOCTYPE html>
<html><head><meta charset="utf-8"><title>Подтверждение регистрации</title></head>
<body> $style
${token == null ? ''' <a href="#" class="button17" tabindex="0" onclick="window.top.close();">
 Ошибка верификации. Закрыть окно.</a>''' : '''
<a href="https://andrey253.github.io" class="button17" tabindex="0">Верификация прошла успешно</a>
'''} </body></html>''';
  return context.res.send(html, 200, {'content-type': 'text/html'});
}


Future<Token?> accountverfication(
    Map<String, String> queryParameters, final context) async {
// Why not try the Appwrite SDK?
  final client = Client()
      .setEndpoint('https://allmarket.space/v1')
      .setProject(Platform.environment['APPWRITE_FUNCTION_PROJECT_ID'])
      .setSelfSigned();
  Account account = Account(client);


  try {
    return await account.updateVerification(
      userId: queryParameters['userId'] ?? '',
      secret: queryParameters['secret'] ?? '',
    );
  } on Exception catch (e) {
    context.log('updateVerification $e');
    return null;
  }
}

Future<Token?> verificationOrRecovery(
    Map<String, String> queryParameters, final context) async {
  try {
    if (queryParameters['userId'] != null &&
        queryParameters['secret'] != null &&
        queryParameters['type'] == 'accountverfication') {
      print('teg _queryParameters $queryParameters');

      return await accountverfication(queryParameters, context);
    }
  } on AppwriteException catch (e) {
    return null;
  }

  return null;
}
