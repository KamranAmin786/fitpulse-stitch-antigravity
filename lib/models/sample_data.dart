import 'package:flutter/material.dart';

class DayRhythm {
  final String day;
  final bool isCompleted;
  final bool isToday;
  final bool isRest;

  const DayRhythm({
    required this.day,
    this.isCompleted = false,
    this.isToday = false,
    this.isRest = false,
  });
}

class WorkoutSet {
  final String setNumber;
  final String previous;
  int reps;
  double weight;
  bool isCompleted;
  bool isActive;
  bool isLocked;

  WorkoutSet({
    required this.setNumber,
    required this.previous,
    required this.reps,
    required this.weight,
    this.isCompleted = false,
    this.isActive = false,
    this.isLocked = false,
  });
}

class ExerciseDetail {
  final String number;
  final String name;
  final String category;
  final String targetSummary;
  final IconData icon;
  final Color iconColor;
  final List<WorkoutSet>? sets;
  final List<String>? summaryPills;

  const ExerciseDetail({
    required this.number,
    required this.name,
    required this.category,
    required this.targetSummary,
    required this.icon,
    required this.iconColor,
    this.sets,
    this.summaryPills,
  });
}

class BarData {
  final String day;
  final double calories;
  final String duration;
  final double heightRatio;
  final bool isPeak;
  final bool isRest;

  const BarData({
    required this.day,
    required this.calories,
    required this.duration,
    required this.heightRatio,
    this.isPeak = false,
    this.isRest = false,
  });

  String get tooltipText => isRest ? 'Rest Day • Light Walk' : '${calories.toInt()} kcal • $duration';
}

class PersonalRecord {
  final String exercise;
  final String badgeText;
  final Color? badgeColor;
  final String subtitle;
  final String recordValue;
  final String recordUnit;
  final String recordType;
  final IconData icon;
  final Color iconColor;

  const PersonalRecord({
    required this.exercise,
    required this.badgeText,
    this.badgeColor,
    required this.subtitle,
    required this.recordValue,
    required this.recordUnit,
    required this.recordType,
    required this.icon,
    required this.iconColor,
  });
}

class SampleData {
  // User Profile
  static const String userName = 'Alex Rivera';
  static const String userHandle = '@arivera_fit • Athlete Tier 3';
  static const String userAvatarUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBjYA2JiE4tXu688tf0fahULfYIZvH5M_eLTy2-9gcLUSCVVaTHQUf344BVZOJGQjn14l1trE5myQPFVC3xrZKy7zukS5-5-0nvMUHgdZNKDdReWTbrLN-kv93SVQycdv4bpHhNqUt1CeWtsIrcWceYS7MvBUUWWbGBve1oQclMNEyRWdk3J9fibPy_wBIuRqtdlm8H5fNhl1bWNlwOtUe06h5KKzzEp4twMAWGis8';
  static const String coachAvatarUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuAs1MPVRrfhN_Vpu4rtHOW-c6q9iF2tMLPKwNvNebs4EAGdTu_7RteX1YjkI34W1e4irWKBe6bk7bN9KLmYv52iejMiVwVt4-1oWjWVoiory9ah3XeLH3fWMnWyvWpVh31mKQZ1fQuvh41EqquvkWu3byEu96WQoTGvsnprV22Q0gUqNZEIo8jrgUbIgk-qKduh9xUZ3zEoGurAWtMeG5WYydDqbTIh6tJn4foGQQ0';
  static const String workoutImageUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuDQoCB9pOhj1zyvIIyNx4677t263nXqGRzQk2IPsUUYISEmXCx9eN2kd4TeiDIR8iM8z7v7os-5GmCDQP4kkSbBupgCJDLIKK-N2l7YC5St1YkJWkdwC27vgGEyQat7BUQwQ-H2ryzky0pWFzkjbKUwFWdgunp8DSg3QWkZvldCeIjhQLDrDaB8oszkeT5r4i7-r2dbJdQVtEmCctzCESnB_Es1nrId0SHbxplqiNI';
  static const String cooldownImageUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuDWKf0dbkqQWw86g9waSjz2zbWD7Rf9AYDdw0HHhay6uPMIyF_JVJ1VCeLgy-AoNCXLfepqQV5guiD1c2xywtVyuGL0W1pTSYCxuvkMY7JEj-F76YhGHP6m5pc_A-ymIwbtp1u3e5HJh-5enUU5ptSFqXOV2RyoaZrIC45KUunsmslWM-x-8G9h6K2qXv_2sqpnX7RALgIrKHVnIbptPmk6Ms6MxYLieNgYNrruUV0';

  // Weekly Rhythm
  static const List<DayRhythm> weeklyRhythm = [
    DayRhythm(day: 'M', isCompleted: true),
    DayRhythm(day: 'T', isCompleted: true),
    DayRhythm(day: 'W', isCompleted: true),
    DayRhythm(day: 'T', isCompleted: true),
    DayRhythm(day: 'F', isCompleted: true),
    DayRhythm(day: 'S', isToday: true),
    DayRhythm(day: 'S', isRest: true),
  ];

