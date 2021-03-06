CREATE PROCEDURE [sp_dokuman_duzenleme(ekleme güncelleme silme)]
--TRANSACTION PROCEDURE
--(######INSERT ISLEMI SONRADAN TRIGGER I TETIKLEMESI ICIN EKLENMISTIR.###########)
--Stored procedure verilen değerlere göre veritabanındaki döküman tablosunu update ve delete işlemi yapar.
--INSERT için islem_turu = 'INSERT' ## UPDATE için islem_turu = 'UPDATE' ## DELETE için islem_turu = 'DELETE' verilmelidir.
--Değişebilen değerler döküman tablosundaki dokuman_turu ve aciklama sütunlarıdır.
--Değerlerden birisi NULL verilir ise o sütun değiştirilmez.
@islem_turu NVARCHAR(11),
@personel_no VARCHAR(11),
@dokuman_no INT,
@dokuman_turu NVARCHAR(10) = NULL,
@aciklama NVARCHAR(50) = NULL,
@ders_kodu INT = NULL, --INSERT ISLEMI YAPILACAGI ZAMAN GONDERILIR. ONUN DISINDA NULL GONDERILIR
@islem_sonucu NVARCHAR(50) OUTPUT
AS
BEGIN
	SET NOCOUNT ON	
	BEGIN TRANSACTION
	IF(@islem_turu <> 'INSERT')
	BEGIN
			SET @islem_sonucu = ('Update veya Delete işlemi gerçekleşmedi')
			IF(ISNULL((SELECT top 1 Dokuman.dokuman_no FROM Dokuman WHERE Dokuman.dokuman_no = @dokuman_no),0)=0)
			BEGIN
				RAISERROR('Döküman no ya ait döküman tabloda bulunamadı!',16,1)
				RETURN 0
			END
				DECLARE @kontrol VARCHAR(11) = (SELECT Akademisyen.personel_no FROM Akademisyen INNER JOIN DersVerme 
				ON Akademisyen.personel_no=DersVerme.personel_no INNER JOIN Ders  
				ON Ders.ders_kodu = DersVerme.ders_kodu INNER JOIN Dokuman ON Dokuman.ders_kodu = Ders.ders_kodu
				WHERE Akademisyen.personel_no = @personel_no AND Dokuman.dokuman_no = @dokuman_no)
			IF(@kontrol IS NULL)
			BEGIN
				RAISERROR('Personel no ile uyumlu akademisyen yada akademisyene ait döküman tabloda bulunamadı!',16,1)
				RETURN 0
			END
			
			IF(@islem_turu = 'UPDATE')
			BEGIN
				BEGIN TRY
					IF (@dokuman_turu IS NOT NULL) UPDATE Dokuman SET dokuman_turu = @dokuman_turu WHERE Dokuman.dokuman_no = @dokuman_no
					IF (@aciklama IS NOT NULL) UPDATE Dokuman SET aciklama = @aciklama WHERE Dokuman.dokuman_no = @dokuman_no
					SET @islem_sonucu = 'Update işlemi başarılı!'
				END	TRY
				BEGIN CATCH
					SET @islem_sonucu = ('Update sırasında bir hata oluştu. Hata kodu : ' + ERROR_NUMBER() + ' . Hata : ' + ERROR_MESSAGE())
					ROLLBACK
					RETURN 0
				END CATCH
			END
			ELSE IF (@islem_turu = 'DELETE')
			BEGIN
				BEGIN TRY
					IF(SELECT top 1 dokuman_no FROM OgrenciDokumanTakip WHERE OgrenciDokumanTakip.dokuman_no = @dokuman_no) IS NOT NULL
					BEGIN
						DELETE FROM OgrenciDokumanTakip WHERE OgrenciDokumanTakip.dokuman_no = @dokuman_no
					END
					DELETE FROM Dokuman WHERE Dokuman.dokuman_no = @dokuman_no
					SET @islem_sonucu = 'Delete işlemi başarılı!'
				END TRY
				BEGIN CATCH
					SET @islem_sonucu = ('Delete sırasında bir hata oluştu. Hata kodu : ' + ERROR_NUMBER() + ' . Hata : ' + ERROR_MESSAGE())
					ROLLBACK
					RETURN 0
				END CATCH
			END
			ELSE
			BEGIN
				RAISERROR('Belirtilen işlem tanımlanamadı. İşlem yapılamaz!',16,1)
				ROLLBACK
				RETURN 0
			END
			COMMIT TRANSACTION
			SET NOCOUNT OFF
	END
	ELSE
	BEGIN
		BEGIN TRY
			IF(@dokuman_turu IS NOT NULL) AND (@aciklama IS NOT NULL) AND (@ders_kodu IS NOT NULL)
			BEGIN
				INSERT INTO Dokuman VALUES (@dokuman_turu,@aciklama,@ders_kodu)
				SET @islem_sonucu = 'Insert işlemi başarılı!'
			END
			ELSE RAISERROR('Tabloya eklenmesi gereken değerler NULL verilmiş!',16,1)
		END TRY
		BEGIN CATCH
			ROLLBACK
			SET @islem_sonucu = ('Insert sırasında bir hata oluştu. Hata kodu : ' + ERROR_NUMBER() + ' . Hata : ' + ERROR_MESSAGE())
			RETURN
		END CATCH
	END
	COMMIT TRANSACTION
	--DECLARE @islem_sonucu NVARCHAR(50)
	--EXEC [sp_dokuman_duzenleme(ekleme güncelleme silme)] 'UPDATE', '15101030009', 1,NULL,NULL,NULL,@islem_sonucu OUTPUT
	--PRINT @islem_sonucu

	--DECLARE @islem_sonucu NVARCHAR(50)
	--EXEC [sp_dokuman_duzenleme(ekleme güncelleme silme)] 'UPDATE', '15101030009', 7,'## PDF','## Matematik - 1  ders notları',NULL,@islem_sonucu OUTPUT
	--PRINT @islem_sonucu

	--DECLARE @islem_sonucu NVARCHAR(50)
	--EXEC [sp_dokuman_duzenleme(ekleme güncelleme silme)] 'DELETE', '15101030013', 1,NULL,NULL,NULL,@islem_sonucu OUTPUT
	--PRINT @islem_sonucu

	--TRIGGER I TETIKLEMEKTEDIR
	--DECLARE @islem_sonucu NVARCHAR(50)
	--EXEC [sp_dokuman_duzenleme(ekleme güncelleme silme)] 'INSERT', NULL , NULL ,'PDF','Matematik dersi çalışma soruları',101,@islem_sonucu OUTPUT
	--PRINT @islem_sonucu

	--TRIGGER I TETIKLEMEKTEDIR
	--DECLARE @islem_sonucu NVARCHAR(50)
	--EXEC [sp_dokuman_duzenleme(ekleme güncelleme silme)] 'INSERT', NULL , NULL ,'PDF','Lineer Cebir dersi çalışma soruları',108,@islem_sonucu OUTPUT
	--PRINT @islem_sonucu
END