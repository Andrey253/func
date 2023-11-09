import 'package:dart_appwrite/models.dart';

String body(Token? token) => token == null
    ? '''
<a href="#" class="button17" tabindex="0" onclick="window.top.close();">
    Ошибка верификации. Закрыть окно.
</a>'''
    : '''
<a href="https://andrey253.github.io" class="button17" tabindex="0">
  Верификация прошла успешно
</a>
''';
