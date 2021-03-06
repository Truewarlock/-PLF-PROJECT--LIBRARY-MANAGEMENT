domains

FILE=vfi;vfo 
  
 %timpul de date din baza de date
  tdp=dp(string,string,string)
  tdb=db(string,string,string,integer)
  tdi=di(string,string,tda)
  tda=da(string,string,string)

database-config
  flagas(integer)
%bazele de date proproiu zise
database-utilizatori
  utilizator(tdp)

database-biblio
  biblioteca(tdb)

database-imprumutttt
  imprumut(tdi)


%in predicate definim numele 'functiei' si argumentele sale daca e nevoie
predicates
  main_run
  run
  initapp
  preg_utilizatori
  preg_biblio
  preg_imp
  prelopt(char)
  execopt(char)
  valido(char)
  makew_meniua
  makew_adaugau
  makew_imprumu
  makew_adaugac
  makew_conanb
  makew_conanu
  makew_conani 
  makew_veziu 
  makew_vezic
  makew_eroare
  makew_confirm
  readmv(integer)
  crefu(FILE)
  crefb(FILE)
  crefi(FILE)
  checkDisp(string)
  checkID(string)
  checkBorrow(string)
  verificare1(char)
  verificare2(char)
  delsf
  delang
  cons
 



%in clauze atribuim actiuni acestor functii
clauses

  readmv(M):-
    readint(M).
  delsf:-
    retract(flagas(_)).
  
  delsf.
    
  delang:-
    retractall(utilizator(dp(_,_,_))).
  
  delang.

    cons:-
    existfile("Utilizatori.dat"),
    consult("Utilizatori.dat",utilizatori).
  
  cons.

%incarcat informatia din fisier text in RAM
  initapp:-
    delsf,
    delang,
    assert(flagas(0)),
    cons,
    preg_utilizatori,
    preg_biblio,
    preg_imp.

%crefu, crefb, crefi se folosesc de informatia incarcata in ram ca sa genereze un suport vizual cu datele din database
  crefu(NSF):-
    writedevice(NSF),
    utilizator(dp(CNP,NU,PU)),
    write("***********************"),nl,
    write("CNP            :",CNP),nl,
    write("Nume           :",NU),nl,
    write("Prenume        :",PU),nl,
   
    fail.

  crefu(NSF):-
    write("***********************"),
    closefile(NSF),
    writedevice(screen).

  crefb(NSF):-
    writedevice(NSF),
    biblioteca(db(ID,NC,NA,AVA)),
    write("***********************"),nl,
    write("UNIQUE ID      :",ID),nl,
    write("Nume carte     :",NC),nl,
    write("Nume autor     :",NA),nl,
    write("Disponibilitate:",AVA),nl,

   
    fail.

  crefb(NSF):-
    write("***********************"),
    closefile(NSF),
    writedevice(screen).

  crefi(NSF):-
    writedevice(NSF),
    imprumut(di(CNP,ID,da(ZI,LUNA,AN))),
    write("***********************"),nl,
    write("CNP            :",CNP),nl,
    write("ID carte       :",ID),nl,
    write("ZI imprumut    :",ZI),nl,
    write("Luna imprumut  :",LUNA),nl,
    write("An imprumut    :",AN),nl,
   
    fail.

  crefi(NSF):-
    write("***********************"),
    closefile(NSF),
    writedevice(screen).

  makew_meniua:-
    makewindow(1,7,14,"Meniu aplicatie",3,15,12,50).

  makew_adaugau:-
    makewindow(2,7,7,"Adaugare utilizator",9,2,14,76).
  makew_imprumu:-
    makewindow(2,7,7,"Imprumuta carte",9,2,14,76).
  makew_eroare:-
    makewindow(2,7,7,"Errrrrrror",9,2,14,76).
  makew_confirm:-
    makewindow(2,7,7,"Confirmare",9,2,14,76).

  makew_adaugac:-
    makewindow(2,7,7,"Adaugare carte",9,2,14,76).
      
  makew_conanb:-
    makewindow(3,7,7,"Biblioteca",9,2,14,76). 
  makew_conanu:-
    makewindow(3,7,7,"Utilizatori",9,2,14,76). 
  makew_conani:-
    makewindow(3,7,7,"Imprumuturi",9,2,14,76). 
  makew_veziu:-
    makewindow(2,7,7,"Cauta utilizaotr dupa CNP",9,2,14,76). 
  makew_vezic:-
    makewindow(2,7,7,"Cauta carte dupa ID",9,2,14,76).



  preg_utilizatori:-
   utilizator(dp(_,_,_)),
   retractall(utilizator(dp(_,_,_)),utilizatori),
   existfile("utili.txt"),
   consult("utili.txt",utilizatori).

 preg_utilizatori:-
   existfile("utili.txt"),
   consult("utili.txt",utilizatori).

  preg_biblio:-
   biblioteca(db(_,_,_,_)),
   retractall(biblioteca(db(_,_,_,_)),biblio),
   existfile("biblio.txt"),
   consult("biblio.txt",biblio).

 preg_biblio:-
   existfile("biblio.txt"),
   consult("biblio.txt",biblio).

  preg_imp:-
   imprumut(di(_,_,da(_,_,_))),
   retractall(imprumut(di(_,_,da(_,_,_))),imprumutttt),
   existfile("imprumut.txt"),
   consult("imprumut.txt",imprumutttt).

 preg_imp:-
   existfile("imprumut.txt"),
   consult("imprumut.txt",imprumutttt).


