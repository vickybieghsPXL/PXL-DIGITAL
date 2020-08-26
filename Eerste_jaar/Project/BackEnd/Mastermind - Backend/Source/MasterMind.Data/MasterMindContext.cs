using System;
using MasterMind.Data.DomainClasses;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace MasterMind.Data
{
    //DO NOT TOUCH THIS FILE!!
    public class MasterMindContext: IdentityDbContext<User, IdentityRole<Guid>, Guid>
    {
        public MasterMindContext()
        {
        }

        public MasterMindContext(DbContextOptions options) : base(options) { }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                string connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=MastermindDb;Integrated Security=True";
                optionsBuilder.UseSqlServer(connectionString);
            }
        }
    }
}