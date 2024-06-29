using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace mttLibraryProject.Models
{
    public class Ogrenci
    {
        public int Id { get; set; }
        public string Ad { get; set; }
        public string Soyad { get; set; }
        public string OkulNo { get; set; }
        public string TcNo { get; set; }
    }
}