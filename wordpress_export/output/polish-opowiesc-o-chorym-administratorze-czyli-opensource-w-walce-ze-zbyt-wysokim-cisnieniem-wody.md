Title: (Polish) Opowieść o chorym administratorze, czyli OpenSource w walce ze zbyt wysokim ciśnieniem wody
Date: 2013-01-20 20:21
Author: docent
Category: operations
Tags: fedora, gnuplot, imagemagick, mae, monitoring, motion, opensource
Slug: polish-opowiesc-o-chorym-administratorze-czyli-opensource-w-walce-ze-zbyt-wysokim-cisnieniem-wody
Status: published

<!--:en-->  

Sorry guys - this post is only in polish. If You feel like reading this in english - post me a comment and I'll do my best :)
-----------------------------------------------------------------------------------------------------------------------------

Wstępniak
---------

Od ponad 3 miesięcy żyliśmy w remoncie. Większość tego czasu również
towarzyszyły nam jakieś choroby (czego tam mały z przedszkola nie
przyniósł). No i nadszedł **ten** weekend - koniec remontu!

Dodam, że ja od samego początku trzymałem się nieźle - w zasadzie w
ogóle nie chorowałem. Owszem - byłem już cholernie zmęczony kurzem,
syfem, pyłem, łomotem, przenoszeniem mebli itd - ale żyłem tym dniem,
gdy to wszystko się skończy.

Ta sobota zaczęła się inaczej. W zasadzie nie mogłem wstać z łóżka.
Czułem się jakby mnie walec rozjechał. Nie byłem tak chory od kilku albo
i kilkunastu lat. Yeahhhh.... Samej soboty nie pamiętam wiele - podobnie
noc z soboty na niedzielę nie wyglądała najlepiej. I nadeszła niedziela.
Temperatura nadal, ale walec ze mnie zjechał. Nie chciało mi się
cholernie wstawać z łóżka, ale nieszczęśliwie - coś nie teges z
internetem. A, że "serwerownia" znajduje się w piwnicy - musiałem się
tam wybrać. Nie, żebym był szczęśliwy, ale wiecie - są pewne priorytety,
a internet jest na początku tej listy.

Coś się dzieje...
-----------------

Podejrzewałem, że klasycznie powiesił się router Neostrady - mimo, że
dopiero co wymieniany (bo stary wieszał się ciągle). Jako, że nie mogłem
się dobić do jego interfejsu tak też musiałem tam iść i załatwić to
osobiście (ale już niedługo - namierzyłem tanie listwy zasilające IP -
zobaczymy co wtedy powie).

Gdy już moja szanowne cztery litery zeszły do Mordoru, pierwsze co
usłyszałem to "kap,kap,kap". Cóż - "\*urwa, \*urwa, \*urwa" pomyślałem.
W trakcie remontu wymieniliśmy (co nie było w planie) wszystkie
kaloryfery i sporo hydrauliki. Raz już się to zdarzyło po tej wymianie -
a teraz znowu:

[![](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/woda-225x300.jpg "Karramba"){.aligncenter
.size-medium .wp-image-209 width="225"
height="300"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/woda.jpg)Na
zdjęciu powyżej tego nie widać, ale piec ma miernik ciśnienia wody -
akurat wskazywał max pozycję (pow. 4 atmosfer) - pewnie było więcej, bo
po prostu się skala skończyła. Woda zaczęła kapać, bo po prostu
uszczelka puściła. Szczęście, że uszczelka, a nie jakaś złączka gdzieś w
ścianie. Notabene gdy się to wcześniej stało to pod piecem nie było
wiadra a sanki małego - plastikowe. Zebrały sporo wody wtedy ;)

Simple visual monitoring
------------------------

