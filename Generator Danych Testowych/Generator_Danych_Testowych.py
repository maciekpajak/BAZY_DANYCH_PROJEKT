import random
import datetime
import csv
from uczen import Uczen
from nauczyciel import Nauczyciel
from Uzytkownik import Uzytkownik
from Rodzic import Rodzic
from Ocena import Ocena
from Lekcja import Lekcja
from Obecnosc import Obecnosc

znak_odstepu = ';'

przedmioty = ('matematyka', 'polski', 'angielski','historia','wf','fizyka','chemia','geografia','biologia','WOS','niemiecki')
stopnie = ('brak','ndst','dop','dst','db','bdb','cel')
mf = ['m','f']
imiona_f = []
imiona_m = []
nazwiska_m =[]
nazwiska_f = []

status_obecnosci = ('obecny','nieobecny','spóźniony')

klasy_dla_n= ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16']
klasy_id = ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16']
klasy= ['1a','1b','1c','1d','2a','2b','2c','2d','3a','3b','3c','3d','4a','4b','4c','4d']
uczniowie_w_klasach = [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]]
liczba_klas = 16
wychowawcow = 16

liczba_nauczycieli = 80
liczba_uczniow_w_klasie = 30
liczba_uczniow = liczba_uczniow_w_klasie*16
liczba_ocen = liczba_uczniow *5 #20*10
liczba_lekcji = 10 * liczba_klas #2825 * liczba_klas

user_id = 1
nauczyciel_id = 1
uczen_id = 1
rodzic_id = 1
powiazanie_id = 1
obecnosc_id = 1
lekcja_id = 1
ocena_id = 1
klasa_id = 1

adres = []
adres_naglowki = ('adres_ID','ulice_miejscowosci_id','nr_domu','nr_mieszkania')
czas_lekcji = []
czas_lekcji_naglowki = ('czas_lekcji_ID','data','godz_start','godz_koniec')


uzytkownicy = []
uzytkownik_naglowki = ('','','','','','')
nauczyciele = []
rodzice = []
uczniowie = []
lekcje = []
oceny = []
obecnosci = []
powiazania = []


def load_imiona_f():
    global imiona_f
    file = open('./imiona_f.txt','r')
    imiona_f = file.read().split(';')

def load_imiona_m():
    global imiona_m
    file = open('./imiona_m.txt','r')
    imiona_m = file.read().split(';')

def load_nazwiska_f():
    global nazwiska_f
    file = open('./nazwiska_f.txt','r')
    nazwiska_f = file.read().split(';')

def load_nazwiska_m():
    global nazwiska_m
    file = open('./nazwiska_m.txt','r')
    nazwiska_m = file.read().split(';')

def pisz_do_pliku(nazwa_pliku,naglowki, instancja ):
    with open(nazwa_pliku, 'w') as csvfile:
        csvwriter = csv.writer(csvfile, delimiter=znak_odstepu)
        csvwriter.writerow(naglowki)
        for i in instancja:
            csvwriter.writerow(i.write())

def generuj_nauczyciela():
    global nauczyciel_id
    global przedmioty
    global liczba_klas
    global wychowawcow
    global klasa_id
    global user_id
    global nauczyciele
    global klasy_dla_n

    id = str(nauczyciel_id).zfill(3)
    nauczyciel_id = nauczyciel_id + 1

    plec = random.choice(mf)
    if plec == 'm':
        imie = random.choice(imiona_m)
        nazwisko = random.choice(nazwiska_m)
    else:
        imie = random.choice(imiona_f)
        nazwisko = random.choice(nazwiska_f)

    nr_tel = str(random.randint(600000000,700000000))
    if wychowawcow > 0:
        czy_wychowawca = 'Y'
        wychowawcow = wychowawcow - 1
    else:
        czy_wychowawca = 'N'

    #if czy_wychowawca == 'Y':
    #    klasa = str(klasa_id).zfill(2)
    #    klasa_id += 1
    #else:
    #    klasa = '00'

    przedmiot = random.choice(przedmioty)
    user = str(user_id).zfill(4)
    user_id += 1

    generuj_uzytkownika(user,'N')

    nauczyciele.append(Nauczyciel(id,imie, nazwisko, nr_tel, czy_wychowawca, przedmiot, user))

