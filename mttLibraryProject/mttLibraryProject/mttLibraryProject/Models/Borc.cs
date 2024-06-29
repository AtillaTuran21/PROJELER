using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace mttLibraryProject.Models
{
    public class Borc
    {
        public int Id { get; set; }

        public int Borc_Miktari { get; set; }

        public string Ad { get; set; }

        public string Soyad { get; set; }

        public string Tc_No { get; set; }

        public int TeslimTarihiGecenSure { get; set; }

        public string Okul_No { get; set; }

    }
}