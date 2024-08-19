import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import '../../controller/dogs_controller.dart';
import '../../models/dog_model.dart';
import '../../repository/dogs_repository.dart';
import '../../routes/routes.dart';
import '../../settings/service.dart';
import '../../theme/colortheme.dart';

class Dogs extends StatefulWidget {
  const Dogs({super.key});
  static const dogsPageRoute = Routes.dogsPage;

  @override
  State<Dogs> createState() => _DogsState();
}

class _DogsState extends State<Dogs> {
  final dogsController =
      DogsController(repository: DogsRepository(service: DioService()));
  final dogByIdController = DogByIdController(
    repository: DogsRepository(service: DioService()),
  );

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    fetchData();
    super.initState();
    _scrollController.addListener(() {
      var nextPageTrigger = 0.9 * _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels > nextPageTrigger) {
        setState(() {
          dogsController.loadMoreCats();
        });
        // fetchData();
      }
    });
  }

  fetchData() async {
    await dogsController.getDogs();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Area Dogs", style: ThemeColor.fontsTheme.titleLarge),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Hero(
            tag: "dog",
            child: Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              height: 240,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/kathy.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ValueListenableBuilder<List<DogModel>>(
            valueListenable: dogsController,
            builder: (ctx, listDogs, child) {
              if (dogsController.loading) {
                return const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(),
                      )
                    ],
                  ),
                );
              }

              return Container(
                height: 200,
                padding:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                child: dogsController.error
                    ? Text(dogsController.errorMessage)
                        .animate()
                        .fade(delay: 200.ms)
                    : ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listDogs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(10),
                            splashColor: Colors.blue[100],
                            onTap: () async {
                              dogsController.selectDog(listDogs[index]);
                              await dogByIdController
                                  .getDogsByid(listDogs[index].id);
                            },
                            child: Container(
                              width: 300,
                              height: 100,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Card(
                                elevation: 5,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    fit: BoxFit.cover,
                                    listDogs[index].url,
                                  ),
                                ),
                              ).animate().fade(delay: 200.ms),
                            ),
                          );
                        },
                      ),
              );
            },
          ),
          ValueListenableBuilder<DogByIdModel>(
            valueListenable: dogByIdController,
            builder: (ctx, dog, child) {
              if (dogByIdController.loading) {
                return const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      )
                    ],
                  ),
                );
              }

              if (dog.breed == null) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: MediaQuery.of(context).size.height - 540,
                  child: dogsController.select
                      ? Column(
                          children: [
                            Lottie.asset(
                              'assets/dog_not.json',
                              height: 200,
                            ),
                            Expanded(
                              child: Text(
                                'Oh! Não encontramos incormações para este pet.',
                                style: ThemeColor.fontsTheme.headlineMedium,
                                textAlign: TextAlign.center,
                              ).animate().fade(delay: 200.ms),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              child: Lottie.asset(
                                'assets/dog.json',
                                height: 200,
                              ),
                            ).animate().fade(),
                            Expanded(
                              child: Text(
                                'Selecionando um pet, você encontra algumas informações sobre sua raça.',
                                style: ThemeColor.fontsTheme.headlineMedium,
                                textAlign: TextAlign.center,
                              ).animate().fade(delay: 1.5.seconds),
                            ),
                          ],
                        ),
                )
                    .animate()
                    .fade(delay: dogsController.select ? 0.seconds : 1.seconds);
              }

              return SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 540,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: AnimateList(
                        interval: 150.ms,
                        effects: [const FadeEffect()],
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.pets,
                                color: ThemeColor.lightTheme.primary,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(dog.breed?.name ?? "",
                                  style: ThemeColor.fontsTheme.headlineMedium),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.heart_broken,
                                color: ThemeColor.lightTheme.primary,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(dog.breed?.lifeSpan ?? "",
                                  style: ThemeColor.fontsTheme.headlineMedium),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.insert_emoticon_rounded,
                                color: ThemeColor.lightTheme.primary,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(dog.breed?.temperament ?? "",
                                    style:
                                        ThemeColor.fontsTheme.headlineMedium),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                            height: 20,
                          ),
                          if (dog.breed?.breedGroup != null) ...[
                            Row(
                              children: [
                                Icon(
                                  Icons.group,
                                  color: ThemeColor.lightTheme.primary,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(dog.breed?.breedGroup ?? "",
                                      style:
                                          ThemeColor.fontsTheme.headlineMedium),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                              height: 20,
                            ),
                          ],
                          if (dog.breed?.bredFor != null) ...[
                            Row(
                              children: [
                                Icon(
                                  Icons.create,
                                  color: ThemeColor.lightTheme.primary,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(dog.breed?.bredFor ?? "",
                                      style:
                                          ThemeColor.fontsTheme.headlineMedium),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                              height: 20,
                            ),
                          ],
                          if (dog.breed?.origin != null) ...[
                            Row(
                              children: [
                                Icon(
                                  Icons.fmd_good_sharp,
                                  color: ThemeColor.lightTheme.primary,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(dog.breed?.origin ?? "",
                                    style:
                                        ThemeColor.fontsTheme.headlineMedium),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
