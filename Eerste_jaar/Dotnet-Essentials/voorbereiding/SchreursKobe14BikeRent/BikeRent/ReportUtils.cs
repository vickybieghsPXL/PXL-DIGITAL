using System.Text;

namespace BikeRent
{
    public static class ReportUtils
    {
        private const string BikeIdMarker = "@@BIKEID@@";
        private const string ReportDataMarker = "@@REPORTDATA@@";

        private static string template = @"<!DOCTYPE html>
<html lang=""nl"">
<head>
    <meta charset=""UTF-8"">
    <meta name=""viewport"" content=""width=device-width, initial-scale=1.0"">
    <title>Rapport</title>
    <style>
        h1 {
            font-family: Arial, Helvetica, sans-serif;
        }
        .bike-table {
            border: solid 1px #DDEEEE;
            border-collapse: collapse;
            border-spacing: 0;
            font: normal 13px Arial, Helvetica, sans-serif;
        }
        .bike-table thead th {
            background-color: #DDEFEF;
            border: solid 1px #DDEEEE;
            color: #336B6B;
            padding: 10px;
            text-align: left;
            text-shadow: 1px 1px 1px #fff;
        }
        .bike-table tbody td {
            border: solid 1px #DDEEEE;
            color: #333;
            padding: 10px;
            text-shadow: 1px 1px 1px #fff;
        }
    </style>
</head>
<body>
    <h1>Rapport voor fiets @@BIKEID@@</h1>
    <table class=""bike-table"">
        <thead>
            <tr>
                <th>Startdatum</th>
                <th>Einddatum</th>
                <th>Klant</th>
                <th>Prijs (EUR)</th>
                <th>Afstand (km)</th>
            </tr>
        </thead>
        <tbody>
            @@REPORTDATA@@
        </tbody>
    </table>
</body>
</html>";

        public static string CreateReport(BikeBase bike)
        {
            //ToDo: the string in template contains two markers that you need to replace
            //      with actual data:
            //  @@BIKEID@@ : Id of the bike
            //  @@REPORTDATA@@ : for each Rental in the list create a <tr>-element
            //                 : see example/Bike_003.html and example/Bike_011.html
            //                 : in your project!

            // IMPORTANT: your code should make as few strings as possible!
            string temp = template.Replace(BikeIdMarker, bike.Id.ToString());
            
            return temp;
        }
    }
}