  // Daily Telemetry
  static const int currentCalories = 640;
  static const int targetCalories = 850;
  static const double calorieProgress = 640 / 850; // 0.75
  static const double hydrationProgress = 0.72;
  static const String activeMinutes = '48';
  static const String heartBpm = '138';
  static const String stepsCount = '8,420';
  static const int recoveryScore = 92;

  // Initial Exercises for Workout Detail
  static List<ExerciseDetail> getInitialExercises() {
    return [
      ExerciseDetail(
        number: 'Exercise 1',
        name: 'Barbell Incline Bench Press',
        category: 'Chest • Triceps',
        targetSummary: '4 Sets • 8-12 reps',
        icon: Icons.fitness_center_rounded,
        iconColor: const Color(0xFFC3F400),
        sets: [
          WorkoutSet(setNumber: '01', previous: '12 × 67.5 kg', reps: 12, weight: 70.0, isCompleted: true),
          WorkoutSet(setNumber: '02', previous: '10 × 72.5 kg', reps: 10, weight: 75.0, isCompleted: true),
          WorkoutSet(setNumber: '03', previous: '8 × 80 kg', reps: 8, weight: 80.0, isCompleted: false, isActive: true),
          WorkoutSet(setNumber: '04', previous: '8 × 80 kg', reps: 8, weight: 80.0, isCompleted: false, isLocked: true),
        ],
      ),
      const ExerciseDetail(
        number: 'Exercise 2',
        name: 'Dumbbell Incline Chest Fly',
        category: 'Upper Chest',
        targetSummary: '3 Sets • 12 reps × 22 kg target',
        icon: Icons.sports_gymnastics_rounded,
        iconColor: Color(0xFF00E3FD),
        summaryPills: ['Set 1: 12 × 22 kg', 'Set 2: 12 × 22 kg', 'Set 3: 12 × 22 kg'],
      ),
      const ExerciseDetail(
        number: 'Exercise 3',
        name: 'Seated Cable Row',
        category: 'Back • Lats',
        targetSummary: '4 Sets • 10 reps × 65 kg target',
        icon: Icons.rowing_rounded,
        iconColor: Color(0xFF6FFBBE),
        summaryPills: ['Set 1-4: 10 reps × 65 kg', 'PR: 70 kg'],
      ),
      const ExerciseDetail(
        number: 'Exercise 4',
        name: 'Tricep Rope Pushdown',
        category: 'Arms • Isolation',
        targetSummary: '3 Sets • 15 reps × 28 kg target',
        icon: Icons.sports_kabaddi_rounded,
        iconColor: Color(0xFFC3F400),
        summaryPills: ['3 Sets: 15 reps × 28 kg', 'Superset Ready'],
      ),
    ];
  }

  // 7-Day Performance Analytics
  static const List<BarData> weeklyBarData = [
    BarData(day: 'Mon', calories: 420, duration: '40 min', heightRatio: 0.54),
    BarData(day: 'Tue', calories: 560, duration: '50 min', heightRatio: 0.72),
    BarData(day: 'Wed', calories: 620, duration: '55 min', heightRatio: 0.82),
    BarData(day: 'Thu', calories: 780, duration: '65 min', heightRatio: 1.0, isPeak: true),
    BarData(day: 'Fri', calories: 510, duration: '45 min', heightRatio: 0.65),
    BarData(day: 'Sat', calories: 690, duration: '60 min', heightRatio: 0.88),
    BarData(day: 'Sun', calories: 120, duration: '20 min', heightRatio: 0.22, isRest: true),
  ];

  // Personal Records
  static const List<PersonalRecord> personalRecords = [
    PersonalRecord(
      exercise: 'Barbell Deadlift',
      badgeText: '+10 kg PR',
      badgeColor: Color(0xFFC3F400),
      subtitle: 'Broken 2 days ago • Conventional',
      recordValue: '210',
      recordUnit: 'kg',
      recordType: '1RM Best',
      icon: Icons.fitness_center_rounded,
      iconColor: Color(0xFFC3F400),
    ),
    PersonalRecord(
      exercise: 'Barbell Back Squat',
      badgeText: 'New Rep Max',
      badgeColor: Color(0xFF00E3FD),
      subtitle: '5 Reps Max @ High Bar',
      recordValue: '175',
      recordUnit: 'kg',
      recordType: '5 Reps',
      icon: Icons.airline_seat_legroom_extra_rounded,
      iconColor: Color(0xFF00E3FD),
    ),
    PersonalRecord(
      exercise: 'Bench Press',
      badgeText: '',
      subtitle: 'Achieved Oct 12 • Flat Pause',
      recordValue: '125',
      recordUnit: 'kg',
      recordType: '1RM Best',
      icon: Icons.sports_gymnastics_rounded,
      iconColor: Color(0xFF8E9BAE),
    ),
    PersonalRecord(
      exercise: '5K Run Pace',
      badgeText: 'PB Track',
      badgeColor: Color(0xFF6FFBBE),
      subtitle: 'Outdoor Track • 4:20/km',
      recordValue: '21:40',
      recordUnit: 'min',
      recordType: 'Record Pace',
      icon: Icons.directions_run_rounded,
      iconColor: Color(0xFF6FFBBE),
    ),
  ];
}
