using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace mttLibraryProject.Models
{
    public class Kitap
    {
        public int Id { get; set; }
        public string KitapAdi { get; set; }
        public string Yazar { get; set; }
        public string Aciklama { get; set; }
        public string KitapTuru { get; set; }
        public int KitapAdedi { get; set; }
        public string SayfaSayisi { get; set; }
        public string KitapKonumu { get; set; }
        public string KitapResimYol { get; set; }
    }
}