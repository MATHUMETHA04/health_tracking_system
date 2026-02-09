import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/menstrual_log.dart';

class IKYKTab extends StatefulWidget {
  const IKYKTab({Key? key}) : super(key: key);

  @override
  _IKYKTabState createState() => _IKYKTabState();
}

class _IKYKTabState extends State<IKYKTab> with SingleTickerProviderStateMixin {
  final List<MenstrualLog> _menstrualLogs = [];
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final _formKey = GlobalKey<FormState>();
  final _flowController = TextEditingController();
  final _symptomsController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  late TabController _tabController;
  bool _isPregnant = false;
  int _trimester = 0;
  DateTime? _lastPeriodDate;
  DateTime? _nextPeriodDate;
  List<String> _selectedSymptoms = [];
  List<String> _selectedSTDs = [];
  bool _isMenopausal = false;
  List<String> _menopauseSymptoms = [];
  List<String> _postnatalCareItems = [];
  DateTime? _dueDate;
  bool _isPostnatal = false;
  int _weeksPostpartum = 0;

  final List<String> _breastCancerSymptoms = [
    'Lump in breast or underarm',
    'Change in breast size or shape',
    'Nipple discharge',
    'Breast pain',
    'Skin changes on breast',
    'Nipple retraction',
  ];

  final List<String> _stdList = [
    'Chlamydia',
    'Gonorrhea',
    'Herpes',
    'HIV/AIDS',
    'HPV',
    'Syphilis',
    'Trichomoniasis',
  ];

  final List<String> _menopauseSymptomList = [
    'Hot flashes',
    'Night sweats',
    'Irregular periods',
    'Mood changes',
    'Sleep problems',
    'Weight gain',
    'Thinning hair',
    'Dry skin',
    'Loss of breast fullness',
  ];

  final List<String> _postnatalCareList = [
    'Postpartum bleeding',
    'Breastfeeding support',
    'Pelvic floor exercises',
    'Emotional well-being',
    'Physical recovery',
    'Nutrition and diet',
    'Sleep management',
    'Baby care basics',
  ];

  final Map<String, List<String>> _pregnancyFoods = {
    'First Trimester': [
      'Leafy greens',
      'Lean proteins',
      'Whole grains',
      'Fruits',
      'Dairy products',
    ],
    'Second Trimester': [
      'Iron-rich foods',
      'Calcium-rich foods',
      'Protein sources',
      'Healthy fats',
      'Fiber-rich foods',
    ],
    'Third Trimester': [
      'Omega-3 rich foods',
      'Complex carbohydrates',
      'Protein-rich foods',
      'Hydrating foods',
      'Iron-rich foods',
    ],
  };

  final Map<String, List<String>> _pregnancyMilestones = {
    'First Trimester': [
      'Week 4-5: Positive pregnancy test',
      'Week 6-8: First ultrasound',
      'Week 10-12: NIPT test',
      'Week 12: First trimester screening',
    ],
    'Second Trimester': [
      'Week 16-20: Anatomy scan',
      'Week 24-28: Glucose test',
      'Week 28: Rhogam shot (if needed)',
      'Week 28: Start kick counts',
    ],
    'Third Trimester': [
      'Week 32: Growth scan',
      'Week 36: Group B strep test',
      'Week 37: Full term',
      'Week 40: Due date',
    ],
  };

  final Map<String, List<String>> _reproductiveHealthTips = {
    'General Health': [
      'Regular exercise (30 minutes daily)',
      'Balanced diet with essential nutrients',
      'Adequate sleep (7-9 hours)',
      'Stress management techniques',
    ],
    'Reproductive Health': [
      'Regular Pap smears',
      'Breast self-exams monthly',
      'Safe sex practices',
      'Regular STI testing',
    ],
    'Pregnancy Preparation': [
      'Prenatal vitamins',
      'Healthy weight management',
      'Quit smoking and alcohol',
      'Regular medical check-ups',
    ],
  };

  final Map<String, List<String>> _mentalHealthTips = {
    'Stress Management': [
      'Practice mindfulness meditation',
      'Regular exercise',
      'Maintain a healthy sleep schedule',
      'Connect with loved ones',
      'Take breaks when needed',
    ],
    'Anxiety Relief': [
      'Deep breathing exercises',
      'Progressive muscle relaxation',
      'Limit caffeine intake',
      'Keep a gratitude journal',
      'Seek professional help if needed',
    ],
    'Depression Support': [
      'Regular physical activity',
      'Balanced diet',
      'Social connection',
      'Therapy or counseling',
      'Medication if prescribed',
    ],
  };

