CREATE PROCEDURE sp_sifre_degis
--UPDATE STORED PROCEDURE
--Bu prosedüre veritabanına kayıtlı kullanıcının şifresini değiştirmek için kullanılır.
--TC yi kontrol eder ve bulamaz ise hata fırlatır
--TC ve şifre uyumunu kontrol eder ve uyumsuz ise hata fırlatır.
  @pTC        VARCHAR(11),
  @pEskiSifre VARCHAR(25),
  @pYeniSifre VARCHAR(25)
AS
BEGIN
  SET NOCOUNT ON
  DECLARE @kontrol VARCHAR(11) = (SELECT Kullanicilar.TC FROM Kullanicilar WHERE Kullanicilar.TC = @pTC)
  IF(@kontrol IS NULL)
  BEGIN
	RAISERROR('Verilen TC ye ait kullanıcı bulunamadı!',16,1)
	RETURN
  END

  SET @kontrol = (SELECT Kullanicilar.TC FROM Kullanicilar WHERE Kullanicilar.TC = @pTC AND Kullanicilar.sifre = @pEskiSifre)

  IF(@kontrol IS NULL)
  BEGIN
	RAISERROR('Verilen TC ile şifre eşleşmemektedir!',16,1)
	RETURN
  END
  BEGIN TRY
	UPDATE Kullanicilar SET sifre = @pYeniSifre  WHERE Kullanicilar.TC = @pTC AND Kullanicilar.sifre = @pEskiSifre
	PRINT ('Şifre başarılı bir şekilde değiştirildi!')
  END TRY
  BEGIN CATCH
	PRINT ('Bir hata ile karşılaşıldı. Hata kodu : ' + error_number() + ' . Hata mesajı :' + error_message())
  END CATCH
END

--EXEC dbo.sp_sifre_degis 12758191725,948,940
--EXEC dbo.sp_sifre_degis 14586369525,220,110
--EXEC dbo.sp_sifre_degis 20258412366,226,1