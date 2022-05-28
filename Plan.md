###Zamysł badań

## Stanowisko badawcze:

Parametry jednostki:

- Dell Latitude E6540
- Intel Core i7-4810MQ
- 16 GB RAM
- dysk SSD
  System:
- Ubuntu 22.04 LTS

## Testowane oprogramowanie:

Platforma Kubernetes konfigurowana oraz uruchamiana przy pomocy takich narzędzi jak (początkowo Minikube i ewentualnie dalej reszta narzędzi jeśli będzie szansa na ciekawe wyniki):

- minikube [GitHub - kubernetes/minikube: Run Kubernetes locally](https://github.com/kubernetes/minikube)
- kubeadm [Bootstrapping clusters with kubeadm | Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/)
- k3s [GitHub - k3s-io/k3s: Lightweight Kubernetes](https://github.com/k3s-io/k3s)
- kind [GitHub - kubernetes-sigs/kind: Kubernetes IN Docker - local clusters for testing Kubernetes](https://github.com/kubernetes-sigs/kind)
- microk8s [GitHub - canonical/microk8s: MicroK8s is a small, fast, single-package Kubernetes for developers, IoT and edge.](https://github.com/canonical/microk8s)

## Scenariusze badawcze:

1. Uruchomienie klastra za pomocą danego narzędzia. Badany będzie czas potrzebny na uruchomienie.
2. Uruchomienie różnych testowych architektur (składających się z obiektów Kubernetes działających w ramach klastra). Badany będzie czas potrzebny na uruchomienie danych architektur. Czas ten będzie mierzony dla różnych ilości podów oraz innych obiektów.
3. Aktualizacja wersji aplikacji (wersji obrazu Docker'owego) dla pewnej ilości podów w zależności od ilości kontenerów w jednym podzie. Badany będzie czas aktualizacji.
4. Aktualizacja wersji aplikacji (wersji obrazu Docker'owego) dla pewnej ilości podów w zależności od mechanizmu. Aby zaktualizować wersje można użyć wbudowanego mechanizmu platformy Kubernetes jakim jest obiekt Deployment. Innym sposobem może być użycie skryptu powłoki który wykona taką aktualizacje. Badany będzie w tym przypadku czas trwania takiej aktualizacji oraz kwestie zarządzania taką aktualizacją za pomocą obu sposobów.
5. Przesył danych (w tym przypadku pliku o odpowiedniej wielkości) między aplikacjami kontenerowymi. W badaniu zmieniana będzie konfiguracja połączeń miedzy aplikacjami (możliwe jest połączenie serwisem lub load balancerem, porównane będą różne protokoły sieciowe http i tcp). Badany będzie czas przesyłu pliku dal poszczególnych aplikacji.
6. Skalowanie ilości podów w odpowiedzi na ilość zapytań. Badanie będzie polegało na mierzeniu czasu skalowania aplikacji w zależności od ilości zapytań oraz konfiguracji.
7. Badanie konfiguracji sieciowych (narazie zamysł)
8. Badanie wpływu protokołu komunikacyjnego dla komunikacji obiektów Kubernetes
