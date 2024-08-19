import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:vet_app/controller/cats_controller.dart';
import 'package:vet_app/repository/cats_repository.dart';
import 'package:vet_app/settings/service.dart';
import '../../global_widgets/progress_bar.dart';
import '../../models/cats_model.dart';
import '../../routes/routes.dart';
import '../../theme/colortheme.dart';

class Cats extends StatefulWidget {
  const Cats({super.key});
  static const catsPageRoute = Routes.catsPage;

  @override
  State<Cats> createState() => _CatsState();
}

class _CatsState extends State<Cats> {
  final catsController =
      CatsController(repository: CatsRepository(service: DioService()));
  final catByIdController = CatByIdController(
    repository: CatsRepository(service: DioService()),
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
          catsController.loadMoreCats();
        });
        // fetchData();
      }
    });
  }

  fetchData() async {
    await catsController.getCats();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  showInfos(CatByIdModel cat) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AnimateList(
                  interval: 200.ms,
                  effects: [
                    SlideEffect(begin: const Offset(-1, 0), delay: 500.ms),
                  ],
                  children: [
                    ProgressBar(
                      label: "Adaptability",
                      value: cat.breed?.adaptability,
                    ),
                    ProgressBar(
                      label: "Dog friendly",
                      value: cat.breed?.dogFriendly,
                    ),
                    ProgressBar(
                      label: "Affection level",
                      value: cat.breed?.affectionLevel,
                    ),
                    ProgressBar(
                      label: "Health issues",
                      value: cat.breed?.healthIssues,
                    ),
                    ProgressBar(
                      label: "Child Friendly",
                      value: cat.breed?.childFriendly,
                    ),
                    ProgressBar(
                      label: "Grooming",
                      value: cat.breed?.grooming,
                    ),
                    ProgressBar(
                      label: "Energy level",
                      value: cat.breed?.energyLevel,
                    ),
                    ProgressBar(
                      label: "Social needs",
                      value: cat.breed?.socialNeeds,
                    ),
                    ProgressBar(
                      label: "Stranger fliendly",
                      value: cat.breed?.strangerFriendly,
                    ),
                    ProgressBar(
                      label: "Vocalisation",
                      value: cat.breed?.vocalisation,
                    ),
                    ProgressBar(
                      label: "Natural",
                      value: cat.breed?.natural,
                    ),
                    ProgressBar(
                      label: "Hairless",
                      value: cat.breed?.hairless,
                    ),
                    ProgressBar(
                      label: "Hypoallergenic",
                      value: cat.breed?.hypoallergenic,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Area Gatos", style: ThemeColor.fontsTheme.titleLarge),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Hero(
            tag: "cat",
            child: Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              height: 240,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/ivye.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ValueListenableBuilder<List<CatModel>>(
            valueListenable: catsController,
            builder: (ctx, listCats, child) {
              if (catsController.loading) {
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
                child: catsController.error
                    ? Text(catsController.errorMessage)
                        .animate()
                        .fade(delay: 200.ms)
                    : ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listCats.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(10),
                            splashColor: Colors.blue[100],
                            onTap: () async {
                              catsController.selectCat(listCats[index]);
                              await catByIdController
                                  .getCatsByid(listCats[index].id);
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
                                    listCats[index].url,
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
          ValueListenableBuilder<CatByIdModel>(
            valueListenable: catByIdController,
            builder: (ctx, cat, child) {
              if (catByIdController.loading) {
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

              if (cat.breed == null) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: MediaQuery.of(context).size.height - 540,
                  child: catsController.select
                      ? Column(
                          children: [
                            Lottie.asset(
                              'assets/loadingCat.json',
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
                                'assets/searchCat.json',
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
                    .fade(delay: catsController.select ? 0.seconds : 1.seconds);
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
                              Text(cat.breed?.name ?? "",
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
                              Text(cat.breed?.lifeSpan ?? "",
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
                                child: Text(cat.breed?.temperament ?? "",
                                    style:
                                        ThemeColor.fontsTheme.headlineMedium),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.fmd_good_sharp,
                                color: ThemeColor.lightTheme.primary,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(cat.breed?.origin ?? "",
                                  style: ThemeColor.fontsTheme.headlineMedium),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.description,
                                color: ThemeColor.lightTheme.primary,
                              ),
                              const SizedBox(
                                width: 20,
                                height: 20,
                              ),
                              Expanded(
                                child: Text(cat.breed?.description ?? "",
                                    style:
                                        ThemeColor.fontsTheme.headlineMedium),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.open_in_new,
                                color: ThemeColor.lightTheme.primary,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () =>
                                      catByIdController.openLinkToBrowser(
                                          cat.breed?.wikipediaUrl ?? ""),
                                  child: Text(
                                    cat.breed?.wikipediaUrl ?? "",
                                    style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                            height: 20,
                          ),
                          ElevatedButton(
                            child: Text(
                              "Click here to other infos.",
                              style: ThemeColor.fontsTheme.bodyMedium,
                            ),
                            onPressed: () => showInfos(cat),
                          ),
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
