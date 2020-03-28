class Lekcja:
    """description of class"""
    def __init__(self,id,temat,data,godz_rozp,godz_zak,klasa,nauczyciel,przedmiot):
        self.ID = id
        self.temat = temat
        self.data = data
        self.godz_rozp = godz_rozp
        self.godz_zak = godz_zak
        self.klasa = klasa
        self.nauczyciel = nauczyciel
        self.przedmiot = przedmiot

    def write(self):
        return(self.ID,self.temat, self.data, self.godz_rozp,self.godz_zak, self.klasa,self.nauczyciel,self.przedmiot)


