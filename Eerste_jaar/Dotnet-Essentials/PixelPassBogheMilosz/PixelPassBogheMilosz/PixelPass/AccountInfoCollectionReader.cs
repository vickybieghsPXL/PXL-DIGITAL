using System;
using System.IO;
using System.Windows;

namespace PixelPass
{
    public class AccountInfoCollectionReader
    {

        public static IAccountInfoCollection Read(string filename)
        {
            AccountInfoCollection accountInfoCollection = null;
            StreamReader reader = null;
            try
            {

                reader = File.OpenText(filename);
                string line = reader.ReadLine();
                if (!line.Contains("Name:"))
                {
                    throw new ParseException($"{filename} does not start with *Name:*");
                }
                else
                {
                    line = line.Replace("Name:", "");
                }
                accountInfoCollection = new AccountInfoCollection(line);
                line = reader.ReadLine();
                while (line != null)
                {
                    //Lijn data in een array steken en verwerken:
                    string[] dataArray = line.Split(',');
                    string title = dataArray[0];
                    string username = dataArray[1];
                    string password = dataArray[2];
                    string notes = dataArray[3];
                    int[] dateInt = Array.ConvertAll(dataArray[4].Split('/'), int.Parse);
                    DateTime expirationDate = new DateTime(dateInt[2], dateInt[1], dateInt[0]);
                    AccountInfo currentAccountInfo = new AccountInfo(title, username, password, notes, expirationDate);
                    accountInfoCollection.AccountInfos.Add(currentAccountInfo);
                    line = reader.ReadLine();
                }

            }
            catch (FileNotFoundException ex)
            {
                MessageBox.Show(ex.Message);
            }
            catch (ParseException ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                reader.Close();
            }

            return accountInfoCollection;

        }
    }
}