def pisz_nauczyciel_do_pliku():
    
    global nauczyciele 
    global liczba_nauczycieli
    with open('nauczyciele.txt', 'w') as csvfile:
        names = ('ID', 'imie' , 'nazwisko', 'nr_tel' , 'czy_wych','przedmiot','uzytkownik')
        
        csvwriter = csv.writer(csvfile, delimiter=znak_odstepu)
        csvwriter.writerow(names)
        for i in nauczyciele:
            csvwriter.writerow(i.write())

def generuj_uzytkownika(uid, rodzaj):
    id = uid
    login = rodzaj + str(uid).zfill(4)
    haslo = '1234'
    rodzaj_konta = rodzaj
    email = 'przykladowy@email.com'

    uzytkownicy.append(Uzytkownik(id,login,haslo,rodzaj_konta,email))

def pisz_uzytkownik_do_pliku():
    
    global uzytkownicy
    with open('uzytkownicy.txt', 'w') as csvfile:
        names = ('ID', 'login' , 'haslo' , 'rodzaj_konta','email')
        
        csvwriter = csv.writer(csvfile, delimiter=znak_odstepu)
        csvwriter.writerow(names)
        for i in uzytkownicy:
            csvwriter.writerow(i.write())

def generuj_ucznia():
    global user_id
    global uczen_id
    global klasy
    global powiazanie_id
    global powiazania
    global klasy_id

    id = str(uczen_id).zfill(3)
    uczen_id += 1
    pesel = random.randint(10000000000,99999999999)
    plec = random.choice(mf)
    if plec == 'm':
        imie = random.choice(imiona_m)
        nazwisko = random.choice(nazwiska_m)
    else:
        imie = random.choice(imiona_f)
        nazwisko = random.choice(nazwiska_f)

    adres = "przykladowyadres"
    klasa = random.choice(klasy_id)

    idx = klasy_id.index(klasa)
    uczniowie_w_klasach[idx].append(id)

    klasa = str(klasa).zfill(2)

    powiazanie = str(powiazanie_id).zfill(3)
    powiazanie_id += 1

    powiazania.append(str(powiazanie))

    user = str(user_id).zfill(3)
    user_id += 1

    generuj_rodzicow(powiazanie,nazwisko)

    generuj_uzytkownika(user,'U')

    uczniowie.append(Uczen(id,pesel,imie, nazwisko,adres,klasa, powiazanie, user))

def pisz_uczen_do_pliku():
    
    global uczniowie
    with open('uczniowie.txt', 'w') as csvfile:
        names = ('ID','pesel', 'imie' , 'nazwisko','adres','klasa','powiazanie','uzytkownik')
        
        csvwriter = csv.writer(csvfile, delimiter=znak_odstepu)
        csvwriter.writerow(names)
        for i in uczniowie:
            csvwriter.writerow(i.write())

def generuj_rodzicow(pow,nazwisko):
    global user_id
    global rodzic_id
    global rodzice

    id = str(rodzic_id).zfill(3)
    rodzic_id += 1

    imie = random.choice(imiona_m)
    nr_tel = str(random.randint(600000000,700000000))
    powiazanie = pow
    user = user_id
    user_id += 1

    generuj_uzytkownika(user,'R')
    rodzice.append(Rodzic(id,imie,nazwisko,nr_tel,powiazanie,user))

    id = rodzic_id
    rodzic_id += 1
    imie = random.choice(imiona_f)
    nr_tel = str(random.randint(600000000,700000000))
    powiazanie = pow
    user = str(user_id).zfill(3)
    user_id += 1

    generuj_uzytkownika(user,'R')
    rodzice.append(Rodzic(id,imie,nazwisko,nr_tel,powiazanie,user))

def pisz_rodzic_do_pliku():
    
    global rodzice
    with open('rodzice.txt', 'w') as csvfile:
        names = ('ID', 'imie' , 'nazwisko' , 'nr_telefonu','powiazanie','uzytkownik')
        
        csvwriter = csv.writer(csvfile, delimiter=znak_odstepu)
        csvwriter.writerow(names)
        for i in rodzice:
            csvwriter.writerow(i.write())

def generuj_ocene():

    global oceny
    global ocena_id

    id = str(ocena_id).zfill(6)
    ocena_id += 1

    stopien = random.choice(stopnie)
    waga = random.randint(0,9)
    opis = 'Brak_opisu'
    data = datetime.datetime(2020, random.randint(1,12), random.randint(1,28))
    uczen = random.randint(1,liczba_uczniow)  #random.choice(uczniowie)
    nauczyciel = random.choice(nauczyciele)
    n_id = nauczyciel.ID
    przedmiot = nauczyciel.przedmiot

    oceny.append(Ocena(id,stopien,waga,opis,data,uczen,n_id,przedmiot))

