CREATE procedure sp_ders_silme (@ders_kodu int) 
AS
/*
Dersin verilerini silebilmek için en alt bağımlılıklardan silmeye başlanmalıdır.
Bu nedenle öncelikle ilgili dersin sınavlarının sorularının çeldirici cevapları silinmiştir.
Bu döngüden bir üstte olan sorular, onun üstündeki sınavlar oluşturma ardından da sınavlar silinmiştir.

Bu bağlardan bağımsız olan dersalma ve verme tabloları ardından silinmiştir.
Son olarak dersin kendisi kayıttan silinmiştir.
*/

BEGIN
SET NOCOUNT ON
	IF(SELECT ders_kodu FROM Ders Where Ders.ders_kodu = @ders_kodu) IS NULL 
	BEGIN
		RAISERROR('Verilen ders koduna ait ders bulunamamaktadır!',16,1)
		RETURN
	END
	
	BEGIN TRANSACTION
	------------------------------------------------------------------------------------
	BEGIN TRY
-- Ders alma tablosundan o dersin tarihlerini silme
		Delete from DersAlma where DersAlma.ders_kodu = @ders_kodu
	END TRY
	BEGIN CATCH
		RAISERROR ('DersAlma tablosundan silerken hata oluştu',16,1)
		ROLLBACK
		RETURN
	END CATCH

------------------------------------------------------------------------------------
	BEGIN TRY
-- Ders Verme tablosundan o dersin tarihlerini silme
		Delete from DersVerme where DersVerme.ders_kodu = @ders_kodu
	END TRY
	BEGIN CATCH
		RAISERROR ('DersVerme silerken hata oluştu',16,1)
		ROLLBACK
		RETURN
	END CATCH
------------------------------------------------------------------------------------
	BEGIN TRY
		DECLARE @dokuman_no TABLE (dokuman_no INT)

		INSERT INTO @dokuman_no SELECT OgrenciDokumanTakip.dokuman_no FROM OgrenciDokumanTakip INNER JOIN Dokuman On Dokuman.dokuman_no = OgrenciDokumanTakip.dokuman_no 
			INNER JOIN Ders ON Ders.ders_kodu = Dokuman.ders_kodu 
		where Ders.ders_kodu = @ders_kodu

		Delete from OgrenciDokumanTakip Where OgrenciDokumanTakip.dokuman_no IN (Select dokuman_no from @dokuman_no)
	END TRY
	BEGIN CATCH
		RAISERROR ('OgrenciDokumanTakip tablosunu silerken hata oluştu',16,1)
		ROLLBACK
		RETURN
	END CATCH
------------------------------------------------------------------------------------
	BEGIN TRY
		Delete from Dokuman where Dokuman.ders_kodu = @ders_kodu
	END TRY
	BEGIN CATCH
		RAISERROR ('Dokuman silerken hata oluştu',16,1)
		ROLLBACK
		RETURN
	END CATCH
---------------------------------------------------------------------------------
	BEGIN TRY
		DECLARE @sinav_kodu TABLE (sinav_kodu INT)

		INSERT INTO @sinav_kodu SELECT SinavaGirme.sinav_kodu FROM SinavaGirme INNER JOIN Sinav On Sinav.sinav_kodu = SinavaGirme.sinav_kodu 
			INNER JOIN Ders ON Ders.ders_kodu = Sinav.ders_kodu where Ders.ders_kodu = @ders_kodu
		
		Delete from SinavaGirme Where SinavaGirme.sinav_kodu IN (Select sinav_kodu from @sinav_kodu)

	END TRY
	BEGIN CATCH
		RAISERROR ('SinavaGirme tablosunu silerken hata oluştu',16,1)
		ROLLBACK
		RETURN
	END CATCH
---------------------------------------------------------------------------------
	BEGIN TRY
-- Sınavların idsini hafızada tutmak için geçici tablo oluşturma
Declare @sinavlarid TABLE (id int)

