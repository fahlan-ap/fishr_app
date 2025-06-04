import 'package:fishr_app/components/nav.dart';
import 'package:flutter/material.dart';
import 'package:fishr_app/pages/splash_screen.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://tlssmepqfoskgwkvajlp.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRsc3NtZXBxZm9za2d3a3ZhamxwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc4MTYzMTMsImV4cCI6MjA2MzM5MjMxM30.i5RXJ5XA1uDG1M9F5tpy2NwE3iTCpwUeTUxDNFjS4RU',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavButton(),
    );
  }
}