  final Map<String, List<String>> _pregnancyCareTips = {
    'First Trimester': [
      'Take prenatal vitamins',
      'Stay hydrated',
      'Get plenty of rest',
      'Avoid raw foods',
      'Manage morning sickness',
    ],
    'Second Trimester': [
      'Start prenatal classes',
      'Monitor weight gain',
      'Practice good posture',
      'Stay active',
      'Begin baby registry',
    ],
    'Third Trimester': [
      'Prepare birth plan',
      'Pack hospital bag',
      'Practice breathing exercises',
      'Monitor baby movements',
      'Get plenty of rest',
    ],
  };

  final Map<String, List<String>> _menstrualCareDetails = {
    'Do\'s and Don\'ts': [
      'Do: Stay hydrated with water and herbal teas',
      'Do: Eat iron-rich foods (spinach, lentils, red meat)',
      'Do: Practice gentle exercise (yoga, walking)',
      'Do: Use heating pad for cramps',
      'Do: Get adequate rest and sleep',
      'Don\'t: Consume excessive caffeine or alcohol',
      'Don\'t: Skip meals or eat junk food',
      'Don\'t: Engage in strenuous exercise',
      'Don\'t: Use scented products in genital area',
      'Don\'t: Ignore severe pain or unusual symptoms',
    ],
    'Self-Care Tips': [
      'Maintain a balanced diet with essential nutrients',
      'Practice stress-reducing activities (meditation, deep breathing)',
      'Keep track of your cycle using a period tracker',
      'Use comfortable, breathable cotton underwear',
      'Take warm baths to relax muscles',
      'Practice good hygiene and change sanitary products regularly',
      'Get regular exercise to reduce PMS symptoms',
      'Consider supplements (iron, magnesium, vitamin B6)',
      'Keep a symptom diary to track patterns',
      'Stay connected with support system',
    ],
    'Period Cramps Management': [
      'Apply heat (heating pad or warm water bottle)',
      'Try gentle abdominal massage',
      'Practice relaxation techniques',
      'Take over-the-counter pain relief if needed',
      'Try herbal teas (chamomile, ginger)',
      'Use essential oils (lavender, clary sage)',
      'Practice yoga poses for menstrual relief',
      'Consider acupuncture or acupressure',
      'Stay hydrated with warm water',
      'Get adequate rest and sleep',
    ],
    'Stress Management': [
      'Practice mindfulness meditation',
      'Try deep breathing exercises',
      'Engage in light physical activity',
      'Maintain a regular sleep schedule',
      'Limit caffeine and sugar intake',
      'Spend time in nature',
      'Practice yoga or tai chi',
      'Keep a gratitude journal',
      'Listen to calming music',
      'Take breaks when needed',
    ],
    'Mood Swing Management': [
      'Maintain regular meal times',
      'Include mood-boosting foods (dark chocolate, bananas)',
      'Practice stress-reduction techniques',
      'Get regular exercise',
      'Ensure adequate sleep',
      'Limit alcohol and caffeine',
      'Stay socially connected',
      'Practice self-compassion',
      'Consider therapy or counseling',
      'Use relaxation techniques',
    ],
  };

  final Map<String, List<String>> _pregnancyNutritionDetails = {
    'First Trimester': [
      'Folic Acid: Leafy greens, citrus fruits, beans',
      'Iron: Red meat, spinach, fortified cereals',
      'Calcium: Dairy products, almonds, tofu',
      'Protein: Lean meats, eggs, legumes',
      'Vitamin B6: Bananas, avocados, whole grains',
    ],
    'Second Trimester': [
      'Omega-3: Salmon, walnuts, flaxseeds',
      'Vitamin D: Fortified milk, eggs, sunlight',
      'Magnesium: Nuts, seeds, whole grains',
      'Fiber: Whole grains, fruits, vegetables',
      'Vitamin C: Citrus fruits, bell peppers, broccoli',
    ],
    'Third Trimester': [
      'Calcium: Dairy, leafy greens, almonds',
      'Iron: Red meat, spinach, lentils',
      'Protein: Lean meats, eggs, legumes',
      'Healthy Fats: Avocados, nuts, olive oil',
      'Complex Carbs: Whole grains, sweet potatoes',
    ],
  };

