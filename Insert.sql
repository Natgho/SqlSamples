
CREATE TABLE Kullanicilar(
ad NVARCHAR(25) NOT NULL,
soyad NVARCHAR(25) NOT NULL,
sifre VARCHAR(25) NOT NULL,
TC VARCHAR(11) PRIMARY KEY,
);

CREATE TABLE Iletisim(
iletisim_no INT PRIMARY KEY IDENTITY(1,1),
mail VARCHAR(100) UNIQUE,
adres NVARCHAR(100),
telefon VARCHAR(15),
TC VARCHAR(11),
FOREIGN KEY (TC) REFERENCES Kullanicilar(TC),
);

CREATE TABLE Akademisyen(
personel_no VARCHAR(11) PRIMARY KEY,
TC VARCHAR(11),
FOREIGN KEY (TC) REFERENCES Kullanicilar(TC)
);

CREATE TABLE Ogrenci(
ogrenci_no VARCHAR(11) PRIMARY KEY,
TC VARCHAR(11),
FOREIGN KEY (TC) REFERENCES Kullanicilar(TC)
);

CREATE TABLE Mesaj(
mesaj_kodu INT PRIMARY KEY IDENTITY(1,1),
konusu NVARCHAR(50) NOT NULL,
aciklama NVARCHAR(500),
gonderilme_tarihi DATE DEFAULT(GETDATE()),
okunma_tarihi DATE,
TCgonderen VARCHAR(11),
TCalan VARCHAR(11),
FOREIGN KEY (TCgonderen) REFERENCES Kullanicilar(TC),
FOREIGN KEY (TCalan) REFERENCES Kullanicilar(TC),
);

CREATE TABLE Duyuru(
duyuru_no INT PRIMARY KEY IDENTITY(1,1),
duyuru_basligi NVARCHAR(50) NOT NULL,
aciklama NVARCHAR(500),
duyuru_tarihi DATE DEFAULT (GETDATE()),
);

CREATE TABLE DuyuruGoruntulenme(
goruntulendigi_tarih DATE,
duyuru_no INT,
TC VARCHAR(11),
FOREIGN KEY(duyuru_no) REFERENCES Duyuru(duyuru_no),
FOREIGN KEY(TC) REFERENCES Kullanicilar(TC),
);

CREATE TABLE Ders(
ders_kodu INT PRIMARY KEY,
ders_adi NVARCHAR(50) NOT NULL,
kredi INT CHECK (kredi > 0 AND kredi < 10),
);

CREATE TABLE DersAlma(
donem NVARCHAR(5) NOT NULL,
ogretim_yili NVARCHAR(10) NOT NULL,
ders_kodu INT,
ogrenci_no VARCHAR(11),
FOREIGN KEY(ders_kodu) REFERENCES Ders(ders_kodu),
FOREIGN KEY(ogrenci_no) REFERENCES Ogrenci(ogrenci_no),
);

CREATE TABLE DersVerme(
donem NVARCHAR(5) NOT NULL,
ogretim_yili NVARCHAR(10) NOT NULL,
ders_kodu INT,
personel_no VARCHAR(11),
FOREIGN KEY(ders_kodu) REFERENCES Ders(ders_kodu),
FOREIGN KEY(personel_no) REFERENCES Akademisyen(personel_no),
);

CREATE TABLE Dokuman(
dokuman_no INT PRIMARY KEY IDENTITY (1,1),
dokuman_turu NVARCHAR(10),
aciklama NVARCHAR(50),
ders_kodu INT,
FOREIGN KEY(ders_kodu) REFERENCES Ders(ders_kodu),
);

CREATE TABLE OgrenciDokumanTakip (
goruntulenme_tarihi DATE,
dokuman_no INT,
ogrenci_no VARCHAR(11)
FOREIGN KEY(ogrenci_no) REFERENCES Ogrenci(ogrenci_no),
FOREIGN KEY(dokuman_no) REFERENCES Dokuman(dokuman_no),
);

CREATE TABLE SinavTipi (
sinav_tipi_no INT PRIMARY KEY IDENTITY(1,1),
sinav_turu NVARCHAR(10),
);

CREATE TABLE Sinav(
sinav_kodu INT PRIMARY KEY IDENTITY(1,1),
aciklama NVARCHAR(100),
sinav_basligi NVARCHAR(100) NOT NULL,
tarih DATE,
ders_kodu INT,
sinav_tipi_no INT,
FOREIGN KEY(sinav_tipi_no) REFERENCES SinavTipi(sinav_tipi_no),
FOREIGN KEY(ders_kodu) REFERENCES Ders(ders_kodu),
);

CREATE TABLE SinavaGirme(
sinav_kodu INT,
ogrenci_no VARCHAR(11),
sinav_notu INT CHECK(sinav_notu >= 0 AND sinav_notu <= 100),
FOREIGN KEY(sinav_kodu) REFERENCES Sinav(sinav_kodu),
FOREIGN KEY(ogrenci_no) REFERENCES Ogrenci(ogrenci_no),
);

CREATE TABLE Soru(
soru_no INT PRIMARY KEY IDENTITY (1,1),
aciklama NVARCHAR(300) NOT NULL,
dogru_cevap NVARCHAR(300) NOT NULL,
);


CREATE TABLE SinavOlusturma(
sinav_kodu INT,
soru_no INT,
FOREIGN KEY (sinav_kodu) REFERENCES Sinav(sinav_kodu),
FOREIGN KEY (soru_no) REFERENCES Soru(soru_no),
);

CREATE TABLE Celdirici(
yanlis_cevap_no INT PRIMARY KEY IDENTITY(1,1),
yanlis_cevap NVARCHAR(300) NOT NULL,
soru_no INT,
FOREIGN KEY(soru_no) REFERENCES Soru(soru_no),
);

GO

INSERT INTO Kullanicilar VALUES('El�in','Haktan�r',111,'69548532015')
INSERT INTO Kullanicilar VALUES('Buse Irmak','Baysal',112,'75258859889')
INSERT INTO Kullanicilar VALUES('Ahmet','Okur',113,'53547387382')
INSERT INTO Kullanicilar VALUES('Beyza','�ardak',114,58421642619)
INSERT INTO Kullanicilar VALUES('Burak','Eraslan',115,87512765216)
INSERT INTO Kullanicilar VALUES('Dilara','Demircan',116,25149721667)
INSERT INTO Kullanicilar VALUES('Eda','�atamak',117,12571649567)
INSERT INTO Kullanicilar VALUES('�lker','Epik',118,26545256429)
INSERT INTO Kullanicilar VALUES('Sezer Yavuzer','Bozk�r',119,95164214664)
INSERT INTO Kullanicilar VALUES('�sa','Demir',120,15242497912)
INSERT INTO Kullanicilar VALUES('Talha','Erdo�an',121,26146249297)
INSERT INTO Kullanicilar VALUES('Esma �i�dem','Yaman',122,61586559856)
INSERT INTO Kullanicilar VALUES('Ebru','Adar',123,65189123125)
INSERT INTO Kullanicilar VALUES('Dilara','G�z�b�y�k',124,78465131516)
INSERT INTO Kullanicilar VALUES('Damla','Ta�ar',125,75123669565)
INSERT INTO Kullanicilar VALUES('Gizem','Sayalan',126,45220321520)
INSERT INTO Kullanicilar VALUES('Fatih','Tayar',127,96558695423)
INSERT INTO Kullanicilar VALUES('�eyma','Arslan',128,62417642762)
INSERT INTO Kullanicilar VALUES('�eyma','Ert�rk',129,67524126472)
INSERT INTO Kullanicilar VALUES('Bet�l','�ak�r',130,57247617458)
INSERT INTO Kullanicilar VALUES('Seher','Y�lmaz',948,52472679752)
INSERT INTO Kullanicilar VALUES('Onur','Erg�l',948,46526429792)
INSERT INTO Kullanicilar VALUES('Esma','G�ne�er',948,33641971557)
INSERT INTO Kullanicilar VALUES('Sultan','Kalkan',948,75196759791)
INSERT INTO Kullanicilar VALUES('Hacer','�nci',948,26145605210)
INSERT INTO Kullanicilar VALUES('�eyma','Yeti�en',948,97517547529)
INSERT INTO Kullanicilar VALUES('K�bra','Akkoyun',948,12758191725)
INSERT INTO Kullanicilar VALUES('Nagihan','�amo�lu',948,81752812556)
INSERT INTO Kullanicilar VALUES('Selin','T�rk',948,19551915851)
INSERT INTO Kullanicilar VALUES('Beyza','�al��kan',948,21761205789)

