-- Insert tipus d'usuari
insert into `spotify`.`tipus_usuari` values (1,'free');
insert into `spotify`.`tipus_usuari` values (2,'premium');

-- Insert targetes
insert into `spotify`.`targetes`(id_targeta, num_targeta, mes_caducitat,
any_caducitat) values (1,'0123456789ABCDEFGHIJ',12,2358);

-- Insert paypal accounts
insert into `spotify`.`comptes_paypal`(id_paypal, nom_dusuari) 
values(1,'sinclair@paypal.com');

-- Insert formes de pagament
insert into `spotify`.`formes_pagament`(id_forma_pagament, tipus, targeta_id)
values (1,'targeta',1);
insert into `spotify`.`formes_pagament`(id_forma_pagament, tipus, paypal_id)
values (2,'paypal',1);

-- Insert usuaris free
insert into `spotify`.`usuaris`(email, contrasenya, nom_dusuari, data_neixement,
sexe, pais, codi_postal, tipus_usuari_id, subscripcio_id) 
values ('picard@starmail.st','fhpoyfpn1yp1','picard','2318-7-04','M',
'França',00001,1,null);

-- Insert usuaris premium (cal inserir primer la corresponent subscripció)
-- Si un usuari passa de free a premium, primer cal inserir la subscripció
-- Usuari premium que paga amb targeta
insert into `spotify`.`subscripcions`(data_inici,forma_pagament_id) 
values ('2345-8-1',1);

insert into `spotify`.`usuaris`(email, contrasenya, nom_dusuari, data_neixement,
sexe, pais, codi_postal, tipus_usuari_id, subscripcio_id) 
values ('sinclair@babylon.5','!fqhqup843frf','valen','2218-1-1','M',
'Earth',00010,2,LAST_INSERT_ID());

-- Usuari premium que paga amb paypal
insert into `spotify`.`subscripcions`(data_inici,forma_pagament_id) 
values ('2346-2-23',2);

insert into `spotify`.`usuaris`(email, contrasenya, nom_dusuari, data_neixement,
sexe, pais, codi_postal, tipus_usuari_id, subscripcio_id) 
values ('ivanova@babylon.5','!fqhqup843frf','suzi','2222-5-11','F',
'Earth',00011,2,LAST_INSERT_ID());

-- Insert into pagaments
insert into `spotify`.`pagaments`(num_ordre, data, total, usuari_id)
values (33, '2346-2-23', 19, 3);
insert into `spotify`.`pagaments`(num_ordre, data, total, usuari_id)
values (27, '2345-8-1', 19, 2);

-- Insert artistes
insert into `spotify`.`artistes`(id_artista, nom) values (1, "Artista1 Jazz");
insert into `spotify`.`artistes`(id_artista, nom) values (2, "Artista2 Jazz");
insert into `spotify`.`artistes`(id_artista, nom) values (3, "Artista3 Pop");
insert into `spotify`.`artistes`(id_artista, nom) values (4, "Artista4 Pop");
insert into `spotify`.`artistes`(id_artista, nom) values (5, "Artista5 Disco");
insert into `spotify`.`artistes`(id_artista, nom) values (6, "Artista6 Disco");

-- Insert artistes semblants
insert into `spotify`.`artistes_semblants`(artista1_id, artista2_id) values (1, 2);
insert into `spotify`.`artistes_semblants`(artista1_id, artista2_id) values (3, 4);
insert into `spotify`.`artistes_semblants`(artista1_id, artista2_id) values (5, 6);

-- Insert usuari_segueix_artistes
insert into `spotify`.`usuari_segueix_artistes`(usuari_id, artista_id) 
values(LAST_INSERT_ID(),2);

-- Insert albums
insert into `spotify`.`albums`(id_album, titol, any_publicacio, artista_id)
values(1, 'Muntanyes', 1993, 4);
insert into `spotify`.`albums`(id_album, titol, any_publicacio, artista_id)
values(2, 'Amors enyorats', 1985, 1);
insert into `spotify`.`albums`(id_album, titol, any_publicacio, artista_id)
values(3, 'Festa Major', 1986, 5);

-- Insert cançons
insert into `spotify`.`cancons`(id_canco, titol, durada, num_reproduccions, album_id)
values (1, 'Canigó', 483, 10099, 1);
insert into `spotify`.`cancons`(id_canco, titol, durada, num_reproduccions, album_id)
values (2, 'Pica', 343, 9008, 1);
insert into `spotify`.`cancons`(id_canco, titol, durada, num_reproduccions, album_id)
values (3, 'Julieta', 311, 14000, 2);
insert into `spotify`.`cancons`(id_canco, titol, durada, num_reproduccions, album_id)
values (4, 'Estimada', 296, 99999, 2);
insert into `spotify`.`cancons`(id_canco, titol, durada, num_reproduccions, album_id)
values (5, 'Trontolla', 184, 1992, 3);

-- Insert llistes reproducció
insert into `spotify`.`llistes_reproduccio`(
id_llista_reproduccio,
titol,
num_cancons,
creador_id)
values (1, 'Les meves', 3, 1);
insert into `spotify`.`llistes_reproduccio`(
id_llista_reproduccio,
titol,
num_cancons,
creador_id)
values (2, 'Per a ballar', 2, 2);

-- Insert llista_reproduccio te cancons

insert into `spotify`.`llista_reproduccio_te_cancons`(
llista_reproduccio_id,
canco_id)
values(1, 1);
insert into `spotify`.`llista_reproduccio_te_cancons`(
llista_reproduccio_id,
canco_id)
values(1, 3);
insert into `spotify`.`llista_reproduccio_te_cancons`(
llista_reproduccio_id,
canco_id)
values(2, 1);
insert into `spotify`.`llista_reproduccio_te_cancons`(
llista_reproduccio_id,
canco_id)
values(2, 2);
insert into `spotify`.`llista_reproduccio_te_cancons`(
llista_reproduccio_id,
canco_id)
values(2, 4);

-- Insert llistes reproducció compartides
-- La llista 1, creada per l'usuari 1, és compartida
-- amb els usuaris 2 i 3
insert into `spotify`.`llistes_reproduccio_compartides`(
id_llista_reproduccio_compartida,
usuari_id,
llistes_reproduccio_id)
values(1, 3, 1);
insert into `spotify`.`llistes_reproduccio_compartides`(
id_llista_reproduccio_compartida,
usuari_id,
llistes_reproduccio_id)
values(2, 2, 1);

-- Insert a llista compartida té cançons
-- el valor per defecte del timestamp s'aplica
insert into `spotify`.`llista_compartida_te_cancons`(
id,
llista_compartida_id,
canco_id)
values(1,1,1);
insert into `spotify`.`llista_compartida_te_cancons`(
id,
llista_compartida_id,
canco_id)
values(2,1,3);

-- Insert cançons preferides
insert into `spotify`.`cancons_preferides`(usuari_id, canco_id)
values(2,1);
insert into `spotify`.`cancons_preferides`(usuari_id, canco_id)
values(2,2);
insert into `spotify`.`cancons_preferides`(usuari_id, canco_id)
values(1,3);
insert into `spotify`.`cancons_preferides`(usuari_id, canco_id)
values(1,4);

-- Insert into albums preferits
insert into `spotify`.`albums_preferits`(usuari_id, album_id)
values(1,2);
insert into `spotify`.`albums_preferits`(usuari_id, album_id)
values(2,1);
