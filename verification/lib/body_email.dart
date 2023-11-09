import 'package:dart_appwrite/models.dart';

String accountverficationbody(Token? token) => token == null
    ? '''
<a href="https://andrey253.github.io" class="button17" tabindex="0" >
    Ошибка верификации. Закрыть окно.
</a>'''
    : '''
<a href="https://andrey253.github.io" class="button17" tabindex="0">
  Верификация прошла успешно
</a>
''';
