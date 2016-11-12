Title: MySQL HA
Date: 2013-08-05 20:08
Author: docent
Category: tech
Tags: failover, ha, mysql, replication
Slug: mysql-ha
Status: published

<!--:en-->[![MySQL](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/08/mysql_logo-300x155.png){.aligncenter
width="300"
height="155"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/08/mysql_logo.png)

This is very interesting topic from sysops' point of view. Honestly -
It's not that common to find a well organised HA MySQL environment (I'm
talking here about good failover solution in master - slave scenario).

I won't write here details for the most known solutions / scenarios - I
think it's enough to point those that one can check if it fits his
needs.

1.  **<span style="line-height: 22px;">Master - master replication. In
    this scenario we don't need automated failover - when we have some
    outage of one of those masters then it's no problem as second one is
    still working. It's good to use some LB layer between application
    and MySQL hosts that makes the app always hit the
    working server.</span>**
2.  MySQL cluster. This is very comfortable scenario as MySQL cluster
    takes care of almost everything - this is "no single point of
    failure" solution. You can read about those
    here <http://www.mysql.com/products/cluster/> and
    here <http://dev.mysql.com/downloads/cluster/> -
3.  MySQL Galera cluster - for synchronous, active - active multi -
    master
    topology: <http://www.codership.com/content/using-galera-cluster>
4.  ****Failover - for now I know 2 solutions worth mentioning:****
    1.  Matsunobu Yoshinori created mysql-master-ha (working on MySQL
        servers 5.0, 5.1 and later) - this is very good tool, that
        handles automatic, manual and semi - manual failovers (even when
        slaves are in different relaylog positions). In addition You can
        use it when MySQL master host migration is needed. I recommend
        watching those
        slides: <http://www.slideshare.net/matsunobu/automated-master-failover>
    2.  MySQL utilities - this is quite simple daemon which primary job
        is to perform automated failover when needed. You can read about
        it
        here: http://www.clusterdb.com/mysql/mysql-utilities-webinar-qa-replay-now-available/

<!--:--><!--:pl-->[![MySQL](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/08/mysql_logo-300x155.png){.aligncenter
.size-medium .wp-image-341 width="300"
height="155"}](http://maciek.lasyk.info/sysop/wp-content/uploads/2013/08/mysql_logo.png)

Ten temat jest bardzo interesujący z administracyjnego punktu widzenia.
Tak na prawdę to rzadko spotykam się z dobrze zorganizowanym
środowiskiem wysokiej dostępności w MySQLu. Mam tu na myśli porządnie
zaimplementowany system failoveru w układzie master-slave (lub wiele
slave'ów).

Nie będę może tego tematu rozkładał na czynniki pierwsze, gdyż zostało
to już wykonane na wielu serwisach - wymienię w kilku punktach
możliwości uzyskania prawdziwej wysokiej dostępności w MySQLu.

1.  <span style="line-height: 13px;">**Replikacja master - master**. W
    takim układzie niepotrzebny jest nam failover. Do dowolnego mastera
    możemy podłączyć również dowolną liczbę slave'ów. Jest to układ
    bardzo wygodny, gdyż jest w zupełności bezobsługowy (pod warunkiem,
    że przed obydwoma masterami mamy warstwę LB, dzięki której aplikacja
    zawsze trafia w działającego mastera). W przypadku awarii serwisy
    nadal nam działają a procedura dalszego postępowania zależy od
    naszej topologii serwerów.</span>
2.  **MySQL cluster**. W takim układzie system działa za nas - więcej
    informacji znajduje się
    tutaj: <http://www.mysql.com/products/cluster/> oraz
    tutaj <http://dev.mysql.com/downloads/cluster/> - idea topologii to
    brak SPOFa (Single Point of Failure).
3.  MySQL Galera cluster - zapewnia synchroniczną replikację w topologii
    active - active z wieloma
    masterami: <http://www.codership.com/content/using-galera-cluster>
4.  <div>

    Failover - można rozwiązać na dwa sposoby:

    </div>

    1.  Matsunobu Yoshinori stworzył mysql-master-ha (który działa na
        MySQLach 5.0, 5.1 i
        wyżej): <https://code.google.com/p/mysql-master-ha/> - bardzo
        dobre narzędzie, dzięki któremu możemy zapewnić automatyczny
        oraz manualny failover (nawet w sytuacjach gdy różne slave'y są
        w różnej pozycji relayloga). Dodatkowo można go wykorzystać do
        przełączania mastera na innego hosta (gdy np. chcemy dokonać
        shutdownu hosta). Polecam
        obejrzeć <http://www.slideshare.net/matsunobu/automated-master-failover>
    2.  MySQL utilities - w dużym uproszczeniu to demon, który odpowiada
        za wykonanie automatycznego failoveru w przypadku
        awarii mastera.
        Informacje: http://www.clusterdb.com/mysql/mysql-utilities-webinar-qa-replay-now-available/

<!--:-->