--AKADEM�SYEN

INSERT INTO Kullanicilar VALUES('M�fit','�etin',210,46548965256)
INSERT INTO Kullanicilar VALUES('Ahmet','Akba�',211,49865489465)
INSERT INTO Kullanicilar VALUES('Ya�ar','Becerikli',212,36985698569)
INSERT INTO Kullanicilar VALUES('Ali','�skurt',213,48626582354)
INSERT INTO Kullanicilar VALUES('Murat','G�k',214,58212355623)
INSERT INTO Kullanicilar VALUES('Necla','Band�rmal�',215,45230023256)
INSERT INTO Kullanicilar VALUES('Osman Hilmi','Ko�al',216,58632596325)
INSERT INTO Kullanicilar VALUES('Adem','Tuncer',217,48625652038)
INSERT INTO Kullanicilar VALUES('Esra','Pek�n�r',218,45896220569)
INSERT INTO Kullanicilar VALUES('Yunus','�zen',219,48526625963)
INSERT INTO Kullanicilar VALUES('Muhammed','Tekin',220,14586369525)
INSERT INTO Kullanicilar VALUES('Muaz','G�ltekin',221,58525102520)
INSERT INTO Kullanicilar VALUES('H�seyin','Savran',222,45852025286)
INSERT INTO Kullanicilar VALUES('Cafer','Avc�',223,65620363363)
INSERT INTO Kullanicilar VALUES('G�ne�','Harman',224,25205636258)
INSERT INTO Kullanicilar VALUES('�rfan','K�sesoy',225,25662459635)
INSERT INTO Kullanicilar VALUES('�brahim','Deliba�o�lu',226,20258412366)
INSERT INTO Kullanicilar VALUES('Fatih','Aslan',227,25202525625)
INSERT INTO Kullanicilar VALUES('Burcu','Okkal�o�lu',228,25895654896)
INSERT INTO Kullanicilar VALUES('Murat','Okkal�o�lu',229,48525485629)


INSERT INTO Akademisyen VALUES(15101030001,46548965256)
INSERT INTO Akademisyen VALUES(15101030002,49865489465)
INSERT INTO Akademisyen VALUES(15101030003,36985698569)
INSERT INTO Akademisyen VALUES(15101030004,48626582354)
INSERT INTO Akademisyen VALUES(15101030005,58212355623)
INSERT INTO Akademisyen VALUES(15101030006,45230023256)
INSERT INTO Akademisyen VALUES(15101030007,58632596325)
INSERT INTO Akademisyen VALUES(15101030008,48625652038)
INSERT INTO Akademisyen VALUES(15101030009,45896220569)
INSERT INTO Akademisyen VALUES(15101030010,48526625963)
INSERT INTO Akademisyen VALUES(15101030011,14586369525)
INSERT INTO Akademisyen VALUES(15101030012,58525102520)
INSERT INTO Akademisyen VALUES(15101030013,45852025286)
INSERT INTO Akademisyen VALUES(15101030014,65620363363)
INSERT INTO Akademisyen VALUES(15101030015,25205636258)
INSERT INTO Akademisyen VALUES(15101030016,25662459635)
INSERT INTO Akademisyen VALUES(15101030017,20258412366)
INSERT INTO Akademisyen VALUES(15101030018,25202525625)
INSERT INTO Akademisyen VALUES(15101030019,25895654896)
INSERT INTO Akademisyen VALUES(15101030020,48525485629)

INSERT INTO Ogrenci VALUES(12001010001,69548532015)
INSERT INTO Ogrenci VALUES(12001010002,75258859889)
INSERT INTO Ogrenci VALUES(12001010003,53547387382)
INSERT INTO Ogrenci VALUES(12001010004,58421642619)
INSERT INTO Ogrenci VALUES(12001010005,87512765216)
INSERT INTO Ogrenci VALUES(12001010006,25149721667)
INSERT INTO Ogrenci VALUES(12001010007,12571649567)
INSERT INTO Ogrenci VALUES(12001010008,26545256429)
INSERT INTO Ogrenci VALUES(12001010009,95164214664)
INSERT INTO Ogrenci VALUES(12001010010,15242497912)
INSERT INTO Ogrenci VALUES(12001010011,26146249297)
INSERT INTO Ogrenci VALUES(12001010012,61586559856)
INSERT INTO Ogrenci VALUES(12001010013,65189123125)
INSERT INTO Ogrenci VALUES(12001010014,78465131516)
INSERT INTO Ogrenci VALUES(12001010015,75123669565)
INSERT INTO Ogrenci VALUES(12001010016,45220321520)
INSERT INTO Ogrenci VALUES(12001010017,96558695423)
INSERT INTO Ogrenci VALUES(12001010018,62417642762)
INSERT INTO Ogrenci VALUES(12001010019,67524126472)
INSERT INTO Ogrenci VALUES(12001010020,57247617458)
INSERT INTO Ogrenci VALUES(12001010021,52472679752)
INSERT INTO Ogrenci VALUES(12001010022,46526429792)
INSERT INTO Ogrenci VALUES(12001010023,33641971557)
INSERT INTO Ogrenci VALUES(12001010024,75196759791)
INSERT INTO Ogrenci VALUES(12001010025,26145605210)
INSERT INTO Ogrenci VALUES(12001010026,97517547529)
INSERT INTO Ogrenci VALUES(12001010027,12758191725)
INSERT INTO Ogrenci VALUES(12001010028,81752812556)
INSERT INTO Ogrenci VALUES(12001010029,19551915851)
INSERT INTO Ogrenci VALUES(12001010030,21761205789)

INSERT INTO Iletisim VALUES('elcin.haktanir35@hotmail.com','1108 sok. 26/56 �zmir',50712367674,69548532015)
INSERT INTO Iletisim VALUES('buse.irmak.baysal@gmail.com','1166 sok. 26/56 Adana',5783459034,75258859889)
INSERT INTO Iletisim VALUES('ahmet.okur@gmail.com','k�smet sok. 226/556 �stanbul',5638496729,53547387382)
INSERT INTO Iletisim VALUES('beyza.cardak@gmail.com','aliye sok. 26/1 Ankara',5254687522,58421642619)
INSERT INTO Iletisim VALUES('burak.eraslan@gmail.com','narlidere cad. 2/2 Samsun',5246972557,87512765216)
INSERT INTO Iletisim VALUES('dilara.demircan@gmail.com','dere sok. 1/2 Sakarya',5657831024,25149721667)
INSERT INTO Iletisim VALUES('eda.catamak@gmail.com','sakar sok. 17/2 Yozgat',5654865354,12571649567)
INSERT INTO Iletisim VALUES('ilker.epik@gmail.com','keser sokak 45/6 Adana',5065425456,26545256429)
INSERT INTO Iletisim VALUES('sezer.yavuzer.bozkir@gmail.com',' 2/5 Yozgart',5065478214,95164214664)
INSERT INTO Iletisim VALUES('isa.demir@hotmail.de','saf sokak 6/5 Sivas',5026547966,15242497912)
INSERT INTO Iletisim VALUES('talha.erdogan@hotmail.com','erdo�an sokak No : 2 Samsun',5075989268,26146249297)
INSERT INTO Iletisim VALUES('esma.cigdem.yaman@hotmail.com','yaman sokak 26/56 Yalova',5074185296,61586559856)
INSERT INTO Iletisim VALUES('ebru.adar@gmail.com','k�sa sokak 1/1 Bal�kesir',5096385274,65189123125)
INSERT INTO Iletisim VALUES('dilara.gozubuyuk@gmail.com','kore sokak 6/1 Mardin',5075989268,78465131516)
INSERT INTO Iletisim VALUES('damla.tasar@hotmail.com','11 sok. 52/2 �zmir',5075989268,75123669565)
INSERT INTO Iletisim VALUES('gizem.sayalan@gmail.com','48 sok. 26/56 Kocaeli',5045625789,45220321520)
INSERT INTO Iletisim VALUES('fatih.tayar@gmail.com','tay sokak 26/56 �zmit',5077531598,96558695423)
INSERT INTO Iletisim VALUES('seyma.erturk@hotmail.com','t�rk sokak 26/56 �zmir',5074511225,67524126472)
INSERT INTO Iletisim VALUES('seyma.arslan@gmail.com','arslan sokak 26/56 �zmir',5075989268,62417642762)
INSERT INTO Iletisim VALUES('betul.cakir@hotmail.com','cakir sokak 26/56 Ayd�n',5075989268,57247617458)

