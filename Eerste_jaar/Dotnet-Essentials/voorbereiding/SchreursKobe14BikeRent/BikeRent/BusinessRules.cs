using System;

namespace BikeRent
{
    public static class BusinessRules // this should remain static!
    {
        public static double CalculatePrice(double pricePerDay, int days)
        {
            if(days == 1)
            {
                return pricePerDay;
            }else if(days == 2)
            {
                return pricePerDay * 0.8;
            }else
            {
                return pricePerDay * 0.7;
            }
          
        }
        public static DateTime CheckStartDate(string text)
        {
            try
            {
                DateTime date = Convert.ToDateTime(text);
                if(date < DateTime.Now)
                {
                    throw new ValidationException(date + " mag niet in het verleden liggen");
                }
                else if(!date.ToString().Contains(date.Day + "/" + date.Month + "/" + date.Year))
                {
                    throw new ValidationException(date + " is geen geldige datum van het formaat dd/mm/jjjj");
                }
                else
                {
                    return date;
                }
            }
            catch
            {
                throw new ValidationException("This is not a valid date!");
            }
         
            
        }
        // ToDo: implement CalculatePrice
        //       1 day rent    => full price
        //       2 day rent    => 20% discount
        //       > 2 day rent  => 30% discount

        // ToDo: implement CheckStartDate(string text)
        //       should be of format dd/mm/jjjj
        //       should not be in the past
        //       throws a ValidationException if these rules are violated
    }
}