  final Map<String, List<String>> _menopauseCareDetails = {
    'Hot Flashes Management': [
      'Dress in layers for easy temperature control',
      'Keep a small fan nearby',
      'Practice deep breathing exercises',
      'Maintain a cool bedroom temperature',
      'Limit spicy foods and caffeine',
    ],
    'Bone Health': [
      'Consume calcium-rich foods daily',
      'Get regular weight-bearing exercise',
      'Ensure adequate vitamin D intake',
      'Limit alcohol and caffeine',
      'Consider bone density testing',
    ],
    'Heart Health': [
      'Maintain regular exercise routine',
      'Eat heart-healthy diet',
      'Monitor blood pressure regularly',
      'Manage stress levels',
      'Get regular check-ups',
    ],
    'Emotional Well-being': [
      'Practice mindfulness meditation',
      'Stay socially connected',
      'Get adequate sleep',
      'Consider therapy if needed',
      'Maintain regular exercise',
    ],
  };

  final Map<String, List<String>> _pregnancyTrimesterDetails = {
    'First Trimester (Weeks 1-12)': [
      'Baby Development: Formation of major organs and body systems',
      'Common Symptoms: Morning sickness, fatigue, breast tenderness',
      'Important Tests: First ultrasound, blood tests, genetic screening',
      'Weight Gain: 1-4 pounds (0.5-2 kg)',
      'Exercise: Light walking, prenatal yoga, swimming (15-30 minutes daily)',
    ],
    'Second Trimester (Weeks 13-27)': [
      'Baby Development: Rapid growth, movement begins, gender visible',
      'Common Symptoms: Reduced nausea, increased energy, back pain',
      'Important Tests: Anatomy scan, glucose screening, AFP test',
      'Weight Gain: 1 pound (0.5 kg) per week',
      'Exercise: Moderate walking, prenatal yoga, swimming (30 minutes daily)',
    ],
    'Third Trimester (Weeks 28-40)': [
      'Baby Development: Final growth, brain development, position change',
      'Common Symptoms: Heartburn, swelling, Braxton Hicks contractions',
      'Important Tests: Group B strep test, fetal monitoring, final ultrasound',
      'Weight Gain: 1 pound (0.5 kg) per week',
      'Exercise: Gentle walking, prenatal yoga, pelvic floor exercises (20-30 minutes daily)',
    ],
  };

  final Map<String, List<String>> _postnatalCareDetails = {
    'Physical Recovery': [
      'Uterine Recovery: Monitor bleeding and uterine contraction',
      'Perineal Care: Proper hygiene and wound care',
      'Breast Care: Proper breastfeeding techniques and nipple care',
      'Pelvic Floor: Exercises to strengthen muscles',
      'Nutrition: Balanced diet for healing and breastfeeding',
      'Rest: Adequate sleep and gradual return to activities',
    ],
    'Emotional Recovery': [
      'Baby Blues: Common in first 2 weeks, seek support if persistent',
      'Postpartum Depression: Watch for signs, seek professional help',
      'Bonding: Skin-to-skin contact and responsive care',
      'Support System: Family and community support',
      'Self-Care: Time for personal needs and relaxation',
      'Communication: Open discussion about feelings and concerns',
    ],
    'WHO Guidelines': [
      'First 24 Hours: Immediate skin-to-skin contact and breastfeeding',
      'First Week: Daily health checks for mother and baby',
      'First 6 Weeks: Regular postnatal visits and support',
      'Breastfeeding: Exclusive breastfeeding for first 6 months',
      'Family Planning: Discuss contraception options',
      'Mental Health: Screen for postpartum depression',
    ],
    'Immunization Schedule': [
      'Birth: Hepatitis B, BCG (if in high-risk area)',
      '6 Weeks: DTaP, Hib, IPV, PCV, Rotavirus',
      '10 Weeks: DTaP, Hib, IPV, PCV, Rotavirus',
      '14 Weeks: DTaP, Hib, IPV, PCV, Rotavirus',
      '6 Months: Influenza (yearly)',
      '12 Months: MMR, Varicella',
    ],
    'Growth & Development Monitoring': [
      'Weight: Regular weight checks and growth tracking',
      'Height: Monthly measurements',
      'Head Circumference: Regular measurements',
      'Milestones: Track developmental milestones',
      'Vision & Hearing: Regular screening',
      'Nutrition: Monitor feeding patterns and growth',
    ],
    'Postnatal Care Providers': [
      'Hospitals: Specialized postnatal wards',
      'Maternity Clinics: Regular check-ups',
      'Community Health Centers: Local support',
      'Home Visits: Community health workers',
      'Private Practitioners: Specialized care',
      'Online Support: Virtual consultations',
    ],
    'Importance of Postnatal Care': [
      'Maternal Health: Prevents complications and promotes recovery',
      'Infant Health: Ensures proper growth and development',
      'Mental Health: Supports emotional well-being',
      'Breastfeeding: Establishes successful breastfeeding',
      'Family Planning: Provides contraceptive options',
      'Education: Offers guidance on newborn care',
    ],
  };

