using mttLibraryProject.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using System.Runtime.Remoting.Contexts;
using System.Web;
using System.Web.Management;
using System.Web.Mvc;

namespace mttLibraryProject.Controllers
{
    public class IndexController : Controller
    {
        //Context c= new Context();
        Ogrenci ogr=new Ogrenci();//Öğrenci sınıfı nesnesi
        Kitap ktp= new Kitap();//Kitap sınıfı nesnesi
        VerilenKitaplar vrlktp= new VerilenKitaplar();
        VerilenKitapKanit vrlktpknt=new VerilenKitapKanit();
        Borc brc= new Borc();   
        dbCntx db= new dbCntx();//Database nesnesi

        
        // GET: Index
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult About()
        {
            var tumOgrenciler= db.ogrenciler.ToList();
            return View(tumOgrenciler);
        }

        [HttpPost]
        public ActionResult Contact(string kitapAdi, string yazarAdi, string kitapTuru, int kitapAdedi, string sayfaSayisi, string kitapKonumu, string aciklama,HttpPostedFileBase resim) 
        {
            
            var kontrol = db.kitaplar.Where(x => x.KitapAdi == kitapAdi).ToList();
            bool kitapEklemeKontrol = false;
            if (kontrol.Count >= 1)
            {
                kitapEklemeKontrol = false;
            }
            else
            {
                kitapEklemeKontrol = true;
            }
            if (kitapEklemeKontrol==true)
            {
                if (ModelState.IsValid)
                {
                    if (resim.ContentLength > 0)
                    {
                        var image = Path.GetFileName(resim.FileName);
                        var path = Path.Combine(Server.MapPath("/resimlerr"), image);
                        resim.SaveAs(path);
                        ktp.KitapResimYol = "/resimlerr/" + image;
                        // u1.resim = "/resimlerr/" + image;

                    }
                }
                // kitap nesnesine gerekli veriler eklenir

                ktp.Aciklama = aciklama;
                ktp.KitapTuru = kitapTuru;
                ktp.KitapAdi = kitapAdi;
                ktp.SayfaSayisi = sayfaSayisi;
                ktp.KitapKonumu = kitapKonumu;
                ktp.Yazar = yazarAdi;
                ktp.KitapAdedi = kitapAdedi;

                //databasete kitap nesnesi paket halinde eklenir
                db.kitaplar.Add(ktp);
                db.SaveChanges();

                 
            }
            else
            {
                 //404 Sayfasına yollanacak
            }
            
            return RedirectToAction("Shop");
        }//Kitap ekleme
        public ActionResult Contact()
        {
            return View();
        }
        public ActionResult Shop()
        {
            var tumUrunler = db.kitaplar.ToList();
            return View(tumUrunler);
        }

        [HttpPost]
        public ActionResult UyeEkle(string ad, string soyad,string tc_no, string okul_no)
        {
            //Kontroller çalışıyor yapılması gereken uyarı mesajı kaldı.
            var kontrol= db.ogrenciler.Where(x => x.TcNo == tc_no).ToList();
            var kontrol2 = db.ogrenciler.Where(x => x.OkulNo == okul_no).ToList();
            bool eklemeKontrol=false;
            if (kontrol.Count >= 1 || kontrol2.Count>=1)
            {
                eklemeKontrol = false;
            }
            else
            {
                eklemeKontrol = true;
            }
            if (eklemeKontrol==true)
            {
                ogr.Ad = ad;
                ogr.Soyad = soyad;
                ogr.OkulNo = okul_no;
                ogr.TcNo = tc_no;

                db.ogrenciler.Add(ogr);
                db.SaveChanges();
            }
            else
            {
                //
            }


            return View();
        }
        public ActionResult UyeEkle()
        {
            return View();
        }

        [HttpPost]
        public ActionResult KitapVer(string tc_noKitapVer, string okul_noKitapVer,string kitapAdiKitapVer)
        {
            
            var kisiKontrolTc=db.ogrenciler.Where(x=> x.TcNo == tc_noKitapVer).ToList();
            var kisiKontrolOkulNo = db.ogrenciler.Where(x => x.OkulNo == okul_noKitapVer).ToList();
            
            if (kisiKontrolOkulNo.Count >=1 || kisiKontrolTc.Count>=1)
            {
                DateTime bugun = DateTime.Now;
                int sure = 15;
                //Kitap Verilecek
               
                vrlktp.Ad = kisiKontrolTc[0].Ad;
                vrlktp.Soyad = kisiKontrolTc[0].Soyad;
                vrlktp.Okul_NO = kisiKontrolTc[0].OkulNo;
                vrlktp.Tarih = DateTime.Now;
                vrlktp.TeslimTarih= bugun.AddDays(15);
                vrlktp.KitapAdi = kitapAdiKitapVer;
                vrlktp.Tc_No = kisiKontrolTc[0].TcNo;
                vrlktp.KitapAlinanGun = bugun.Day;
                vrlktp.KitapTeslimGun= bugun.Day+sure;

                vrlktpknt.Ad = kisiKontrolTc[0].Ad;
                vrlktpknt.Soyad = kisiKontrolTc[0].Soyad;
                vrlktpknt.Okul_NO = kisiKontrolTc[0].OkulNo;
                vrlktpknt.Tarih = DateTime.Now;
                vrlktpknt.TeslimTarih = bugun.AddDays(1);
                vrlktpknt.KitapAdi = kitapAdiKitapVer;
                vrlktpknt.Tc_No = kisiKontrolTc[0].TcNo;
                vrlktpknt.KitapAlinanGun = bugun.Day;
                vrlktpknt.KitapTeslimGun = bugun.Day + sure;

                db.verilenKitapKanit.Add(vrlktpknt);
                db.verilenKitap.Add(vrlktp);
                db.SaveChanges();


                return RedirectToAction("Shop");
                
            }
            else
            {
                //Kişi kayıtlı olmadığı için kitap verilmeyecek
            }
            return View();
        }
        
