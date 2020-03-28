class Rodzic:
    """description of class"""    

    def __init__(self,id, imie, nazwisko, nr_tel, powiazanie, user):
        self.ID = id
        self.imie = imie
        self.nazwisko = nazwisko
        self.nr_tel = nr_tel
        self.powiazanie = powiazanie
        self.user = user
        
    def write(self):
        return(self.ID,self.imie, self.nazwisko,self.nr_tel,self.powiazanie,self.user)