  final Map<String, List<String>> _breastHealthDetails = {
    'Self-Awareness & Self-Examination': [
      'Monthly Self-Exam: Perform breast self-exam 7-10 days after period',
      'Visual Check: Look for changes in size, shape, or skin texture',
      'Touch Check: Feel for lumps or thickening in breast tissue',
      'Nipple Check: Look for discharge, inversion, or skin changes',
      'Underarm Check: Feel for lumps in armpit area',
      'Regular Monitoring: Track any changes and report to doctor',
    ],
    'Clinical Breast Exams': [
      'Frequency: Every 1-3 years for women 20-39, annually after 40',
      'Professional Check: Doctor examines breasts and underarms',
      'Mammogram Referral: Based on age and risk factors',
      'Follow-up: Schedule next exam based on findings',
      'Risk Assessment: Discuss family history and risk factors',
      'Documentation: Keep record of all clinical exams',
    ],
    'Screening Guidelines': [
      'Mammograms: Annual screening recommended starting at age 40',
      'Ultrasound: Additional screening for dense breast tissue',
      'MRI: For high-risk individuals or specific cases',
      'Genetic Testing: For those with family history',
      'Regular Check-ups: Maintain consistent screening schedule',
      'Follow-up Tests: Based on initial screening results',
    ],
    'Healthy Lifestyle': [
      'Maintain Healthy Weight: BMI between 18.5-24.9',
      'Regular Exercise: 150 minutes moderate activity weekly',
      'Balanced Diet: Rich in fruits, vegetables, whole grains',
      'Limit Alcohol: No more than 1 drink per day',
      'No Smoking: Avoid tobacco products',
      'Stress Management: Practice relaxation techniques',
    ],
    'Hygiene & Care': [
      'Proper Bra Fit: Supportive, well-fitting bras',
      'Skin Care: Moisturize and protect breast skin',
      'Cleanliness: Regular washing with mild soap',
      'Nipple Care: Keep area clean and dry',
      'Breastfeeding Hygiene: Proper care during lactation',
      'Regular Check-ups: Monitor breast health',
    ],
    'Early Detection Signs': [
      'New Lump: In breast or underarm area',
      'Skin Changes: Dimpling, puckering, or redness',
      'Nipple Changes: Inversion, discharge, or pain',
      'Size Changes: Unexplained swelling or shrinkage',
      'Pain: Persistent breast or nipple pain',
      'Texture Changes: Thickening or hardening of tissue',
    ],
    'Precautionary Steps': [
      'Know Your Risk: Family history and genetic factors',
      'Regular Screening: Follow recommended schedule',
      'Healthy Habits: Maintain balanced lifestyle',
      'Breastfeeding: If possible, breastfeed your baby',
      'Hormone Therapy: Discuss risks with doctor',
      'Environmental Factors: Limit exposure to radiation',
    ],
    'Risk Factors': [
      'Age: Risk increases with age',
      'Family History: Close relatives with breast cancer',
      'Genetic Mutations: BRCA1, BRCA2 genes',
      'Reproductive History: Early menstruation, late menopause',
      'Previous Conditions: History of breast conditions',
      'Radiation Exposure: Previous chest radiation',
    ],
  };