-- Sınavların idsini geçici tabloya aktarma
Insert into @sinavlarid Select SinavOlusturma.sinav_kodu from Ders
	inner join Sinav on Sinav.ders_kodu = Ders.ders_kodu
	inner join SinavOlusturma on SinavOlusturma.sinav_kodu = Sinav.sinav_kodu
	where Ders.ders_kodu = @ders_kodu

-- Sınav oluşturma tablosundan sınav sorularının idlerini Silme
Delete from SinavOlusturma where SinavOlusturma.sinav_kodu IN(Select id from @sinavlarid)
	END TRY
	BEGIN CATCH
		RAISERROR ('Sınav Oluşturma tablosundaki verileri silerken hata oluştu',16,1)
		ROLLBACK
		RETURN
	END CATCH
------------------------------------------------------------------------------------
	BEGIN TRY
		-- Çeldiricileri hafızada tutmak için geçici tablo oluşturma
		Declare @celdiricilerid TABLE (id int)
		-- Çeldiricileri geçici tabloya aktarma
		Insert into @celdiricilerid Select Celdirici.yanlis_cevap_no from Ders
		inner join Sinav on Sinav.ders_kodu = Ders.ders_kodu
		inner join SinavOlusturma on SinavOlusturma.soru_no = Sinav.sinav_kodu
		inner join Soru on Soru.soru_no = SinavOlusturma.soru_no
		inner join Celdirici on Celdirici.soru_no = soru.soru_no
		where Ders.ders_kodu = @ders_kodu

		-- Çeldiricileri Silme
		Delete from Celdirici where Celdirici.yanlis_cevap_no IN(Select id from @celdiricilerid)
	END TRY
	BEGIN CATCH
		RAISERROR ('Çeldirici silerken hata oluştu',16,1)
		ROLLBACK
		RETURN
	END CATCH

--------------------------------------------------------------------------------

	BEGIN TRY
-- Soruların idsini hafızada tutmak için geçici tablo oluşturma
	Declare @sorularid TABLE (id int)

-- Soruların idsini geçici tabloya aktarma
	Insert into @sorularid Select Soru.soru_no from Ders
	inner join Sinav on Sinav.ders_kodu = Ders.ders_kodu
	inner join SinavOlusturma on SinavOlusturma.soru_no = Sinav.sinav_kodu
	inner join Soru on Soru.soru_no = SinavOlusturma.soru_no
	where Ders.ders_kodu = @ders_kodu

-- Soruları Silme
Delete from Soru where Soru.soru_no IN(Select id from @sorularid)
	END TRY
	BEGIN CATCH
		RAISERROR ('Soru silerken hata oluştu!',16,1)
		ROLLBACK
		RETURN
	END CATCH
-----------------------------------------------------------------------------------
	BEGIN TRY
-- Sınavların idsini hafızada tutmak için geçici tablo oluşturma
Declare @sinavgenelid TABLE (id int)

-- Sınavların idsini geçici tabloya aktarma
Insert into @sinavgenelid Select Sinav.sinav_kodu from Ders
	inner join Sinav on Sinav.ders_kodu = Ders.ders_kodu
	where Ders.ders_kodu = @ders_kodu

-- Sınav tablosundan sınavları Silme
Delete from Sinav where Sinav.sinav_kodu IN(Select id from @sinavgenelid)
	END TRY
	BEGIN CATCH
		RAISERROR ('Sınav silerken hata oluştu',16,1)
		ROLLBACK
		RETURN
	END CATCH
------------------------------------------------------------------------------------

	BEGIN TRY
		Delete from Ders where Ders.ders_kodu = @ders_kodu
	END TRY
	BEGIN CATCH
		RAISERROR ('Ders silerken hata oluştu',16,1)
		ROLLBACK
		RETURN
	END CATCH
	COMMIT TRANSACTION
	PRINT('İşlem Başarılı')
	SET NOCOUNT OFF
------------------------------------------------------------------------------------
END

--select * from Ders

--EXEC dbo.sp_ders_silme 108
--EXEC dbo.sp_ders_silme 106
--EXEC dbo.sp_ders_silme 107
