class Uczen:

    def __init__(self,id, pesel, imie, nazwisko,adres, klasa, powiazanie, user):
        self.ID = id
        self.pesel = pesel
        self.imie = imie
        self.nazwisko = nazwisko
        self.adres = adres
        self.klasa = klasa
        self.powiazanie = powiazanie
        self.user = user
        
    def write(self):
        return(self.ID,self.pesel,self.imie, self.nazwisko,self.adres,self.klasa,self.powiazanie,self.user)

