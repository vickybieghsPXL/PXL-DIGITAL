using System;
using System.IO;
using System.Windows;

namespace PixelPass
{
    public class AccountInfoCollectionReader
    {
        public static IAccountInfoCollection Read(string filename)
        {
			StreamReader reader = null;
			IAccountInfoCollection retval = new AccountInfoCollection();
			try
			{
				reader = File.OpenText(filename);
				string line = reader.ReadLine();
					line = reader.ReadLine();
					while (line != null)
					{
						string[] passWordData = line.Split(',');
						/* Adding account info to the list */
						AccountInfo infoAboutAccount = new AccountInfo();
						infoAboutAccount.Title = passWordData[0];
						infoAboutAccount.Username = passWordData[1];
						infoAboutAccount.Password = passWordData[2];
						infoAboutAccount.Notes = passWordData[3];

						string[] expireDateInfo = passWordData[4].Split('/');
						DateTime expired = new DateTime(int.Parse(expireDateInfo[2]), int.Parse(expireDateInfo[1]), int.Parse(expireDateInfo[0]));

						infoAboutAccount.Expiration = expired;
					
						retval.AccountInfos.Add(infoAboutAccount);
						line = reader.ReadLine();
					}
					return retval;
			}
			catch (FileNotFoundException)
			{
				MessageBox.Show("No such file was found");
			}

			finally
			{
				reader?.Close();
			}
			return null;   
        }
    }
}