INSERT INTO Iletisim VALUES('mufit.cetin@gmail.com','12 sok. No:26 Yalova',5074662148,46548965256)
INSERT INTO Iletisim VALUES('ahmet.akbas@hotmail.com','24 sok. 1/6 Bursa',5048425476,49865489465)
INSERT INTO Iletisim VALUES('yasar.becerikli@gmail.com','23 sok. 26/56 Yalova',5070236478,36985698569)
INSERT INTO Iletisim VALUES('ali.iskurt@hotmail.com','423 sok. 26/56 �stanbul',5072003584,48626582354)
INSERT INTO Iletisim VALUES('murat.gok@gmail.com','234 sok. 26/56 Ankara',5076258464,58212355623)
INSERT INTO Iletisim VALUES('necla.bandirmali@hotmail.com','23 sok. 2/6 Bal�kesir',5072846396,45230023256)
INSERT INTO Iletisim VALUES('osman.hilmi.kocal@hotmail.com','45 sok. 26/56 Yalova',5552555599,58632596325)
INSERT INTO Iletisim VALUES('adem.tuncer@gmail.com','123 sok. 3/6 Yalova',5074752668,48625652038)
INSERT INTO Iletisim VALUES('esra.pekonur@hotmail.com','1108 sok. 12/3 Yalova',5011235265,45896220569)
INSERT INTO Iletisim VALUES('yunus.ozen@gmail.com','523 sok. 26/56 Yalova',5074612347,48526625963)
INSERT INTO Iletisim VALUES('muhammed.tekin@gmail.com','1255 sok. 2/52 Ayd�n',5085674826,14586369525)
INSERT INTO Iletisim VALUES('muaz.gultekin@hotmail.com','112 sok. 26/56 Yalova',5551594826,58525102520)
INSERT INTO Iletisim VALUES('huseyin.savran@gmail.com','1258 sok. 2/5 Yalova',5452684591,45852025286)
INSERT INTO Iletisim VALUES('cafer.avci@hotmail.com','2208 sok. 26/56 Yalova',5445926184,65620363363)
INSERT INTO Iletisim VALUES('gunes.harman@hotmail.com','228 sok. 26/56 Yalova',5232346725,25205636258)
INSERT INTO Iletisim VALUES('irfan.kosesoy@hotmail.com','128 sok. 26/56 Yalova',5074815263,25662459635)
INSERT INTO Iletisim VALUES('ibrahim.delibasoglu@hotmail.com','1108 sok. 26/56 �zmir',5045962481,20258412366)
INSERT INTO Iletisim VALUES('fatih.aslan@hotmail.com','208 sok. 26/56 Yalova',5077635626,25202525625)
INSERT INTO Iletisim VALUES('burcu.okkalioglu@gtmail.com','108 sok. 26/56 Yalova',5055012647,25895654896)
INSERT INTO Iletisim VALUES('murat.okkalioglu@hotmail.com','1108 sok. 26/56 Yalova',5552454562,48525485629)
INSERT INTO Iletisim VALUES('beya_caliskan@hotmail.com',NULL,	NULL,21761205789)
INSERT INTO Iletisim VALUES('sein_turk@hotmail.com',NULL,		05075989268,19551915851)
INSERT INTO Iletisim VALUES('ngi_han@hotmail.com','08 sok. 26/56 �stanbul',			05075989268,81752812556)
INSERT INTO Iletisim VALUES('ubra_koyun@hotmail.com',NULL,		05075989268,12758191725)
INSERT INTO Iletisim VALUES('syma_yetisen@hotmail.com','1108 sok. 26/56 �stanbul',		05075989268,97517547529)
INSERT INTO Iletisim VALUES('hcer_inci@hotmail.com','08 sok. 26/56 Ankara',		NULL,26145605210)
INSERT INTO Iletisim VALUES('sltan_kalkan@hotmail.com','1108 sok. 26/56 �zmir',		05075989268,75196759791)
INSERT INTO Iletisim VALUES('esm_gunes@hotmail.com',NULL,		05075989268,33641971557)
INSERT INTO Iletisim VALUES('onr_ergul@hotmail.com','1108 sok. 26/56 �zmir',		05075989268,46526429792)
INSERT INTO Iletisim VALUES('sher_yilmaz@hotmail.com','1108 sok. 26/56 Ankara',		05075989268,52472679752)
INSERT INTO Iletisim VALUES('btul_cakir@hotmail.com','1108 sok. 26/56 �stanbul',		NULL,57247617458)
INSERT INTO Iletisim VALUES('syma_turk@hotmail.com','18 sok. 26/56 �zmir',		NULL,67524126472)
INSERT INTO Iletisim VALUES('syma_slan@hotmail.com',NULL,		05075989268,62417642762)
INSERT INTO Iletisim VALUES('fath_tayr@hotmail.com','18 sok. 26/56 Ankara',		05075989268,96558695423)
INSERT INTO Iletisim VALUES('gzm_sayalan@hotmail.com','1108 sok. 26/56 �stanbul',		05075989268,45220321520)
INSERT INTO Iletisim VALUES('ebru.adar@hotmail.com',NULL,		NULL,65189123125)
INSERT INTO Iletisim VALUES('tlha_erdogan@hotmail.com',NULL,		05075989268,26146249297)
INSERT INTO Iletisim VALUES('isaaa_Demir@hotmail.com','1108 sok. 26/56 �zmir',		05075989268,15242497912)
INSERT INTO Iletisim VALUES('sezer_ozkir@hotmail.com',NULL,		NULL,95164214664)
INSERT INTO Iletisim VALUES('ilkr.pk@hotmail.com',NULL,			05075989268,26545256429)
INSERT INTO Iletisim VALUES('eda.at@hotmail.com','1108 sok. 26/56 Ankara',			05075989268,12571649567)
INSERT INTO Iletisim VALUES('dilra_demir@hotmail.com','1108 sok. 26/56 �zmir',		05075989268,25149721667)
INSERT INTO Iletisim VALUES('burk_ersln@hotmail.com',NULL,		05075989268,87512765216)
INSERT INTO Iletisim VALUES('byz.cardk@hotmail.com','1108 sok. 26/56 �zmir',		05075989268,58421642619)
INSERT INTO Iletisim VALUES('ahmt_okur@hotmail.com',NULL	,		05075989268,53547387382)
INSERT INTO Iletisim VALUES('bse.baysal@hotmail.com',NULL,		NULL,75258859889)

