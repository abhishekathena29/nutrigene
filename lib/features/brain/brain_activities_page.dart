import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';

class BrainActivitiesPage extends StatelessWidget {
  const BrainActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        title: const Text('Brain Activities'),
        leading: IconButton(
          icon: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppTheme.textPrimary),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          // Info banner
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: [
                Icon(Icons.extension_rounded, color: AppTheme.secondaryColor, size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Activities designed to enhance cognitive development at every age.',
                    style: TextStyle(fontSize: 13, color: AppTheme.secondaryColor, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          _CategorySection(
            title: 'Language & Communication',
            activities: [
              _ActivityData(
                title: 'Story Time',
                description: 'Read books together daily to build vocabulary and comprehension.',
                ageRange: '2–6 years',
                duration: '15–20 min',
                icon: Icons.menu_book_rounded,
                color: const Color(0xFF7C3AED),
                bgColor: const Color(0xFFF5F3FF),
              ),
              _ActivityData(
                title: 'Rhyme & Song',
                description: 'Sing nursery rhymes and songs to develop phonological awareness.',
                ageRange: '1–5 years',
                duration: '10–15 min',
                icon: Icons.music_note_rounded,
                color: const Color(0xFFEC4899),
                bgColor: const Color(0xFFFDF2F8),
              ),
            ],
          ),
          const SizedBox(height: 20),

          _CategorySection(
            title: 'Problem Solving & Logic',
            activities: [
              _ActivityData(
                title: 'Puzzle Play',
                description: 'Age-appropriate puzzles improve spatial reasoning and problem-solving.',
                ageRange: '3–8 years',
                duration: '20–30 min',
                icon: Icons.extension_rounded,
                color: AppTheme.secondaryColor,
                bgColor: const Color(0xFFEFF6FF),
              ),
              _ActivityData(
                title: 'Building Blocks',
                description: 'Create structures with blocks to develop spatial awareness.',
                ageRange: '2–7 years',
                duration: '15–25 min',
                icon: Icons.view_module_rounded,
                color: const Color(0xFFF97316),
                bgColor: const Color(0xFFFFF7ED),
              ),
              _ActivityData(
                title: 'Memory Games',
                description: 'Card matching and memory exercises strengthen recall abilities.',
                ageRange: '4–10 years',
                duration: '10–15 min',
                icon: Icons.style_rounded,
                color: const Color(0xFF0D9488),
                bgColor: const Color(0xFFF0FDFA),
              ),
            ],
          ),
          const SizedBox(height: 20),

          _CategorySection(
            title: 'Creative & Motor Skills',
            activities: [
              _ActivityData(
                title: 'Arts & Crafts',
                description: 'Drawing, coloring, and crafting enhance fine motor skills and creativity.',
                ageRange: '2–10 years',
                duration: '20–40 min',
                icon: Icons.palette_rounded,
                color: const Color(0xFFEF4444),
                bgColor: const Color(0xFFFEF2F2),
              ),
              _ActivityData(
                title: 'Dance & Movement',
                description: 'Rhythmic movement improves coordination and body awareness.',
                ageRange: '2–8 years',
                duration: '15–30 min',
                icon: Icons.directions_walk_rounded,
                color: AppTheme.primaryColor,
                bgColor: AppTheme.primarySurface,
              ),
            ],
          ),
          const SizedBox(height: 20),

          _CategorySection(
            title: 'Social & Emotional',
            activities: [
              _ActivityData(
                title: 'Role Play',
                description: 'Pretend play develops imagination and social understanding.',
                ageRange: '3–8 years',
                duration: '20–40 min',
                icon: Icons.theater_comedy_rounded,
                color: const Color(0xFF7C3AED),
                bgColor: const Color(0xFFF5F3FF),
              ),
              _ActivityData(
                title: 'Group Games',
                description: 'Interactive games teach cooperation and turn-taking.',
                ageRange: '3–10 years',
                duration: '20–30 min',
                icon: Icons.groups_rounded,
                color: AppTheme.secondaryColor,
                bgColor: const Color(0xFFEFF6FF),
              ),
            ],
          ),
          const SizedBox(height: 20),

          _CategorySection(
            title: 'STEM Activities',
            activities: [
              _ActivityData(
                title: 'Nature Exploration',
                description: 'Outdoor discovery builds observation and scientific thinking.',
                ageRange: '3–10 years',
                duration: '30–60 min',
                icon: Icons.nature_rounded,
                color: AppTheme.primaryColor,
                bgColor: AppTheme.primarySurface,
              ),
              _ActivityData(
                title: 'Simple Experiments',
                description: 'Safe science experiments develop curiosity and analytical skills.',
                ageRange: '5–10 years',
                duration: '20–40 min',
                icon: Icons.science_rounded,
                color: const Color(0xFF6366F1),
                bgColor: const Color(0xFFEEF2FF),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActivityData {
  const _ActivityData({
    required this.title,
    required this.description,
    required this.ageRange,
    required this.duration,
    required this.icon,
    required this.color,
    required this.bgColor,
  });

  final String title;
  final String description;
  final String ageRange;
  final String duration;
  final IconData icon;
  final Color color;
  final Color bgColor;
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({required this.title, required this.activities});
  final String title;
  final List<_ActivityData> activities;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 12),
        ...activities.map(
          (a) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _ActivityCard(data: a),
          ),
        ),
      ],
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({required this.data});
  final _ActivityData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: data.bgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(data.icon, color: data.color, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            data.description,
            style: const TextStyle(
              fontSize: 13,
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _InfoChip(
                icon: Icons.child_care_rounded,
                label: data.ageRange,
                color: AppTheme.secondaryColor,
              ),
              const SizedBox(width: 8),
              _InfoChip(
                icon: Icons.schedule_rounded,
                label: data.duration,
                color: const Color(0xFFF97316),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label, required this.color});
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
