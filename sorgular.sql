--SORGU 1 : Akademisyenlerin payla�t��� d�k�manlar� derslere g�re gruplayarak listeleyin.

select Akademisyen.personel_no,Ders.ders_adi,Dokuman.dokuman_turu 
from Akademisyen inner join DersVerme
	on Akademisyen.personel_no = DersVerme.personel_no inner join Ders 
		on DersVerme.ders_kodu = Ders.ders_kodu inner join Dokuman
			on Dokuman.ders_kodu = Ders.ders_kodu
group by Ders.ders_adi, Akademisyen.personel_no,Dokuman.dokuman_turu

--SORGU 2 : Her ��rencinin ald��� derslerin kredileri toplam�n� azalan s�rayla yazd�r�n.

select Kullanicilar.ad,Kullanicilar.soyad, sum(Ders.kredi) as toplam_kredi
from Kullanicilar inner join Ogrenci 
		on Ogrenci.TC=Kullanicilar.TC inner join DersAlma 
			on Ogrenci.ogrenci_no = DersAlma.ogrenci_no inner join Ders 
				on Ders.ders_kodu = DersAlma.ders_kodu
group by Kullanicilar.ad,Kullanicilar.soyad
order by toplam_kredi desc

--SORGU 3 : Sistemdeki 1 numaral� duyuruyu g�r�nt�lemeyen ��rencilerin adlar�n� ve soyadlar�n� yazd�r�n�z.*

select Kullanicilar.ad,Kullanicilar.soyad from Kullanicilar inner join Ogrenci 
	on Kullanicilar.TC = Ogrenci.TC
EXCEPT
select Kullanicilar.ad,Kullanicilar.soyad from Kullanicilar inner join DuyuruGoruntulenme
	on Kullanicilar.TC = DuyuruGoruntulenme.TC inner join Duyuru 
		on Duyuru.duyuru_no = DuyuruGoruntulenme.duyuru_no
where Duyuru.duyuru_no=1
order by Kullanicilar.ad,Kullanicilar.soyad

--SORGU 4 : 2014-2015 y�l� bahar d�nemi vize ve final sinav tarihlerini listeleyin.*

select distinct Ders.ders_adi,Sinav.tarih from Sinav inner join Ders 
	on Sinav.ders_kodu = Ders.ders_kodu inner join DersAlma 
		on DersAlma.ders_kodu = Ders.ders_kodu
where DersAlma.ogretim_yili = '2014-2015' and DersAlma.donem ='Bahar' and Sinav.sinav_tipi_no = 1
UNION
select distinct Ders.ders_adi,Sinav.tarih from Sinav inner join Ders 
	on Sinav.ders_kodu = Ders.ders_kodu inner join DersAlma 
		on DersAlma.ders_kodu = Ders.ders_kodu
where DersAlma.ogretim_yili = '2014-2015' and DersAlma.donem ='Bahar' and Sinav.sinav_tipi_no = 2
order by Sinav.tarih

--SORGU 5 : Lineer Cebir dersi 2014-2015 bahar final s�nav sorular� listeleyin. *

select distinct Soru.aciklama,Soru.dogru_cevap from Ders inner join DersAlma 
	on Ders.ders_kodu = DersAlma.ders_kodu inner join Sinav
		on Sinav.ders_kodu = Ders.ders_kodu inner join SinavOlusturma 
			on Sinav.sinav_kodu = SinavOlusturma.sinav_kodu inner join Soru 
				on Soru.soru_no = SinavOlusturma.soru_no
where Ders.ders_adi = 'Lineer Cebir' and DersAlma.donem = 'Bahar' and DersAlma.ogretim_yili = '2013-2014'
and Sinav.sinav_tipi_no = 2

--SORGU 6 : Final notu 40' �n alt�nda olan ��rencileri derslere g�re gruplayarak, ders ad�na g�re A dan Z ye s�ralayarak,
--��rencilerin say�s�n� bulunuz.

select Ders.ders_adi,count(SinavaGirme.ogrenci_no) as dersten_kalan_ogr_sayisi from SinavaGirme inner join Sinav 
	on Sinav.sinav_kodu = SinavaGirme.sinav_kodu inner join Ders
		on Ders.ders_kodu = Sinav.ders_kodu
