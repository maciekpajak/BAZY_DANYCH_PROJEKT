class Nauczyciel:

    def __init__(self,id, imie, nazwisko, nr_tel, czy_wych, przedmiot, user):
        self.ID = id
        self.imie = imie
        self.nazwisko = nazwisko
        self.nr_tel = nr_tel
        self.czy_wych = czy_wych
        #self.klasa = klasa
        self.przedmiot = przedmiot
        self.user = user
        
    def write(self):
        return(self.ID,self.imie, self.nazwisko,self.nr_tel,self.czy_wych,self.przedmiot,self.user)
