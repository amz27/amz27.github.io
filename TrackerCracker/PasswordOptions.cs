using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TrackerCracker
{
    public class PasswordOptions
    {
        public int RequiredLength { get; set; }
        
        public bool IncludeDigit { get; set; }
        public bool IncludeLowercase { get; set; }
        
        public bool IncludeUppercase { get; set; }

        public bool IncludeSymbols { get; set; }
        //public int RequiredUniqueChars { get; set; }
        //

    }
}