where Sinav.sinav_tipi_no = 2 and SinavaGirme.sinav_notu < 40
group by Ders.ders_adi
order by Ders.ders_adi

--SORGU 7 : Bilgisayar M�hendisli�ine Giri� dersinde akademisyenin payla�t��� d�k�man� vize s�nav tarihinden daha ileri 
--bir tarihte g�r�nt�leyen ��rencilerin bilgilerini getirin. *

select distinct Kullanicilar.ad,Kullanicilar.soyad,Ogrenci.ogrenci_no,OgrenciDokumanTakip.goruntulenme_tarihi 
from Akademisyen inner join DersVerme
	on Akademisyen.personel_no = DersVerme.personel_no inner join Ders 
		on DersVerme.ders_kodu=Ders.ders_kodu inner join Dokuman
			on Dokuman.ders_kodu=Ders.ders_kodu inner join OgrenciDokumanTakip 
				on OgrenciDokumanTakip.dokuman_no=Dokuman.dokuman_no inner join Ogrenci
					on Ogrenci.ogrenci_no=OgrenciDokumanTakip.ogrenci_no inner join Sinav
						on Ders.ders_kodu=Sinav.ders_kodu inner join Kullanicilar
							on Ogrenci.TC = Kullanicilar.TC
where Ders.ders_adi='Bilgisayar M�hendisli�ine Giri�' and Sinav.sinav_tipi_no= 1 
	and OgrenciDokumanTakip.goruntulenme_tarihi>Sinav.tarih

--SORGU 8 : 2013-2014 Bahar d�nemi Lineer Cebir dersi final s�nav� notu, ortalaman�n �zerinde olan ��rencilerin 
--adlar�n�, soyadlar�n� ve notlar�n� listeleyin.

select Kullanicilar.ad,Kullanicilar.soyad,SinavaGirme.sinav_notu 
	from Kullanicilar inner join Ogrenci 
		on Ogrenci.TC=Kullanicilar.TC inner join SinavaGirme 
			on SinavaGirme.ogrenci_no = Ogrenci.ogrenci_no 
where SinavaGirme.sinav_kodu in (
	select distinct Sinav.sinav_kodu from Ders inner join Sinav 
		on Sinav.ders_kodu = Ders.ders_kodu inner join DersAlma
			on Ders.ders_kodu = DersAlma.ders_kodu
	where Sinav.sinav_tipi_no = 2 and Ders.ders_adi='Lineer Cebir' 
	and DersAlma.donem = 'Bahar' and DersAlma.ogretim_yili ='2013-2014'
)
and SinavaGirme.sinav_notu >= (
	select distinct AVG(sinav_notu) from Sinav inner join Ders	
		on Ders.ders_kodu = Sinav.ders_kodu inner join SinavaGirme
			on SinavaGirme.sinav_kodu = Sinav.sinav_kodu
	where Ders.ders_adi = 'Lineer Cebir' and Sinav.sinav_tipi_no = 1
)

--SORGU 9 : Lineer Cebir dersinin genel notu(vize ve finalin ortalamas�) 10 ile 100 aras�nda olan
--��rencilerin ortalamas�n� hesaplay�n. 

select AVG(ort) as ortalama from
(
	select Ogrenci.ogrenci_no,AVG(sinav_notu) as ort from Sinav inner join SinavaGirme 
		on Sinav.sinav_kodu = SinavaGirme.sinav_kodu inner join Ogrenci
			on Ogrenci.ogrenci_no = SinavaGirme.ogrenci_no inner join Ders
				on Ders.ders_kodu = Sinav.ders_kodu
	where Ders.ders_adi = 'Lineer Cebir'
	group by Ogrenci.ogrenci_no
	having AVG(sinav_notu) >= 10 and AVG(sinav_notu) <100
)temp

--SORGU 10 : Algoritma Programlama - 1 dersinin vizesinde 40 �n �st� al�pda finalde 40 �n alt�nda kalan ��rencileri s�ralay�n. *

