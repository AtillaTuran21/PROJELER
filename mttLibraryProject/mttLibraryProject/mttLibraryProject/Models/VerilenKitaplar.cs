using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace mttLibraryProject.Models
{
    public class VerilenKitaplar
    {
        public int Id { get; set; }

        public string Ad { get; set; }

        public string Soyad { get; set; }

        public string Tc_No { get; set; }

        public string Okul_NO { get; set; }

        public string KitapAdi { get; set; }

        public int KitapAlinanGun { get; set; }

        public int KitapTeslimGun { get; set; }

        public DateTime Tarih { get; set; }

        public DateTime TeslimTarih { get; set; }

    }
}