INSERT INTO Mesaj VALUES('�dev','�devlerde grup �al��mas� olur mu?','20140918','20140920',67524126472,62417642762)
INSERT INTO Mesaj VALUES('S�nav','S�nav ka��d�ma tekrar bak�lmas�n� istiyorum','20141014','20141020',52472679752,57247617458)
INSERT INTO Mesaj VALUES('Proje','Proje konumuzu nerden ��renebiliriz?','20141101','20141103',12571649567,48625652038)
INSERT INTO Mesaj VALUES('�dev','Konu k�s�tlamas� var m�?','20141212','20141213',75196759791,33641971557)
INSERT INTO Mesaj VALUES('Proje','Proje son teslim tarihi ne zaman','20150101','20150105',97517547529,26145605210)
INSERT INTO Mesaj VALUES('S�nav','Maazeret s�nav� ne zaman?','20150118','20150119',81752812556,12758191725)
INSERT INTO Mesaj VALUES('�dev','�dev konular� ne zaman belli olur?','20150202','20150208',21761205789,19551915851)
INSERT INTO Mesaj VALUES('S�nav','S�nav ka��d�ma tekrar bak�lmas�n� istiyorum','20150205','20150216',21761205789,48625652038)
INSERT INTO Mesaj VALUES('S�nav','S�nav sonu�lar� ne zaman belli olur?','20150224','20150226',21761205789,45896220569)
INSERT INTO Mesaj VALUES('Proje','Proje notlar� ne zaman a��klan�r?','20150303','20150503',81752812556,58212355623)
INSERT INTO Mesaj VALUES('Proje','Proje notlar� ne zaman a��klan�r?','20150326','20150330',19551915851,48526625963)
INSERT INTO Mesaj VALUES('Ders','Yar�n ki ders iptal mi?','20150401','20150402',19551915851,46548965256)
INSERT INTO Mesaj VALUES('S�nav','S�nav ka��d�ma tekrar bak�lmas�n� istiyorum.','20150419','20150422',75258859889,53547387382)
INSERT INTO Mesaj VALUES('�dev','�devin son teslim tarihi ne zaman?','20150429','20150430',87512765216,58421642619)
INSERT INTO Mesaj VALUES('Proje','Proje �al��mas�nda en az ka� ki�i olabilir?','20150501','20150402',25149721667,12571649567)
INSERT INTO Mesaj VALUES('S�nav','Sonu�lar ne zaman belli olur?','20150530','20150604',95164214664,26545256429)
INSERT INTO Mesaj VALUES('�dev','�dev notumuz ne zaman belli olur','20150601','20150602',15242497912,26146249297)
INSERT INTO Mesaj VALUES('Ders','Yar�n ki ders iptal mi?','20150611','20150612',65189123125,61586559856)
INSERT INTO Mesaj VALUES('Proje','Proje notlar� ne zaman a��klan�r?','20150513','20150514',75123669565,78465131516)
INSERT INTO Mesaj VALUES('S�nav','S�nav ne zaman?','20150522','20150525',96558695423,45220321520)

INSERT INTO Duyuru VALUES('S�nav','S�nav notlar� yay�ndad�r.','20140108')
INSERT INTO Duyuru VALUES('S�nav','S�nav tarihleri a��klanm��t�r.','20150210')
INSERT INTO Duyuru VALUES('Hata','Sistemde bir hata meydana gelmi�tir.','20150304')
INSERT INTO Duyuru VALUES('Gezi','Teknik geziye b�t�n ��renciler davetlidir.','20150416')
INSERT INTO Duyuru VALUES('Katk� Pay�','Katk� pay� �demelerini belirtilen tarihe kadar yap�n�z.','20150523')
INSERT INTO Duyuru VALUES('S�nav','S�nav yerleri duyurulacakt�r.','20150630')
INSERT INTO Duyuru VALUES('Yar��ma','Seramik yar��mas�na kat�l�mlar�n�z� bekliyoruz','20140904')
INSERT INTO Duyuru VALUES('Erasmus','Asil adaylar a��klanm��t�r','20141017')
INSERT INTO Duyuru VALUES('Erasmus','Yedek adaylar a��klanm��t�r','20141119')
INSERT INTO Duyuru VALUES('Farabi','Asil adaylar a��klanm��t�r','20141225')
INSERT INTO Duyuru VALUES('S�nav','Yedek adaylar a��klanm��t�r','20140911')
INSERT INTO Duyuru VALUES('Akademik takvim','Akademik takvim yay�ndad�r','20150919')
INSERT INTO Duyuru VALUES('Kan Ba����','Kan ba���� katk�lar�n�z� bekliyoruz','20150526')
INSERT INTO Duyuru VALUES('S�nav','S�nav notlar� yay�ndad�r','20150430')
INSERT INTO Duyuru VALUES('Gezi','Teknik geziye b�t�n ��renciler davetlidir.','20150306')
INSERT INTO Duyuru VALUES('S�nav','S�nav yerleri duyurulacakt�r.','20150509')
INSERT INTO Duyuru VALUES('S�nav','S�nav yerleri yay�ndad�r','20140907')
INSERT INTO Duyuru VALUES('Hata','Sistemde bir hata meydana gelmi�tir','20140913')
INSERT INTO Duyuru VALUES('S�nav','S�nav tarihleri a��klanm��t�r.','20151022')
INSERT INTO Duyuru VALUES('Ders Program�','Ders programlar� yay�ndad�r','20141111')

INSERT INTO DuyuruGoruntulenme VALUES ('20140108',1,78465131516)
INSERT INTO DuyuruGoruntulenme VALUES ('20140109',1,67524126472)
INSERT INTO DuyuruGoruntulenme VALUES ('20140110',1,96558695423)
INSERT INTO DuyuruGoruntulenme VALUES ('20140111',1,61586559856)
INSERT INTO DuyuruGoruntulenme VALUES ('20140113',1,15242497912)
INSERT INTO DuyuruGoruntulenme VALUES ('20140911',11,78465131516)
INSERT INTO DuyuruGoruntulenme VALUES ('20140911',11,67524126472)
INSERT INTO DuyuruGoruntulenme VALUES ('20140912',11,96558695423)
INSERT INTO DuyuruGoruntulenme VALUES ('20140913',11,57247617458)
INSERT INTO DuyuruGoruntulenme VALUES ('20140914',11,15242497912)
INSERT INTO DuyuruGoruntulenme VALUES ('20140913',18,26145605210)
INSERT INTO DuyuruGoruntulenme VALUES ('20140913',18,97517547529)
INSERT INTO DuyuruGoruntulenme VALUES ('20140913',18,12758191725)
INSERT INTO DuyuruGoruntulenme VALUES ('20140913',18,15242497912)
INSERT INTO DuyuruGoruntulenme VALUES ('20140913',18,81752812556)
INSERT INTO DuyuruGoruntulenme VALUES ('20140913',18,21761205789)
INSERT INTO DuyuruGoruntulenme VALUES ('20141017',8,62417642762)
INSERT INTO DuyuruGoruntulenme VALUES ('20141018',8,58421642619)
INSERT INTO DuyuruGoruntulenme VALUES ('20141020',8,61586559856)
INSERT INTO DuyuruGoruntulenme VALUES ('20141027',8,15242497912)
INSERT INTO DuyuruGoruntulenme VALUES ('20141101',8,26146249297)
INSERT INTO DuyuruGoruntulenme VALUES ('20141104',8,12571649567)
INSERT INTO DuyuruGoruntulenme VALUES ('20150304',3,62417642762)
INSERT INTO DuyuruGoruntulenme VALUES ('20150304',3,53547387382)
INSERT INTO DuyuruGoruntulenme VALUES ('20150304',3,96558695423)
INSERT INTO DuyuruGoruntulenme VALUES ('20150304',3,15242497912)
INSERT INTO DuyuruGoruntulenme VALUES ('20150304',3,58421642619)
INSERT INTO DuyuruGoruntulenme VALUES ('20150304',3,75258859889)
INSERT INTO DuyuruGoruntulenme VALUES ('20150306',15,52472679752)
INSERT INTO DuyuruGoruntulenme VALUES ('20150306',15,57247617458)
INSERT INTO DuyuruGoruntulenme VALUES ('20150306',15,67524126472)
INSERT INTO DuyuruGoruntulenme VALUES ('20150306',15,62417642762)
INSERT INTO DuyuruGoruntulenme VALUES ('20150306',15,96558695423)
INSERT INTO DuyuruGoruntulenme VALUES ('20150306',15,26145605210)
INSERT INTO DuyuruGoruntulenme VALUES ('20150526',13,69548532015)
INSERT INTO DuyuruGoruntulenme VALUES ('20150526',13,75258859889)
INSERT INTO DuyuruGoruntulenme VALUES ('20150526',13,53547387382)
INSERT INTO DuyuruGoruntulenme VALUES ('20150526',13,58421642619)
INSERT INTO DuyuruGoruntulenme VALUES ('20150526',13,87512765216)
INSERT INTO DuyuruGoruntulenme VALUES ('20150526',13,25149721667)
INSERT INTO DuyuruGoruntulenme VALUES ('20150526',13,95164214664)
INSERT INTO DuyuruGoruntulenme VALUES ('20150526',13,15242497912)
INSERT INTO DuyuruGoruntulenme VALUES ('20150526',13,26146249297)
INSERT INTO DuyuruGoruntulenme VALUES ('20150526',13,61586559856)
INSERT INTO DuyuruGoruntulenme VALUES ('20150526',13,65189123125)
INSERT INTO DuyuruGoruntulenme VALUES ('20150526',13,78465131516)

