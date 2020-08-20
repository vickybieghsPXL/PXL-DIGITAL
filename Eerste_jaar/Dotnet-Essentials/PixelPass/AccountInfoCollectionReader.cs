using Microsoft.Win32;
using System;
using System.IO;

namespace PixelPass
{
    public class AccountInfoCollectionReader
    {
        public static IAccountInfoCollection Read(string filename)
            {
                FileStream stream = new FileStream(filename, FileMode.Open, FileAccess.Read);
                StreamReader reader = new StreamReader(stream);
                reader.DiscardBufferedData();
                string line;
                AccountInfoCollection collection = new AccountInfoCollection();
                reader.ReadLine();
                while ((line = reader.ReadLine()) != null)
                {
                    string[] parts = line.Split(',');
                    string title = parts[0];
                    string username = parts[1];
                    string password = parts[2];
                    string notes = parts[3];
                    DateTime expiration = DateTime.Parse(parts[4]);
                    collection.Name = title;
                    collection.AccountInfos.Add(new AccountInfo(title, username, password, notes, expiration));
                }
                stream.Close();
                reader.Close();
            return collection;

            }
                
           
            
        }
    }

