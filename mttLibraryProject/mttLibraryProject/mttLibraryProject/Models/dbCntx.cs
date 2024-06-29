using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
namespace mttLibraryProject.Models
{
    public class dbCntx:DbContext
    {
        public DbSet<Kitap> kitaplar {get; set;}
        public DbSet<Ogrenci> ogrenciler { get; set; }

        public DbSet<VerilenKitaplar> verilenKitap { get; set; }

        public DbSet<VerilenKitapKanit> verilenKitapKanit { get; set; }

        public DbSet<Borc> borc { get; set; }
    }
}