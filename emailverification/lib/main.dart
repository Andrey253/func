import 'dart:async';
import 'dart:io';

import 'package:dart_appwrite/dart_appwrite.dart' as dart_appwrite;
import 'package:dart_appwrite/models.dart' as models;
import 'package:starter_template/body.dart';
import 'package:starter_template/html.dart';

import 'style.dart';

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

  final document = html
    ..replaceAll('''{body}''', body(token))
    ..replaceAll('''{style}''', style);
  context.log(document);
  try {
  return context.res.send(document, 200, {'content-type': 'text/html'});
} on Exception catch (e) {
    return context.res.send('Error');
}
}

Future<models.Token?> accountverfication(
    Map<String, String> queryParameters, final context) async {
// Why not try the Appwrite SDK?
  final client = dart_appwrite.Client()
      .setEndpoint('https://allmarket.space/v1')
      .setProject(Platform.environment['APPWRITE_FUNCTION_PROJECT_ID'])
      .setSelfSigned();
  dart_appwrite.Account account = dart_appwrite.Account(client);

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

Future<models.Token?> verificationOrRecovery(
    Map<String, String> queryParameters, final context) async {
  try {
    if (queryParameters['userId'] != null &&
        queryParameters['secret'] != null &&
        queryParameters['type'] == 'accountverfication') {
      print('teg _queryParameters $queryParameters');

      return await accountverfication(queryParameters, context);
    }
  } on dart_appwrite.AppwriteException catch (e) {
    return null;
  }

  return null;
}
