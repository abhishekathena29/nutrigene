import 'package:flutter/material.dart';

class BrainActivitiesPage extends StatelessWidget {
  const BrainActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Brain-Boosting Activities')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            color: Colors.blue.shade50,
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.extension, color: Colors.blue),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Activities designed to enhance cognitive development',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Language & Communication',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildActivityCard(
            title: 'Story Time',
            description:
                'Read books together daily to build vocabulary and comprehension',
            ageRange: '2-6 years',
            duration: '15-20 min',
            icon: Icons.menu_book,
            color: Colors.purple,
          ),
          const SizedBox(height: 8),
          _buildActivityCard(
            title: 'Rhyme & Song',
            description:
                'Sing nursery rhymes and songs to develop phonological awareness',
            ageRange: '1-5 years',
            duration: '10-15 min',
            icon: Icons.music_note,
            color: Colors.pink,
          ),
          const SizedBox(height: 16),
          const Text(
            'Problem Solving & Logic',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildActivityCard(
            title: 'Puzzle Play',
            description:
                'Age-appropriate puzzles improve spatial reasoning and problem-solving',
            ageRange: '3-8 years',
            duration: '20-30 min',
            icon: Icons.extension,
            color: Colors.blue,
          ),
          const SizedBox(height: 8),
          _buildActivityCard(
            title: 'Building Blocks',
            description:
                'Create structures with blocks to develop spatial awareness',
            ageRange: '2-7 years',
            duration: '15-25 min',
            icon: Icons.dashboard,
            color: Colors.orange,
          ),
          const SizedBox(height: 8),
          _buildActivityCard(
            title: 'Memory Games',
            description:
                'Card matching and memory exercises strengthen recall abilities',
            ageRange: '4-10 years',
            duration: '10-15 min',
            icon: Icons.replay,
            color: Colors.teal,
          ),
          const SizedBox(height: 16),
          const Text(
            'Creative & Motor Skills',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildActivityCard(
            title: 'Arts & Crafts',
            description:
                'Drawing, coloring, and crafting enhance fine motor skills and creativity',
            ageRange: '2-10 years',
            duration: '20-40 min',
            icon: Icons.palette,
            color: Colors.red,
          ),
          const SizedBox(height: 8),
          _buildActivityCard(
            title: 'Dance & Movement',
            description:
                'Rhythmic movement improves coordination and body awareness',
            ageRange: '2-8 years',
            duration: '15-30 min',
            icon: Icons.directions_walk,
            color: Colors.green,
          ),
          const SizedBox(height: 16),
          const Text(
            'Social & Emotional',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildActivityCard(
            title: 'Role Play',
            description:
                'Pretend play develops imagination and social understanding',
            ageRange: '3-8 years',
            duration: '20-40 min',
            icon: Icons.theater_comedy,
            color: Colors.purple,
          ),
          const SizedBox(height: 8),
          _buildActivityCard(
            title: 'Group Games',
            description: 'Interactive games teach cooperation and turn-taking',
            ageRange: '3-10 years',
            duration: '20-30 min',
            icon: Icons.groups,
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          const Text(
            'STEM Activities',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildActivityCard(
            title: 'Nature Exploration',
            description:
                'Outdoor discovery builds observation and scientific thinking',
            ageRange: '3-10 years',
            duration: '30-60 min',
            icon: Icons.nature,
            color: Colors.green,
          ),
          const SizedBox(height: 8),
          _buildActivityCard(
            title: 'Simple Experiments',
            description:
                'Safe science experiments develop curiosity and analytical skills',
            ageRange: '5-10 years',
            duration: '20-40 min',
            icon: Icons.science,
            color: Colors.indigo,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard({
    required String title,
    required String description,
    required String ageRange,
    required String duration,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.2),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildInfoChip(Icons.child_care, ageRange, Colors.blue),
                const SizedBox(width: 8),
                _buildInfoChip(Icons.schedule, duration, Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