INSERT INTO Ders VALUES(101,'Bilgisayar M�hendisli�ine Giri�',2)
INSERT INTO Ders VALUES(106,'Matematik-1',3)
INSERT INTO Ders VALUES(107,'Matematik-2',3)
INSERT INTO Ders VALUES(108,'Lineer Cebir',1)
INSERT INTO Ders VALUES(102,'Algoritma Programlama - 1',2)
INSERT INTO Ders VALUES(103,'Algoritma Programlama - 2',4)
INSERT INTO Ders VALUES(202,'Ayr�k Matematik',4)
INSERT INTO Ders VALUES(201,'Nesne Y�nelimli Programlama - 1',2)
INSERT INTO Ders VALUES(205,'Nesne Y�nelimli Programlama - 2',2)
INSERT INTO Ders VALUES(203,'��aretler Sistemler',1)
INSERT INTO Ders VALUES(206,'Veritaban� Y�netim Sistemleri - 1',2)
INSERT INTO Ders VALUES(301,'Veritaban� Y�netim Sistemleri - 2',2)
INSERT INTO Ders VALUES(204,'Elektrik Devre Temelleri',1)
INSERT INTO Ders VALUES(207,'Elektronik Devre Temelleri',1)
INSERT INTO Ders VALUES(302,'Yaz�l�m M�hendisli�i',2)
INSERT INTO Ders VALUES(303,'��letim Sistemleri',1)
INSERT INTO Ders VALUES(304,'Sanal Ger�eklik',2)
INSERT INTO Ders VALUES(401,'Giri�imcili�e Giri�',1)
INSERT INTO Ders VALUES(404,'Veri Madencili�i',2)
INSERT INTO Ders VALUES(402,'Mobil Uygulama Geli�tirme',1)

INSERT INTO Dokuman VALUES('PDF','BMG ders notlar�',101)
INSERT INTO Dokuman VALUES('Video','Sanal Ger�eklik ders notlar�',304)
INSERT INTO Dokuman VALUES('PDF','EDT ge�mi� y�llar�n sorular�',207)
INSERT INTO Dokuman VALUES('PDF','Veritaban� - 1 dersi ders notlar�',206)
INSERT INTO Dokuman VALUES('Video','Ayr�k Matematik ders notlar�',202)
INSERT INTO Dokuman VALUES('Video','Algoritma Programlama - 1 ders notlar�',102)
INSERT INTO Dokuman VALUES('PDF','Matematik - 1  ders notlar�',106)
INSERT INTO Dokuman VALUES('Video','Mobil Uygulama ders notlar�',402)
INSERT INTO Dokuman VALUES('PDF','Veri Madencili�i ders notlar�',404)
INSERT INTO Dokuman VALUES('Video','Veritaban� - 1 ders notlar�',206)
INSERT INTO Dokuman VALUES('PDF','Veritaban� - 2 ders notlar�',301)
INSERT INTO Dokuman VALUES('Video','��letim Sistemleri ders notlar�',303)
INSERT INTO Dokuman VALUES('PDF','��aretler sistemler ders notlar�',203)
INSERT INTO Dokuman VALUES('Video','Giri�imcili�e Giri� ders notlar�',401)
INSERT INTO Dokuman VALUES('Video','Matematik - 1 ekstra ders notlar�',106)
INSERT INTO Dokuman VALUES('PDF','Matematik - 2 ders notlar�',107)
INSERT INTO Dokuman VALUES('PDF','Lineer Cebir ders notlar�',108)
INSERT INTO Dokuman VALUES('Video','Algoritma Programlama - 2 ders notlar�',103)
INSERT INTO Dokuman VALUES('Video','Mobil Uygulama Geli�tirme s�nava haz�rl�k notlar�',402)
INSERT INTO Dokuman VALUES('Video','Veri Madencili�i ge�mi� y�llar�n sorular�',404)

INSERT INTO DersAlma VALUES('G�z','2014-2015',106,12001010008)
INSERT INTO DersAlma VALUES('G�z','2014-2015',106,12001010009)
INSERT INTO DersAlma VALUES('G�z','2014-2015',106,12001010013)
INSERT INTO DersAlma VALUES('G�z','2014-2015',106,12001010004)
INSERT INTO DersAlma VALUES('G�z','2014-2015',106,12001010015)

INSERT INTO DersAlma VALUES('G�z','2013-2014',101,12001010001)
INSERT INTO DersAlma VALUES('G�z','2013-2014',101,12001010002)
INSERT INTO DersAlma VALUES('G�z','2013-2014',101,12001010003)
INSERT INTO DersAlma VALUES('G�z','2013-2014',101,12001010004)
INSERT INTO DersAlma VALUES('G�z','2013-2014',101,12001010005)

INSERT INTO DersAlma VALUES('G�z','2013-2014',102,12001010006)
INSERT INTO DersAlma VALUES('G�z','2013-2014',102,12001010002)
INSERT INTO DersAlma VALUES('G�z','2013-2014',102,12001010003)
INSERT INTO DersAlma VALUES('G�z','2013-2014',102,12001010004)
INSERT INTO DersAlma VALUES('G�z','2013-2014',102,12001010005)

INSERT INTO DersAlma VALUES('Bahar','2013-2014',108,12001010007)
INSERT INTO DersAlma VALUES('Bahar','2013-2014',108,12001010008)
INSERT INTO DersAlma VALUES('Bahar','2013-2014',108,12001010009)
INSERT INTO DersAlma VALUES('Bahar','2013-2014',108,12001010010)
INSERT INTO DersAlma VALUES('Bahar','2013-2014',108,12001010011)

INSERT INTO DersAlma VALUES('G�z','2014-2015',202,12001010011)
INSERT INTO DersAlma VALUES('G�z','2014-2015',202,12001010012)
INSERT INTO DersAlma VALUES('G�z','2014-2015',202,12001010013)
INSERT INTO DersAlma VALUES('G�z','2014-2015',202,12001010014)
INSERT INTO DersAlma VALUES('G�z','2014-2015',202,12001010015)

INSERT INTO DersAlma VALUES('Bahar','2014-2015',205,12001010016)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',205,12001010017)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',205,12001010018)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',205,12001010019)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',205,12001010020)

INSERT INTO DersAlma VALUES('G�z','2014-2015',101,12001010008)
INSERT INTO DersAlma VALUES('G�z','2014-2015',101,12001010009)
INSERT INTO DersAlma VALUES('G�z','2014-2015',101,12001010013)
INSERT INTO DersAlma VALUES('G�z','2014-2015',101,12001010004)
INSERT INTO DersAlma VALUES('G�z','2014-2015',101,12001010015)