Konstrukcja niestety nie pozwala tutaj spuścić wody z obiegu - trzeba to
zrobić gdzieś indziej (na górze - w mieszkaniu - bezpośrednio z jednego
z kaloryferów). A to jest problem, bo nie można spuścić jej zbyt wiele -
bo wtedy się zapowietrzą kaloryfery, trzeba dolewać od nowa itd. Nie
myśląc zbyt wiele pobiegłem po netbooka ([Toshiba
NB500](http://www.getech.co.uk/pdf/NB500-12X.pdf))  i ustawiłem go na
starym foteliku małego - na przeciw pieca:

[![](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/netbook1-300x225.jpg "Simple monitoring"){.aligncenter
.size-medium .wp-image-212 width="300"
height="225"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/netbook1.jpg)

Ten netbook ma kamerkę, więc w tej chwili mógłbym po prostu połączyć się
z nim via Skype. Ale to mało koszerne, bo Skype ma swoje widzimisie i
zdarzało mi się, że traciłem z nim połączenie. Stąd też pomysł, aby
postawić serwer kamery internetowej - na netbooku mam Fedorę 17,
więc: **yum install motion**

I sprawa załatwiona (no prawie - nie było internetu, więc reset routera,
potem jeszcze Wireshark w ruch bo to pudło się kompletnie zresetowało i
po kilku chwilach już było ok). Teraz jeszcze tylko go uruchomić
(**service motion start**), wyszukać netstatem, na którym porcie
nasłuchuje i przepuścić go przez iptables (**8081**) i obraz gotowy.
Rozłożyłem więc zestaw do spuszczania wody na górze, odpaliłem laptopa,
połączyłem się z kamerką i rozpocząłem procedurę awaryjną ;)

[![](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/gora-300x225.jpg "Procedura awaryjnego spuszczania wody ;)"){.aligncenter
.size-medium .wp-image-213 width="300"
height="225"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/gora.jpg)No
dobra. W ten sposób spuściłem trochę wody do wiadra i ciśnienie wróciło
z powrotem do normy. Poprawiłem siłę dokręcenia kurka wody w piecu i
trzymałem kciuki. Niestety po godzinie sprawa znów się pogorszyła -
zarówno ciśnienie wody skoczyło do góry jak i moja temperatura.

Co tam - nie takie sytuacje się załatwiało - padały replikacje baz
danych, równocześnie poole memcache'a, odpieraliśmy ataki DDos, dyski
przestawały działać, ginęły backupy, wybuchały (!!!) serwerownie - i
niby ciśnienie wody w piecu ma mnie pokonać? :D

DEFCON 1 - Black Ops response
-----------------------------

Problem - rozpoznanie:

-   ciśnienie wody w obiegu szwankuje, gdy osiąga granicę 3-4 atmosfer
    uszczelka zaczyna puszczać wodę. Cholera wie przy jakim ciśnienie
    woda rozsadzi coś innego niż uszczelkę w piecu
-   jest niedziela - zapomnij o hydrauliku czy serwisie pieca
-   zapomnij o jakichkolwiek zakupach - jesteś chory, więc radź sobie z
    tym co masz w domu

Możliwości:

-   zakręcić dopływ wody do pieca - jednak to odetnie nas w domu od
    ciepłej wody w kranie. niekoszerne...
-   mając już zorganizowane stanowisko spuszczania wody można tą akcję
    powtórzyć kilka razy i sprawdzić czy może lekkie dokręcenie głównego
    zaworu w dopływie wody nie rozwiąże go - może mniejsze ciśnienie
    wejściowe da nam trochę czasu?

<div>

<span style="line-height: 18px;">Decyzja prosta i krótka - potrzebny nam
real-time monitoring, który sam nas będzie ostrzegał w sytuacji
przekroczenia określonego ciśnienia (2 atmosfery) - wtedy spuszczamy
wodę, delikatnie dokręcamy główny zawór wody i ponawiamy akcję.</span>

</div>

<div>

Piec niestety jest stary - nie ma żadnej możliwości podłączenia via
jakikolwiek interfejs do serwera tak aby pobierać z niego dane na temat
parametrów środowiskowych. Dlatego też pozostaje nam monitoring z
zewnątrz. Mamy obraz - wystarczy więc zrealizować rozpoznawanie pozycji
strzałki pokazującej ciśnienie i tyle.

</div>

Automatyzujemy proces monitoringu
---------------------------------

Niestety nie znalazłem nigdzie na CPANie czy php.necie biblioteki
"jpg2pressure", więc z palca nie udało mi się rozwiązać problemu.
Rozpocząłem więc research. Po kilku minutach doszedłem do wniosku, że
rozpoznawanie pozycji strzałki nie jest dobrą drogą, bo można by z tego
napisać doktorat. Dużo łatwiej jest porównywać obrazy. Do tego można
spokojnie skorzystać z biblioteki **ImageMagick**. Znalazłem tam funkcję
porównywania - pozostaje się w niej
zdoktoryzować: <http://www.imagemagick.org/Usage/compare/>

Checklista:

1.  Kamera internetowa musi być ustawiona stabilnie. Fotelik małego nie
    działa dobrze, znaleźć inne rozwiązanie
2.  Kamera internetowa generuje 2 obrazy na sekundę a do tego obciąża
    netbooka bardzo mocno (LAVG w okolicach 1, czyli max). Wystarczy nam
    jedno zdjęcie co minutę.
3.  Potrzebuję trzech zdjęć - dla poziomu "alert" (2 atmosfery, dla
    poziomu "warning" (1,5 atmosfery) oraz dla poziomu "OK" (lekko
    poniżej 1 atmosfery).
4.  Potrzebny jest automat, który będzie przycinał zdjęcia tak aby było
    widać tylko aktywne pole, po którym wędruje strzałka. Dzięki temu
    porównanie będzie dużo łatwiejsze.
5.  Potrzebny jest patent do porównywania tych obrazów (to już raczej
    załatwione - ImageMagick oraz **compare**)
6.  Na koniec wpinamy to w domowego Nagiosa i SMSy :)

<div>

No to do roboty:

</div>

### **ad1. Kamera internetowa musi być ustawiona stabilnie. Fotelik małego nie działa dobrze, znaleźć inne rozwiązanie.**

<div>

To była krótka piłka. Postawiłem netbooka na szafce na buty i
przybliżyłem jeszcze do pieca. Stał już bardzo stabilnie.

</div>

### **ad2. Kamera internetowa generuje 2 obrazy na sekundę a do tego obciąża netbooka bardzo mocno (LAVG w okolicach 1, czyli max). Wystarczy nam jedno zdjęcie co minutę.**

<div>

Musiałem ogólnie zmienić kilka parametrów kamery
(**/etc/motion/motion.conf**):

</div>

> <div>
>
> <div>
>
> width 640
>
> </div>
>
> <div>
>
> height 480
>
> </div>
>
> <div>
>
> framerate 2
>
> </div>
>
> </div>
>
> <div>
>
> minimum\_frame\_time 60
>
> </div>
>
> <div>
>
> quality 100
>
> </div>
>
> <div>
>
> picture\_type jpeg
>
> </div>

<div>

Po powyższych zmianach i przeładowaniu serwera motion obciążenie
netbooka spadło znacznie :)

</div>

### 

### **ad3. Potrzebuję trzech zdjęć - dla poziomu "alert" (2 atmosfery, dla poziomu "warning" (1,5 atmosfery) oraz dla poziomu "OK" (lekko poniżej 1 atmosfery).**

<div>

Miałem kilka zdjęć jeszcze z operacji spuszczania wody z obiegu, więc
wziąłem kilka przydatnych.

</div>

### 

### **ad4. Potrzebny jest automat, który będzie przycinał zdjęcia tak aby było widać tylko aktywne pole, po którym wędruje strzałka. Dzięki temu porównanie będzie dużo łatwiejsze.**

<div>

Oczywiście można by się bawić w pisanie kodu, który wczytuje obraz i go
tnie, ale to takie... programistyczne. A ja jestem chory i nie chce mi
się dziś programować, a poza tym po co nam aż taka armata. Tutaj
wystarczy **convert** - który jest składnikiem biblioteki
**ImageMagick**, więc **yum install ImageMagick** i następnie:

</div>

> <div>
>
> /usr/bin/convert -crop 110x50+60+250 alert.jpg alert.jpg
>
> </div>

<div>

No i mamy ślicznie przycięty obrazek. Oczywiście rozmiar oraz pozycję
przycięcia wyznaczyłem organoleptycznie ;)

</div>

<div>

[![](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/probe.jpg "probe"){.aligncenter
.size-full .wp-image-216 width="110"
height="50"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/probe.jpg)

</div>

### 

### **ad5. Potrzebny jest patent do porównywania tych obrazów**

<div>

I tu się zrobiło ciekawie. Lektura do
poczytania: <http://www.imagemagick.org/Usage/compare/> - czytając na
szybko doszedłem do wniosku, że albo próbuję metodą porównywania
statystyk obrazu (**Comparison Statistics**) albo armatą,
czyli **Matching Sub-Images and Shapes (**HitAndMiss Morphology, Peak
Finding and extracting, Using a Laplacian Convolution Kernel - itd...).

</div>

<div>

Co mogłem powiedzieć - z Laplasjanami bawiłem się jakieś 10 lat temu gdy
studiowałem fizykę, więc stwierdziłem, że najpierw dam szansę metodom
statystycznym - to w końcu najprostsze rozwiązanie :)

</div>

<div>

Streszczając metodę statystyczną - podajemy 2 obrazy na wejściu,
wybieramy jeden z algorytmów porównania i na wyjściu otrzymujemy pewną
liczbę - a jej znaczenie zależy od algorytmu. Po lekturze dokumentacji
wybrałem na początek metrykę  **Average Error (over all pixels) - MAE
(Mean absolute error, average channel error distance)**. Żeby sprawdzić
jej wyniki wziąłem jeden przycięty obraz (**probe.jpg**), który to
pokazywał przypadkową pozycję strzałĸi. Następnie w pętli zrobiłem
porównanie tego obrazu za pomocą metryki MAE do kilku dziesięciu
obrazów, które zebrałem w trakcie spuszczania wody z obiegu (czyli
wędrówki strzałki od 4 atmosfer aż do pozycji poniżej 1 atmosfery, czyli
określonej przeze mnie jako OK):

</div>

> <div>
>
> for i in \`ls imgs/\*jpg\`; do /usr/bin/compare -metric mae probe.jpg
> \$i null: 2&gt;&gt;data\_out.csv; done
>
> </div>

<div>

Na koniec jeszcze musiałem przyciąć plik CSV tak aby zawierał tylko
liczby całkowite i żadnych stringów:

</div>

> <div>
>
> cut -d . -f 1 data\_out.csv &gt; data\_out2.csv
>
> </div>

<div>

No i mogłem zobaczyć na wykresie czy cokolwiek tutaj ma sens:

</div>

<div>

[![](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/wykres1-300x122.png "Bingo!"){.aligncenter
.size-medium .wp-image-214 width="300"
height="122"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/wykres1.png)Bingo!
Wyraźnie widać miejsce, w którym wartość spada do minimum, a nawet do
zera. To jest miejsce, w którym osiągamy maksimum podobieństwa obrazów,
czyli minimalna wartość porównania wg. metryki MAE. Sweet :) Dodam, że
to co po lewej to były jakieś odrzuty danych, więc nie brałem ich pod
uwagę (to były obrazy, które były zrobione jeszcze w innej pozycji
kamery, przed zastąpieniem fotelika szafką na buty).

</div>

<div>

W tej chwili musiałem jeszcze określić granicę alertów dla konkretnych
liczb. Wyszło mi na to, że skala podobieństwa poniżej 1800 oznacza, że
obrazy są podobne na tyle, iż mogę stwierdzić, że strzałka ciśnienia
jest w podanym miejscu. Dokonałem jeszcze kilku sprawdzeń i
zwykresowałem wyniki na kilkunastu wykresach generowanych automatycznie
gnuplotem:

</div>

<div>

[![](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/plot2_mae-300x225.png "plot2_mae"){.aligncenter
.size-medium .wp-image-215 width="300"
height="225"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/plot2_mae.png)Teraz
pozostało to tylko ubrać w jakiś skrypt i całość gotowa:

</div>

<div>

    #!/bin/bash

    BASEDIR=/root/pressure_monitoring
    rm -rf $BASEDIR/data_*csv $BASEDIR/imgs/*

    # let's move images from camera dir to our tmp dir:
    mv /var/motion/*jpg $BASEDIR/imgs/

    # we are interested only in checking 1 file - when this script is executed every N seconds (where N == frequency of image-generation by camera) then this is not a problem. Finally I'm running this script in crontab every 60 seconds, but this is not an issue as there's no way the pressure could rise so quick to warning or alarm level (and if so - then I'm really fucked...
    PROBE=`ls $BASEDIR/imgs | tail -1`
    WGET=/usr/bin/wget

    mv $BASEDIR/imgs/$PROBE $BASEDIR/probe.jpg

    # converting to proper size:
    /usr/bin/convert -crop 110x50+60+250 $BASEDIR/probe.jpg $BASEDIR/probe.jpg

    # let's compare probe.jpg to level templates:
    for i in $BASEDIR/alert.jpg $BASEDIR/warning.jpg $BASEDIR/ok.jpg; do /usr/bin/compare -metric mae $BASEDIR/probe.jpg $i null: 2>>$BASEDIR/data_out.csv; done
    cut -d . -f 1 $BASEDIR/data_out.csv > $BASEDIR/data_out2.csv
    cut -d ' ' -f 1 $BASEDIR/data_out2.csv > $BASEDIR/data_out.csv

    ALERT_LEV=`head -1 $BASEDIR/data_out.csv`
    WARNING_LEV=`head -2 $BASEDIR/data_out.csv | tail -1`
    OK_LEV=`tail -1 $BASEDIR/data_out.csv`

    if [ "$ALERT_LEV" -le "1800" -a "$ALERT_LEV" -le "$OK_LEV" ]; then
        MSG="PRESSURE is about 2ba! Comparison level: $ALERT_LEV ($WARNING_LEV/$OK_LEV)"
        echo $MSG | mail -s "PRESSURE ALERT" docent.net@gmail.com
        echo `date +"%Y-%m-%d %H:%M:%S"` $MSG >> /var/log/pressure.log
        MSG_SMS=$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$MSG")
        $WGET "https://somewhere_in_the_space.pl?message=$MSG_SMS" -O /dev/null
        cp $BASEDIR/probe.jpg "$BASEDIR/alert_imgs/`date +\"%Y-%m-%d %H-%M-%S\"`.jpg"
    elif [ "$WARNING_LEV" -le "1800" -a "$WARNING_LEV" -le "$OK_LEV" ]; then
        MSG="PRESSURE is about 1.5ba! Comparison level: $WARNING_LEV ($ALERT_LEV/$OK_LEV)"
        echo `date +"%Y-%m-%d %H:%M:%S"` $MSG >> /var/log/pressure.log
        cp $BASEDIR/probe.jpg "$BASEDIR/alert_imgs/`date +\"%Y-%m-%d %H-%M-%S\"`.jpg"
    #        echo "$MSG" | mail -s "PRESSURE WARNING" docent.net@gmail.com
    #   MSG_SMS=$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$MSG")
    #        $WGET "https://somewhere_in_the_space.pl?message=$MSG_SMS" -O /dev/null
    elif [ "$OK_LEV" -le "1800" ]; then
            MSG="PRESSURE is ok :) Comparison levels (ALERT/WARNING/OK): $ALERT_LEV/$WARNING_LEV/$OK_LEV"
            echo `date +"%Y-%m-%d %H:%M:%S"` $MSG >> /var/log/pressure.log
    #       echo "$MSG" | mail -s "PRESSURE info" docent.net@gmail.com
    #       MSG_SMS=$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$MSG")
    #        $WGET "https://somewhere_in_the_space.pl?message=$MSG_SMS" -O /dev/null
    fi

    if [ "$ALERT_LEV" -ge "1800" -a "$WARNING_LEV" -ge "1800" -a "$OK_LEV" -ge "1800" ]; then
        MSG="PRESSURE level is UNKNOWN! Comparison levels (ALERT/WARNING/OK): $ALERT_LEV/$WARNING_LEV/$OK_LEV" 
        echo `date +"%Y-%m-%d %H:%M:%S"` $MSG >> /var/log/pressure.log
        cp $BASEDIR/probe.jpg "$BASEDIR/alert_imgs/`date +\"%Y-%m-%d %H-%M-%S\"`.jpg"
    #   echo "$MSG" | mail -s "PRESSURE UNKNOWN" docent.net@gmail.com
    #   MSG_SMS=$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$MSG")
    #       $WGET "https://somewhere_in_the_space.pl?message=$MSG_SMS" -O /dev/null
    fi

</div>

<div>

W dużym skrócie - skrypt działa w ten sposób, że pobiera obrazy z
kamery, wybiera ostatni z nich i na nim dokonuje porównania. A potem na
podstawie wyniku decyduje czy wysyłać alert czy nie.

</div>

### 

### **ad5. Na koniec wpinamy to w domowego Nagiosa i SMSy :)**

<div>

Tutaj nie ma już co opisywać :) Tak - mam domowego Nagiosa - to chyba
normalne, nie? :)