  final Map<String, List<String>> _stdAwarenessDetails = {
    'Chlamydia': [
      'Most common bacterial STI',
      'Often asymptomatic in women',
      'Can cause pelvic inflammatory disease if untreated',
      'Regular screening recommended for sexually active women under 25',
      'Treated with antibiotics',
      'Can lead to infertility if untreated',
    ],
    'Gonorrhea': [
      'Bacterial infection affecting mucous membranes',
      'Can cause pelvic inflammatory disease',
      'May lead to infertility if untreated',
      'Increasing antibiotic resistance',
      'Regular screening important',
      'Treated with antibiotics',
    ],
    'Herpes': [
      'Caused by HSV-1 or HSV-2 virus',
      'Lifelong infection with periodic outbreaks',
      'Can be transmitted even without symptoms',
      'No cure but antiviral medications help',
      'Safe sex practices reduce transmission',
      'Regular check-ups recommended',
    ],
    'HIV/AIDS': [
      'Attacks immune system',
      'Can be managed with antiretroviral therapy',
      'Regular testing important',
      'Safe sex practices crucial',
      'Pre-exposure prophylaxis (PrEP) available',
      'Early detection improves outcomes',
    ],
    'HPV': [
      'Most common viral STI',
      'Some types cause genital warts',
      'Some types linked to cervical cancer',
      'Vaccination available for prevention',
      'Regular Pap smears important',
      'Most infections clear on their own',
    ],
    'Syphilis': [
      'Bacterial infection with multiple stages',
      'Can cause serious complications if untreated',
      'Congenital syphilis can affect babies',
      'Regular screening important',
      'Treated with antibiotics',
      'Can be cured with proper treatment',
    ],
    'Trichomoniasis': [
      'Parasitic infection',
      'Common cause of vaginal infections',
      'Can increase HIV transmission risk',
      'Treated with antibiotics',
      'Regular screening recommended',
      'Partners should be treated simultaneously',
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _initializeMockData();
    _calculateNextPeriod();
    _schedulePeriodNotification();
  }

  void _calculateNextPeriod() {
    if (_menstrualLogs.isNotEmpty) {
      final lastLog = _menstrualLogs.first;
      _lastPeriodDate = lastLog.startDate;
      _nextPeriodDate = lastLog.startDate.add(const Duration(days: 28));
    }
  }

  void _schedulePeriodNotification() {
    if (_nextPeriodDate != null) {
      final notificationDate = _nextPeriodDate!.subtract(
        const Duration(days: 2),
      );
      // Here you would implement your notification scheduling logic
      // This is a placeholder for the actual notification implementation
      print(
        'Period notification scheduled for: ${notificationDate.toString()}',
      );
    }
  }

  void _initializeMockData() {
    setState(() {
      _menstrualLogs.addAll([
        MenstrualLog(
          logId: '1',
          startDate: DateTime.now().subtract(const Duration(days: 30)),
          endDate: DateTime.now().subtract(const Duration(days: 26)),
          flow: 'Medium',
          symptoms: 'Mild cramps',
        ),
        MenstrualLog(
          logId: '2',
          startDate: DateTime.now().subtract(const Duration(days: 60)),
          endDate: DateTime.now().subtract(const Duration(days: 56)),
          flow: 'Heavy',
          symptoms: 'Severe cramps, mood swings',
        ),
      ]);
    });
  }

  void _addMenstrualLog() {
    if ((_formKey.currentState?.validate() ?? false) &&
        _startDate != null &&
        _endDate != null) {
      final log = MenstrualLog(
        logId: DateTime.now().millisecondsSinceEpoch.toString(),
        startDate: _startDate!,
        endDate: _endDate!,
        flow: _flowController.text,
        symptoms: _symptomsController.text,
      );

      setState(() {
        _menstrualLogs.add(log);
        _flowController.clear();
        _symptomsController.clear();
        _startDate = null;
        _endDate = null;
        _calculateNextPeriod();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Menstrual log added successfully!')),
      );
    }
  }

  @override
  void dispose() {
    _flowController.dispose();
    _symptomsController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 154, 187),
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 113, 92, 100),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: const Color.fromARGB(255, 234, 151, 187),
              unselectedLabelColor: const Color.fromARGB(255, 220, 125, 157),
              indicatorColor: const Color.fromARGB(255, 231, 143, 181),
              tabs: const [
                Tab(
                  child: Row(
                    children: [
                      Icon(Icons.water_drop, size: 20),
                      SizedBox(width: 8),
                      Text('Menstrual'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      Icon(Icons.pregnant_woman, size: 20),
                      SizedBox(width: 8),
                      Text('Pregnancy'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      Icon(Icons.child_care, size: 20),
                      SizedBox(width: 8),
                      Text('Postnatal'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      Icon(Icons.woman, size: 20),
                      SizedBox(width: 8),
                      Text('Menopause'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      Icon(Icons.health_and_safety, size: 20),
                      SizedBox(width: 8),
                      Text('Breast Health'),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      Icon(Icons.favorite, size: 20),
                      SizedBox(width: 8),
                      Text('Sexual Health'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMenstrualTracking(),
                _buildPregnancyTracking(),
                _buildPostnatalCare(),
                _buildMenopauseTracking(),
                _buildBreastHealth(),
                _buildSexualHealth(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenstrualTracking() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            color: Colors.pink[50],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Menstrual Cycle Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 220, 123, 165),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (_lastPeriodDate != null)
                    ListTile(
                      leading: Icon(
                        Icons.calendar_today,
                        color: const Color.fromARGB(255, 228, 130, 173),
                      ),
                      title: const Text('Last Period'),
                      subtitle: Text(
                        _lastPeriodDate!.toString().substring(0, 10),
                      ),
                    ),
                  if (_nextPeriodDate != null)
                    ListTile(
                      leading: Icon(
                        Icons.event,
                        color: const Color.fromARGB(255, 228, 127, 170),
                      ),
                      title: const Text('Next Period Expected'),
                      subtitle: Text(
                        _nextPeriodDate!.toString().substring(0, 10),
                      ),
                    ),
                  if (_nextPeriodDate != null)
                    ListTile(
                      leading: Icon(
                        Icons.notifications,
                        color: const Color.fromARGB(255, 228, 131, 173),
                      ),
                      title: const Text('Period Reminder'),
                      subtitle: Text(
                        'You will be notified 2 days before your next period (${_nextPeriodDate!.subtract(const Duration(days: 2)).toString().substring(0, 10)})',
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailedSection('Do\'s and Don\'ts', {
            'Do\'s and Don\'ts': _menstrualCareDetails['Do\'s and Don\'ts']!,
          }),
          const SizedBox(height: 16),
          _buildDetailedSection('Self-Care Tips', {
            'Self-Care Tips': _menstrualCareDetails['Self-Care Tips']!,
          }),
          const SizedBox(height: 16),
          _buildDetailedSection('Period Cramps Management', {
            'Period Cramps Management':
                _menstrualCareDetails['Period Cramps Management']!,
          }),
          const SizedBox(height: 16),
          _buildDetailedSection('Stress Management', {
            'Stress Management': _menstrualCareDetails['Stress Management']!,
          }),
          const SizedBox(height: 16),
          _buildDetailedSection('Mood Swing Management', {
            'Mood Swing Management':
                _menstrualCareDetails['Mood Swing Management']!,
          }),
          const SizedBox(height: 16),
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: const Color.fromARGB(255, 245, 135, 172),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: const Color.fromARGB(255, 217, 113, 148),
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: const Color.fromARGB(255, 184, 102, 129),
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
              weekendTextStyle: TextStyle(
                color: const Color.fromARGB(255, 241, 139, 183),
              ),
              defaultTextStyle: TextStyle(
                color: const Color.fromARGB(255, 222, 126, 168),
              ),
              selectedTextStyle: const TextStyle(color: Colors.white),
              todayTextStyle: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedSection(
    String title,
    Map<String, List<String>> details,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.arrow_right,
              color: const Color.fromARGB(255, 230, 124, 170),
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 238, 133, 178),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...details.entries.map(
          (entry) => Card(
            elevation: 2,
            color: Colors.pink[50],
            child: ExpansionTile(
              leading: Icon(Icons.arrow_drop_down, color: Colors.pink[800]),
              title: Text(
                entry.key,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 245, 134, 182),
                ),
              ),
              children:
                  entry.value
                      .map(
                        (item) => ListTile(
                          leading: Icon(
                            Icons.fiber_manual_record,
                            size: 12,
                            color: const Color.fromARGB(255, 250, 148, 182),
                          ),
                          title: Text(item),
                        ),
                      )
                      .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPregnancyTracking() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            color: Colors.pink[50],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pregnancy Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 249, 152, 194),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    title: const Text('I am pregnant'),
                    value: _isPregnant,
                    activeColor: const Color.fromARGB(255, 252, 160, 200),
                    onChanged: (value) {
                      setState(() {
                        _isPregnant = value;
                        if (value) {
                          _trimester = 1;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          if (_isPregnant) ...[
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              color: Colors.pink[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Trimester',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 241, 148, 188),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        ChoiceChip(
                          label: const Text('1st'),
                          selected: _trimester == 1,
                          selectedColor: Colors.pink[200],
                          labelStyle: TextStyle(
                            color:
                                _trimester == 1
                                    ? const Color.fromARGB(255, 240, 143, 185)
                                    : const Color.fromARGB(255, 253, 147, 182),
                          ),
                          onSelected: (selected) {
                            if (selected) setState(() => _trimester = 1);
                          },
                        ),
                        const SizedBox(width: 10),
                        ChoiceChip(
                          label: const Text('2nd'),
                          selected: _trimester == 2,
                          selectedColor: Colors.pink[200],
                          labelStyle: TextStyle(
                            color:
                                _trimester == 2
                                    ? const Color.fromARGB(255, 247, 144, 188)
                                    : const Color.fromARGB(255, 250, 153, 185),
                          ),
                          onSelected: (selected) {
                            if (selected) setState(() => _trimester = 2);
                          },
                        ),
                        const SizedBox(width: 10),
                        ChoiceChip(
                          label: const Text('3rd'),
                          selected: _trimester == 3,
                          selectedColor: Colors.pink[200],
                          labelStyle: TextStyle(
                            color:
                                _trimester == 3
                                    ? const Color.fromARGB(255, 232, 142, 181)
                                    : const Color.fromARGB(255, 244, 148, 180),
                          ),
                          onSelected: (selected) {
                            if (selected) setState(() => _trimester = 3);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              color: Colors.pink[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Due Date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 248, 150, 192),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _dueDate ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 280),
                          ),
                        );
                        if (picked != null) {
                          setState(() => _dueDate = picked);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          245,
                          155,
                          194,
                        ),
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        _dueDate == null
                            ? 'Set Due Date'
                            : 'Due Date: ${_dueDate!.toString().substring(0, 10)}',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              color: Colors.pink[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last Period Date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 242, 153, 192),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _lastPeriodDate ?? DateTime.now(),
                          firstDate: DateTime.now().subtract(
                            const Duration(days: 90),
                          ),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setState(() => _lastPeriodDate = picked);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          242,
                          157,
                          194,
                        ),
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        _lastPeriodDate == null
                            ? 'Set Last Period Date'
                            : 'Last Period: ${_lastPeriodDate!.toString().substring(0, 10)}',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailedSection(
              'Trimester Details',
              _pregnancyTrimesterDetails,
            ),
            const SizedBox(height: 16),
            _buildDetailedSection(
              'Pregnancy Nutrition Guide',
              _pregnancyNutritionDetails,
            ),
            const SizedBox(height: 16),
            _buildDetailedSection('Pregnancy Care Tips', _pregnancyCareTips),
          ],
        ],
      ),
    );
  }

  Widget _buildPostnatalCare() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            color: Colors.pink[50],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Postnatal Care Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 237, 154, 190),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    title: const Text('I am in postnatal period'),
                    value: _isPostnatal,
                    onChanged: (value) {
                      setState(() {
                        _isPostnatal = value;
                        if (value) {
                          _weeksPostpartum = 1;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          if (_isPostnatal) ...[
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              color: Colors.pink[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weeks Postpartum',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 244, 157, 195),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Slider(
                      value: _weeksPostpartum.toDouble(),
                      min: 1,
                      max: 52,
                      divisions: 51,
                      label: '$_weeksPostpartum weeks',
                      onChanged: (value) {
                        setState(() => _weeksPostpartum = value.toInt());
                      },
                      activeColor: const Color.fromARGB(255, 248, 170, 204),
                      inactiveColor: Colors.pink[200],
                    ),
                    Text(
                      'Current Week: $_weeksPostpartum',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 255, 171, 207),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailedSection('Physical Recovery', {
              'Physical Recovery': _postnatalCareDetails['Physical Recovery']!,
            }),
            const SizedBox(height: 16),
            _buildDetailedSection('Emotional Recovery', {
              'Emotional Recovery':
                  _postnatalCareDetails['Emotional Recovery']!,
            }),
            const SizedBox(height: 16),
            _buildDetailedSection('WHO Guidelines', {
              'WHO Guidelines': _postnatalCareDetails['WHO Guidelines']!,
            }),
            const SizedBox(height: 16),
            _buildDetailedSection('Immunization Schedule', {
              'Immunization Schedule':
                  _postnatalCareDetails['Immunization Schedule']!,
            }),
            const SizedBox(height: 16),
            _buildDetailedSection('Growth & Development', {
              'Growth & Development Monitoring':
                  _postnatalCareDetails['Growth & Development Monitoring']!,
            }),
            const SizedBox(height: 16),
            _buildDetailedSection('Care Providers', {
              'Postnatal Care Providers':
                  _postnatalCareDetails['Postnatal Care Providers']!,
            }),
            const SizedBox(height: 16),
            _buildDetailedSection('Importance of Care', {
              'Importance of Postnatal Care':
                  _postnatalCareDetails['Importance of Postnatal Care']!,
            }),
          ],
        ],
      ),
    );
  }

  Widget _buildMenopauseTracking() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            color: Colors.pink[50],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Menopause Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 240, 146, 187),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    title: const Text('I am experiencing menopause symptoms'),
                    value: _isMenopausal,
                    onChanged: (value) {
                      setState(() => _isMenopausal = value);
                    },
                  ),
                ],
              ),
            ),
          ),
          if (_isMenopausal) ...[
            const SizedBox(height: 16),
            _buildDetailedSection(
              'Menopause Care Guide',
              _menopauseCareDetails,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBreastHealth() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            color: Colors.pink[50],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Breast Health Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 248, 175, 207),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Regular breast health monitoring is essential for early detection and prevention of breast cancer.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailedSection('Self-Awareness & Self-Examination', {
            'Self-Awareness & Self-Examination':
                _breastHealthDetails['Self-Awareness & Self-Examination']!,
          }),
          const SizedBox(height: 16),
          _buildDetailedSection('Clinical Breast Exams', {
            'Clinical Breast Exams':
                _breastHealthDetails['Clinical Breast Exams']!,
          }),
          const SizedBox(height: 16),
          _buildDetailedSection('Screening Guidelines', {
            'Screening Guidelines':
                _breastHealthDetails['Screening Guidelines']!,
          }),
          const SizedBox(height: 16),
          _buildDetailedSection('Healthy Lifestyle', {
            'Healthy Lifestyle': _breastHealthDetails['Healthy Lifestyle']!,
          }),
          const SizedBox(height: 16),
          _buildDetailedSection('Hygiene & Care', {
            'Hygiene & Care': _breastHealthDetails['Hygiene & Care']!,
          }),
          const SizedBox(height: 16),
          _buildDetailedSection('Early Detection Signs', {
            'Early Detection Signs':
                _breastHealthDetails['Early Detection Signs']!,
          }),
          const SizedBox(height: 16),
          _buildDetailedSection('Precautionary Steps', {
            'Precautionary Steps': _breastHealthDetails['Precautionary Steps']!,
          }),
          const SizedBox(height: 16),
          _buildDetailedSection('Risk Factors', {
            'Risk Factors': _breastHealthDetails['Risk Factors']!,
          }),
        ],
      ),
    );
  }

  Widget _buildSexualHealth() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            color: Colors.pink[50],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sexual Health Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 249, 169, 204),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Regular STI screening and safe sex practices are essential for maintaining sexual health.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailedSection('STD Awareness', _stdAwarenessDetails),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            color: Colors.pink[50],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prevention Tips',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 242, 158, 194),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: Icon(
                      Icons.shield,
                      color: const Color.fromARGB(255, 244, 150, 191),
                    ),
                    title: const Text('Use Protection'),
                    subtitle: const Text('Always use condoms or dental dams'),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.medical_services,
                      color: const Color.fromARGB(255, 241, 145, 186),
                    ),
                    title: const Text('Regular Testing'),
                    subtitle: const Text(
                      'Get tested regularly, especially with new partners',
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.vaccines,
                      color: const Color.fromARGB(255, 245, 159, 196),
                    ),
                    title: const Text('Vaccinations'),
                    subtitle: const Text(
                      'Get HPV and Hepatitis B vaccinations',
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.people,
                      color: const Color.fromARGB(255, 251, 163, 201),
                    ),
                    title: const Text('Partner Communication'),
                    subtitle: const Text('Discuss sexual health with partners'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