INSERT INTO DersAlma VALUES('Bahar','2014-2015',207,12001010006)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',207,12001010002)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',207,12001010003)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',207,12001010004)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',207,12001010005)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',207,12001010007)

INSERT INTO DersAlma VALUES('Bahar','2013-2014',108,12001010008)
INSERT INTO DersAlma VALUES('Bahar','2013-2014',108,12001010009)
INSERT INTO DersAlma VALUES('Bahar','2013-2014',108,12001010010)
INSERT INTO DersAlma VALUES('Bahar','2013-2014',108,12001010011)

INSERT INTO DersAlma VALUES('G�z','2014-2015',301,12001010011)
INSERT INTO DersAlma VALUES('G�z','2014-2015',301,12001010012)
INSERT INTO DersAlma VALUES('G�z','2014-2015',301,12001010013)
INSERT INTO DersAlma VALUES('G�z','2014-2015',301,12001010014)
INSERT INTO DersAlma VALUES('G�z','2014-2015',301,12001010015)

INSERT INTO DersAlma VALUES('Bahar','2014-2015',206,12001010016)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',206,12001010017)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',206,12001010018)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',206,12001010019)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',206,12001010020)

INSERT INTO DersAlma VALUES('G�z','2014-2015',201,12001010001)
INSERT INTO DersAlma VALUES('G�z','2014-2015',201,12001010002)
INSERT INTO DersAlma VALUES('G�z','2014-2015',201,12001010003)
INSERT INTO DersAlma VALUES('G�z','2014-2015',201,12001010004)
INSERT INTO DersAlma VALUES('G�z','2014-2015',201,12001010005)

INSERT INTO DersAlma VALUES('Bahar','2014-2015',103,12001010016)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',103,12001010017)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',103,12001010018)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',103,12001010019)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',103,12001010020)

INSERT INTO DersAlma VALUES('G�z','2014-2015',203,12001010008)
INSERT INTO DersAlma VALUES('G�z','2014-2015',203,12001010009)
INSERT INTO DersAlma VALUES('G�z','2014-2015',203,12001010013)
INSERT INTO DersAlma VALUES('G�z','2014-2015',203,12001010004)
INSERT INTO DersAlma VALUES('G�z','2014-2015',203,12001010015)

INSERT INTO DersAlma VALUES('Bahar','2014-2015',107,12001010026)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',107,12001010022)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',107,12001010023)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',107,12001010024)
INSERT INTO DersAlma VALUES('Bahar','2014-2015',107,12001010025)

INSERT INTO DersVerme VALUES('G�z','2014-2015',202,15101030013)
INSERT INTO DersVerme VALUES('G�z','2014-2015',201,15101030010)
INSERT INTO DersVerme VALUES('Bahar','2014-2015',206,15101030011)
INSERT INTO DersVerme VALUES('Bahar','2014-2015',207,15101030007)
INSERT INTO DersVerme VALUES('G�z','2013-2014',101,15101030001)
INSERT INTO DersVerme VALUES('G�z','2013-2014',102,15101030002)
INSERT INTO DersVerme VALUES('G�z','2015-2016',304,15101030010)
INSERT INTO DersVerme VALUES('G�z','2015-2016',401,15101030001)
INSERT INTO DersVerme VALUES('G�z','2013-2014',103,15101030006)
INSERT INTO DersVerme VALUES('G�z','2013-2014',106,15101030009)
INSERT INTO DersVerme VALUES('G�z','2013-2014',107,15101030009)
INSERT INTO DersVerme VALUES('Bahar','2013-2014',108,15101030009)
INSERT INTO DersVerme VALUES('G�z','2014-2015',301,15101030011)
INSERT INTO DersVerme VALUES('G�z','2014-2015',203,15101030004)
INSERT INTO DersVerme VALUES('Bahar','2015-2016',402,15101030013)

INSERT INTO OgrenciDokumanTakip VALUES('20130902',1,12001010001)
INSERT INTO OgrenciDokumanTakip VALUES('20130903',1,12001010015)
INSERT INTO OgrenciDokumanTakip VALUES('20131203',1,12001010004)
INSERT INTO OgrenciDokumanTakip VALUES('20130903',1,12001010013)
INSERT INTO OgrenciDokumanTakip VALUES('20131206',1,12001010005)
INSERT INTO OgrenciDokumanTakip VALUES('20140902',3,12001010011)
INSERT INTO OgrenciDokumanTakip VALUES('20140903',3,12001010012)
INSERT INTO OgrenciDokumanTakip VALUES('20140903',3,12001010013)
INSERT INTO OgrenciDokumanTakip VALUES('20140903',3,12001010014)
INSERT INTO OgrenciDokumanTakip VALUES('20140906',3,12001010015)
INSERT INTO OgrenciDokumanTakip VALUES('20140102',16,12001010022)
INSERT INTO OgrenciDokumanTakip VALUES('20140104',16,12001010023)
INSERT INTO OgrenciDokumanTakip VALUES('20140104',16,12001010024)
INSERT INTO OgrenciDokumanTakip VALUES('20140104',16,12001010025)
INSERT INTO OgrenciDokumanTakip VALUES('20140106',16,12001010026)
INSERT INTO OgrenciDokumanTakip VALUES('20140902',6,12001010002)
INSERT INTO OgrenciDokumanTakip VALUES('20140903',6,12001010003)
INSERT INTO OgrenciDokumanTakip VALUES('20140903',6,12001010004)
INSERT INTO OgrenciDokumanTakip VALUES('20140903',6,12001010005)
INSERT INTO OgrenciDokumanTakip VALUES('20140906',6,12001010006)
INSERT INTO OgrenciDokumanTakip VALUES('20150902',4,12001010016)
INSERT INTO OgrenciDokumanTakip VALUES('20150903',4,12001010017)
INSERT INTO OgrenciDokumanTakip VALUES('20150903',4,12001010018)
INSERT INTO OgrenciDokumanTakip VALUES('20150903',4,12001010019)
INSERT INTO OgrenciDokumanTakip VALUES('20150906',4,12001010020)

INSERT INTO SinavTipi(sinav_turu) VALUES ('Vize')
INSERT INTO SinavTipi(sinav_turu) VALUES ('Final')
INSERT INTO SinavTipi(sinav_turu) VALUES ('Quiz')

INSERT INTO Sinav 
	VALUES ('Her soru e�it puandir. S�re 100 dakikad�r. Ba�ar�lar',
	'2013-2014 G�z D�nemi - Matematik - 1  vize s�nav�','20141120',106,1)
INSERT INTO Sinav
	VALUES ('Her soru e�it puandir. S�re 150 dakikad�r. Ba�ar�lar',
	'2013-2014 G�z D�nemi - Matematik - 1 final s�nav�','20141230',106,2)
INSERT INTO Sinav 
	VALUES ('Her soru 20 puandir. S�re 90 dakikad�r. Ba�ar�lar',
	'2013-2014 G�z D�nemi - Bilgisayar M�hendisli�ine Giri� vize s�nav�','20131123',101,1)
INSERT INTO Sinav 
	VALUES ('Her soru 20 puandir S�re 90 dakikad�r . Ba�ar�lar',
	'2013-2014 G�z D�nemi - Bilgisayar M�hendisli�ine Giri� final s�nav�','20140104',101,2)
INSERT INTO Sinav
	VALUES ('S�re 80 dakikad�r. Ba�ar�lar',
	'2013-2014 Bahar D�nemi - Lineer Cebir vize s�nav�','20140404',108,1)
INSERT INTO Sinav
	VALUES ('S�re 70 dakikad�r. Ba�ar�lar',
	'2013-2014 Bahar D�nemi - Lineer Cebir final s�nav�','20140505',108,2)