</div>

Kończ waść...
-------------

Tak jak teraz na to patrzę z perspektywy czasu... chyba na prawdę byłem
chory :) Ale co by tu nie mówić - to zadziałało :) Dostałem 3 SMSy z
alertami, za każdym razem spuszczałem delikatnie wodę i dokręcałem
główny zawór delikatnie aż sytuacja się unormowała. Nikogo nie wzywałem
już - w wakacje i tak piec wymieniam, więc zabawa się zacznie od
początku.

Teraz już patent zlikwidowałem, jednak do serwera, który siedzi w
piwnicy mam zamiar podpiąć kamerkę USB - tak na wszelki wypadek :) A
nowy piec mam nadzieję, że będzie miał już jakiś ludzki interfejs tak,
aby to monitorować po ludzku a nie metodą chałupniczą.

Co mogę powiedzieć na koniec - OpenSource rządzi :)

Aaaa.. macie na koniec zdjęcie głównego zaworu wody:

[![](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/zawor.jpg-300x225.jpg "zawor.jpg"){.aligncenter
.size-medium .wp-image-217 width="300"
height="225"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/zawor.jpg.jpg)<!--:--><!--:pl-->  

Wstępniak
---------

Od ponad 3 miesięcy żyliśmy w remoncie. Większość tego czasu również
towarzyszyły nam jakieś choroby (czego tam mały z przedszkola nie
przyniósł). No i nadszedł **ten** weekend - koniec remontu!

Dodam, że ja od samego początku trzymałem się nieźle - w zasadzie w
ogóle nie chorowałem. Owszem - byłem już cholernie zmęczony kurzem,
syfem, pyłem, łomotem, przenoszeniem mebli itd - ale żyłem tym dniem,
gdy to wszystko się skończy.

Ta sobota zaczęła się inaczej. W zasadzie nie mogłem wstać z łóżka.
Czułem się jakby mnie walec rozjechał. Nie byłem tak chory od kilku albo
i kilkunastu lat. Yeahhhh.... Samej soboty nie pamiętam wiele - podobnie
noc z soboty na niedzielę nie wyglądała najlepiej. I nadeszła niedziela.
Temperatura nadal, ale walec ze mnie zjechał. Nie chciało mi się
cholernie wstawać z łóżka, ale nieszczęśliwie - coś nie teges z
internetem. A, że "serwerownia" znajduje się w piwnicy - musiałem się
tam wybrać. Nie, żebym był szczęśliwy, ale wiecie - są pewne priorytety,
a internet jest na początku tej listy.

Coś się dzieje...
-----------------

Podejrzewałem, że klasycznie powiesił się router Neostrady - mimo, że
dopiero co wymieniany (bo stary wieszał się ciągle). Jako, że nie mogłem
się dobić do jego interfejsu tak też musiałem tam iść i załatwić to
osobiście (ale już niedługo - namierzyłem tanie listwy zasilające IP -
zobaczymy co wtedy powie).

Gdy już moja szanowne cztery litery zeszły do Mordoru, pierwsze co
usłyszałem to "kap,kap,kap". Cóż - "\*urwa, \*urwa, \*urwa" pomyślałem.
W trakcie remontu wymieniliśmy (co nie było w planie) wszystkie
kaloryfery i sporo hydrauliki. Raz już się to zdarzyło po tej wymianie -
a teraz znowu:

[![](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/woda-225x300.jpg "Karramba"){width="225"
height="300"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/woda.jpg)Na
zdjęciu powyżej tego nie widać, ale piec ma miernik ciśnienia wody -
akurat wskazywał max pozycję (pow. 4 atmosfer) - pewnie było więcej, bo
po prostu się skala skończyła. Woda zaczęła kapać, bo po prostu
uszczelka puściła. Szczęście, że uszczelka, a nie jakaś złączka gdzieś w
ścianie. Notabene gdy się to wcześniej stało to pod piecem nie było
wiadra a sanki małego - plastikowe. Zebrały sporo wody wtedy ;)

Simple visual monitoring
------------------------

Konstrukcja niestety nie pozwala tutaj spuścić wody z obiegu - trzeba to
zrobić gdzieś indziej (na górze - w mieszkaniu - bezpośrednio z jednego
z kaloryferów). A to jest problem, bo nie można spuścić jej zbyt wiele -
bo wtedy się zapowietrzą kaloryfery, trzeba dolewać od nowa itd. Nie
myśląc zbyt wiele pobiegłem po netbooka ([Toshiba
NB500](http://www.getech.co.uk/pdf/NB500-12X.pdf))  i ustawiłem go na
starym foteliku małego - na przeciw pieca:

[![](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/netbook1-300x225.jpg "Simple monitoring"){width="300"
height="225"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/netbook1.jpg)

Ten netbook ma kamerkę, więc w tej chwili mógłbym po prostu połączyć się
z nim via Skype. Ale to mało koszerne, bo Skype ma swoje widzimisie i
zdarzało mi się, że traciłem z nim połączenie. Stąd też pomysł, aby
postawić serwer kamery internetowej - na netbooku mam Fedorę 17,
więc: **yum install motion**

I sprawa załatwiona (no prawie - nie było internetu, więc reset routera,
potem jeszcze Wireshark w ruch bo to pudło się kompletnie zresetowało i
po kilku chwilach już było ok). Teraz jeszcze tylko go uruchomić
(**service motion start**), wyszukać netstatem, na którym porcie
nasłuchuje i przepuścić go przez iptables (**8081**) i obraz gotowy.
Rozłożyłem więc zestaw do spuszczania wody na górze, odpaliłem laptopa,
połączyłem się z kamerką i rozpocząłem procedurę awaryjną ;)

[![](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/gora-300x225.jpg "Procedura awaryjnego spuszczania wody ;)"){width="300"
height="225"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/gora.jpg)No
dobra. W ten sposób spuściłem trochę wody do wiadra i ciśnienie wróciło
z powrotem do normy. Poprawiłem siłę dokręcenia kurka wody w piecu i
trzymałem kciuki. Niestety po godzinie sprawa znów się pogorszyła -
zarówno ciśnienie wody skoczyło do góry jak i moja temperatura.

Co tam - nie takie sytuacje się załatwiało - padały replikacje baz
danych, równocześnie poole memcache'a, odpieraliśmy ataki DDos, dyski
przestawały działać, ginęły backupy, wybuchały (!!!) serwerownie - i
niby ciśnienie wody w piecu ma mnie pokonać? :D

DEFCON 1 - Black Ops response
-----------------------------

Problem - rozpoznanie:

-   ciśnienie wody w obiegu szwankuje, gdy osiąga granicę 3-4 atmosfer
    uszczelka zaczyna puszczać wodę. Cholera wie przy jakim ciśnienie
    woda rozsadzi coś innego niż uszczelkę w piecu
-   jest niedziela - zapomnij o hydrauliku czy serwisie pieca
-   zapomnij o jakichkolwiek zakupach - jesteś chory, więc radź sobie z
    tym co masz w domu

Możliwości:

-   zakręcić dopływ wody do pieca - jednak to odetnie nas w domu od
    ciepłej wody w kranie. niekoszerne...
-   mając już zorganizowane stanowisko spuszczania wody można tą akcję
    powtórzyć kilka razy i sprawdzić czy może lekkie dokręcenie głównego
    zaworu w dopływie wody nie rozwiąże go - może mniejsze ciśnienie
    wejściowe da nam trochę czasu?

<div>

Decyzja prosta i krótka - potrzebny nam real-time monitoring, który sam
nas będzie ostrzegał w sytuacji przekroczenia określonego ciśnienia (2
atmosfery) - wtedy spuszczamy wodę, delikatnie dokręcamy główny zawór
wody i ponawiamy akcję.

</div>

<div>

Piec niestety jest stary - nie ma żadnej możliwości podłączenia via
jakikolwiek interfejs do serwera tak aby pobierać z niego dane na temat
parametrów środowiskowych. Dlatego też pozostaje nam monitoring z
zewnątrz. Mamy obraz - wystarczy więc zrealizować rozpoznawanie pozycji
strzałki pokazującej ciśnienie i tyle.

</div>

Automatyzujemy proces monitoringu
---------------------------------

Niestety nie znalazłem nigdzie na CPANie czy php.necie biblioteki
"jpg2pressure", więc z palca nie udało mi się rozwiązać problemu.
Rozpocząłem więc research. Po kilku minutach doszedłem do wniosku, że
rozpoznawanie pozycji strzałki nie jest dobrą drogą, bo można by z tego
napisać doktorat. Dużo łatwiej jest porównywać obrazy. Do tego można
spokojnie skorzystać z biblioteki **ImageMagick**. Znalazłem tam funkcję
porównywania - pozostaje się w niej
zdoktoryzować: <http://www.imagemagick.org/Usage/compare/>

Checklista:

1.  Kamera internetowa musi być ustawiona stabilnie. Fotelik małego nie
    działa dobrze, znaleźć inne rozwiązanie
2.  Kamera internetowa generuje 2 obrazy na sekundę a do tego obciąża
    netbooka bardzo mocno (LAVG w okolicach 1, czyli max). Wystarczy nam
    jedno zdjęcie co minutę.
3.  Potrzebuję trzech zdjęć - dla poziomu "alert" (2 atmosfery, dla
    poziomu "warning" (1,5 atmosfery) oraz dla poziomu "OK" (lekko
    poniżej 1 atmosfery).
4.  Potrzebny jest automat, który będzie przycinał zdjęcia tak aby było
    widać tylko aktywne pole, po którym wędruje strzałka. Dzięki temu
    porównanie będzie dużo łatwiejsze.
5.  Potrzebny jest patent do porównywania tych obrazów (to już raczej
    załatwione - ImageMagick oraz **compare**)
6.  Na koniec wpinamy to w domowego Nagiosa i SMSy :)

<div>

No to do roboty:

</div>

### **ad1. Kamera internetowa musi być ustawiona stabilnie. Fotelik małego nie działa dobrze, znaleźć inne rozwiązanie.**

<div>

To była krótka piłka. Postawiłem netbooka na szafce na buty i
przybliżyłem jeszcze do pieca. Stał już bardzo stabilnie.

</div>

### **ad2. Kamera internetowa generuje 2 obrazy na sekundę a do tego obciąża netbooka bardzo mocno (LAVG w okolicach 1, czyli max). Wystarczy nam jedno zdjęcie co minutę.**

<div>

Musiałem ogólnie zmienić kilka parametrów kamery
(**/etc/motion/motion.conf**):

</div>

> <div>
>
> <div>
>
> width 640
>
> </div>
>
> <div>
>
> height 480
>
> </div>
>
> <div>
>
> framerate 2
>
> </div>
>
> </div>
>
> <div>
>
> minimum\_frame\_time 60
>
> </div>
>
> <div>
>
> quality 100
>
> </div>
>
> <div>
>
> picture\_type jpeg
>
> </div>

<div>

Po powyższych zmianach i przeładowaniu serwera motion obciążenie
netbooka spadło znacznie :)

</div>

### 

### **ad3. Potrzebuję trzech zdjęć - dla poziomu "alert" (2 atmosfery, dla poziomu "warning" (1,5 atmosfery) oraz dla poziomu "OK" (lekko poniżej 1 atmosfery).**

<div>

Miałem kilka zdjęć jeszcze z operacji spuszczania wody z obiegu, więc
wziąłem kilka przydatnych.

</div>

### 

### **ad4. Potrzebny jest automat, który będzie przycinał zdjęcia tak aby było widać tylko aktywne pole, po którym wędruje strzałka. Dzięki temu porównanie będzie dużo łatwiejsze.**

<div>

Oczywiście można by się bawić w pisanie kodu, który wczytuje obraz i go
tnie, ale to takie... programistyczne. A ja jestem chory i nie chce mi
się dziś programować, a poza tym po co nam aż taka armata. Tutaj
wystarczy **convert** - który jest składnikiem
biblioteki **ImageMagick**, więc **yum install ImageMagick** i
następnie:

</div>

> /usr/bin/convert -crop 110x50+60+250 alert.jpg alert.jpg

<div>

No i mamy ślicznie przycięty obrazek. Oczywiście rozmiar oraz pozycję
przycięcia wyznaczyłem organoleptycznie ;)

</div>

<div>

[![](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/probe.jpg "probe"){width="110"
height="50"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/probe.jpg)

</div>

### 

### **ad5. Potrzebny jest patent do porównywania tych obrazów**

<div>

I tu się zrobiło ciekawie. Lektura do
poczytania: <http://www.imagemagick.org/Usage/compare/> - czytając na
szybko doszedłem do wniosku, że albo próbuję metodą porównywania
statystyk obrazu (**Comparison Statistics**) albo armatą,
czyli **Matching Sub-Images and Shapes (**HitAndMiss Morphology, Peak
Finding and extracting, Using a Laplacian Convolution Kernel - itd...).

</div>

<div>

Co mogłem powiedzieć - z Laplasjanami bawiłem się jakieś 10 lat temu gdy
studiowałem fizykę, więc stwierdziłem, że najpierw dam szansę metodom
statystycznym - to w końcu najprostsze rozwiązanie :)

</div>

<div>

Streszczając metodę statystyczną - podajemy 2 obrazy na wejściu,
wybieramy jeden z algorytmów porównania i na wyjściu otrzymujemy pewną
liczbę - a jej znaczenie zależy od algorytmu. Po lekturze dokumentacji
wybrałem na początek metrykę  **Average Error (over all pixels) - MAE
(Mean absolute error, average channel error distance)**. Żeby sprawdzić
jej wyniki wziąłem jeden przycięty obraz (**probe.jpg**), który to
pokazywał przypadkową pozycję strzałĸi. Następnie w pętli zrobiłem
porównanie tego obrazu za pomocą metryki MAE do kilku dziesięciu
obrazów, które zebrałem w trakcie spuszczania wody z obiegu (czyli
wędrówki strzałki od 4 atmosfer aż do pozycji poniżej 1 atmosfery, czyli
określonej przeze mnie jako OK):

</div>

> for i in \`ls imgs/\*jpg\`; do /usr/bin/compare -metric mae probe.jpg
> \$i null: 2&gt;&gt;data\_out.csv; done

<div>

Na koniec jeszcze musiałem przyciąć plik CSV tak aby zawierał tylko
liczby całkowite i żadnych stringów:

</div>

> cut -d . -f 1 data\_out.csv &gt; data\_out2.csv

<div>

No i mogłem zobaczyć na wykresie czy cokolwiek tutaj ma sens:

</div>

<div>

[![](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/wykres1-300x122.png "Bingo!"){width="300"
height="122"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/wykres1.png)Bingo!
Wyraźnie widać miejsce, w którym wartość spada do minimum, a nawet do
zera. To jest miejsce, w którym osiągamy maksimum podobieństwa obrazów,
czyli minimalna wartość porównania wg. metryki MAE. Sweet :) Dodam, że
to co po lewej to były jakieś odrzuty danych, więc nie brałem ich pod
uwagę (to były obrazy, które były zrobione jeszcze w innej pozycji
kamery, przed zastąpieniem fotelika szafką na buty).

</div>

<div>

W tej chwili musiałem jeszcze określić granicę alertów dla konkretnych
liczb. Wyszło mi na to, że skala podobieństwa poniżej 1800 oznacza, że
obrazy są podobne na tyle, iż mogę stwierdzić, że strzałka ciśnienia
jest w podanym miejscu. Dokonałem jeszcze kilku sprawdzeń i
zwykresowałem wyniki na kilkunastu wykresach generowanych automatycznie
gnuplotem:

</div>

<div>

[![](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/plot2_mae-300x225.png "plot2_mae"){width="300"
height="225"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/plot2_mae.png)Teraz
pozostało to tylko ubrać w jakiś skrypt i całość gotowa:

</div>

<div>

    #!/bin/bash

    BASEDIR=/root/pressure_monitoring
    rm -rf $BASEDIR/data_*csv $BASEDIR/imgs/*

    # let's move images from camera dir to our tmp dir:
    mv /var/motion/*jpg $BASEDIR/imgs/

    # we are interested only in checking 1 file - when this script is executed every N seconds (where N == frequency of image-generation by camera) then this is not a problem. Finally I'm running this script in crontab every 60 seconds, but this is not an issue as there's no way the pressure could rise so quick to warning or alarm level (and if so - then I'm really fucked...
    PROBE=`ls $BASEDIR/imgs | tail -1`
    WGET=/usr/bin/wget

    mv $BASEDIR/imgs/$PROBE $BASEDIR/probe.jpg

    # converting to proper size:
    /usr/bin/convert -crop 110x50+60+250 $BASEDIR/probe.jpg $BASEDIR/probe.jpg

    # let's compare probe.jpg to level templates:
    for i in $BASEDIR/alert.jpg $BASEDIR/warning.jpg $BASEDIR/ok.jpg; do /usr/bin/compare -metric mae $BASEDIR/probe.jpg $i null: 2>>$BASEDIR/data_out.csv; done
    cut -d . -f 1 $BASEDIR/data_out.csv > $BASEDIR/data_out2.csv
    cut -d ' ' -f 1 $BASEDIR/data_out2.csv > $BASEDIR/data_out.csv

    ALERT_LEV=`head -1 $BASEDIR/data_out.csv`
    WARNING_LEV=`head -2 $BASEDIR/data_out.csv | tail -1`
    OK_LEV=`tail -1 $BASEDIR/data_out.csv`

    if [ "$ALERT_LEV" -le "1800" -a "$ALERT_LEV" -le "$OK_LEV" ]; then
        MSG="PRESSURE is about 2ba! Comparison level: $ALERT_LEV ($WARNING_LEV/$OK_LEV)"
        echo $MSG | mail -s "PRESSURE ALERT" docent.net@gmail.com
        echo `date +"%Y-%m-%d %H:%M:%S"` $MSG >> /var/log/pressure.log
        MSG_SMS=$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$MSG")
        $WGET "https://somewhere_in_the_space.pl?message=$MSG_SMS" -O /dev/null
        cp $BASEDIR/probe.jpg "$BASEDIR/alert_imgs/`date +\"%Y-%m-%d %H-%M-%S\"`.jpg"
    elif [ "$WARNING_LEV" -le "1800" -a "$WARNING_LEV" -le "$OK_LEV" ]; then
        MSG="PRESSURE is about 1.5ba! Comparison level: $WARNING_LEV ($ALERT_LEV/$OK_LEV)"
        echo `date +"%Y-%m-%d %H:%M:%S"` $MSG >> /var/log/pressure.log
        cp $BASEDIR/probe.jpg "$BASEDIR/alert_imgs/`date +\"%Y-%m-%d %H-%M-%S\"`.jpg"
    #        echo "$MSG" | mail -s "PRESSURE WARNING" docent.net@gmail.com
    #   MSG_SMS=$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$MSG")
    #        $WGET "https://somewhere_in_the_space.pl?message=$MSG_SMS" -O /dev/null
    elif [ "$OK_LEV" -le "1800" ]; then
            MSG="PRESSURE is ok :) Comparison levels (ALERT/WARNING/OK): $ALERT_LEV/$WARNING_LEV/$OK_LEV"
            echo `date +"%Y-%m-%d %H:%M:%S"` $MSG >> /var/log/pressure.log
    #       echo "$MSG" | mail -s "PRESSURE info" docent.net@gmail.com
    #       MSG_SMS=$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$MSG")
    #        $WGET "https://somewhere_in_the_space.pl?message=$MSG_SMS" -O /dev/null
    fi

    if [ "$ALERT_LEV" -ge "1800" -a "$WARNING_LEV" -ge "1800" -a "$OK_LEV" -ge "1800" ]; then
        MSG="PRESSURE level is UNKNOWN! Comparison levels (ALERT/WARNING/OK): $ALERT_LEV/$WARNING_LEV/$OK_LEV" 
        echo `date +"%Y-%m-%d %H:%M:%S"` $MSG >> /var/log/pressure.log
        cp $BASEDIR/probe.jpg "$BASEDIR/alert_imgs/`date +\"%Y-%m-%d %H-%M-%S\"`.jpg"
    #   echo "$MSG" | mail -s "PRESSURE UNKNOWN" docent.net@gmail.com
    #   MSG_SMS=$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$MSG")
    #       $WGET "https://somewhere_in_the_space.pl?message=$MSG_SMS" -O /dev/null
    fi

</div>

<div>

W dużym skrócie - skrypt działa w ten sposób, że pobiera obrazy z
kamery, wybiera ostatni z nich i na nim dokonuje porównania. A potem na
podstawie wyniku decyduje czy wysyłać alert czy nie.

</div>

### 

### **ad5. Na koniec wpinamy to w domowego Nagiosa i SMSy :)**

<div>

Tutaj nie ma już co opisywać :) Tak - mam domowego Nagiosa - to chyba
normalne, nie? :)

</div>

Kończ waść...
-------------

Tak jak teraz na to patrzę z perspektywy czasu... chyba na prawdę byłem
chory :) Ale co by tu nie mówić - to zadziałało :) Dostałem 3 SMSy z
alertami, za każdym razem spuszczałem delikatnie wodę i dokręcałem
główny zawór delikatnie aż sytuacja się unormowała. Nikogo nie wzywałem
już - w wakacje i tak piec wymieniam, więc zabawa się zacznie od
początku.

Teraz już patent zlikwidowałem, jednak do serwera, który siedzi w
piwnicy mam zamiar podpiąć kamerkę USB - tak na wszelki wypadek :) A
nowy piec mam nadzieję, że będzie miał już jakiś ludzki interfejs tak,
aby to monitorować po ludzku a nie metodą chałupniczą.

Co mogę powiedzieć na koniec - OpenSource rządzi :)

Aaaa.. macie na koniec zdjęcie głównego zaworu wody:

[![](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/zawor.jpg-300x225.jpg "zawor.jpg"){width="300"
height="225"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/01/zawor.jpg.jpg)<!--:-->