def pisz_ocena_do_pliku():
    global oceny
    with open('oceny.txt', 'w') as csvfile:
        names = ('ID','stopien','waga','opis','data','uczen','nauczyciel','przedmiot')
        
        csvwriter = csv.writer(csvfile, delimiter=znak_odstepu)
        csvwriter.writerow(names)
        for i in oceny:
            csvwriter.writerow(i.write())

def generuj_lekcje():

    global lekcje
    global lekcja_id

    id = str(lekcja_id).zfill(6)
    lekcja_id += 1

    temat = 'Brak_tematu'
    data = datetime.date(2020, random.randint(1,12), random.randint(1,28))
    godz_rozp = datetime.time(8,0,0)
    godz_zak = datetime.time(8,45,0)

    klasa = random.choice(klasy_id)

    idx = klasy_id.index(klasa)
    klasa = str(klasa).zfill(2)

    nauczyciel = random.choice(nauczyciele)
    n_id = nauczyciel.ID
    przedmiot = nauczyciel.przedmiot

    generuj_obecnosci(idx,id)

    lekcje.append(Lekcja(id,temat,data,godz_rozp,godz_zak,klasa,n_id,przedmiot))

def pisz_lekcja_do_pliku():
    global lekcje
    with open('lekcje.txt', 'w') as csvfile:
        names = ('ID','temat','data','godz_rozp','godz_zak','klasa','nauczyciel','przedmiot')
        
        csvwriter = csv.writer(csvfile, delimiter=znak_odstepu)
        csvwriter.writerow(names)
        for i in lekcje:
            csvwriter.writerow(i.write())

def generuj_obecnosci(klasa_idx,lekcja_id):

    global obecnosci
    global obecnosc_id
    global uczniowie_w_klasach

    for uczen in uczniowie_w_klasach[klasa_idx]:
        id = str(obecnosc_id).zfill(7)
        obecnosc_id += 1
        status = random.choice(status_obecnosci)
        obecnosci.append(Obecnosc(id,status,uczen,lekcja_id)) 

def pisz_obecnosc_do_pliku():
    global obecnosci
    with open('obecnosci.txt', 'w') as csvfile:
        names = ('ID','status','uczen','lakcja')
        
        csvwriter = csv.writer(csvfile, delimiter=znak_odstepu)
        csvwriter.writerow(names)
        for i in obecnosci:
            csvwriter.writerow(i.write())

def pisz_przedmiot_do_pliku():
    global przedmioty
    with open('przedmioty.txt', 'w') as csvfile:
        names = ('nazwa')
        
        csvwriter = csv.writer(csvfile)
        csvwriter.writerow(names)
        for i in przedmioty:
            csvwriter.writerow([i])

def pisz_powiazania_do_pliku():
    global powiazania
    with open('powiazania.txt', 'w') as csvfile:
        names = ('ID')
        
        csvwriter = csv.writer(csvfile)
        csvwriter.writerow(names)
        for i in powiazania:
            csvwriter.writerow([i])

def pisz_klasy_do_pliku():
    global klasy
    with open('klasy.txt', 'w') as csvfile:
        names = ('ID','oddzial')
        
        csvwriter = csv.writer(csvfile, delimiter=znak_odstepu)
        csvwriter.writerow(names)
        j = 1
        for i in klasy:
            csvwriter.writerow([str(j).zfill(2), i])
            j+=1

def main():

    load_imiona_f()
    load_imiona_m()
    load_nazwiska_f()
    load_nazwiska_m()
    
    print("Generuje liste nauczycieli...")
    for i in range(liczba_nauczycieli):
        generuj_nauczyciela()

    print("Generuje liste uczniow i ich rodzicow...")
    for i in range(liczba_uczniow):
        generuj_ucznia()

    print("Generuje liste ocen...")
    for i in range(liczba_ocen):
        generuj_ocene()

    print("Generuje liste lekcji i obecnosci...")
    for i in range(liczba_lekcji):
        generuj_lekcje()


    
    pisz_nauczyciel_do_pliku()
    pisz_uczen_do_pliku()
    pisz_rodzic_do_pliku()
    pisz_uzytkownik_do_pliku()
    pisz_ocena_do_pliku()
    pisz_lekcja_do_pliku()
    pisz_obecnosc_do_pliku()
    pisz_powiazania_do_pliku()
    pisz_przedmiot_do_pliku()
    pisz_klasy_do_pliku()

if __name__ == "__main__":
    main()

