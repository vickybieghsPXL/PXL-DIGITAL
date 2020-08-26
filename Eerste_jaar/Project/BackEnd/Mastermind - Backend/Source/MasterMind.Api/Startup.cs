using MasterMind.Business.Models;
using MasterMind.Business.Services;
using MasterMind.Data;
using MasterMind.Data.DomainClasses;
using MasterMind.Data.Repositories;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Authorization;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using NSwag;
using System;
using System.Collections.Generic;
using System.Text;
using NSwag.AspNetCore;
using NSwag.SwaggerGeneration.Processors.Security;

namespace MasterMind.Api
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddMvc(options =>
            {
                var policy = new AuthorizationPolicyBuilder(JwtBearerDefaults.AuthenticationScheme)
                    .RequireAuthenticatedUser().Build();
                options.Filters.Add(new AuthorizeFilter(policy));
            })
                .SetCompatibilityVersion(CompatibilityVersion.Version_2_2);

            services.AddCors();
            services.AddDbContext<MasterMindContext>(options =>
            {
                if (Configuration.GetValue<bool>("UseInmemoryDb"))
                {
                    //options.UseSqlite("DataSource=:memory:");
                    options.UseInMemoryDatabase("MasterMindTestDb");
                }
                else
                {
                    string connectionString = @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=MastermindDb;Integrated Security=True";
                    options.UseSqlServer(connectionString);
                }
            });

            services.AddIdentity<User, IdentityRole<Guid>>(options =>
            {
                options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromMinutes(15);
                options.Lockout.MaxFailedAccessAttempts = 8;
                options.Lockout.AllowedForNewUsers = true;

                options.Password.RequireNonAlphanumeric = false;
                options.Password.RequireDigit = false;
                options.Password.RequireUppercase = false;
                options.Password.RequireLowercase = false;
                options.Password.RequiredLength = 5;

                options.SignIn.RequireConfirmedEmail = false;
                options.SignIn.RequireConfirmedPhoneNumber = false;
            })
                .AddEntityFrameworkStores<MasterMindContext>()
                .AddDefaultTokenProviders();

            var tokenSettings = new TokenSettings();
            Configuration.Bind("Token", tokenSettings);

            services.AddAuthentication(options =>
            {
                options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
            })
                .AddJwtBearer(options =>
                {
                    options.TokenValidationParameters = new TokenValidationParameters()
                    {
                        ValidIssuer = tokenSettings.Issuer,
                        ValidAudience = tokenSettings.Audience,
                        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(tokenSettings.Key)),
                    };
                });

            services.AddSwaggerDocument(config =>
            {
                config.PostProcess = document =>
                {
                    document.SecurityDefinitions.Add("bearer", new SwaggerSecurityScheme
                    {
                        Type = SwaggerSecuritySchemeType.ApiKey,
                        Name = "Authorization",
                        Description =
                            "Copy 'Bearer ' + valid token into field. You can retrieve a bearer token via '/api/authentication/token'",
                        In = SwaggerSecurityApiKeyLocation.Header
                    });
                    document.Schemes = new List<SwaggerSchema> { SwaggerSchema.Https };
                    document.Info.Title = "MasterMind Api";
                    document.Info.Description =
                        "Data services for the MasterMind web application";
                };
                config.OperationProcessors.Add(new OperationSecurityScopeProcessor("bearer"));
            });

            services.AddSingleton<ITokenFactory>(new JwtTokenFactory(tokenSettings));
            services.AddSingleton<IWaitingRoomRepository, InMemoryWaitingRoomRepository>();
            services.AddSingleton<IWaitingRoomService, WaitingRoomService>();
            services.AddSingleton<IGameRepository, InMemoryGameRepository>();
            services.AddSingleton<IGameService, GameService>();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseHsts();
            }
            app.UseCors(builder => builder.AllowAnyOrigin().AllowAnyHeader());
            app.UseHttpsRedirection();

            app.UseSwagger();
            app.UseSwaggerUi3();

            app.UseMvc();
        }
    }
}
