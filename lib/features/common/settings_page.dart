import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';
import 'package:nutritrack/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'English';
  String _selectedUnits = 'Metric';

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: const Text('Settings'),
        leading: IconButton(
          icon: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              size: 18,
              color: AppTheme.textPrimary,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          const _SectionLabel(label: 'General'),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Column(
              children: [
                _ToggleRow(
                  icon: Icons.notifications_outlined,
                  iconColor: AppTheme.primaryColor,
                  iconBg: AppTheme.primarySurface,
                  title: 'Notifications',
                  subtitle: 'Receive alerts and reminders',
                  value: _notificationsEnabled,
                  onChanged: (v) => setState(() => _notificationsEnabled = v),
                ),
                const Divider(height: 1, indent: 56),
                _ToggleRow(
                  icon: Icons.dark_mode_outlined,
                  iconColor: const Color(0xFF7C3AED),
                  iconBg: const Color(0xFFF5F3FF),
                  title: 'Dark Mode',
                  subtitle: 'Use dark theme',
                  value: themeProvider.isDarkMode,
                  onChanged: (v) => themeProvider.setDarkMode(v),
                  isLast: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // const _SectionLabel(label: 'Language & Region'),
          // const SizedBox(height: 10),
          // Container(
          //   decoration: BoxDecoration(
          //     color: AppTheme.surfaceColor,
          //     borderRadius: BorderRadius.circular(18),
          //     border: Border.all(color: AppTheme.borderColor),
          //   ),
          //   child: Column(
          //     children: [
          //       _NavRow(
          //         icon: Icons.language_rounded,
          //         iconColor: AppTheme.secondaryColor,
          //         iconBg: const Color(0xFFEFF6FF),
          //         title: 'Language',
          //         value: _selectedLanguage,
          //         onTap: _showLanguageDialog,
          //       ),
          //       const Divider(height: 1, indent: 56),
          //       _NavRow(
          //         icon: Icons.straighten_rounded,
          //         iconColor: const Color(0xFFF97316),
          //         iconBg: const Color(0xFFFFF7ED),
          //         title: 'Units',
          //         value: _selectedUnits,
          //         onTap: _showUnitsDialog,
          //         isLast: true,
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 20),
          const _SectionLabel(label: 'Data & Privacy'),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Column(
              children: [
                _NavRow(
                  icon: Icons.cloud_upload_outlined,
                  iconColor: AppTheme.primaryColor,
                  iconBg: AppTheme.primarySurface,
                  title: 'Backup Data',
                  value: 'Save to cloud',
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Backing up data...')),
                  ),
                ),
                const Divider(height: 1, indent: 56),
                _NavRow(
                  icon: Icons.download_rounded,
                  iconColor: AppTheme.secondaryColor,
                  iconBg: const Color(0xFFEFF6FF),
                  title: 'Export Data',
                  value: 'Download your data',
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Exporting data...')),
                  ),
                ),
                const Divider(height: 1, indent: 56),
                _NavRow(
                  icon: Icons.delete_forever_rounded,
                  iconColor: AppTheme.errorColor,
                  iconBg: const Color(0xFFFEF2F2),
                  title: 'Clear All Data',
                  value: 'Permanently delete',
                  onTap: _showClearDataDialog,
                  isLast: true,
                  titleColor: AppTheme.errorColor,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          const _SectionLabel(label: 'Support'),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Column(
              children: [
                _NavRow(
                  icon: Icons.help_outline_rounded,
                  iconColor: AppTheme.secondaryColor,
                  iconBg: const Color(0xFFEFF6FF),
                  title: 'Help Center',
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening help center...')),
                  ),
                ),
                const Divider(height: 1, indent: 56),
                _NavRow(
                  icon: Icons.feedback_outlined,
                  iconColor: AppTheme.primaryColor,
                  iconBg: AppTheme.primarySurface,
                  title: 'Send Feedback',
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening feedback form...')),
                  ),
                ),
                const Divider(height: 1, indent: 56),
                _NavRow(
                  icon: Icons.bug_report_outlined,
                  iconColor: const Color(0xFFF97316),
                  iconBg: const Color(0xFFFFF7ED),
                  title: 'Report a Bug',
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening bug report...')),
                  ),
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Select Language'),
          content: RadioGroup<String>(
            groupValue: _selectedLanguage,
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedLanguage = value);
                Navigator.pop(ctx);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: ['English', 'Spanish', 'French']
                  .map(
                    (lang) =>
                        RadioListTile<String>(title: Text(lang), value: lang),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _showUnitsDialog() {
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Select Units'),
          content: RadioGroup<String>(
            groupValue: _selectedUnits,
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedUnits = value);
                Navigator.pop(ctx);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                RadioListTile<String>(
                  title: Text('Metric (kg, cm)'),
                  value: 'Metric',
                ),
                RadioListTile<String>(
                  title: Text('Imperial (lb, in)'),
                  value: 'Imperial',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showClearDataDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear All Data?'),
        content: const Text(
          'This will permanently delete all data. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data cleared successfully')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: AppTheme.textTertiary,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.isLast = false,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppTheme.primaryColor,
          ),
        ],
      ),
    );
  }
}

class _NavRow extends StatelessWidget {
  const _NavRow({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.onTap,
    this.value,
    this.isLast = false,
    this.titleColor = AppTheme.textPrimary,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String? value;
  final VoidCallback onTap;
  final bool isLast;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: titleColor,
                    ),
                  ),
                  if (value != null)
                    Text(
                      value!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: AppTheme.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
