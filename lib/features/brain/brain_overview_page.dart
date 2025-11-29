import 'package:flutter/material.dart';

class BrainOverviewPage extends StatelessWidget {
  const BrainOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Brain Development Overview')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.purple.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.psychology, color: Colors.purple, size: 32),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Early Brain Development',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'The foundation for lifelong learning',
                            style: TextStyle(color: Colors.purple),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Introduction',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Brain development in children is a complex process that begins before birth and continues into early adulthood. The first few years of life are particularly critical, as the brain forms more than 1 million neural connections every second.',
                  style: TextStyle(fontSize: 16, height: 1.6),
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Key Development Stages',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildStageCard(
              '0-3 Years',
              'Rapid Brain Growth',
              'The brain reaches 80% of adult size. Critical period for language, sensory, and motor skill development.',
              Icons.child_care,
              Colors.pink,
            ),
            const SizedBox(height: 8),
            _buildStageCard(
              '3-6 Years',
              'Social & Emotional Development',
              'Development of self-control, emotional regulation, and social skills. Language skills expand rapidly.',
              Icons.people,
              Colors.blue,
            ),
            const SizedBox(height: 8),
            _buildStageCard(
              '6-12 Years',
              'Cognitive Growth',
              'Improved attention span, problem-solving abilities, and logical thinking. Academic skills develop.',
              Icons.school,
              Colors.green,
            ),
            const SizedBox(height: 8),
            _buildStageCard(
              '12+ Years',
              'Executive Functions',
              'Development of planning, decision-making, and impulse control. Brain continues maturing into mid-20s.',
              Icons.psychology,
              Colors.purple,
            ),
            const SizedBox(height: 24),

            const Text(
              'Factors Affecting Brain Development',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildFactorCard(
              'Nutrition',
              'Proper nutrition provides essential building blocks for brain cells and neurotransmitters',
              Icons.restaurant,
              Colors.orange,
            ),
            const SizedBox(height: 8),
            _buildFactorCard(
              'Stimulation',
              'Interactive play, reading, and conversation promote neural pathway formation',
              Icons.toys,
              Colors.blue,
            ),
            const SizedBox(height: 8),
            _buildFactorCard(
              'Sleep',
              'Adequate sleep is crucial for memory consolidation and brain development',
              Icons.bedtime,
              Colors.indigo,
            ),
            const SizedBox(height: 8),
            _buildFactorCard(
              'Physical Activity',
              'Exercise improves blood flow to the brain and supports cognitive function',
              Icons.directions_run,
              Colors.green,
            ),
            const SizedBox(height: 8),
            _buildFactorCard(
              'Emotional Safety',
              'Secure attachment and stress-free environment promote healthy brain development',
              Icons.favorite,
              Colors.red,
            ),
            const SizedBox(height: 24),

            Card(
              color: Colors.green.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb, color: Colors.green),
                        SizedBox(width: 12),
                        Text(
                          'Key Takeaway',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Early experiences and nutrition have lasting impacts on brain architecture. Providing proper nutrition, stimulation, and care during childhood sets the foundation for cognitive abilities, learning, and emotional well-being throughout life.',
                      style: TextStyle(color: Colors.green, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStageCard(
    String age,
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        age,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFactorCard(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

