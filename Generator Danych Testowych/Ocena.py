class Ocena:
    """description of class"""    

    def __init__(self,id,stopien,waga,opis,data,uczen,nauczyciel,przedmiot):
        self.ID = id
        self.stopien = stopien
        self.waga = waga
        self.opis = opis
        self.data = data
        self.uczen = uczen
        self.nauczyciel = nauczyciel
        self.przedmiot = przedmiot

    def write(self):
        return(self.ID,self.stopien,self.waga,self.opis, self.data,self.uczen,self.nauczyciel,self.przedmiot)