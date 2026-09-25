import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: ListView(
        children: [
          _buildSection(
            context,
            title: 'Подключение',
            children: [
              ListTile(
                leading: const Icon(Icons.link),
                title: const Text('URL сервера'),
                subtitle: const Text('https://hermes.example.com'),
                onTap: () {
                  // TODO: Edit server URL
                },
              ),
              ListTile(
                leading: const Icon(Icons.key),
                title: const Text('API ключ'),
                subtitle: const Text('••••••••'),
                onTap: () {
                  // TODO: Edit API key
                },
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'Интерфейс',
            children: [
              ListTile(
                leading: const Icon(Icons.palette),
                title: const Text('Тема'),
                subtitle: const Text('Системная'),
                onTap: () {
                  // TODO: Change theme
                },
              ),
              ListTile(
                leading: const Icon(Icons.text_fields),
                title: const Text('Размер шрифта'),
                subtitle: const Text('Средний'),
                onTap: () {
                  // TODO: Change font size
                },
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'Уведомления',
            children: [
              SwitchListTile(
                secondary: const Icon(Icons.notifications),
                title: const Text('Включить уведомления'),
                value: true,
                onChanged: (value) {
                  // TODO: Toggle notifications
                },
              ),
              SwitchListTile(
                secondary: const Icon(Icons.vibration),
                title: const Text('Вибрация'),
                value: true,
                onChanged: (value) {
                  // TODO: Toggle vibration
                },
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'Данные',
            children: [
              ListTile(
                leading: const Icon(Icons.cleaning_services),
                title: const Text('Очистить кэш'),
                onTap: () {
                  // TODO: Clear cache
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_sweep),
                title: const Text('Очистить историю'),
                onTap: () {
                  // TODO: Clear history
                },
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'О приложении',
            children: [
              const ListTile(
                leading: Icon(Icons.info),
                title: Text('Версия'),
                subtitle: Text('1.0.0'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement logout
                context.go('/login');
              },
              icon: const Icon(Icons.logout),
              label: const Text('Выйти из аккаунта'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ...children,
      ],
    );
  }
}
