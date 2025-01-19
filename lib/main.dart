import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:siram_pintar_mobile/cubits/auth/auth_cubit.dart';
import 'package:siram_pintar_mobile/cubits/auth/auth_state.dart';
import 'package:siram_pintar_mobile/cubits/login/login_cubit.dart';
import 'package:siram_pintar_mobile/cubits/register/register_cubit.dart';
import 'package:siram_pintar_mobile/pages/home/home_page.dart';
import 'package:siram_pintar_mobile/pages/login/login_page.dart';
import 'package:siram_pintar_mobile/pages/profile/profile_page.dart';
import 'package:siram_pintar_mobile/repositories/auth_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:siram_pintar_mobile/utils/api_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthCubit(
            apiClient: apiClient,
          ),
        ),
        BlocProvider(
          create: (context) => LoginCubit(
            authRepository: AuthRepository(),
            authCubit: context.read<AuthCubit>(),
          ),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(
            authRepository: AuthRepository(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          if (authState is AuthLoggedIn) {
            return const MyStatefulWidget();
          }
          return const LoginPage();
        },
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _index = 0;

  void _onBottomNavigationTap(int value) {
    setState(() {
      _index = value;
    });
  }

  final pages = [
    const HomeScreen(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onBottomNavigationTap,
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
