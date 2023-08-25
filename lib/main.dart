import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const BasketballLiveScoreApp());
}

class BasketballLiveScoreApp extends StatelessWidget {
  const BasketballLiveScoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Score App'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('basketball')
              .doc('1_ban_vs_ind')
              .snapshots(),
          builder:
              (context, AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
            print(snapshot.data?.data());
                final score = snapshot.data!;
                return Center(
                  child: Column(
                    children: [
                      Text(
                        score.get('match_name'),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                score.get('score_team_a').toString(),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                score.get('team_a'),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          const Text('VS'),
                          Column(
                            children: [
                              Text(
                                score.get('score_team_b').toString(),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                score.get('team_b'),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          FirebaseFirestore.instance
              .collection('basketball')
              .doc('1_ban_vs_ind')
              .update({'match_name':"Bangladesh vs India"});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