INSERT INTO Sinav 
	VALUES ('S�re 60 dakikad�r. Ba�ar�lar',
	'2013-2014 Bahar D�nemi - Algoritma Programalama - 2  vize s�nav�','20150428',103,1)
INSERT INTO Sinav 
	VALUES ('S�re 60 dakikad�r. Ba�ar�lar',
	'2013-2014 Bahar D�nemi - Algoritma Programalama - 2  final s�nav�','20150606',103,2)
INSERT INTO Sinav 
	VALUES ('S�re 200 dakikad�r. Ba�ar�lar',
	'2014-2015 G�z D�nemi - Ayr�k Matematik vize s�nav�','20141110',202,1)
INSERT INTO Sinav 
	VALUES ('S�re 150 dakikad�r. Ba�ar�lar',
	'2014-2015 G�z D�nemi - Ayr�k Matematik final s�nav�','20141220',202,2)
INSERT INTO Sinav  
	VALUES ('Her soru 20 puandir. S�re 100 dakikad�r. Ba�ar�lar',
	'2014-2015 G�z D�nemi - Nesne Y�nelimli Programalama-1 vize s�nav�','20141109',201,1)
INSERT INTO Sinav 
	VALUES ('Her soru 20 puandir S�re 70 dakikad�r . Ba�ar�lar',
	'2014-2015 G�z D�nemi - Nesne Y�nelimli Programalama-1 final s�nav�','20141219',201,2)
INSERT INTO Sinav 
	VALUES ('Her soru 25 puandir. S�re 50 dakikad�r. Ba�ar�lar',
	'2013-2014 G�z D�nemi - Algoritma Programlama-1 vize s�nav�','20131124',102,1)
INSERT INTO Sinav 
	VALUES ('Her soru 25 puandir. S�re 75 dakikad�r. Ba�ar�lar',
	'2013-2014 G�z D�nemi - Algoritma Programlama-1 final s�nav�','20131231',102,2)
INSERT INTO Sinav  
	VALUES ('Her soru 25 puandir. Zamandan ba��ms�zd�r. Ba�ar�lar',
	'2014-2015 G�z D�nemi - ��aretler sistemler vize s�nav�','20141112',203,1)
INSERT INTO Sinav  
	VALUES ('Her soru 25 puandir. Zamandan ba��ms�zd�r. Ba�ar�lar',
	'2014-2015 G�z D�nemi - ��aretler sistemler final s�nav�','20150105',203,2)
INSERT INTO Sinav
	VALUES ('Her soru 25 puandir. S�re 200 dakikad�r. Ba�ar�lar',
	'2014-2015 Bahar D�nemi - Veritaban� Y�netim Sistemleri - 1 vize s�nav�','20150405',206,1)
INSERT INTO Sinav  
	VALUES ('Her soru 25 puandir. S�re 150 dakikad�r. Ba�ar�lar',
	'2014-2015 Bahar D�nemi - Veritaban� Y�netim Sistemleri - 1 final s�nav�','20150526',206,2)
INSERT INTO Sinav 
	VALUES ('Her soru e�it puandir. S�re 100 dakikad�r. Ba�ar�lar',
	'2014-2015 Bahar D�nemi - Elektronik Devreler vize s�nav�','20150406',207,1)
INSERT INTO Sinav
	VALUES ('Her soru e�it puandir. S�re 150 dakikad�r. Ba�ar�lar',
	'2014-2015 Bahar D�nemi - Elektronik Devreler final s�nav�','20150601',207,2)

INSERT INTO SinavaGirme VALUES (1,12001010008,50)
INSERT INTO SinavaGirme VALUES (1,12001010009,45)
INSERT INTO SinavaGirme VALUES (1,12001010013,80)
INSERT INTO SinavaGirme VALUES (1,12001010004,60)
INSERT INTO SinavaGirme VALUES (1,12001010015,40)

INSERT INTO SinavaGirme VALUES (2,12001010008,50)
INSERT INTO SinavaGirme VALUES (2,12001010009,45)
INSERT INTO SinavaGirme VALUES (2,12001010013,80)
INSERT INTO SinavaGirme VALUES (2,12001010004,60)
INSERT INTO SinavaGirme VALUES (2,12001010015,40)

----
INSERT INTO SinavaGirme VALUES (3,12001010001,20)
INSERT INTO SinavaGirme VALUES (3,12001010002,10)
INSERT INTO SinavaGirme VALUES (3,12001010003,100)
INSERT INTO SinavaGirme VALUES (3,12001010004,90)
INSERT INTO SinavaGirme VALUES (3,12001010005,20)

------
INSERT INTO SinavaGirme VALUES (4,12001010001,20)
INSERT INTO SinavaGirme VALUES (4,12001010002,10)
INSERT INTO SinavaGirme VALUES (4,12001010003,100)
INSERT INTO SinavaGirme VALUES (4,12001010004,90)
INSERT INTO SinavaGirme VALUES (4,12001010005,20)
------

INSERT INTO SinavaGirme VALUES (5,12001010007,50)
INSERT INTO SinavaGirme VALUES (5,12001010008,45)
INSERT INTO SinavaGirme VALUES (5,12001010009,80)
INSERT INTO SinavaGirme VALUES (5,12001010010,60)
INSERT INTO SinavaGirme VALUES (5,12001010011,7)


INSERT INTO SinavaGirme VALUES (6,12001010007,67)
INSERT INTO SinavaGirme VALUES (6,12001010008,45)
INSERT INTO SinavaGirme VALUES (6,12001010009,21)
INSERT INTO SinavaGirme VALUES (6,12001010010,92)
INSERT INTO SinavaGirme VALUES (6,12001010011,9)

INSERT INTO SinavaGirme VALUES (7,12001010016,40)
INSERT INTO SinavaGirme VALUES (7,12001010017,25)
INSERT INTO SinavaGirme VALUES (7,12001010018,75)
INSERT INTO SinavaGirme VALUES (7,12001010019,29)
INSERT INTO SinavaGirme VALUES (7,12001010020,65)

INSERT INTO SinavaGirme VALUES (8,12001010016,60)
INSERT INTO SinavaGirme VALUES (8,12001010017,55)
INSERT INTO SinavaGirme VALUES (8,12001010018,25)
INSERT INTO SinavaGirme VALUES (8,12001010019,79)
INSERT INTO SinavaGirme VALUES (8,12001010020,15)

INSERT INTO SinavaGirme VALUES (9,12001010011,40)
INSERT INTO SinavaGirme VALUES (9,12001010012,25)
INSERT INTO SinavaGirme VALUES (9,12001010013,75)
INSERT INTO SinavaGirme VALUES (9,12001010014,29)
INSERT INTO SinavaGirme VALUES (9,12001010015,65)

INSERT INTO SinavaGirme VALUES (10,12001010011,10)
INSERT INTO SinavaGirme VALUES (10,12001010012,65)
INSERT INTO SinavaGirme VALUES (10,12001010013,85)
INSERT INTO SinavaGirme VALUES (10,12001010014,30)
INSERT INTO SinavaGirme VALUES (10,12001010015,65)

INSERT INTO SinavaGirme VALUES (11,12001010001,10)
INSERT INTO SinavaGirme VALUES (11,12001010002,65)
INSERT INTO SinavaGirme VALUES (11,12001010003,85)
INSERT INTO SinavaGirme VALUES (11,12001010004,30)
INSERT INTO SinavaGirme VALUES (11,12001010005,65)

INSERT INTO SinavaGirme VALUES (12,12001010001,10)
INSERT INTO SinavaGirme VALUES (12,12001010002,65)
INSERT INTO SinavaGirme VALUES (12,12001010003,85)
INSERT INTO SinavaGirme VALUES (12,12001010004,30)
INSERT INTO SinavaGirme VALUES (12,12001010005,65)

INSERT INTO SinavaGirme VALUES (13,12001010006,20)
INSERT INTO SinavaGirme VALUES (13,12001010002,40)
INSERT INTO SinavaGirme VALUES (13,12001010003,45)
INSERT INTO SinavaGirme VALUES (13,12001010004,60)
INSERT INTO SinavaGirme VALUES (13,12001010005,95)

