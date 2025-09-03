import 'package:choach_debate/features/Debate/presentation/bloc/debate_bloc.dart';
import 'package:choach_debate/features/Topics/presentation/bloc/topics_bloc.dart';
import 'package:choach_debate/features/Topics/presentation/pages/topic_page.dart';
import 'package:choach_debate/injection.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  String supabaseURL = dotenv.env["SUPABASE_URL"] ?? "";
  String supabaseKEY = dotenv.env["SUPABASE_KEY"] ?? "";
  await Supabase.initialize(url: supabaseURL, anonKey: supabaseKEY);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<DebateBloc>()),
        BlocProvider(
          create: (context) => di.sl<TopicsBloc>()..add(GetTopicsEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Debat LLM',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TopicPage(),
      ),
    );
  }
}
