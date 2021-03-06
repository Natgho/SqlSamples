CREATE PROCEDURE sp_kullanici_ekle(
--INSERT STORED PROCEDURE
--Bu sp de sisteme kullanıcı ekleme işi yapılmaktadır. Gönderilen parametreler ilgili tablolara insert edilmektedir.
--Stored procedure de gerekli hata kontrolleri yapılmaktadır.
@kayitTuru nvarchar(15),
@tc varchar(11),
@no varchar(11),
@ad nvarchar(25) ,
@soyad nvarchar(25),
@sifre varchar(25),
@mail varchar(100),
@adres nvarchar(100),
@telefon varchar(15)

)
AS
BEGIN
	if(select TC from Kullanicilar where tc=@tc) IS NOT NULL
	BEGIN
		RAISERROR('Bu TC numarası ile kayıtlı kullanıcı zaten var...',16,1)
		return 0;
	END

	if(select Iletisim.mail from Iletisim where mail=@mail) IS NOT NULL
	BEGIN
		RAISERROR('Aynı mail adresine sahip kullanıcı bulunmaktadır...',16,1)
		return 0;
	END

if(@kayitTuru='ÖĞRENCİ')
BEGIN
	if(select ogrenci_no from Ogrenci where @no=ogrenci_no) IS NOT NULL
		BEGIN
			RAISERROR ('Bu öğrenci numarası ile kayıtlı kullanıcı zaten var...',16,1)
			return 0;
		END
		BEGIN TRANSACTION
		BEGIN TRY 
			INSERT INTO Kullanicilar(ad,soyad,TC,sifre) VALUES(@ad,@soyad,@tc,@sifre)
			INSERT INTO Ogrenci(ogrenci_no,TC) VALUES (@no,@tc)
			INSERT INTO Iletisim(mail,adres,telefon,TC) VALUES (@mail,@adres,@telefon,@tc)
		END TRY
		BEGIN CATCH
			ROLLBACK
			RAISERROR('Ekleme sırasında hata oluştu! ',16,1)
			RETURN 0
		END CATCH
		COMMIT TRANSACTION
END
else if(@kayitTuru='AKADEMİSYEN')
BEGIN
	if(select personel_no from Akademisyen where @no=personel_no) IS NOT NULL
	BEGIN
		RAISERROR('Bu akademisyen numarası ile kayıtlı kullanıcı zaten var...',16,1)
		return 0;
	END
	BEGIN TRANSACTION
	BEGIN TRY
			INSERT INTO Kullanicilar(ad,soyad,TC,sifre) VALUES(@ad,@soyad,@tc,@sifre)
			INSERT INTO Iletisim(mail,adres,telefon,TC) VALUES (@mail,@adres,@telefon,@tc)
			INSERT INTO Akademisyen(personel_no,TC) VALUES (@no,@tc)
	END TRY
	BEGIN CATCH
		RAISERROR('Ekleme sırasında hata oluştu!',16,1)
		ROLLBACK
		RETURN 0;
	END CATCH
	COMMIT TRANSACTION
END
else
BEGIN
	RAISERROR('Kayıt türü ÖĞRENCİ yada AKADEMİSYEN girilmeli!',16,1)
END
END
--exec sp_kullanici_ekle 'ÖĞRENCİ','33333333333','12001010034','Ahmet','Ali','12345','ahmet@123.com','karanfil mahallesi 25/26 buca-İzmir','5556789455'
--exec sp_kullanici_ekle 'AKADEMİSYEN','98765432101','15101030023','Mehmet','Yıldız','000','mehmet@123.com','papatya mahallesi 22/1 buca-İzmir','5556780099'

--exec sp_kullanici_ekle 'ÖĞRENCİ','78978978900','12001010035','Ayşe','Kütük','125','ayse@kutuk.com','soğanlık mahallesi 25/26 Merkez-Adana','5556789454'
--exec sp_kullanici_ekle 'AKADEMİSYEN','56756756799','15101030025','Didem','Toksoy','112','didem@123.com','su mahallesi 22/1 muğla','5546780099'
--exec sp_kullanici_ekle 'KİŞİ','33333333332','12001010034','Ahmet','Ali','12345','ahmet@234.com','karanfil mahallesi 25/26 buca-İzmir','5556789455'


