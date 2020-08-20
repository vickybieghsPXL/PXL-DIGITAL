using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikeRent
{
    class ValidationException : Exception
    {
        public ValidationException(string message) : base(message) { }
    }
}
