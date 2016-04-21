ALTER TRIGGER trg_dokuman_haber_verme ON Dokuman AFTER Insert  
AS
--TRIGGER
--Herhangi bir akademisyen tarafýndan döküman eklenirse dersi alan öðrencilere sistem tarafýndan mesaj gönderilmektedir
--Bu trigger otomatik mesaj gönderme iþini yapmaktadýr.
SET NOCOUNT ON
--Admin kullanýcýsý, veritabanýnda diðer kullanýcýlara sistem mesajý göndermek için oluþturulmuþtur
--Daha önceki sürümlerde kullanýlmadýðý için trigger içinde insert edilmiþtir.
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
		VALUES('Sistem Mesajý','Almýþ olduðunuz derse ait döküman, ilgili akademiyen tarafýndan paylaþýlmýþtýr.
		Ulaþmak için TIKLAYIN',GETDATE(),NULL,'SYSTEM',(SELECT TOP 1 TC FROM @ogrenciler)
		)
	SET @mesaj_sayac = @mesaj_sayac + 1
	DELETE FROM @ogrenciler WHERE TC = (SELECT TOP 1 TC FROM @ogrenciler)
END
IF(@mesaj_sayac = 0) PRINT('Dersi alan öðrenci bulunmamaktadýr.')
ELSE PRINT (CAST(@mesaj_sayac AS VARCHAR(5)) +' öðrenci paylaþýlan duyuru hakkýnda bilgilendirildi!')
--INSERT INTO Dokuman (dokuman_turu,aciklama,ders_kodu) VALUES ('PDF','Matematik-1 dersi geçmiþ yýlýn vize sorularý',106)
--INSERT INTO Dokuman (dokuman_turu,aciklama,ders_kodu) VALUES ('PDF','Ayrýk Matematik dersi geçmiþ yýlýn vize sorularý',202)
--INSERT INTO Dokuman (dokuman_turu,aciklama,ders_kodu) VALUES ('Video','VTYS-2 video dersleri paylaþýlmýþtýr.',101)
SET NOCOUNT OFF

--BEGIN TRANSACTION

	--DECLARE @islem_sonucu NVARCHAR(50)
	--EXEC [sp_dokuman_duzenleme(ekleme güncelleme silme)] 'INSERT', NULL , NULL ,'PDF','Matematik dersi çalýþma sorularý',101,@islem_sonucu OUTPUT
	--PRINT @islem_sonucu

	--EXEC [sp_dokuman_duzenleme(ekleme güncelleme silme)] 'INSERT', NULL , NULL ,'PDF','Lineer Cebir dersi çalýþma sorularý',108,@islem_sonucu OUTPUT
	--PRINT @islem_sonucu

	--Select * FROM mesaj

--ROLLBACK