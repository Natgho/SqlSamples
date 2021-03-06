CREATE PROCEDURE sp_harf_notu @ogrenci_no VARCHAR(11) AS
BEGIN
--öncelikle gönderilen öğrenci numrasında kayıt olup olmadığını kontrol edildi.Aksi durumda hata mesajı ekrana basıldı.
IF(select ogrenci_no from Ogrenci where ogrenci_no=@ogrenci_no) is null
	BEGIN
		PRINT 'Sisteme kayıtlı '+ @ogrenci_no+' numaralı öğrenci bulunmamaktadır !!!'
	END
else
begin
--cursorda kullanacağımız değişkenler tanımlandı.
	DECLARE @ogrno VARCHAR(11);
	DECLARE @ders_adi NVARCHAR(50);
	DECLARE @not INT;
	DECLARE @harf_notu NVARCHAR(10);
--CURSOR tanımlandı.
	DECLARE myCUR CURSOR FOR
--Select sorgusu yazıldı ve kullanılacak değerlere göre istenilen kısım çekildi.
--Select sorgusunda procedure çalıştırılken gönderilen öğrenci numrasına göre şart yazıldı.Ders adına göre gruplama yapılarak vize ve final notlarının ortalamsı alındı.
		SELECT O.ogrenci_no,D.ders_adi,AVG(S.sinav_notu)as ort FROM
			   Ogrenci O inner join SinavaGirme S ON
			   O.ogrenci_no=S.ogrenci_no inner join Sinav Si ON
			   S.sinav_kodu=Si.sinav_kodu inner join Ders D ON
			   Si.ders_kodu=D.ders_kodu inner join SinavTipi ST ON
			   Si.sinav_tipi_no=ST.sinav_tipi_no
			   WHERE O.ogrenci_no=@ogrenci_no
			   GROUP BY D.ders_adi,O.ogrenci_no	   
	OPEN myCUR
--select sorgusunda çekilecek olan alanlar değikenlere atandı.
	FETCH NEXT FROM myCUR INTO @ogrno,@ders_adi,@not
--öğrenci numrasının ekranda sadece bir defa görünmesini istediğimizden aşağıdaki mesajı while döngüsünün dışına yazdık.
	PRINT '	'+@ogrno+' numaralı öğrencinin ders notları aşağıda verilmiştir.'
	WHILE @@FETCH_STATUS=0
		BEGIN
--harf notlarının belirlenmesi için case-when yapısını kullandık.
			set @harf_notu = CASE	
				WHEN (@not>=90 AND @not <=100) THEN 'AA'
				WHEN (@not>=85 AND @not <=89) THEN 'BA'
				WHEN (@not>=80 AND @not <=84) THEN 'BB'
				WHEN (@not>=75 AND @not <=79) THEN 'CB'
				WHEN (@not>=65 AND @not <=74) THEN 'CC'
				WHEN (@not>=60 AND @not <=64) THEN 'DC'
				WHEN (@not>=55 AND @not <=59) THEN 'DD'
				WHEN (@not>=50 AND @not <=54) THEN 'FD'
				WHEN (@not<49) THEN 'FF'
			END
--Harf notlarının hesabıda belirlendiğine göre artık mesajımızı ekrana yazdırabiliriz.
--@not değişkeni int tanımladığından öncelikle cast işlemi uyguladık.
			PRINT @ders_adi+' -> '+CAST(@not AS VARCHAR(5))+' -> '+@harf_notu
--Bir sonraki satıra geçmesini sağladık.
			FETCH NEXT FROM myCUR INTO  @ogrno,@ders_adi,@not
		END
--CURSOR'u kapattık.
	CLOSE myCUR
	DEALLOCATE myCUR
end
END

--EXEC sp_harf_notu '12001010001'
--EXEC sp_harf_notu '12001010002'
--EXEC sp_harf_notu '12001010003'
--EXEC sp_harf_notu '12001010009'