%optiuni valide, daca introducem alt caracter care nu e intre 1 si 8 functia crapa
  valido(Opt):-
    Opt='1';
    Opt='2';
    Opt='3';
    Opt='4';
    Opt='5';
    Opt='6';
    Opt='7';
    Opt='8';
    Opt='9'.

  prelopt(Opt):-
    makew_meniua,
    cursor(0,3),write("1. Adauga utilizator"),
    cursor(1,3),write("2. Adauga carte"),
    cursor(2,3),write("3. Imprumuta carte"),
    cursor(3,3),write("4. Returneaza carte"),
    cursor(4,3),write("5. Lista carti"),
    cursor(5,3),write("6. Lista utilizatori"),
    cursor(6,3),write("7. Lista imprumuturi"),
    cursor(8,3),write("8. Salveaza databases "),
    cursor(9,3),write("9. Exit program"),
    readchar(Opt),
    valido(Opt).
%cand prelopt crapa deoarece valido nu e inteplinit, programul cauta alta solutie, in cazu nostru chestia de mai jos care
% ne zice ca optiunea nu e valida, si dupa reporneste functia prelopt de la inceput, pana punem o functie buna
  prelopt(Opt):-
    makew_eroare,
    cursor(7,3),write("Optiune eronata!<CR pentru revenire>"),
    readchar(_),
    removewindow,
    prelopt(Opt).
%introducem date dupa le salvam in baza de date 
  execopt('1'):-
    makew_adaugau,
    cursor(0,2),write("CNP      :"),readln(CNP),
    cursor(1,2),write("Nume     :"),readln(NU),
    cursor(2,2),write("Prenume  :"),readln(PU),
    assert(utilizator(dp(CNP,NU,PU))),
    assert(flagas(1)),
    write("______________"),nl,
    write("Mai doriti(D,N):"),
    readchar(Ras),
    removewindow,
    %verifica1, verifica daa charul Raspuns este d(d mic) sau D(d mare), daca functia se indeplineste, se repeta inregistrarea
    verificare1(Ras).
%daca charul nu e D sau d atuncia functia crapa si mergem la a doua varianta, da remove la fereastra si ne lasa in meniul prelopt
% ca sa alegem o alta optiune din meniu
  execopt('1'):-
    makew_eroare,
    write("Am inteles"),
    readchar(_),
    removewindow.
    %asemanator cu execopt optiunea 1, doar ca sunt date diferite, acici avem carti nu utiliatori
  execopt('2'):-
    makew_adaugac,
    cursor(0,2),write("UNIQUE ID    :"),readln(ID),
    cursor(1,2),write("Nume carte   :"),readln(NC),
    cursor(2,2),write("Nume autor   :"),readln(NA),
    assert(biblioteca(db(ID,NC,NA,1))),
    assert(flagas(1)),
    write("______________"),nl,
    write("Mai doriti(D,N):"),
    readchar(Ras),
    removewindow,
    verificare2(Ras).

  execopt('2'):-
    makew_eroare,
    write("Am inteles"),
    readchar(_),
    removewindow.
