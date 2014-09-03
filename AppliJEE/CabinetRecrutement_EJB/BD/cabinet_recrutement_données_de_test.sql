delete from message_candidature;
delete from message_offre_emploi;
delete from secteur_activite_offre;
delete from secteur_activite_candidature;
delete from candidature;
delete from offre_emploi;
delete from entreprise;

SELECT pg_catalog.setval('candidature_id_seq', 5, true);
SELECT pg_catalog.setval('entreprise_id_seq', 2, true);
SELECT pg_catalog.setval('message_candidature_id_seq', 12, true);
SELECT pg_catalog.setval('message_offre_emploi_id_seq', 21, true);
SELECT pg_catalog.setval('offre_emploi_id_seq', 10, true);

INSERT INTO candidature (id, nom, prenom, date_naissance, adresse_postale, adresse_email, cv, date_depot, id_niveau_qualification) VALUES (2, 'TOTO', 'Robert', '1111-11-11', 'BREST', 'robert.toto@gmail.com', '- Tagada
- Tsoin
- Tsoin
', '2011-07-07', 4);
INSERT INTO candidature (id, nom, prenom, date_naissance, adresse_postale, adresse_email, cv, date_depot, id_niveau_qualification) VALUES (3, 'M''OISELLE', 'Jeanne', '1111-11-11', 'BRUXELLES', 'moiselle.jeanne@telecom-bretagne.eu', 'A début petite et laide, elle apparaît uniquement comme prétexte à un gag où Gaston a besoin dune partenaire pour un costume de centaure pour un bal masqué. Cette partenaire doit avoir une queue de cheval.

Avec le temps, cette fille qui est instantanément tombée amoureuse de Gaston, sest embellie. Elle sest habillé un peu mieux et de plus en plus sexy, elle a prit soin de son apparence et est devenue jolie.

Gaston nest pas resté indifférent à Jeanne. Cest la seule femme à qui il va sintéresser et avec qui il va partager ses rêves. Tout restera toujours très platonique.
', '2011-07-07', 3);
INSERT INTO candidature (id, nom, prenom, date_naissance, adresse_postale, adresse_email, cv, date_depot, id_niveau_qualification) VALUES (1, 'TANGUY', 'Philippe', '1961-12-21', 'LE RELECQ-KERHUON', 'philippe.tanguy@telecom-bretagne.eu', 'Formation
=========

2002
  Diplôme dingénieur du Conservatoire National des Arts et Métiers,
  spécialité Informatique
  Centre régional associé de Brest
  Mention : très bien
  Sujet : réalisation dune plateforme de composition sémantique de dossiers
  thématiques de presse. Le travail présenté dans le mémoire dingénieur a été
  réalisé au sein du département IASC de lENST Bretagne dans le cadre du projet
  ICCARS dirigé par M. Serge Garlatti.

1999
  DEST CNAM (Diplôme dEtudes Supérieures Techniques)

1997
  DPCT CNAM (Diplôme de Premier Cycle Technique)

Expérience professionnelle
==========================

De janvier 2002 à juin 2009
  Cadre informatique et réseau
     Département LUSSI / TELECOM Bretagne
     Fonctions :
        - Développement logiciel sur les projets de recherche du département.
        - Participation aux activités denseignement (base de données, systèmes
          dinformation).
        - Correspondant informatique du département avec la DISI(support).

De juin 2000 à décembre 2001
  Développement logiciel
     CDD au département IASC / ENST Bretagne
     Travail dans le cadre du projet ICCARS (Integrated And Cooperative
      Computer-Assisted Reporting System)
        - Conception dun prototype daide à la composition de dossiers de
          presse thématiques personnalisés sur Internet.
     Chef de projet : Serge Garlatti
     Le travail effectué sur ce contrat a fait lobjet de mon mémoire
      dingénieur CNAM soutenu en juin 2002.

De septembre 1999 à avril 2000
  Développement logiciel
     CDD au département Informatique / ENST Bretagne
     Travail dans le cadre du projet européen MALTED (Multimedia Authoring for
      Language Tutors and Educational Development)
        - Etude et proposition dune architecture logicielle alternative basée
          sur des composants serveurs EJB.
     Chef de projet : Jean-Daniel Laisné

De septembre 1998 à juin 1999
  Développement logiciel
     CDD au département Informatique / ENST Bretagne
     Travail dans le cadre du projet européen AMUSEMENT
        - Développement en Java dune interface utilisateur permettant une
          communication multilingue.
     Chef de projet : Eric Cousin

De septembre 1990 à août 1998
  Instituteur
     Différentes écoles dans la région brestoise
     IUFM de Quimper de septembre 1990 à juin 1992

De septembre 1983 à août 1990
  Infirmier de secteur psychiatrique
     CHR Brest (hôpital de Bohars)
     Centre de formation de lhôpital de Bohars de septembre 1983 à juin 1986
', '2011-07-07', 4);

INSERT INTO entreprise (id, nom, descriptif, adresse_postale) VALUES (2, 'ENIB', 'Une autre école d''ingénieurs juste à côté...', 'PLOUZANÉ');
INSERT INTO entreprise (id, nom, descriptif, adresse_postale) VALUES (1, 'TÉLÉCOM Bretagne', 'En 30 ans depuis sa création, Télécom Bretagne s''est affirmée comme une Grande École pionnière en formation, en recherche et en entrepreneuriat. Elle forme des ingénieurs polyvalents et aptes à prendre des responsabilités importantes. Reconnue pour son dynamisme, sa très grande ouverture internationale, Télécom Bretagne a noué des partenariats avec plus de 50 établissements d''enseignement supérieur et de recherche à travers le monde. Elle collabore avec le MIT, l''École Polytechnique fédérale de Lausanne sur l''innovation pédagogique.

Plus d''un millier délèves, issus de 40 pays suivent une formation d''ingénieur, de master, de doctorat ou de mastère spécialisé sur deux campus d''exception au cur de technopôles très actifs.

Parmi les 300 personnels permanents de Télécom Bretagne, les 160 enseignants-chercheurs reçoivent régulièrement les plus hautes distinctions pour leur contribution à l''avancée de la Recherche dans leur domaine de spécialité. Plusieurs vont même jusqu''à la valorisation industrielle de leurs résultats et ont créé des entreprises solides qui irriguent le tissu économique local, régional ou national.

Télécom Bretagne est un acteur important de la valorisation de la Recherche à travers ses multiples partenariats et réseaux (vice présidence de l''Université européenne de Bretagne, des pôles de compétitivité Images & réseaux et Mer). Elle a créé plusieurs laboratoires mixtes avec le CNRS, l''Inserm ou l''université. Elle collabore de près avec les industriels au travers de son Pôle de recherche avancée en communications (Pracom).

Tout notre personnel est fier de contribuer, au sein de l''Institut Télécom,  à former les cadres de demain qui auront à cur de créer de la richesse dans le respect de l''individu, de la planète et des valeurs humanistes de notre École.

Paul Friedel
Directeur', 'PLOUZANÉ');

INSERT INTO offre_emploi (id, titre, descriptif_mission, profil_recherche, date_depot, id_entreprise, id_niveau_qualification) VALUES (1, 'CDD jeune ingénieur', 'CDD jeune ingénieur : ingénierie des modèles, architecture des systèmes.

Le département Informatique de Télécom Bretagne à Brest (http://www.telecom-bretagne.eu/) recrute sur contrat à durée déterminée un jeune ingénieur.

La mission porte sur le une étude de l''optimisation du processus d''ingénierie des interfaces (systèmes, sous-systèmes, composants). Les applications cibles incluent notamment les systèmes temps-réel.

Début du contrat : octobre 2011
Durée du contrat : 4 à 6 mois
Formation requise : bac+5, diplômé en 2009 - 2011
Rémunération : 2 583  bruts mensuels
', 'Compétences et Profil :

    * formation en informatique et connaissances du développement logiciel et de l''outil Eclipse (et ses extensions gestionnaire de versions, compilation, documentation, tests, débogage, ) ;
    * bonne maîtrise du langage de modélisation UML ;
    * très bonne maitrise du langage de programmation Java ;
    * bonnes connaissances en applications distribuées (RMI, CORBA, etc.) ;
    * des connaissances en modélisation sous Eclipse (EMF, GMF) sont un plus ;
    * maîtrise de l''anglais technique et scientifique ;
    * bonnes aptitudes de communication ;
    * compétences ou aptitudes appréciées : capacité à travailler en équipe, curiosité vis-à-vis des techniques avancées de l''ingénierie du logiciel.

Les déclarations de candidature se font par mail à Antoine Beugnard (antoine.beugnard@telecombretagne.eu) avant le 7 septembre 2011 et contenant :

- CV détaillé,
- Recommandations

Pour tout renseignement complémentaire vous pouvez contacter Antoine Beugnard (antoine.beugnard@telecom-bretagne.eu)', '2011-07-07', 1, 4);
INSERT INTO offre_emploi (id, titre, descriptif_mission, profil_recherche, date_depot, id_entreprise, id_niveau_qualification) VALUES (6, 'Jardinier', 'S''occuper des jardins de l''ENIB.', 'CAP jardiner', '2011-07-09', 2, 1);
INSERT INTO offre_emploi (id, titre, descriptif_mission, profil_recherche, date_depot, id_entreprise, id_niveau_qualification) VALUES (2, 'CDD Secrétaire en gestion financière', 'Institut de rattachement : INSIS (Institut des sciences de l''ingénierie et des systèmes)

Institut secondaire : INS2I (Institut des sciences informatiques et de leurs interactions)

B.A.P. : J

CODE UNITE : 3192

EMPLOI-TYPE : Secrétaire en gestion financière et comptable

TITRE-FONCTION : Secrétaire en gestion financière, comptable et administrative

MISSION : Assurer auprès du Directeur et des Directeurs-adjoints de l''Unité l''assistance pour toutes les questions financières, comptables et administratives
ACTIVITES :

- Gérer les données Xlab

    * Création des fournisseurs et agents
    * Création des commandes, services faits, factures
    * Vérification des données (différences antre les données Xlab et Bfc)
    * Contacts avec la gestionnaire de la délégation (K. MOITTE)
    * Contacts avec les fournisseurs pour les commandes

- Gérer la comptabilité de l''Unité
- Gérer la base de données Labintel
- Création et suppression des agents dans la base
- Contacts avec les directeurs adjoints de lunité
- Contact avec les secrétaires des sites

- Suivre les dossiers issus de lINSIS
- Aider à la rédaction de rapport dactivités
- Rédaction de courriers pour le Directeur
- Suivi du courrier
- Tableaux de bord et indicateurs (personnel, budget, inventaire)
- Rédaction de compte rendu de réunions (conseil de laboratoire, bureau)', 'COMPÉTENCES :

- Xlab
- Labintel
- Excel , Word, Power Point
- Anglais

CONTEXTE :

Le laboratoire est multi site (deux sites à Brest, un site à Lorient, un site à Vannes). Le poste sera basé à Brest Télécom Bretagne. La personne recrutée pourra être amenée à effectuer des déplacements dans les autres sites dans le cadre de réunions.

Contact et dépôt des candidatures (CV + lettre de motivation) auprès de :', '2011-07-07', 1, 3);
INSERT INTO offre_emploi (id, titre, descriptif_mission, profil_recherche, date_depot, id_entreprise, id_niveau_qualification) VALUES (3, 'TEST', 'TEST', 'Glop !', '2011-07-08', 1, 3);

INSERT INTO message_candidature (id, id_source, id_destination, date_envoi, corps) VALUES (1, 1, 1, '2011-07-07', 'Coucou, je suis bien intéressé par cette offre alléchante au plus haut point !!!');
INSERT INTO message_candidature (id, id_source, id_destination, date_envoi, corps) VALUES (2, 2, 1, '2011-07-07', 'Y''a pas que Philippe TANGUY qui compte !!! Moi aussi je suis intéressé...');
INSERT INTO message_candidature (id, id_source, id_destination, date_envoi, corps) VALUES (3, 1, 2, '2011-07-07', 'J''ai pas le profil, mais je suis intéressé tout de même.');
INSERT INTO message_candidature (id, id_source, id_destination, date_envoi, corps) VALUES (4, 1, 2, '2011-07-07', 'sdgfdfsdfsdf');
INSERT INTO message_candidature (id, id_source, id_destination, date_envoi, corps) VALUES (5, 1, 1, '2011-07-07', 'Coucou, c''est moi, qu''est-ce que tu fais ce soir ???');
INSERT INTO message_candidature (id, id_source, id_destination, date_envoi, corps) VALUES (6, 3, 2, '2011-07-08', 'zouzou');
INSERT INTO message_candidature (id, id_source, id_destination, date_envoi, corps) VALUES (7, 3, 2, '2011-07-08', 'zaza');
INSERT INTO message_candidature (id, id_source, id_destination, date_envoi, corps) VALUES (8, 1, 1, '2011-07-08', 'toto titi tata');
INSERT INTO message_candidature (id, id_source, id_destination, date_envoi, corps) VALUES (9, 1, 1, '2011-07-08', 'tutu la mouche');
INSERT INTO message_candidature (id, id_source, id_destination, date_envoi, corps) VALUES (10, 3, 2, '2011-07-08', 'dfdfhq r rehy qert qer t');
INSERT INTO message_candidature (id, id_source, id_destination, date_envoi, corps) VALUES (11, 2, 1, '2011-07-08', 'zeazeaze');

INSERT INTO message_offre_emploi (id, id_source, id_destination, date_envoi, corps) VALUES (1, 1, 2, '2011-07-07', 'Toto, une petite histoire ?');
INSERT INTO message_offre_emploi (id, id_source, id_destination, date_envoi, corps) VALUES (2, 2, 3, '2011-07-07', 'Besoin d''un petit boulot mal payé et fatigant ?');
INSERT INTO message_offre_emploi (id, id_source, id_destination, date_envoi, corps) VALUES (3, 2, 3, '2011-07-08', 'Alors ???....');
INSERT INTO message_offre_emploi (id, id_source, id_destination, date_envoi, corps) VALUES (4, 2, 3, '2011-07-08', 'ggggggg');
INSERT INTO message_offre_emploi (id, id_source, id_destination, date_envoi, corps) VALUES (5, 2, 3, '2011-07-08', 'llllllllllll');
INSERT INTO message_offre_emploi (id, id_source, id_destination, date_envoi, corps) VALUES (6, 2, 3, '2011-07-08', 'Coucou.......');
INSERT INTO message_offre_emploi (id, id_source, id_destination, date_envoi, corps) VALUES (7, 2, 3, '2011-07-08', 'toto la mouche');
INSERT INTO message_offre_emploi (id, id_source, id_destination, date_envoi, corps) VALUES (8, 2, 3, '2011-07-08', 'tagada');
INSERT INTO message_offre_emploi (id, id_source, id_destination, date_envoi, corps) VALUES (9, 2, 3, '2011-07-08', 'tsoin tsoin');
INSERT INTO message_offre_emploi (id, id_source, id_destination, date_envoi, corps) VALUES (10, 2, 3, '2011-07-08', 'dfsdfsdfsdfsdf');
INSERT INTO message_offre_emploi (id, id_source, id_destination, date_envoi, corps) VALUES (11, 2, 3, '2011-07-08', 'szdqsdqsd');
INSERT INTO message_offre_emploi (id, id_source, id_destination, date_envoi, corps) VALUES (12, 2, 3, '2011-07-08', 'pppppppppppppppppppppppppppppp');
INSERT INTO message_offre_emploi (id, id_source, id_destination, date_envoi, corps) VALUES (13, 2, 3, '2011-07-08', 'cvwcv zrgfrgg gre rgere

sezserz

zerz');
INSERT INTO message_offre_emploi (id, id_source, id_destination, date_envoi, corps) VALUES (14, 2, 3, '2011-07-08', 'sqdqsdq

vbnvb
');
INSERT INTO message_offre_emploi (id, id_source, id_destination, date_envoi, corps) VALUES (15, 2, 3, '2011-07-08', 'gfsgsdgsdf');
INSERT INTO message_offre_emploi (id, id_source, id_destination, date_envoi, corps) VALUES (16, 2, 3, '2011-07-08', '7777777');
INSERT INTO message_offre_emploi (id, id_source, id_destination, date_envoi, corps) VALUES (17, 2, 3, '2011-07-08', 'turlututu');
INSERT INTO message_offre_emploi (id, id_source, id_destination, date_envoi, corps) VALUES (18, 2, 3, '2011-07-08', 'chapeau pointu');

INSERT INTO secteur_activite_candidature (id_candidature, id_secteur_activite) VALUES (1, 16);
INSERT INTO secteur_activite_candidature (id_candidature, id_secteur_activite) VALUES (1, 19);
INSERT INTO secteur_activite_candidature (id_candidature, id_secteur_activite) VALUES (1, 18);
INSERT INTO secteur_activite_candidature (id_candidature, id_secteur_activite) VALUES (1, 22);
INSERT INTO secteur_activite_candidature (id_candidature, id_secteur_activite) VALUES (1, 25);
INSERT INTO secteur_activite_candidature (id_candidature, id_secteur_activite) VALUES (2, 19);
INSERT INTO secteur_activite_candidature (id_candidature, id_secteur_activite) VALUES (2, 3);
INSERT INTO secteur_activite_candidature (id_candidature, id_secteur_activite) VALUES (2, 8);
INSERT INTO secteur_activite_candidature (id_candidature, id_secteur_activite) VALUES (3, 2);
INSERT INTO secteur_activite_candidature (id_candidature, id_secteur_activite) VALUES (3, 23);
INSERT INTO secteur_activite_candidature (id_candidature, id_secteur_activite) VALUES (3, 22);
INSERT INTO secteur_activite_candidature (id_candidature, id_secteur_activite) VALUES (3, 8);
INSERT INTO secteur_activite_candidature (id_candidature, id_secteur_activite) VALUES (1, 3);

INSERT INTO secteur_activite_offre (id_offre_emploi, id_secteur_activite) VALUES (1, 19);
INSERT INTO secteur_activite_offre (id_offre_emploi, id_secteur_activite) VALUES (2, 2);
INSERT INTO secteur_activite_offre (id_offre_emploi, id_secteur_activite) VALUES (2, 22);
INSERT INTO secteur_activite_offre (id_offre_emploi, id_secteur_activite) VALUES (2, 10);
INSERT INTO secteur_activite_offre (id_offre_emploi, id_secteur_activite) VALUES (3, 10);
INSERT INTO secteur_activite_offre (id_offre_emploi, id_secteur_activite) VALUES (6, 3);
INSERT INTO secteur_activite_offre (id_offre_emploi, id_secteur_activite) VALUES (3, 2);