select distinct Kullanicilar.ad , Kullanicilar.soyad 
from Kullanicilar inner join Ogrenci 
	on Kullanicilar.TC = Ogrenci.TC inner join DersAlma
		on Ogrenci.ogrenci_no = DersAlma.ogrenci_no inner join Ders
			on Ders.ders_kodu = DersAlma.ders_kodu inner join SinavaGirme 
				on Ogrenci.ogrenci_no = SinavaGirme.ogrenci_no
where SinavaGirme.sinav_notu >= 40 and SinavaGirme.sinav_kodu = (
	select Sinav.sinav_kodu from Sinav inner join Ders
		on Ders.ders_kodu = Sinav.ders_kodu 
		where Sinav.sinav_tipi_no = 1 and Ders.ders_adi = 'Algoritma Programlama - 1'
)
intersect
select distinct Kullanicilar.ad , Kullanicilar.soyad 
from Kullanicilar inner join Ogrenci 
	on Kullanicilar.TC = Ogrenci.TC inner join DersAlma
		on Ogrenci.ogrenci_no = DersAlma.ogrenci_no inner join Ders
			on Ders.ders_kodu = DersAlma.ders_kodu inner join SinavaGirme 
				on Ogrenci.ogrenci_no = SinavaGirme.ogrenci_no
where SinavaGirme.sinav_notu < 40 and SinavaGirme.sinav_kodu = (
	select Sinav.sinav_kodu from Sinav inner join Ders
		on Ders.ders_kodu = Sinav.ders_kodu 
		where Sinav.sinav_tipi_no = 2 and Ders.ders_adi = 'Algoritma Programlama - 1'
)

--SORGU 11 : Bilgisayar M�hendisli�ine Giri� dersinin 2013-2014 bahar d�nemi vize s�nav�na girmeyen ��rencilerin 
--e�er S�nav ba�l�kl� mesaj ile ileti�ime ge�memi�lerse e-mail adreslerini getirin.

select Kullanicilar.ad,Kullanicilar.soyad,Iletisim.mail from (
	select distinct Ogrenci.ogrenci_no
	from Ogrenci inner join DersAlma 
		on Ogrenci.ogrenci_no = DersAlma.ogrenci_no inner join Ders 
			on Ders.ders_kodu=DersAlma.ders_kodu 
	where Ders.ders_adi like 'Bilgisayar M�hendisli�ine Giri�' and DersAlma.ogretim_yili = '2013-2014'
	--BMG dersini alan ��renciler se�iliyor
	except
		select distinct SinavaGirme.ogrenci_no 
		from SinavaGirme inner join Sinav
			on SinavaGirme.sinav_kodu = Sinav.sinav_kodu
		where SinavaGirme.ogrenci_no in (
			select distinct Ogrenci.ogrenci_no
			from Ogrenci inner join DersAlma
				on Ogrenci.ogrenci_no = DersAlma.ogrenci_no inner join Ders 
					on Ders.ders_kodu=DersAlma.ders_kodu 
			where Ders.ders_adi like 'Bilgisayar M�hendisli�ine Giri�' and DersAlma.ogretim_yili = '2013-2014'
		)
		and Sinav.sinav_kodu = (
			select Sinav.sinav_kodu from Sinav inner join Ders
				on Sinav.ders_kodu = Ders.ders_kodu 
			where Ders.ders_adi = 'Bilgisayar M�hendisli�ine Giri�' and Sinav.sinav_tipi_no = 1
		)
	-- BMG dersinin sinavina giren ��renciler listeden except ile ��kar�l�yor.
		except
		select distinct Ogrenci.ogrenci_no 
			from Mesaj inner join Kullanicilar 
				on Mesaj.TCgonderen= Kullanicilar.TC inner join Ogrenci
					on Ogrenci.TC = Kullanicilar.TC
			where Mesaj.konusu = 'S�nav'
	--BMG dersinin s�nav�na girmeyip mesaj atanlar se�iliyor
) temp inner join Ogrenci 
	on Ogrenci.ogrenci_no = temp.ogrenci_no inner join Kullanicilar
		on Kullanicilar.TC = Ogrenci.TC inner join Iletisim 
			on Iletisim.TC = Kullanicilar.TC
order by Kullanicilar.ad
