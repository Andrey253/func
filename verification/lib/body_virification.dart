import 'package:dart_appwrite/models.dart';

String recoverybody(Token? token) => token == null
    ? '''
<a href="https://andrey253.github.io" class="button17" tabindex="0" >
    Ошибка восстановления пароля. Закрыть окно.
</a>'''
    : '''
<a href="https://andrey253.github.io" class="button17" tabindex="0">
  Восстановление пароля прошло успешно
</a>
''';
