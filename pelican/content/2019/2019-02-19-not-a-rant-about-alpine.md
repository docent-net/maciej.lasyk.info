Title: Why I don't use Alpine in containers
Category: tech
Tags: docker, devops, alpine, containers
Author: Maciej Lasyk
Summary: Not a rant, until it is.
Status: Draft

<center>![Alpine Linux]({filename}/images/alpine.jpg)</center>

## What this is about?

A few days after my [systemd talk @Pykonik meetup](https://www.pykonik.org/tech-talks/40/)
I posted an URL for an interesting art describing [multi - stage builds in
Python/Docker containers](https://simonwillison.net/2018/Nov/19/smaller-python-docker-images/0).

In addition I wrote, that I don't really liked the idea of using Alpine Linux
in container image. And here the discussion started - question was "why and
if not Alpine then what?"

## What internets tell us about Alpine?

So before I answer above question I wanted to see what TOP results from my 
DuckDuckGo/Google results tell me about **alpine linux docker**:

1. [The 3 Biggest Wins When Using Alpine as a Base Docker Image](https://nickjanetakis.com/blog/the-3-biggest-wins-when-using-alpine-as-a-base-docker-image)
1. [Meet Alpine Linux, Docker’s Distribution of Choice for Containers](https://thenewstack.io/alpine-linux-heart-docker/)

Briefly:

1. Alpine is fast.
1. Alpine is secure.

Ok, so really?

## Is Alpine fast?





1. security - panuje wszechobecne przekonanie, że to jest bardzo mała dystrybucja i dzięki temu jest bezpieczna (sic!), ponieważ nie zawiera zbyt wiele softu. O ile to może być prawda o tyle cały system paczkowania (apk) jest słaby w designie; tu jest wątek w sprawie apk - dość świeży: https://news.ycombinator.com/item?id=17981452 ; od siebie dodam jeszcze tyle, że utrzymywanie kolejnego formatu paczek to też nienajlepszy pomysł; pomijając fakt kolejnego rozbijania community linuksowego to nie wierzę w to, aby security było na wysokim poziomie gdy proces tworzenia i pbulishowania paczki jest reviewowany przez 2 osoby (https://wiki.alpinelinux.org/wiki/Creating_an_Alpine_package) - w takiej sytuacji wpuszczenie malware jest mega proste; imo cały ten system apk powiela problemy np node'a; i tego nie rozumiem - deb czy rpmki mają bardzo dobry system developmentu, review i dystrybucji; no ale alpine nie używa glibc, więc nie mogli tego użyć najwyraźniej; dalej - chwalą się też tym, że mają sfkorkowany unofficial kernel z grsecurity; no fajnie i super ale utrzymanie swojego kernela tak aby byl secure kosztuje bardzo, bardzo duzo; forka zrobili imo dlatego, bo grsec nie jest już darmowy; imo więc to całe securoty w alpine to jest tylko i wyłącznie marketing, bo mają spore problemy u samych podstaw
2. musl libc vs glibc - podejrzewam, że 80% użytkowników alpine nawet nie wie jak skompilować paczkę z jednym czy drugim i jaka jest różnica w praktyce; problem jest spory, ponieważ używając musl libc nie masz nawet jak puścić strace na syscallach aby sprawdzić co się tam dzieje (chyba, że go sobie skompilujesz); ogólnie operacyjnie to jest wielki dramat - glibc jest standardem nie bez przyczyny; może i posiada o wiele więcej kodu i pewnie problemów z tym związanych, ale posiada tez dużo większe community, które to rozwija - i spore firmy, które w to pakują kasę aby działało jak należy; w praktyce z musl libc sporo binarek po prostu nie zadziała, a część może się wysypać dopiero w corner - case'ach; tu ciekawy wątek w temacie: https://www.reddit.com/r/linuxmasterrace/comments/41q2m9/eli5_what_is_musl_and_glibc/
3. systemd z tym nie pójdzie, bo nie używa glibc - to w sumie tyle; tak więc chcąc mieć systemd jako init w kontenerze (a to na prawdę bardzo dobry pomysł i cri-o w kubernetes w tym kierunku zmierza) nie da rady z alpine

reasumując - oszczędzanie 300mb po to aby mieć minimalny base image w porównaniu do innych (czy to debian czy fedora czy cokolwiek innego, co ma przygotowany dobry obraz podstawowy do kontenerów) kosztem security i zgodności z gnu (bo tak to widzę) nie ma sensu. szczególnie w przypadku gdy mamy warstwowy filesystem (vide overlay2 czy cokolwiek, nawet da rady z devicemapperem wyczarować) i ten koszt ponosimy _raz_; a ceny dysków są teraz małe, transfer też niewiele kosztuje (IN nie OUT), więc jakby to podsumować - ktoś znalazł małą dystrybucję, nie rozumie jak ona działa, ale zajmuje mało miejsca to musi być super. może nawet ktoś ją nazwie eko (no dobra, poleciałem :stuck_out_tongue: ) :wink: (edited) 


po pierwsze i najważniejsze nad alpine pracuje garstka ludzi tworząca kompletnie odrębny ekosystem (garstka w kontraście do całej armii ludzi opierającej się na glibc) i o ile będziemy traktować ten wynalazek jako właśnie hobbystyczny wynalazek, a nie poważne, produkcyjne rozwiązanie to ok ale jeżeli ktoś przychodzi i zaczyna mówić, że alpine jest dzięki temu secure to to jest przykład magicznego myślenia w najczystszej postaci.
jakim cudem ma być bardziej secure? bo nie ma komu przeglądać kodu więc nie znajdują w nim tylu bugów i tylko bazując na tej właśnie małej liczbie mamy tak zakładać? mam nadzieję, ze nie trzeba tłumaczyć jak idiotyczne to założenie. alpine zyskał zainteresowanie tylko z jednego powodu - base image waży 2x MiB, to było szalenie istotne w momencie jak docker eksplodował i nagle wszyscy chcieli go używać, a sieroty nie ogarnęły popularności więc zaczęły się poważne problemy z wydajnością/dostępnością docker huba co zmusiło ludzi do kombinowania jak minimalizować obrazy by ograniczyć interakcję z docker hubem do minimum. wtedy wszedł alpine cały na biało. drugim powodem był dramatyczny stan driverów storageowych w dockerze - aufs był TYLKO w ubuntu, cała reszta musiała kombinować z devicemapperem czy plain driverem. dzisiaj mamy zfs/ovelayfs/btrfs (tego ostatniego bym nie tykał ale to ja)
dzisiaj fetysz małych obrazków ma tyle samo sensu co fetyszyzowanie lolitek w japońskich bajkach. można ale czy to zdrowe i normalne? nie mnie oceniać.
alpine mimo wszystko ma piękną listę fuck-upów włączając ostatni z apk linkowany przez Maćka. tych rozmiarów wpadek w poważnych dystrybucjach nie było już dawno, ostatnie czkawki z paczkami miał ubuntu 14.04 (oby nigdy nie wyszedł) i nie były związane z bezpieczeństwem tylko z zepsutym drzewem dependencji. jeżeli jest jedna rzecz, której przez te 20 lat dystrybucje się nauczyły to jak pakować soft (niekoniecznie jak efektywnie ale jak bezpiecznie) i każda szanująca się dystrybucja ma kilkuwarstwowy proces zatwierdzania bałaganu, który dostarcza. alpine ma nic w porównaniu do tego.
i teraz to co najsmutniejsze czyli fakt, że stał się tak popularny wcale nie zwiększyło zauważalnie liczby oczu, która weryfikuje apline ale za to radykalnie zwiększyło liczbę oczu szukającego dziur w celach wiadomych.
czyli podsumowująć wiara pakuje na serwery hobbystyczny wynalazek na którego rozwojem pracuje kilku ludzi usilnie starających się zachować jakąś kompatybilność by pozostać jakąkolwiek alternatywą dla glibc i przez to goniących ciągle z kodem, którego mało kto analizuje i weryfikuje i który jest pakowany i dystrybuowany na wariata.

jeszcze jedno - to nie jest tak, że jesteście skazani na jakieś kosmicznie wielkie obrazy bazowe, oficjalna fedora ma 267 MiB, w robocie przyciąłem to do 134 MiB bez większej zabawy i to dodając jeszcze zewnętrzną paczkę. obstawiam, że z ubuntu i debianem spokojnie też da się tak zrobić jeżeli zaczynamy from scratch.