        public ActionResult KitapVer(string veriAdi)
        {
            var kitapArama = db.kitaplar.Where(w => w.KitapAdi == veriAdi).ToList();
            return View(kitapArama);
        }

        //Kitap arama işlemleri
        [HttpPost]
        public ActionResult KitapAdiFiltrele(string kitapAdiAra)
        {
            var kitapAdiKontrol=db.kitaplar.Where(x=> x.KitapAdi.StartsWith(kitapAdiAra)).ToList();

            return View("Shop",kitapAdiKontrol);
        }

        [HttpPost]
        public ActionResult KitapYazarFiltrele(string yazarAdiFiltrele)
        {
            var kitapAdiKontrol = db.kitaplar.Where(x => x.Yazar.StartsWith(yazarAdiFiltrele)).ToList();

            return View("Shop", kitapAdiKontrol);
        }

        [HttpPost]
        public ActionResult KitapTuruFiltrele(string kitapTuruFiltrele)
        {
            var kitapAdiKontrol = db.kitaplar.Where(x => x.KitapTuru.StartsWith(kitapTuruFiltrele)).ToList();

            return View("Shop", kitapAdiKontrol);
        }
        //Kitap arama işlemler end




        public ActionResult Kanit()
        {
            var tumListe=db.verilenKitapKanit.ToList();
            return View(tumListe);
        }

        public ActionResult Teslim()
        {
            return View();
        }

        public ActionResult GeriKitapAl()
        {
            return View();
        }

        /*public ActionResult BorcGoruntule()
        {
            DateTime dateTime = DateTime.Now;
            var kitapAlanlar = db.verilenKitap.ToList();
            bool kontrol = false;
            int borc=0;

            foreach (var a in kitapAlanlar)
            {
                if(a.TeslimTarih>dateTime)
                {
                    kontrol = false;
                }
                else
                {
                    while (kontrol==false)
                    {
                        if (dateTime.Day==a.TeslimTarih.Day)
                        {
                            kontrol = true;
                            break;
                        }
                        else
                        {
                            dateTime=dateTime.AddDays(1);
                            kontrol=false;
                            borc++;
                        }
                       
                    }
                }
            }

            
            
            return View();
        }*/

        public ActionResult BorcGoruntule()
        {
            //DateTime date = DateTime.Now;
            int teslimGunu = 0;
            int borc = 0;
            int gun=0;
            //Borc brc=new Borc();
            var kontrol = db.verilenKitap.ToList();
            if (kontrol.Count > 0)
            {
                foreach (var a in db.verilenKitap)
                {
                    teslimGunu = 15;
                    gun = a.KitapAlinanGun + teslimGunu;
                    if (gun > a.KitapTeslimGun)
                    {
                        borc = teslimGunu - gun;
                        borc = borc * 5;

                        brc.Borc_Miktari = borc;
                        brc.Ad = a.KitapAdi;
                        brc.Soyad = a.Soyad;
                        brc.TeslimTarihiGecenSure = teslimGunu - gun;

                        db.borc.Add(brc);
                        db.SaveChanges();
                    }
                }
            }
            
            var tumBorclar = db.borc.ToList();
            return View(tumBorclar);
        }
        public ActionResult KitapAl(int id)
        {
            var sorgu=db.verilenKitap.Where(x=> x.Id== id).ToList();
            db.verilenKitap.Remove(sorgu[0]);
            db.SaveChanges();
            return RedirectToAction("KitapTeslimEt");
        }
        public ActionResult KitapTeslimEt()
        {
            var tumKitaplar = db.verilenKitap.ToList();
            return View(tumKitaplar);
        }
        public ActionResult kitapguncel(int Id)
        {
            List<Kitap> ara = db.kitaplar.Where(x => x.Id == Id).ToList();

            return View(ara);
        }
        [HttpPost]
        public ActionResult kitapguncelle(int id,string kitapAdi, string yazarAdi, string kitapTuru, int kitapAdedi, string sayfaSayisi, string kitapKonumu, string aciklama, HttpPostedFileBase resim)
        {
            var dosyaisim = Path.GetFileName(resim.FileName);
            //
            var yol = Path.Combine(Server.MapPath("/resimlerr"), dosyaisim);
            resim.SaveAs(yol);
            var gunceldeger = db.kitaplar.Find(id);
            gunceldeger.KitapAdi = kitapAdi;
            gunceldeger.Yazar = yazarAdi;
            gunceldeger.KitapTuru = kitapTuru;
            gunceldeger.KitapAdedi = kitapAdedi;
            gunceldeger.SayfaSayisi = sayfaSayisi;
            gunceldeger.KitapKonumu = kitapKonumu;
            gunceldeger.Aciklama = aciklama;
            gunceldeger.KitapResimYol = "/resimlerr/" + dosyaisim;

            db.SaveChanges();
            return View("Index");
        }
       

        public ActionResult kisigun(int id)
        {
            List<Ogrenci> ara = db.ogrenciler.Where(x => x.Id == id).ToList();

            return View(ara);
        }
        [HttpPost]
        public ActionResult kisiguncelle(int id,string ad, string soyad, string tc_no, string okul_no)
        {

            var gunceldeger = db.ogrenciler.Find(id);
            gunceldeger.Ad = ad;
            gunceldeger.Soyad= soyad;
            gunceldeger.TcNo = tc_no;
            gunceldeger.OkulNo = okul_no;

            db.SaveChanges();


            return View("Index");
        }
    }

}