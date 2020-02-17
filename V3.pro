domains

	FILE=vfi;vfo 

	
	td1=carti(string,string,string,integer)
	td2=imprumut(string,string,string,string,td3)
	td3=data(string,string,string)


	database-books
		book(td1)
	database-imprumuturi
		borrow(td2)


predicates
	main
	run
	initializare
	upload_books
	upload_imprumuturi
	make_window_meniu
	make_window_imprumut
	make_window_eroare
    make_window_books
	vezi_carti(FILE)
	vezi_imprumuturi(FILE)
	prelopt(char)
	execopt(char)
	valido(char)




clauses

	make_window_meniu:-
        makewindow(1,7,14,"Meniu aplicatie",3,15,12,50).

    make_window_eroare:-
        makewindow(1,7,14,"Eroare",3,15,12,50).

    make_window_imprumut:-
        makewindow(1,7,14,"Imprumuturi",3,15,12,50).

    make_window_books:-
        makewindow(1,7,14,"Carti",3,15,12,50).

	vezi_imprumuturi(NSF):-
		writedevice(NSF),
    	borrow(imprumut(COD,CNP,NUME,PRENUME,data(ZI,LUNA,AN))),
    	write("***********************"),nl,
    	write("ID carte           :",COD),nl,
    	write("CNP utilizator     :",CNP),nl,
    	write("Nume utilizator    :",NUME),nl,
    	write("Prenume utilizator :",PRENUME),nl,
    	write("ZI imprumut        :",ZI),nl,
    	write("Luna imprumut      :",LUNA),nl,
    	write("An imprumut        :",AN),nl,
   
    	fail.

  	vezi_imprumuturi(NSF):-
    	write("***********************"),
    	closefile(NSF),
    	writedevice(screen).

    vezi_carti(NSF):-
        writedevice(NSF),
        book(carti(COD,NUME,AUTOR,_)),
        write("***********************"),nl,
        write("ID carte           :",COD),nl,
        write("CNP utilizator     :",NUME),nl,
        write("Nume utilizator    :",AUTOR),nl,
        
   
        fail.

    vezi_carti(NSF):-
        write("***********************"),
        closefile(NSF),
        writedevice(screen).





	prelopt(Opt):-
    	make_window_meniu,
   	 	cursor(0,3),write("1. Adauga carte"),
    	cursor(1,3),write("2. Imprumuta carte"),
    	cursor(2,3),write("3. Vezi imprumuturi"),
        cursor(3,3),write("4. Restituie carte"),
        cursor(4,3),write("5. Vezi carti"),

    	cursor(6,3),write("6. EXIT"),
    	readchar(Opt),
    	valido(Opt).
    prelopt(Opt):-
    	make_window_eroare,
    	write("Optiune este eronata. Press ESC"),
    	readchar(_),
    	removewindow,
        prelopt(Opt).


    execopt('1'):-
    	make_window_books,
    	cursor(0,3),write("Cod carte : "),readln(COD),
    	cursor(1,3),write("Nume carte: "),readln(NUME),
    	cursor(2,3),write("Nume autor: "),readln(AUTOR),
    	assert(book(carti(COD,NUME,AUTOR,1))),
    	save("Biblio.txt",books),
    	removewindow.
    execopt('2'):-
    	make_window_imprumut,
    	cursor(0,3),write("Cod carte : "),readln(COD),
    	cursor(1,3),write("CNP utilizator:  "),readln(CNP),
    	cursor(2,3),write("Nume utilizator: "),readln(NUME),
    	cursor(3,3),write("Prenume utilizator: "),readln(PRENUME),
    	cursor(4,3),write("ZI "),readln(ZI),
    	cursor(5,3),write("LUNA "),readln(LUNA),
    	cursor(6,3),write("AN "),readln(AN),
    	retract(book(carti(COD,NUME,AUTOR,_))),
    	assert(book(carti(COD,NUME,AUTOR,0))),
    	assert(borrow(imprumut(COD,CNP,NUME,PRENUME,data(ZI,LUNA,AN)))),
    	save("IMP.txt",imprumuturi),
    	removewindow.
    execopt('3'):-
    	make_window_imprumut,
    	openwrite(vfo,"B.DAT"),
   		vezi_imprumuturi(vfo),
    	file_str("B.DAT",Fis),    
    	display(Fis),
    	removewindow.
    execopt('4'):-
        make_window_imprumut,
        cursor(0,2),write("CNP utilizator:"),readln(CNP),
        cursor(1,2),write("ID carte      :"),readln(COD),
        retract(book(carti(COD,NUME,AUTOR,_))),
        assert(book(carti(COD,NUME,AUTOR,1))),
        retract(borrow(imprumut(COD,CNP,NUME,PRENUME,data(_,_,_)))).

    execopt('5'):-
        make_window_books,
        openwrite(vfo,"BB.DAT"),
        vezi_carti(vfo),
        file_str("BB.DAT",Fis),
        display(FIs),
        removewindow.
    execopt('6'):-
    	exit(0).


	valido(Opt):-
    	Opt='1';
    	Opt='2';
    	Opt='3';
    	Opt='4';
        Opt='5';
        Opt='6'.

    upload_books:-
    	existfile("Biblio.txt"),
   		consult("Biblio.txt",books).
    upload_imprumuturi:-
    	existfile("IMP.txt"),
   		consult("IMP.txt",imprumuturi).
    	

    initializare:-
    	upload_imprumuturi,
    	upload_books.
	run:-
		prelopt(O),
		execopt(O),
		run.

	main:-
		initializare,
		run.



goal
	main
