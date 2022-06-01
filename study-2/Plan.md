### Drugi scenariusz badawczy:

W drugim scenariuszu badawczym sprawdzony będzie czas uruchamiania do stanu gotowości obiektów Kubernetes.
Wybranych jest kilka obiektów w różnej konfiguracji.

1. W pierwszej konfiguracji zostanie uruchomiony jeden pod z określoną liczbą kontenerów. Kontener powstanie z przygotowanego obrazu. Depinicja obrazu jest zapisana w pliku Dockerfile. Podobnie jak w pierwszym scenariuszu testowym brany będzie pod uwagę wyłącznie czas utworzenia poda wraz z uruchomieniem procesów w kontenerach. Niezbędne obrazy zostały pobrane wcześniej. Pod uznany jest za stworzony kiedy jego wszystkie kontenery znajdujące sie w nim zostają utworzone a procesy w tych kontenerach uruchomione.

W kontenerach zostaje uruchomiony proces powłoki który wypisuje date z godziną a następnie wchodzi w nieskończoną pętle która rurchamia polecenie "sleep". Dzięki temu w logach możemy sprawdzić kiedy proces w kontenerze został uruchomiony.

Instrukcja użyta do utworzenia poda jest zapisana w pliku uruchamiającym test.
W celu obiczenia wyników należy zmierzyć czas wykonywania polecenia oraz czas przejścia poda do stanu "Running". Informacja taka jest zapisywana prze Kubernete w opisie poda.

Komenda do utworzenia poda `kubectl create -f test-1.yaml`.

NOTE: Aby obliczyć czas należy odjęć czas pobrany zaraz przed uruchomieniem poda od czasu w którym pod osiągnął warunek "Ready" o wartości "True".

NOTE: Dowiedziałem się że nie można uruchomić w podzie wielu kontenerów wystawiających ten sam port. Również kontener bez uruchomonego procesu w nim przestaje działać.

2. W drugiej konfiguracji zostanie uruchomiony jeden pod z pięcioma kontenerem. Kontenery powstaną z obrazów nginx:stable. Podobnie jak w pierwszym scenariuszu testowym brany będzie pod uwagę wyłącznie czas utworzenia poda. Obraz został pobrany wcześniej. Pod uznany jest za stworzony kiedy jego kiedy jego warunek [2] "Ready" jest równy "True".
   Instrukcja użyta do utworzenia poda jest zapisana w pliku uruchamiającym test (kubectl create -f test-1.yaml).
   W celu obiczenia wyników należy zmierzyć czas wykonywania polecenia oraz czas przejścia poda ze stanu Initialized.

NOTE: Aby obliczyć czas należy odjęć czas pobrany zaraz przed uruchomieniem poda od czasu w którym pod osiągnął warunek "Ready" o wartości "True".

Bibliografia:

1. https://hub.docker.com/layers/nginx/library/nginx/stable/images/sha256-62accd5c832bf46871dfd604f86db86a8d2e0e9e4a376c4a05469718a56702d4?context=explore
2. https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/
