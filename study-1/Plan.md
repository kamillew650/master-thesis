### Pierwszy scenariusz badawczy:

W pierwszym scenariuszu badawczym sprawdzony zostanie czas potrzebny do uruchomienia klastra Kubernetes. Wszystkie niezbędne komponenty oraz paczki są pobrane i przygotowane przed rozpoczęciem badań. Badany będzie wyłącznie czas uruchamiania klastra.

Do odnotowania czasu wykonywania się komendy użyte zostało narządzie time (gnu time [1] lub macosx time).

Warto pochylić się również nad paczkami które poszczególne narzędzia potrzebują do uruchomienia klastra Kubernetes.

Minikube:

- aby wylistować potrzebne obrazy należało użyć komendy "minikube image ls --format table"
  | docker.io/kubernetesui/dashboard | v2.3.1 | 5bb89698273d8 | 217MB |
  | docker.io/kubernetesui/metrics-scraper | v1.0.7 | 5717d272af6d4 | 32.5MB |
  | gcr.io/k8s-minikube/storage-provisioner | v5 | ba04bb24b9575 | 29MB |
  | k8s.gcr.io/kube-proxy | v1.23.3 | d36a89daa1945 | 109MB |
  | k8s.gcr.io/kube-controller-manager | v1.23.3 | 3e63a2140741e | 122MB |
  | k8s.gcr.io/kube-scheduler | v1.23.3 | 4bad79a8953b4 | 53MB |
  | k8s.gcr.io/coredns/coredns | v1.8.6 | edaa71f2aee88 | 46.8MB |
  | k8s.gcr.io/pause | 3.6 | 7d46a07936af9 | 484kB |
  | k8s.gcr.io/kube-apiserver | v1.23.3 | 8e7422f73cf36 | 132MB |
  | k8s.gcr.io/etcd | 3.5.1-0 | 1040f7790951c | 132MB |

Kind:

Bibliografia

1. https://www.gnu.org/software/time/
