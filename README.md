# MinskTransportCrossplatform

Кроссплатформенное приложение на Flutter — транспортный справочник Минска с поддержкой Android, iOS, Linux и Web.

## Основные возможности

- Авторизация (email/пароль) с сохранением сессии
- Просмотр маршрутов и остановок
- Добавление/удаление из избранного
- Детальная информация о маршруте
- Тёмная и светлая тема
- Офлайн-режим (кеширование данных)
- Push-уведомления (Android/iOS) и Toast (Linux/Web)
- Настройки приложения
- Локализация (русский, английский, белорусский)
- Адаптивный UI под все платформы

## Технологии

| Компонент       | Технология                            |
|----------------|---------------------------------------|
| Фреймворк       | Flutter 3.24+, Dart 3.5+              |
| Управление состоянием | Riverpod 2.x                     |
| Сеть            | Dio + Retrofit (генерация кода)       |
| Локальное хранение | Hive + Drift (SQLite)               |
| Навигация       | GoRouter                              |
| Графики         | fl_chart                              |
| Тесты           | flutter_test, integration_test       |
| CI/CD           | GitHub Actions                        |

## Установка и запуск

```bash
git clone https://github.com/Xeiniya/minsk_transport_crossplatform.git
cd minsk_transport_crossplatform
flutter pub get
flutter pub run build_runner build
flutter run
```

## Тестирование

```bash
flutter test
```

## Сборка под платформы

```bash
flutter build apk
flutter build linux
flutter build web
```

## Структура проекта

```
lib/
├── app/              # Настройки маршрутов
├── core/             # Константы, темы, утилиты, виджеты
├── data/             # Модели, репозитории, локальное БД
├── features/         # Фичи (auth, routes, favorites, settings)
├── localization/     # Файлы перевода
├── services/         # Сервисы (уведомления, подключение, погода)
└── main.dart
```

## Author

Ксения Николаева