%stergem din ram cartea cu ID-ul introdus dupa o bagam din nou dar cu disponibilitatea 0, adica nu ma e valida de imprumut
  execopt('3'):-
    makew_imprumu,
    cursor(0,2),write("CNP utilizator:"),readln(CNP),
    cursor(1,2),write("ID carte      :"),readln(ID),
    cursor(2,2),write("ZI            :"),readln(ZI),
    cursor(3,2),write("LUNA          :"),readln(LUNA),
    cursor(4,2),write("AN            :"),readln(AN),
    %verifica daca se e in biblioteca ID-ul si daca e valabila(daca are AVA=1)
    checkID(ID),
    retract(biblioteca(db(ID,NC,NA,_))),
    assert(biblioteca(db(ID,NC,NA,0))),
    assert(imprumut(di(CNP,ID,da(ZI,LUNA,AN)))),
    removewindow.
  execopt('4'):-
    makew_imprumu,
    cursor(0,2),write("CNP utilizator:"),readln(CNP),
    cursor(1,2),write("ID carte      :"),readln(ID),
    checkBorrow(ID),
    retract(biblioteca(db(ID,NC,NA,_))),
    assert(biblioteca(db(ID,NC,NA,1))),
    retract(imprumut(di(CNP,ID,da(_,_,_)))).

    %urmatoarele 3 execopts se folosesc de functiile ce creeaa support pentru vizualizare, salveaza informatia intr-un fille
    %dupa care arata continutul documentului
  execopt('5'):-
    makew_conanb,
    openwrite(vfo,"B.DAT"),
    crefb(vfo),
    file_str("B.DAT",Fis),    
    display(Fis),
    removewindow.
  execopt('6'):-
    makew_conanu,
    openwrite(vfo,"U.DAT"),
    crefu(vfo),
    file_str("U.DAT",Fis),    
    display(Fis),
    removewindow.
    
  execopt('7'):-
    makew_conani,
    openwrite(vfo,"I.DAT"),
    crefi(vfo),
    file_str("I.DAT",Fis),    
    display(Fis),
    removewindow.
%am facut o functie separata de salvare ca sa am mai multe optiuni in meniu, puteam sa pun save(nume fisier, database) la sfarstiul
%orcariu execopt '1' '2' sau '3', dar e mai ok sa le salvam noi de mana
  execopt('8'):-
    save("Utili.txt",utilizatori),
    save("Biblio.txt",biblio),
    save("Imprumut.txt",imprumutttt).

% exit(0) termina programul
  execopt('9'):-
    exit(0).


  checkID(ID):-
    biblioteca(db(ID,_,_,_)),
    makew_confirm,
    cursor(1,3), write("Exista carte cu ID=",ID),
    readchar(_),
    checkDisp(ID),
    removewindow.
  checkID(ID):-
    makew_eroare,
    cursor(1,3), write("Nu exista carte cu ID=",ID),
    readchar(_),
    removewindow.

  checkDisp(ID):-
    biblioteca(db(ID,_,_,AVA)),
    AVA=1,
    makew_confirm,
    cursor(2,3), write("Cartea este disponibila."),
    cursor(3,3), write("Ati imprumutat cartea cu ID=", ID),
    readchar(_),
    removewindow.
  checkDisp(ID):-
    makew_eroare,
    cursor(2,3), write("Cartea cu ID ",ID," este deja imprumutata" ),
    readchar(_),
    removewindow.

  checkBorrow(ID):-
    imprumut(di(ID,_,da(_,_,_))),
    makew_confirm,
    cursor(1,3),write("Cartea inca nu a fost restituita"),
    readchar(_),
    removewindow.
  checkBorrow(ID):-
    makew_eroare,
    cursor(1,3),write("Cartea este in biblioteca deja"),
    readchar(_),
    removewindow.
  
  verificare1('D'):-
    execopt('1').

  verificare1('d'):-
    execopt('1').

  verificare2('D'):-
    execopt('2').

  verificare2('d'):-
    execopt('2').

%run care incarca meniul si alegera optiunii, de asemnea functia este introdusa in ea insasi asa ca e loop infinit
  run:-
    prelopt(O),
    execopt(O),
    run.
%main care se asigura ca intai incarcam datele din text filles si dupa ram run
  main_run:-
    initapp,
    run.

%goal practic porneste programul
goal
   main_run