INSERT INTO SinavaGirme VALUES (14,12001010006,80)
INSERT INTO SinavaGirme VALUES (14,12001010002,65)
INSERT INTO SinavaGirme VALUES (14,12001010003,55)
INSERT INTO SinavaGirme VALUES (14,12001010004,30)
INSERT INTO SinavaGirme VALUES (14,12001010005,45)


INSERT INTO SinavaGirme VALUES (19,12001010006,20)
INSERT INTO SinavaGirme VALUES (19,12001010002,30)
INSERT INTO SinavaGirme VALUES (19,12001010003,40)
INSERT INTO SinavaGirme VALUES (19,12001010004,50)
INSERT INTO SinavaGirme VALUES (19,12001010005,60)
INSERT INTO SinavaGirme VALUES (19,12001010007,70)

INSERT INTO SinavaGirme VALUES (20,12001010006,45)
INSERT INTO SinavaGirme VALUES (20,12001010002,65)
INSERT INTO SinavaGirme VALUES (20,12001010003,55)
INSERT INTO SinavaGirme VALUES (20,12001010004,15)
INSERT INTO SinavaGirme VALUES (20,12001010005,01)
INSERT INTO SinavaGirme VALUES (20,12001010007,01)

INSERT INTO Soru VALUES ('A�a��daki kod par�as�n�n ekran ��kt�s� nedir?
												int a = 3;
												int b = 4;
												if( a>b ) printf(a);
												else printf(b);','4');

INSERT INTO Soru(aciklama,dogru_cevap) VALUES ('A�a��daki kod par�as�n�n ekran ��kt�s� nedir?
												int a = 5;
												int b = 4;
												if( a>b ) printf(a);
												else printf(b);','5');

INSERT INTO Soru(aciklama,dogru_cevap) VALUES ('�� i�e for yap�s�yla ekrana 1 den 100 e kadar say�lar� yazd�ran algoritman�n
kodunu yaz�n�z.','int i=0,j=0;
				  for(i;i>10;i++)
				  {
						for(j;j>10;j++)
						{
							printf(i+j);
						}
						j=0;
				  }');

INSERT INTO Soru(aciklama,dogru_cevap) VALUES ('Faktoriyel hesaplayan fonksiyonu yaz�n.','
												public int Faktoriyel(int sayi)
	{
													if(sayi == 0) return 1;
													else return sayi;
	}');

INSERT INTO Soru(aciklama,dogru_cevap) VALUES ('A�ag�dakilerden hangisi yaz�l�m geli�tirme modelidir ? ','Waterfall Model')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('TCP/IP Modeli','5')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('OSI Referans Modeli','5')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('FAT32','5');
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('SMTP','5');

INSERT INTO Soru(aciklama,dogru_cevap) VALUES ('A�ag�dakilerden hangisi nesne y�nelimli paradigmay� desteklemeyen bir 
dildir ? ','C')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('C++','6')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('C#','6')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('Java','6');
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('Javascript','6');

INSERT INTO Soru(aciklama,dogru_cevap) VALUES ('A�ag�dakilerden hangisi OSI referans modelinde yer almaz ? ','Situation')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('Physical','7')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('Application','7')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('Network','7');
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('Presentation','7');

INSERT INTO Soru(aciklama,dogru_cevap) VALUES ('A�ag�dakilerden hangisi daha a�a��dad�r ? ','Physical')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('Network','8')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('Application','8')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('Data-Link','8');
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('Session','8');

INSERT INTO Soru(aciklama,dogru_cevap) VALUES ('A�ag�dakilerden hangisi g�venli bir kodda bulunmamal�d�r?','goto')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('if-else','9')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('class','9')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('alias','9');
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('switch-case','9');

INSERT INTO Soru(aciklama,dogru_cevap) VALUES ('A�ag�dakilerden hangisi nesne y�nelimli programlamada kullan�lan yap�lardan de�ildir?','goto')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('interface','10')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('class','10')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('struct','10');
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('property','10');

INSERT INTO Soru(aciklama,dogru_cevap) VALUES ('A�a��daki matrisin determinant� ka�t�r ?
											0  0  1
											0  2  -1
											0  7  6  ','0');

INSERT INTO Soru(aciklama,dogru_cevap) VALUES ('A�a��daki matrisin rank� ka�t�r ?
											0  0  1
											0  2  -1
											0  7  6  ','2');

INSERT INTO Soru(aciklama,dogru_cevap) VALUES ('(q v 0) v (0 v q) nun dengini bulun.','q');
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('q','13')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('0','13')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('q=>0','13');
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('{}','13');

INSERT INTO Soru(aciklama,dogru_cevap) VALUES ('A�a��dakilerden hangisi evrensel k�medir ?','A U NOT(A)');
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('(A/B) U A','14')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('(A U B)','14')
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('(A)','14');
INSERT INTO Celdirici(yanlis_cevap,soru_no) VALUES('{}','14');

INSERT INTO Soru(aciklama,dogru_cevap) VALUES ('A�a��daki denklemin 2 den 0 a integralini al�n.
												3x^2+7','8');
INSERT INTO Soru(aciklama,dogru_cevap) VALUES ('A�a��daki denklemin 3 den 1 a integralini al�n.
												3x^2+7','26');

INSERT INTO Soru(aciklama,dogru_cevap) VALUES ('f(x) = 3x^2 + 2x + 2 ise t�revinin y=2 noktas�ndaki de�eri nedir ?','14');
INSERT INTO Soru(aciklama,dogru_cevap) VALUES ('f(x) = 3x^2 + 2x + 2 ise t�revinin y=5 noktas�ndaki de�eri nedir ?','32');
INSERT INTO Soru(aciklama,dogru_cevap) VALUES ('f(x) = 3x^2 + 2x + 2 ise t�revinin y=0 noktas�ndaki de�eri nedir ?','2');

INSERT INTO Soru(aciklama,dogru_cevap) VALUES ('Giri�inde periyodu 4 saniye olan darbe s�releri e�it bir kare dalga -5 ile 10[V] aras�nda de�erler
almaktad�r. Buna g�re ��k���n ortalama de�eri nedir ? ','2.5[V]');



INSERT INTO SinavOlusturma VALUES(1,17)
INSERT INTO SinavOlusturma VALUES(1,18)
INSERT INTO SinavOlusturma VALUES(1,19)
INSERT INTO SinavOlusturma VALUES(2,15)
INSERT INTO SinavOlusturma VALUES(2,16)
INSERT INTO SinavOlusturma VALUES(2,17)
INSERT INTO SinavOlusturma VALUES(2,18)
INSERT INTO SinavOlusturma VALUES(13,1)
INSERT INTO SinavOlusturma VALUES(13,2)
INSERT INTO SinavOlusturma VALUES(13,3)
INSERT INTO SinavOlusturma VALUES(14,2)
INSERT INTO SinavOlusturma VALUES(14,3)
INSERT INTO SinavOlusturma VALUES(14,4)
INSERT INTO SinavOlusturma VALUES(3,5)
INSERT INTO SinavOlusturma VALUES(3,6)
INSERT INTO SinavOlusturma VALUES(3,7)
INSERT INTO SinavOlusturma VALUES(3,8)
INSERT INTO SinavOlusturma VALUES(3,9)
INSERT INTO SinavOlusturma VALUES(3,10)
INSERT INTO SinavOlusturma VALUES(4,6)
INSERT INTO SinavOlusturma VALUES(4,7)
INSERT INTO SinavOlusturma VALUES(4,8)
INSERT INTO SinavOlusturma VALUES(4,10)
INSERT INTO SinavOlusturma VALUES(6,11)
INSERT INTO SinavOlusturma VALUES(6,12)
INSERT INTO SinavOlusturma VALUES(10,13)
INSERT INTO SinavOlusturma VALUES(10,14)

