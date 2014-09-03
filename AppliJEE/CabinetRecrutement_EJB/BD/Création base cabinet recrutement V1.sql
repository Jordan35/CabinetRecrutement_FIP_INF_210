-- Titre :             Création base cabinet recrutement V1.sql
-- Version :           0.1
-- Date création :     28 juin 2011
-- Date modification : 28 juin 2011
-- Auteur :            Philippe Tanguy
-- Description :       Script de création de la base de données pour le SI "gestion de cabinet de
--                     recrutement"
--                     Note : script pour PostgreSQL 8.4
--                     Version 1 : cette version ne prend pas en compte la gestion des demandes
--                     d'entretien entre les entreprises et les candidats (messages) ni
--                     l'obsolescence des candidatures et des offres d'emploi.

-- +----------------------------------------------------------------------------------------------+
-- | Suppression des tables                                                                       |
-- +----------------------------------------------------------------------------------------------+

drop table if exists "secteur_activite_offre";
drop table if exists "secteur_activite_candidature";
drop table if exists "offre_emploi";
drop table if exists "entreprise";
drop table if exists "candidature";
drop table if exists "secteur_activite";
drop table if exists "niveau_qualification";

-- +----------------------------------------------------------------------------------------------+
-- | Création des tables                                                                          |
-- +----------------------------------------------------------------------------------------------+

create table "secteur_activite"
(
  id       serial primary key,
  intitule varchar(50) not null
);

create table "niveau_qualification"
(
  id       serial primary key,
  intitule varchar(50) not null
);

create table "entreprise"
(
  id              serial primary key,
  nom             varchar(50) not null,
  descriptif      text,
  adresse_postale varchar(30) -- Pour simplifier, adresse_postale = ville.
);

create table "offre_emploi"
(
  id                      serial primary key,
  titre                   varchar(50) not null,
  descriptif_mission      text,
  profil_recherche        text,
  date_depot              date,
  id_entreprise           integer not null references "entreprise",
  id_niveau_qualification integer not null references "niveau_qualification"
);

create table "secteur_activite_offre"
(
  id_offre_emploi     integer not null references "offre_emploi",
  id_secteur_activite integer not null references "secteur_activite",
  primary key (id_offre_emploi,id_secteur_activite)
);
  
create table "candidature"
(
  id serial primary key,
  nom varchar(50) not null,
  prenom varchar(50),
  date_naissance date,
  adresse_postale varchar(30), -- Pour simplifier, adresse_postale = ville.
  adresse_email   varchar(100),
  cv              text,
  date_depot      date,
  id_niveau_qualification integer not null references "niveau_qualification"
);

create table "secteur_activite_candidature"
(
  id_candidature      integer not null references "candidature",
  id_secteur_activite integer not null references "secteur_activite",
  primary key (id_candidature,id_secteur_activite)
);

-- +----------------------------------------------------------------------------------------------+
-- | Insertion de quelques données de pour les tests                                              |
-- +----------------------------------------------------------------------------------------------+

-- Insertion des secteurs d'activité

insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Achats/Logistique');                  --  1
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Assistanat/Secrétariat');             --  2
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Agriculture');                        --  3
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Agroalimentaire');                    --  4
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Assurance');                          --  5
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Audit/Conseil/Expertises');           --  6
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'BTP/Immobilier');                     --  7
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Commercial');                         --  8
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Communication/Art/Média/Mode');       --  9
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Comptabilité');                       -- 10
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Direction Générale/Executive');       -- 11
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Distribution/Commerce');              -- 12
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Electronique/Microélectronique');     -- 13
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Environnement');                      -- 14
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Finance/Banque');                     -- 15
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Formation/Enseignement');             -- 16
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Hôtellerie/Restauration/Tourisme');   -- 17
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Industrie/Ingénierie/Production');    -- 18
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Informatique');                       -- 19
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Juridique/Fiscal/Droit');             -- 20
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Marketing');                          -- 21
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Public/Parapublic');                  -- 22
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Ressources Humaines');                -- 23
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Santé/Social/Biologie/Humanitaire');  -- 24
insert into "secteur_activite" values (nextval('secteur_activite_id_seq'),'Télécom/Réseaux');                    -- 25

-- Insertion des niveaux de qualification

insert into "niveau_qualification" values (nextval('niveau_qualification_id_seq'),'CAP/BEP');   --  1
insert into "niveau_qualification" values (nextval('niveau_qualification_id_seq'),'Bac');       --  2
insert into "niveau_qualification" values (nextval('niveau_qualification_id_seq'),'Bac+3');     --  3
insert into "niveau_qualification" values (nextval('niveau_qualification_id_seq'),'Bac+5');     --  4
insert into "niveau_qualification" values (nextval('niveau_qualification_id_seq'),'Doctorat');  --  5
