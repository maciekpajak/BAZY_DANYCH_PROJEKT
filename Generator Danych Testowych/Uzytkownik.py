class Uzytkownik:

    def __init__(self,id, login,haslo,rodzaj,email):
        self.ID = id
        self.login = login
        self.haslo = haslo
        self.rodzaj_konta = rodzaj
        self.email = email
        
    def write(self):
        return(self.ID,self.login,self.haslo,self.rodzaj_konta ,self.email)



