ALTER TRIGGER trg_dokuman_haber_verme ON Dokuman AFTER Insert  
AS
--TRIGGER
--Herhangi bir akademisyen taraf�ndan d�k�man eklenirse dersi alan ��rencilere sistem taraf�ndan mesaj g�nderilmektedir
--Bu trigger otomatik mesaj g�nderme i�ini yapmaktad�r.
SET NOCOUNT ON
--Admin kullan�c�s�, veritaban�nda di�er kullan�c�lara sistem mesaj� g�ndermek i�in olu�turulmu�tur
--Daha �nceki s�r�mlerde kullan�lmad��� i�in trigger i�inde insert edilmi�tir.
IF(Select Kullanicilar.TC From Kullanicilar Where Kullanicilar.TC = 'SYSTEM') IS NULL
	INSERT INTO Kullanicilar VALUES('admin','NULL','admin123','SYSTEM')
--
DECLARE @mesaj_sayac INT = 0
DECLARE @ders_kodu INT = (SELECT ders_kodu FROM inserted)
DECLARE @ogrenciler TABLE (
	TC VARCHAR(11)
)

INSERT INTO @ogrenciler SELECT Ogrenci.TC FROM Ogrenci 
							INNER JOIN DersAlma ON Ogrenci.ogrenci_no = DersAlma.ogrenci_no 
							WHERE DersAlma.ders_kodu = @ders_kodu

WHILE(EXISTS(SELECT TC FROM @ogrenciler))
BEGIN
	INSERT INTO Mesaj (konusu,aciklama,gonderilme_tarihi,okunma_tarihi,TCgonderen,TCalan)
		VALUES('Sistem Mesaj�','Alm�� oldu�unuz derse ait d�k�man, ilgili akademiyen taraf�ndan payla��lm��t�r.
		Ula�mak i�in TIKLAYIN',GETDATE(),NULL,'SYSTEM',(SELECT TOP 1 TC FROM @ogrenciler)
		)
	SET @mesaj_sayac = @mesaj_sayac + 1
	DELETE FROM @ogrenciler WHERE TC = (SELECT TOP 1 TC FROM @ogrenciler)
END
IF(@mesaj_sayac = 0) PRINT('Dersi alan ��renci bulunmamaktad�r.')
ELSE PRINT (CAST(@mesaj_sayac AS VARCHAR(5)) +' ��renci payla��lan duyuru hakk�nda bilgilendirildi!')
--INSERT INTO Dokuman (dokuman_turu,aciklama,ders_kodu) VALUES ('PDF','Matematik-1 dersi ge�mi� y�l�n vize sorular�',106)
--INSERT INTO Dokuman (dokuman_turu,aciklama,ders_kodu) VALUES ('PDF','Ayr�k Matematik dersi ge�mi� y�l�n vize sorular�',202)
--INSERT INTO Dokuman (dokuman_turu,aciklama,ders_kodu) VALUES ('Video','VTYS-2 video dersleri payla��lm��t�r.',101)
SET NOCOUNT OFF

--BEGIN TRANSACTION

	--DECLARE @islem_sonucu NVARCHAR(50)
	--EXEC [sp_dokuman_duzenleme(ekleme g�ncelleme silme)] 'INSERT', NULL , NULL ,'PDF','Matematik dersi �al��ma sorular�',101,@islem_sonucu OUTPUT
	--PRINT @islem_sonucu

	--EXEC [sp_dokuman_duzenleme(ekleme g�ncelleme silme)] 'INSERT', NULL , NULL ,'PDF','Lineer Cebir dersi �al��ma sorular�',108,@islem_sonucu OUTPUT
	--PRINT @islem_sonucu

	--Select * FROM mesaj

--ROLLBACK