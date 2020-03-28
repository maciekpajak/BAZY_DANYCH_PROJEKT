class Obecnosc:
    """description of class"""
    def __init__(self,id,status,uczen,przedmiot):
        self.ID = id
        self.status = status
        self.uczen = uczen
        self.przedmiot = przedmiot

    def write(self):
        return(self.ID,self.status,self.uczen,self.przedmiot)

