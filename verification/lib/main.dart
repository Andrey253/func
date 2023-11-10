import 'dart:async';
import 'dart:io';

import 'package:dart_appwrite/dart_appwrite.dart' as dart_appwrite;
import 'package:dart_appwrite/models.dart' as models;
import 'package:starter_template/body_email.dart';
import 'package:starter_template/body_form.dart';

import 'body_virification.dart';
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
  context.log('body ${context.req.body}');
  context.log('body runtimeType ${context.req.body.runtimeType.toString()}');
  context.log('method ${context.req.method}');
  context.log('Uri.splitQueryString(context.req.body) ${Uri.splitQueryString(context.req.body)}');
  context.log('Uri.splitQueryString runtimeType) ${Uri.splitQueryString(context.req.body).runtimeType.toString()}');

  models.Token? token;
  String document = '';

  if (context.req.query['type'] == 'accountverfication') {
    token = await accountverfication(context.req.query, context);
    document = form;
    try {
      return context.res.send(document, 200, {'content-type': 'text/html'});
    } on Exception catch (e) {
      return context.res.send('Error');
    }
  } else if (context.req.query['type'] == 'recovery') {
    token = await recovery(context.req.query, context);
    document = form;
    try {
      return context.res.send(document, 200, {'content-type': 'text/html'});
    } on Exception catch (e) {
      return context.res.send('Error');
    }
  } else {
    return context.res.send(form, 200, {'content-type': 'text/html'});
  }
}

Future<models.Token?> accountverfication(Map<String, String> queryParameters, final context) async {
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

Future<models.Token?> recovery(Map<String, String> queryParameters, final context) async {
  try {
    final client = dart_appwrite.Client()
        .setEndpoint('https://allmarket.space/v1')
        .setProject(Platform.environment['APPWRITE_FUNCTION_PROJECT_ID'])
        .setSelfSigned();
    dart_appwrite.Account account = dart_appwrite.Account(client);
    await account.updateRecovery(
        userId: queryParameters['userId']!,
        secret: queryParameters['secret']!,
        password: '12345678',
        passwordAgain: '12345678');
  } on dart_appwrite.AppwriteException catch (e) {
    return null;
  }

  return null;
}
