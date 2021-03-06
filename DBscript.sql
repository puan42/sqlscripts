USE [master]
GO
/****** Object:  Database [main_autoflow_db]    Script Date: 2020-09-14 09:13:22 PM ******/
CREATE DATABASE [main_autoflow_db]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'main_autoflow_db', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\main_autoflow_db.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'main_autoflow_db_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\main_autoflow_db_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [main_autoflow_db] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [main_autoflow_db].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [main_autoflow_db] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [main_autoflow_db] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [main_autoflow_db] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [main_autoflow_db] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [main_autoflow_db] SET ARITHABORT OFF 
GO
ALTER DATABASE [main_autoflow_db] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [main_autoflow_db] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [main_autoflow_db] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [main_autoflow_db] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [main_autoflow_db] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [main_autoflow_db] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [main_autoflow_db] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [main_autoflow_db] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [main_autoflow_db] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [main_autoflow_db] SET  DISABLE_BROKER 
GO
ALTER DATABASE [main_autoflow_db] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [main_autoflow_db] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [main_autoflow_db] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [main_autoflow_db] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [main_autoflow_db] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [main_autoflow_db] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [main_autoflow_db] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [main_autoflow_db] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [main_autoflow_db] SET  MULTI_USER 
GO
ALTER DATABASE [main_autoflow_db] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [main_autoflow_db] SET DB_CHAINING OFF 
GO
ALTER DATABASE [main_autoflow_db] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [main_autoflow_db] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [main_autoflow_db] SET DELAYED_DURABILITY = DISABLED 
GO
USE [main_autoflow_db]
GO
/****** Object:  User [autoflow]    Script Date: 2020-09-14 09:13:22 PM ******/
CREATE USER [autoflow] FOR LOGIN [autoflow] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [autoflow]
GO
USE [main_autoflow_db]
GO
/****** Object:  Sequence [dbo].[hibernate_sequence]    Script Date: 2020-09-14 09:13:22 PM ******/
CREATE SEQUENCE [dbo].[hibernate_sequence] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
/****** Object:  UserDefinedFunction [dbo].[vf_af_GenID]    Script Date: 2020-09-14 09:13:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[vf_af_GenID](@random int)
RETURNS varchar(100)
AS 
BEGIN

	declare @day varchar(10) = cast(datepart(DAY,getdate())as varchar)
	declare @Month varchar(10) = cast(datepart(MONTH,getdate())as varchar)
	declare @year varchar(10) = cast(datepart(YEAR,getdate())as varchar)
	declare @hour varchar(10) = cast(datepart(HOUR,getdate())as varchar)
	declare @min varchar(10) = cast(datepart(MINUTE,getdate())as varchar)
	declare @sec varchar(10) = cast(datepart(SECOND,getdate())as varchar)
	declare @msec varchar(8) = 'AF20'+CAST(RIGHT('00000000' + CAST(ABS(@random) % 99999999 AS VARCHAR(8)), 8) AS VARCHAR) 

	declare @id varchar(100) = @day+@Month+@year+@hour+@min+@sec+@msec


    RETURN @id;
END

GO
/****** Object:  Table [dbo].[af_adress]    Script Date: 2020-09-14 09:13:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_adress](
	[address_id] [varchar](30) NULL,
	[addresstype_id] [varchar](30) NULL,
	[client_id] [varchar](30) NULL,
	[address_line1] [varchar](30) NULL,
	[address_line2] [varchar](30) NULL,
	[address_line3] [varchar](30) NULL,
	[postal_code] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_adresstype]    Script Date: 2020-09-14 09:13:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_adresstype](
	[addresstype_id] [varchar](30) NULL,
	[customer_id] [varchar](30) NULL,
	[addresstype_name] [varchar](30) NULL,
	[systemdate] [datetime] NULL,
	[systemuser_id] [varchar](30) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_assesor]    Script Date: 2020-09-14 09:13:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_assesor](
	[assesor_id] [varchar](50) NULL,
	[insurance_id] [varchar](50) NULL,
	[assesor_name] [varchar](50) NULL,
	[assesor_tel] [varchar](50) NULL,
	[assesor_cell] [varchar](50) NULL,
	[assesor_email] [varchar](50) NULL,
	[systemdate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_client]    Script Date: 2020-09-14 09:13:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_client](
	[client_id] [varchar](50) NOT NULL,
	[client_name] [varchar](50) NULL,
	[client_surname] [varchar](50) NULL,
	[client_email] [varchar](50) NULL,
	[customer_id] [varchar](50) NULL,
	[client_type_id] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_client_type]    Script Date: 2020-09-14 09:13:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_client_type](
	[client_type_id] [varchar](50) NULL,
	[client_type_name] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_cost_profile]    Script Date: 2020-09-14 09:13:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_cost_profile](
	[cost_profile_id] [varchar](255) NOT NULL,
	[active] [bit] NULL,
	[cost_profile_name] [varchar](255) NULL,
	[customer_id] [int] NULL,
	[system_date] [datetime2](7) NULL,
	[unit_cost] [float] NULL,
	[unit_cost_ml] [float] NULL,
	[unit_price] [float] NULL,
	[stock_id] [varchar](50) NULL,
	[unit_quantity] [int] NULL,
	[unit_quantity_ml] [float] NULL,
	[unit_type_id] [int] NULL,
	[vat] [float] NULL,
	[discount] [float] NULL,
	[priceexcl] [float] NULL,
	[job_name] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[cost_profile_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_customer]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_customer](
	[cust_id] [int] NOT NULL,
	[cust_name] [varchar](255) NULL,
	[reg_no] [varchar](255) NULL,
	[vat_no] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[cust_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_financial]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_financial](
	[financial_id] [varchar](30) NOT NULL,
	[amount] [float] NULL,
	[vat] [float] NULL,
	[amount_excl] [float] NULL,
	[financial_direction] [varchar](20) NULL,
	[financial_type_id] [varchar](30) NULL,
	[job_id] [varchar](30) NULL,
	[systemdate] [datetime] NULL,
	[systemuser] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[financial_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_financial_type]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_financial_type](
	[financial_type_id] [varchar](30) NOT NULL,
	[financial_type_name] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[financial_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_insurance]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_insurance](
	[insurance_id] [varchar](50) NULL,
	[insurance_name] [varchar](50) NULL,
	[systemdate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_job]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_job](
	[job_id] [varchar](255) NOT NULL,
	[customer_id] [int] NULL,
	[job_name] [varchar](255) NULL,
	[client_id] [varchar](50) NULL,
	[vehicle_id] [varchar](50) NULL,
	[job_status_id] [varchar](30) NULL,
	[priority_id] [int] NULL,
	[jobtype_id] [varchar](30) NULL,
	[jobinsuraceid] [varchar](50) NULL,
	[claimno] [varchar](50) NULL,
	[jobassessorid] [varchar](50) NULL,
	[bookeddate] [datetime] NULL,
	[exessAmount] [float] NULL,
	[completionDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[job_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_job_status]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_job_status](
	[job_status_id] [varchar](30) NOT NULL,
	[job_status_name] [varchar](100) NULL,
	[system_date] [datetime] NULL,
	[touch_date] [datetime] NULL,
	[system_id] [int] NULL,
	[touch_id] [int] NULL,
	[customer_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[job_status_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_jobtype]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_jobtype](
	[jobtype_id] [varchar](50) NULL,
	[jobtype_name] [varchar](50) NULL,
	[system_date] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_phone]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_phone](
	[phone_id] [varchar](50) NULL,
	[phone_type] [varchar](50) NULL,
	[phone_client_id] [varchar](50) NULL,
	[system_date] [datetime] NULL,
	[system_id] [varchar](50) NULL,
	[customer_id] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_phone_type]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_phone_type](
	[phone_type_id] [varchar](50) NULL,
	[phone_type_name] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_stock]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_stock](
	[stock_id] [varchar](255) NOT NULL,
	[customer_id] [int] NULL,
	[devident] [int] NULL,
	[min_order_quantity] [int] NULL,
	[min_order_quantity_ml] [float] NULL,
	[stock_discription] [varchar](255) NULL,
	[stock_name] [varchar](255) NULL,
	[stock_supplier_id] [int] NULL,
	[system_date] [datetime2](7) NULL,
	[system_userid] [int] NULL,
	[item_quantity] [int] NULL,
	[item_quantity_ml] [float] NULL,
	[active] [bit] NULL,
	[item_type_id] [int] NULL,
	[touch_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[stock_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_stock_checkedout]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_stock_checkedout](
	[checkedout_id] [varchar](255) NOT NULL,
	[job_id] [varchar](255) NULL,
	[stock_id] [varchar](255) NULL,
	[customer_id] [int] NULL,
	[quantity] [int] NULL,
	[stock_checkout_id] [varchar](255) NULL,
	[soh_id] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[checkedout_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_stock_on_hand]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_stock_on_hand](
	[soh_id] [varchar](50) NOT NULL,
	[stock_id] [varchar](50) NULL,
	[cost_profile_id] [varchar](50) NULL,
	[customer_id] [varchar](50) NULL,
	[quantity] [int] NULL,
	[system_date] [datetime] NULL,
	[system_userid] [varchar](50) NULL,
	[touch_date] [datetime] NULL,
	[touch_userid] [varchar](50) NULL,
	[stock_name] [varchar](50) NULL,
	[profile_name] [varchar](50) NULL,
 CONSTRAINT [PK_af_stock_on_hand] PRIMARY KEY CLUSTERED 
(
	[soh_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_uploads]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_uploads](
	[upload_id] [varchar](30) NULL,
	[upload_name] [varchar](30) NULL,
	[upload_type] [varchar](30) NULL,
	[directory] [varchar](255) NULL,
	[system_date] [datetime] NULL,
	[customer_id] [int] NULL,
	[job_id] [varchar](30) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_vehicle]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_vehicle](
	[vehicleid] [varchar](50) NOT NULL,
	[clientid] [varchar](50) NULL,
	[vin] [varchar](21) NULL,
	[regno] [varchar](22) NULL,
	[vehiclemake] [varchar](50) NULL,
	[vehiclemodel] [varchar](50) NULL,
	[vehicleyear] [varchar](50) NULL,
	[systemdate] [datetime] NULL,
	[customerid] [varchar](50) NULL,
	[touch_date] [datetime] NULL,
	[touch_id] [varchar](30) NULL,
	[system_id] [varchar](30) NULL,
	[vehiclesubmodel] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_vehicle_make]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_vehicle_make](
	[make_id] [varchar](50) NOT NULL,
	[make_name] [varchar](50) NOT NULL,
	[systemdate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[make_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[af_vehicle_model]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[af_vehicle_model](
	[model_id] [varchar](50) NOT NULL,
	[model_name] [varchar](50) NOT NULL,
	[systemdate] [datetime] NULL,
	[make_id] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[model_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[auth_role]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[auth_role](
	[auth_role_id] [int] NOT NULL,
	[role_desc] [varchar](255) NULL,
	[role_name] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[auth_role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[auth_user]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[auth_user](
	[auth_user_id] [int] NOT NULL,
	[username] [varchar](255) NULL,
	[enabled] [int] NULL,
	[first_name] [varchar](255) NULL,
	[last_name] [varchar](255) NULL,
	[password] [varchar](255) NULL,
	[cust_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[auth_user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_aemunee2coyyrve4d18rqcqr1] UNIQUE NONCLUSTERED 
(
	[cust_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SPRING_SESSION]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SPRING_SESSION](
	[PRIMARY_ID] [char](36) NOT NULL,
	[SESSION_ID] [char](36) NOT NULL,
	[CREATION_TIME] [bigint] NOT NULL,
	[LAST_ACCESS_TIME] [bigint] NOT NULL,
	[MAX_INACTIVE_INTERVAL] [int] NOT NULL,
	[EXPIRY_TIME] [bigint] NOT NULL,
	[PRINCIPAL_NAME] [varchar](100) NULL,
 CONSTRAINT [SPRING_SESSION_PK] PRIMARY KEY CLUSTERED 
(
	[PRIMARY_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SPRING_SESSION_ATTRIBUTES]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SPRING_SESSION_ATTRIBUTES](
	[SESSION_PRIMARY_ID] [char](36) NOT NULL,
	[ATTRIBUTE_NAME] [varchar](200) NOT NULL,
	[ATTRIBUTE_BYTES] [varbinary](max) NOT NULL,
 CONSTRAINT [SPRING_SESSION_ATTRIBUTES_PK] PRIMARY KEY CLUSTERED 
(
	[SESSION_PRIMARY_ID] ASC,
	[ATTRIBUTE_NAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[user_role]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_role](
	[user_id] [int] NOT NULL,
	[role_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [SPRING_SESSION_IX1]    Script Date: 2020-09-14 09:13:23 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [SPRING_SESSION_IX1] ON [dbo].[SPRING_SESSION]
(
	[SESSION_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [SPRING_SESSION_IX2]    Script Date: 2020-09-14 09:13:23 PM ******/
CREATE NONCLUSTERED INDEX [SPRING_SESSION_IX2] ON [dbo].[SPRING_SESSION]
(
	[EXPIRY_TIME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [SPRING_SESSION_IX3]    Script Date: 2020-09-14 09:13:23 PM ******/
CREATE NONCLUSTERED INDEX [SPRING_SESSION_IX3] ON [dbo].[SPRING_SESSION]
(
	[PRINCIPAL_NAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[auth_user]  WITH CHECK ADD  CONSTRAINT [FKpdxd7pdjcytou1h1pf9oguu9m] FOREIGN KEY([cust_id])
REFERENCES [dbo].[af_customer] ([cust_id])
GO
ALTER TABLE [dbo].[auth_user] CHECK CONSTRAINT [FKpdxd7pdjcytou1h1pf9oguu9m]
GO
ALTER TABLE [dbo].[SPRING_SESSION_ATTRIBUTES]  WITH CHECK ADD  CONSTRAINT [SPRING_SESSION_ATTRIBUTES_FK] FOREIGN KEY([SESSION_PRIMARY_ID])
REFERENCES [dbo].[SPRING_SESSION] ([PRIMARY_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SPRING_SESSION_ATTRIBUTES] CHECK CONSTRAINT [SPRING_SESSION_ATTRIBUTES_FK]
GO
ALTER TABLE [dbo].[user_role]  WITH CHECK ADD  CONSTRAINT [FKfn92hedcqd4ci9r6m3hvs55l4] FOREIGN KEY([user_id])
REFERENCES [dbo].[auth_user] ([auth_user_id])
GO
ALTER TABLE [dbo].[user_role] CHECK CONSTRAINT [FKfn92hedcqd4ci9r6m3hvs55l4]
GO
ALTER TABLE [dbo].[user_role]  WITH CHECK ADD  CONSTRAINT [FKqqlqhas35obkljn18mrh6mmms] FOREIGN KEY([role_id])
REFERENCES [dbo].[auth_role] ([auth_role_id])
GO
ALTER TABLE [dbo].[user_role] CHECK CONSTRAINT [FKqqlqhas35obkljn18mrh6mmms]
GO
/****** Object:  StoredProcedure [dbo].[sp_af_client_manage]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	Author: Ruan Pienaar
	Date Created: 2020-01-29
	Changes --

*/

CREATE PROCEDURE [dbo].[sp_af_client_manage]

@pclientid varchar(50),
@pclientname varchar(50),
@pclientsurname varchar(50),
@pclientemail varchar(50),
@pcustomer int,
@pAction int,
@pResultReason varchar(255) out,
@pResultNo int out

AS
BEGIN

declare @vclientname varchar(50)
declare @vclientsurname varchar(50)
declare @vclientemail varchar(50)

set @vclientname = @pclientname
set @vclientsurname = @pclientsurname
set @vclientemail = @pclientemail

	if (@pAction = 1) --insert 
	Begin
		insert into af_client
		(
			client_id,
			client_name,
			client_surname,
			client_email,
			customer_id
		)
		values
		(
			dbo.vf_af_GenID(CHECKSUM(newid())),
			@vclientname,
			@vclientsurname,
			@vclientemail,
			@pcustomer

		)
	end
	if @@ERROR <> 0
	begin
		set @pResultNo = 1
		set @pResultReason = 'Error Occured when inserting setting'
		return
	end
	else
	begin
		set @pResultNo = 0
		set @pResultReason = 'SUCCESS'
		return
	end
END

GRANT EXECUTE ON sp_af_client_manage TO public;

GO
/****** Object:  StoredProcedure [dbo].[sp_af_cost_profile_manage]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	Author: Ruan Pienaar
	Date Created: 2020-01-29
	Changes --

*/

CREATE PROCEDURE [dbo].[sp_af_cost_profile_manage]

@pcost_profile_name nvarchar(255),
@pCustomer_id int,
@punit_price money,
@pstockid varchar(50),
@punit_price_excl money,
@pvat money,
@pdiscount int,
@pAction int,
@pResultReason varchar(255) out,
@pResultNo int out

AS
BEGIN

declare @vcost_profile_name nvarchar(255)
declare @vCustomer_id int
declare @vDevident int
declare @vunit_quantity int
declare @vunit_quantity_ml float
declare @vunit_price money
declare @vstockid varchar(50)
declare @vcostperitem money
declare @vcostperml money
declare @vunit_price_excl money
declare @vvat money
declare @vdiscount int

set @vcost_profile_name = @pcost_profile_name
set @vCustomer_id = @pCustomer_id
set @vunit_price = @punit_price
set @vstockid = @pstockid
set @vunit_price_excl = @punit_price_excl
set @vvat = @pvat
set @vdiscount = @pdiscount

select 
@vunit_quantity = s.item_quantity,
@vunit_quantity_ml = s.item_quantity_ml, 
@vDevident = s.devident 
from af_stock s 
where stock_id = @vstockid

if @vunit_quantity > 0
		begin
		set @vcostperitem = (@vunit_price/@vunit_quantity)/@vDevident
		end
		else
		begin
		set @vcostperitem = 0.00
		end
	if @vunit_quantity_ml > 0.0
		begin
		set @vcostperml = @vunit_price/@vunit_quantity_ml
		end
		else
		begin
		set @vcostperml = 0.00
		end
	if (@pAction = 1) --insert 
	Begin
		insert into af_cost_profile 
		(
			cost_profile_id,
			active,
			cost_profile_name,
			customer_id,
			system_date,
			unit_price,
			stock_id,
			unit_cost,
			unit_cost_ml,
			vat,
			discount,
			priceexcl

		)
		values
		(
			dbo.vf_af_GenID(CHECKSUM(newid())),
			1,
			@vcost_profile_name,
			@vCustomer_id,
			getdate(),
			@vunit_price,
			@vstockid,
			@vcostperitem,
			@vcostperml,
			@vvat,
			@vdiscount,
			@vunit_price_excl
		)
	end
	if @@ERROR <> 0
	begin
		set @pResultNo = 1
		set @pResultReason = 'Error Occured when inserting setting'
		return
	end
	else
	begin
		set @pResultNo = 0
		set @pResultReason = 'SUCCESS'
		return
	end
END

GRANT EXECUTE ON sp_af_stock_manage TO public;

GO
/****** Object:  StoredProcedure [dbo].[sp_af_get_jobDetail]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	Author: Ruan Pienaar
	Date Created: 2020-01-29
	Changes --

*/

CREATE PROCEDURE [dbo].[sp_af_get_jobDetail]

@pjobId varchar(30),
@pcustomerId int,
@pResultReason varchar(255) out,
@pResultNo int out

AS
BEGIN
select 
j.job_id,
j.job_name,
j.customer_id,
j.job_status_id,
j.priority_id,
j.client_id,
cl.client_name + ' ' + cl.client_surname as client_name,
vm.make_name + ' ' + vmo.model_name as vehicle_name,
vl.vehicleid,
vl.regno,
isnull(cast(sum(sco.quantity * cp.unit_cost) as decimal(16,2)),0.00) as cost,
j.jobtype_id,
j.claimno,
ins.insurance_id,
ins.insurance_name,
ass.assesor_id,
ass.assesor_name,
ph.phone_id,
j.bookeddate,
j.completionDate,
j.exessAmount
from af_stock_checkedout sco 
inner join af_stock_on_hand soh on sco.soh_id = soh.soh_id
inner join af_cost_profile cp on soh.cost_profile_id = cp.cost_profile_id
right outer join af_job j on j.job_id = sco.job_id
inner join af_client cl on cl.client_id =j.client_id
inner join af_vehicle vl on vl.vehicleid = j.vehicle_id
inner join af_vehicle_make vm on vl.vehiclemake = vm.make_id
inner join af_vehicle_model vmo on vl.vehiclemodel = vmo.model_id
right outer join af_phone ph on ph.phone_client_id = cl.client_id
right outer join af_insurance ins on ins.insurance_id = j.jobinsuraceid
right outer join af_assesor ass on ass.assesor_id = j.jobassessorid
where j.job_id = @pjobId
and j.customer_id = @pcustomerId
group by
j.job_id, 
j.job_name,
j.customer_id,
j.job_status_id,
j.priority_id,
j.client_id,
cl.client_name + ' ' + cl.client_surname,
vm.make_name + ' ' + vmo.model_name,
vl.vehicleid,
vl.regno,
j.jobtype_id,
j.claimno,
ins.insurance_id,
ins.insurance_name,
ass.assesor_id,
ass.assesor_name,
ass.assesor_cell,
ass.assesor_tel,
assesor_email,
ph.phone_id,
j.bookeddate,
j.completionDate,
j.exessAmount
END

GRANT EXECUTE ON sp_af_get_jobDetail TO public;

GO
/****** Object:  StoredProcedure [dbo].[sp_af_insert_client]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	Author: Ruan Pienaar
	Date Created: 2020-08-16
	Changes --

*/

CREATE PROCEDURE [dbo].[sp_af_insert_client]

@pclient_id varchar(50),
@pclient_name varchar(50),
@pclient_surname varchar(50),
@pclient_email varchar(50),
@pcustomer_id int

AS
BEGIN

declare @vclient_id varchar(50)
declare @vclient_name varchar(50)
declare @vclient_surname varchar(50)
declare @vclient_email varchar(50)
declare @vcustomer_id int


set @vclient_id = @pclient_id
set @vclient_name = @pclient_name
set @vclient_surname = @pclient_surname
set @vclient_email = @pclient_email
set @vcustomer_id = @pcustomer_id

insert into af_client(
client_id,
client_name,
client_surname,
client_email,
customer_id
)
values
(
@vclient_id,
@vclient_name,
@vclient_surname,
@vclient_email,
@vcustomer_id
)

--if @@ERROR <> 0
--	begin
--		set @pResultNo = 1
--		set @pResultReason = 'Error Occured when updating status'
--		return
--	end
--	else
--	begin
--		set @pResultNo = 0
--		set @pResultReason = 'SUCCESS'
--		return
--	end

END

GRANT EXECUTE ON sp_af_insert_client TO public;

GO
/****** Object:  StoredProcedure [dbo].[sp_af_insert_financial]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	Author: Ruan Pienaar
	Date Created: 2020-09-11
	Changes --

*/

CREATE PROCEDURE [dbo].[sp_af_insert_financial]

@pamount float,
@pjob_id varchar(30),
@pcustomer_id int,
@pfinancial_direction varchar(5),
@pfinancial_type_id varchar(30),
@pResultReason varchar(255) out,
@pResultNo int out

AS
BEGIN

declare @vamount float
declare @vjob_id varchar(30)
declare @vcustomer_id int
declare @vvat decimal(10,2)
declare @vamountexcl decimal(10,2)
declare @vfinancial_direction varchar(5)
declare @vfinancial_type_id varchar(30)
 
	set @vamount = @pamount
	set @vjob_id = @pjob_id
	set @vcustomer_id = @pcustomer_id
	set @vvat = (CAST(15 AS decimal)/CAST(100 AS decimal)) * @vamount
	set @vamountexcl = @vamount - @vvat
	set @vfinancial_direction = @pfinancial_direction
	set @vfinancial_type_id = @pfinancial_type_id

	insert into af_financial
	select dbo.vf_af_GenID(checksum(NEWID())),@vamount,@vvat,@vamountexcl,@vfinancial_direction,@vfinancial_type_id,@vjob_id,getdate(),1

	if @@ERROR <> 0
	begin
		set @pResultNo = 1
		set @pResultReason = 'Error Occured when inserting financial record for Job ID - ' + @vjob_id
		return
	end
	else
	begin
		set @pResultNo = 0
		set @pResultReason = 'SUCCESS'
		return
	end
END

GRANT EXECUTE ON sp_af_insert_financial TO public;

GO
/****** Object:  StoredProcedure [dbo].[sp_af_insert_vehicle]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	Author: Ruan Pienaar
	Date Created: 2020-08-16
	Changes --

*/

CREATE PROCEDURE [dbo].[sp_af_insert_vehicle]

@pvehicle_id varchar(50),
@pclient_id varchar(50),
@pvehicle_vin varchar(50),
@pvehicle_regno varchar(50),
@pvehicle_make varchar(50),
@pvehicle_model varchar(50),
@pvehicle_submodel varchar(50),
@pvehicle_year varchar(50),
@pcustomer_id int

AS
BEGIN

declare @vvehicle_id varchar(50)
declare @vclient_id varchar(50)
declare @vvehicle_vin varchar(50)
declare @vvehicle_regno varchar(50)
declare @vvehicle_make varchar(50)
declare @vvehicle_model varchar(50)
declare @vvehicle_submodel varchar(50)
declare @vvehicle_year varchar(50)
declare @vcustomer_id int


set @vvehicle_id = @pvehicle_id
set @vclient_id = @pclient_id
set @vvehicle_vin = @pvehicle_vin
set @vvehicle_regno = @pvehicle_regno
set @vvehicle_make = @pvehicle_make
set @vvehicle_model = @pvehicle_model
set @vvehicle_submodel = @pvehicle_submodel
set @vvehicle_year = @pvehicle_year
set @vcustomer_id = @pcustomer_id


insert into af_vehicle(
vehicleid,
clientid,
vin,
regno,
vehiclemake,
vehiclemodel,
vehicleyear,
systemdate,
customerid,
touch_date,
touch_id,
system_id,
vehiclesubmodel
)
values
(
@vvehicle_id,
@vclient_id,
@vvehicle_vin,
@vvehicle_regno,
@vvehicle_make,
@vvehicle_model,
@vvehicle_year,
getdate(),
@vcustomer_id,
getdate(),
1,
1,
@vvehicle_submodel
)

--if @@ERROR <> 0
--	begin
--		set @pResultNo = 1
--		set @pResultReason = 'Error Occured when updating status'
--		return
--	end
--	else
--	begin
--		set @pResultNo = 0
--		set @pResultReason = 'SUCCESS'
--		return
--	end

END

GRANT EXECUTE ON sp_af_insert_vehicle TO public;

GO
/****** Object:  StoredProcedure [dbo].[sp_af_job_add]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	Author: Ruan Pienaar
	Date Created: 2020-08-16
	Changes --

*/

CREATE PROCEDURE [dbo].[sp_af_job_add]

@pclient_name varchar(50),
@pclient_surname varchar(50),
@pclient_email varchar(50),
@pclient_cell varchar(50),
@pclient_phone_type_id varchar(50),
@pclient_id varchar(50),
@pvehicle_vin varchar(50),
@pvehicle_regno varchar(50),
@pvehicle_make varchar(50),
@pvehicle_model varchar(50),
@pvehicle_submodel varchar(50),
@pvehicle_year varchar(50),
@pvehicle_id varchar(50),
@pcustomer_id int,
@pjobstatus varchar(50),
@pjobpriority int,
@pjobtypeid varchar(50),
@pjobinsuranceid varchar(50),
@pclaimno varchar(50),
@pjobasessorid varchar(50),
@pcompletionDate datetime,
@pexessAmount varchar(50),
@pbookeddate varchar(15),
@pResultReason varchar(255) out,
@pResultNo int out

AS
BEGIN

declare @vclient_id varchar(50)
declare @vvehicle_id varchar(50)
declare @vclient_name varchar(50)
declare @vclient_surname varchar(50)
declare @vclient_email varchar(50)
declare @vclient_cell varchar(50)
declare @vclient_phone_type_id varchar(50)
declare @vvehicle_vin varchar(50)
declare @vvehicle_regno varchar(50)
declare @vvehicle_make varchar(50)
declare @vvehicle_model varchar(50)
declare @vvehicle_submodel varchar(50)
declare @vvehicle_year varchar(50)
declare @vcustomer_id int
declare @vjobstatus varchar(50)
declare @vjobpriority int
declare @vjobtypeid varchar(50)
declare @vjobinsuranceid varchar(50)
declare @vclaimno varchar(50)
declare @vjobasessorid varchar(50)
declare @vcompletionDate datetime
declare @vexessAmount float
declare @jobname varchar(100)
declare @vbookeddate datetime



set @vclient_id = @pclient_id
set @vvehicle_id = @pvehicle_id
set @vclient_name = @pclient_name
set @vclient_surname = @pclient_surname
set @vclient_email = @pclient_email
set @vclient_cell = @pclient_cell
set @vclient_phone_type_id = @pclient_phone_type_id
set @vvehicle_vin = @pvehicle_vin
set @vvehicle_regno = @pvehicle_regno
set @vvehicle_make = @pvehicle_make
set @vvehicle_model = @pvehicle_model
set @vvehicle_submodel = @pvehicle_submodel
set @vvehicle_year = @pvehicle_year
set @vjobstatus = @pjobstatus
set @vjobpriority = @pjobpriority
set @vjobtypeid = @pjobtypeid
set @vjobinsuranceid = @pjobinsuranceid
set @vclaimno = @pclaimno
set @vjobasessorid = @pjobasessorid
set @vcustomer_id = @pcustomer_id
set @vbookeddate = @pbookeddate
set @vcompletionDate = @pcompletionDate
set @vexessAmount = @pexessAmount


if (@vclient_id = '')
begin
	set @vclient_id = dbo.vf_af_GenID(CHECKSUM(newid()))
	exec sp_af_insert_client @vclient_id,@vclient_name,@vclient_surname,@vclient_email,@vcustomer_id
	exec sp_af_phone_manage null,@vclient_phone_type_id,@vclient_id,@vcustomer_id,1,'',null
end

if (@vvehicle_id = '')
begin
	set @vvehicle_id = dbo.vf_af_GenID(CHECKSUM(newid()))
	exec sp_af_insert_vehicle @vvehicle_id,@vclient_id,@vvehicle_vin,@vvehicle_regno,@vvehicle_make,@vvehicle_model,@vvehicle_submodel,@vvehicle_year,@vcustomer_id
end

	

	set @jobname = @vclient_name +' '+ @vclient_surname
	exec sp_af_job_manage null,@jobname,@vcustomer_id,@vvehicle_id,@vclient_id, @vjobstatus,@vjobpriority,@pjobtypeid,@vjobinsuranceid,@vclaimno,@vjobasessorid,@vbookeddate,@vcompletionDate,@vexessAmount,1,0,null
	


	if @@ERROR <> 0
	begin
		set @pResultNo = 1
		set @pResultReason = 'Error Occured when updating status'
		return
	end
	else
	begin
		set @pResultNo = 0
		set @pResultReason = 'SUCCESS'
		return
	end
END

GRANT EXECUTE ON sp_af_job_add TO public;

GO
/****** Object:  StoredProcedure [dbo].[sp_af_job_manage]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	Author: Ruan Pienaar
	Date Created: 2020-01-29
	Changes --

*/

CREATE PROCEDURE [dbo].[sp_af_job_manage]

@pjob_id varchar(50),
@pjob_name varchar(50),
@pcustomer_id int,
@pvehicle_id varchar(50),
@pclient_id varchar(50),
@pjob_status_id varchar(50),
@ppriority_id int,
@pjobtypeid varchar(50),
@pjobinsuranceid varchar(50),
@pclaimno varchar(50),
@pjobasessorid varchar(50),
@pbookeddate datetime,
@pcompletionDate datetime,
@pexcessAmount float,
@pAction int,
@pResultReason varchar(255) out,
@pResultNo int out

AS
BEGIN

declare @vjob_id varchar(50)
declare @vjob_name varchar(50)
declare @vcustomer_id int
declare @vclient_id varchar(50)
declare @vvehicle_id varchar(50)
declare @vjob_status_id varchar(50)
declare @vpriority_id int
declare @vjobtypeid varchar(50)
declare @vjobinsuranceid varchar(50)
declare @vclaimno varchar(50)
declare @vjobasessorid varchar(50)
declare @vbookedate datetime
declare @vcompletionDate datetime
declare @vexcessAmount float

set @vjob_id = @pjob_id
set @vjob_name = @pjob_name
set @vcustomer_id = @pcustomer_id
set @vjob_status_id = @pjob_status_id
set @vpriority_id = @ppriority_id
set @vvehicle_id = @pvehicle_id
set @vclient_id = @pclient_id
set @vjobtypeid = @pjobtypeid
set @vjobinsuranceid = @pjobinsuranceid
set @vclaimno = @pclaimno
set @vjobasessorid = @pjobasessorid
set @vbookedate = @pbookeddate
set @vcompletionDate = @pcompletionDate
set @vexcessAmount = @pexcessAmount

	if (@pAction = 1) --insert 
	Begin
		insert into af_job 
		(
			job_id,
			job_name,
			job_status_id,
			priority_id,
			customer_id,
			client_id,
			vehicle_id,
			jobinsuraceid,
			claimno,
			jobassessorid,
			jobtype_id,
			bookeddate,
			completionDate,
			exessAmount
		)
		values
		(
			dbo.vf_af_GenID(CHECKSUM(newid())),
			@vjob_name,
			@vjob_status_id,
			1,
			@vcustomer_id,
			@vclient_id,
			@vvehicle_id,
			@vjobinsuranceid,
			@vclaimno,
			@vjobasessorid,
			@vjobtypeid,
			@vbookedate,
			@vcompletionDate,
			@vexcessAmount
		)
	end

	if (@pAction = 2) --update 
	Begin

		update af_job set 
		job_status_id = @vjob_status_id,
		priority_id = @vpriority_id
		where job_id = @vjob_id

	end
	if @@ERROR <> 0
	begin
		set @pResultNo = 1
		set @pResultReason = 'Error Occured when inserting setting'
		return
	end
	else
	begin
		set @pResultNo = 0
		set @pResultReason = 'SUCCESS'
		return
	end
END

GRANT EXECUTE ON sp_af_job_manage TO public;

GO
/****** Object:  StoredProcedure [dbo].[sp_af_job_status_update]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	Author: Ruan Pienaar
	Date Created: 2020-01-29
	Changes --

*/

CREATE PROCEDURE [dbo].[sp_af_job_status_update]

@pjob_id varchar(50),
@pcustomer_id int,
@pjob_status_id varchar(30),
@pResultReason varchar(255) out,
@pResultNo int out

AS
BEGIN

declare @vjob_id  varchar(30)
declare @vcustomer_id int
declare @vjob_status_id varchar(30)

set @vjob_id = @pjob_id
set @vcustomer_id = @pcustomer_id
set @vjob_status_id = @pjob_status_id

	update af_job set 
	job_status_id = @vjob_status_id
	where job_id = @vjob_id
	
	if @@ERROR <> 0
	begin
		set @pResultNo = 1
		set @pResultReason = 'Error Occured when updating status'
		return
	end
	else
	begin
		set @pResultNo = 0
		set @pResultReason = 'SUCCESS'
		return
	end
END

GRANT EXECUTE ON sp_af_job_status_update TO public;

GO
/****** Object:  StoredProcedure [dbo].[sp_af_phone_manage]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	Author: Ruan Pienaar
	Date Created: 2020-08-24
	Changes --

*/

CREATE PROCEDURE [dbo].[sp_af_phone_manage]

@pphone_id varchar(50),
@pphone_type varchar(50),
@pphone_client_id varchar(50),
@pcustomer_id int,
@pAction int,
@pResultReason varchar(255) out,
@pResultNo int out

AS
BEGIN

declare @vphone_id varchar(50)
declare @vphone_type varchar(50)
declare @vphone_client_id varchar(50)
declare @vcustomer_id int 

set @vphone_id = @pphone_id
set @vphone_type = @pphone_type
set @vphone_client_id = @pphone_client_id
set @vcustomer_id = @pcustomer_id


	if (@pAction = 1) --insert 
	Begin
		insert into af_phone 
		(
			phone_id,
			phone_type,
			phone_client_id,
			system_date,
			system_id,
			customer_id

		)
		values
		(
			dbo.vf_af_GenID(CHECKSUM(newid())),
			@vphone_type,
			@vphone_client_id,
			getdate(),
			'1',
			@vcustomer_id
		)
	end

	if (@pAction = 2) --update 
	Begin

		update af_phone set 
		phone_type = @vphone_type,
		phone_client_id = @vphone_client_id
		where phone_id = @vphone_id

	end
	if @@ERROR <> 0
	begin
		set @pResultNo = 1
		set @pResultReason = 'Error Occured when inserting setting'
		return
	end
	else
	begin
		set @pResultNo = 0
		set @pResultReason = 'SUCCESS'
		return
	end
END

GRANT EXECUTE ON sp_af_phone_manage TO public;

GO
/****** Object:  StoredProcedure [dbo].[sp_af_stock_checkout]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	Author: Ruan Pienaar
	Date Created: 2020-01-29
	Changes --

*/

CREATE PROCEDURE [dbo].[sp_af_stock_checkout]

@pcheckedout_id nvarchar(255),
@pjob_id nvarchar(255),
@pstock_on_hand_id nvarchar(255),
@pcustomer_id int,
@pquantity int,
@pResultReason varchar(255) out,
@pResultNo int out

AS
BEGIN

declare @vjob_id varchar(30)
declare @vstock_on_hand_id varchar(30)
declare @vcustomer_id int
declare @vamount float
declare @vquantity int

set @vjob_id = @pjob_id
set @vcustomer_id = @pcustomer_id
set @vstock_on_hand_id = @pstock_on_hand_id
set @vquantity = @pquantity

		insert into af_stock_checkedout 
		(
			checkedout_id,
			job_id,
			soh_id,
			customer_id,
			quantity

		)
		values
		(
			dbo.vf_af_GenID(CHECKSUM(newid())),
			@vjob_id,
			@vstock_on_hand_id,
			@vcustomer_id,
			@vquantity
		)

	update af_stock_on_hand set quantity -= @vquantity where soh_id = @vstock_on_hand_id

	set @vamount = (
	select
	cp.unit_price * @vquantity as amount
	from af_stock_on_hand soh 
	inner join af_cost_profile cp on soh.cost_profile_id = cp.cost_profile_id 
	where soh.soh_id = @vstock_on_hand_id)

	exec sp_af_insert_financial @vamount,@vjob_id,1,'out','119202013117AF209942','',null
	
	if @@ERROR <> 0
	begin
		set @pResultNo = 1
		set @pResultReason = 'Error Occured when inserting setting'
		return
	end
	else
	begin
		set @pResultNo = 0
		set @pResultReason = 'SUCCESS'
		return
	end
END

GRANT EXECUTE ON sp_af_stock_checkout TO public;

GO
/****** Object:  StoredProcedure [dbo].[sp_af_stock_manage]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	Author: Ruan Pienaar
	Date Created: 2020-01-29
	Changes --

*/

CREATE PROCEDURE [dbo].[sp_af_stock_manage]

@pStockId varchar(50),
@pStockName varchar(255),
@pStockDescription varchar(500),
@pSupplier_Id int,
@pItem_type_Id int,
@pCustomer_Id int,
@pQuantity int,
@pQuantityML float,
@pMinQuantity int,
@pMinQuantityML int,
@pDivident int,
@pAction int,
@pActive bit,
@pResultReason varchar(255) out,
@pResultNo int out

AS
BEGIN
declare @vStockId varchar(50)
declare @vStockName varchar(255)
declare @vStockDescription varchar(500)
declare @vSupplier_Id int
declare @vItem_type_Id int
declare @vCustomer_Id int
declare @vQuantity int
declare @vQuantityML float
declare @vMinQuantity int
declare @vMinQuantityML int
declare @vDivident int
declare @vAction int
declare @vActive bit

 
set @vStockName = @pStockName
set @vStockDescription = @pStockDescription
set @vSupplier_Id = @pSupplier_Id
set @vItem_type_Id = @pItem_type_Id
set @vCustomer_Id = @pCustomer_Id
set @vQuantity = @pQuantity
set @vQuantityML = @pQuantityML
set @vMinQuantity = @pMinQuantity
set @vMinQuantityML = @pMinQuantityML
set @vDivident = @pDivident
set @vAction = @pAction
set @vActive = @pActive
set @vStockId = @pStockId

print @vActive

	if (@vAction = 1) --insert 
	Begin
		insert into af_stock 
		(
			stock_id,
			customer_id,
			stock_discription,
			stock_name,
			stock_supplier_id,
			item_type_id,
			devident,
			min_order_quantity,
			min_order_quantity_ml,
			item_quantity,
			item_quantity_ml,
			active,
			system_userid,
			system_date 

		)
		values
		(
			dbo.vf_af_GenID(CHECKSUM(newid())),
			@vCustomer_id,
			@vStockDescription,
			@vStockName,
			@vSupplier_Id,
			@vItem_type_Id,
			@vDivident,
			@vMinQuantity,
			@vMinQuantityML,
			@vQuantity,
			@vQuantityML,
			@vActive,
			1,
			GETDATE()
		)
	end


	if (@vAction = 2) --update 
	Begin
	
		update af_stock  set 
		customer_id = @vCustomer_id,
		stock_name = @vStockName,
		stock_discription = @vStockDescription,
		stock_supplier_id = @vSupplier_Id,
		item_type_id = @vItem_type_Id,
		min_order_quantity = @vMinQuantity,
		min_order_quantity_ml = @vMinQuantityML,
		item_quantity = @vQuantity,
		item_quantity_ml = @vQuantityML,
		devident = @vDivident,
		active = @vActive
		where stock_id = @vStockId

	end
	if @@ERROR <> 0
	begin
		set @pResultNo = 1
		set @pResultReason = 'Error Occured when inserting setting'
		return
	end
	else
	begin
		set @pResultNo = 0
		set @pResultReason = 'SUCCESS'
		return
	end
END

GRANT EXECUTE ON sp_af_stock_manage TO public;

GO
/****** Object:  StoredProcedure [dbo].[sp_af_stockonhand_manage]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	Author: Ruan Pienaar
	Date Created: 2020-01-29
	Changes --

*/

CREATE PROCEDURE [dbo].[sp_af_stockonhand_manage]

@pcustomer_id int,
@pstock_id varchar(255),
@pcost_profile_id varchar(500),
@pquantity int,
@pResultReason varchar(255) out,
@pResultNo int out

AS
BEGIN
declare @vstock_id varchar(255)
declare @vcost_profile_id varchar(255)
declare @vitemquantity int
declare @vquantity int
declare @vquantity_ml float
declare @vcustomer_id int
declare @vdevided_quantity int
declare @vdevided_quantity_ml float
declare @vdevident int
declare @vstock_type_id int
declare @vAction int
declare @vstock_name varchar(50)
declare @vprofile_name varchar(50)

 
set @vstock_id = @pstock_id
set @vcost_profile_id = @pcost_profile_id
set @vcustomer_id = @pcustomer_id
set @vitemquantity = @pquantity
set @vAction = 1

select 

 @vquantity = s.item_quantity,
 @vquantity_ml = s.item_quantity_ml,
 @vdevident = s.devident,
 @vstock_type_id = s.item_type_id,
 @vstock_name = s.stock_name,
 @vprofile_name = cp.cost_profile_name
 from af_stock s 
 inner join af_cost_profile cp on s.stock_id = cp.stock_id
 where s.stock_id = @vstock_id

if @vstock_type_id = 1
begin
	set @vdevided_quantity = (@vquantity*@vdevident)*@vitemquantity
end
else if @vstock_type_id = 2
begin
	set @vdevided_quantity = (@vquantity_ml*@vdevident)*@vitemquantity
end

if exists(--checks if cost profile/stock item combo exists
		
		select * from af_stock_on_hand soh  
		inner join af_cost_profile cp on soh.cost_profile_id = cp.cost_profile_id
		inner join af_stock s on soh.stock_id = s.stock_id
		where soh.stock_id = @vstock_id
		and soh.cost_profile_id = @vcost_profile_id

		)
		set @vAction = 2


	if (@vAction = 1) --insert 
	Begin
		insert into af_stock_on_hand 
		(
			soh_id,
			stock_id,
			cost_profile_id,
			customer_id,
			quantity,
			system_date,
			system_userid,
			touch_date,
			touch_userid,
			stock_name,
			profile_name
		)
		values
		(
			dbo.vf_af_GenID(CHECKSUM(newid())),
			@vstock_id,
			@vcost_profile_id,
			1,
			@vdevided_quantity,
			getdate(),
			1,
			GETDATE(),
			1,
			@vstock_name,
			@vprofile_name
		)

	end
	if (@vAction = 2)
	begin

		update af_stock_on_hand set 
		quantity += @vdevided_quantity 
		where stock_id = @vstock_id 
		and cost_profile_id = @vcost_profile_id

	end
	if @@ERROR <> 0
	begin
		set @pResultNo = 1
		set @pResultReason = 'Error Occured when inserting setting'
		return
	end
	else
	begin
		set @pResultNo = 0
		set @pResultReason = 'SUCCESS'
		return
	end
END

GRANT EXECUTE ON sp_af_stockonhand_manage TO public;

GO
/****** Object:  StoredProcedure [dbo].[sp_af_upload_manage]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	Author: Ruan Pienaar
	Date Created: 2020-01-29
	Changes --

*/

CREATE PROCEDURE [dbo].[sp_af_upload_manage]

@pUploadId varchar(30),
@pUploadName varchar(30),
@pUploadType varchar(30),
@pDirectory varchar(255),
@pJob_id varchar(30),
@pcustomer_id int,
@pAction int,
@pResultReason varchar(255) out,
@pResultNo int out

AS
BEGIN
declare @vUploadId varchar(30)
declare @vUploadName varchar(30)
declare @vUploadType varchar(30)
declare @vDirectory varchar(255)
declare @vJob_id varchar(30)
declare @vcustomer_id int
declare @vAction int

 
set @vUploadId = @pUploadId
set @vUploadName = @pUploadName
set @vUploadType = @pUploadType
set @vDirectory = @pDirectory
set @vJob_id = @pJob_id
set @vcustomer_id = @pcustomer_id
set @vAction = @pAction

	if (@vAction = 1) --insert 
	Begin
		insert into af_uploads 
		(
			upload_id,
			upload_name,
			upload_type,
			directory,
			job_id,
			customer_id,
			system_date 

		)
		values
		(
			dbo.vf_af_GenID(CHECKSUM(newid())),
			@vUploadName,
			@vUploadType,
			@vDirectory,
			@vJob_id,
			@vcustomer_id,
			GETDATE()
		)
	end


	if (@vAction = 2) --update 
	Begin
	
		update af_uploads  set 
		upload_name = @vUploadName,
		upload_type = @vUploadType,
		directory = @vDirectory,
		job_id = @vJob_id,
		customer_id = @vcustomer_id
		where upload_id = @vUploadId

	end
	if @@ERROR <> 0
	begin
		set @pResultNo = 1
		set @pResultReason = 'Error Occured when inserting setting'
		return
	end
	else
	begin
		set @pResultNo = 0
		set @pResultReason = 'SUCCESS'
		return
	end
END

GRANT EXECUTE ON sp_af_upload_manage TO public;

GO
/****** Object:  StoredProcedure [dbo].[sp_af_vehicle_make_manage]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	Author: Ruan Pienaar
	Date Created: 2020-01-29
	Changes --

*/

CREATE PROCEDURE [dbo].[sp_af_vehicle_make_manage]

@pmake_id varchar(50),
@pmake_name varchar(50),
@pAction int,
@pResultReason varchar(255) out,
@pResultNo int out

AS
BEGIN

declare @vmake_id varchar(50)
declare @vmake_name varchar(50)

set @vmake_id = @pmake_id
set @vmake_name = @pmake_name

	if (@pAction = 1) --insert 
	Begin
		insert into af_vehicle_make
		(
			make_id,
			make_name,
			systemdate

		)
		values
		(
			dbo.vf_af_GenID(CHECKSUM(newid())),
			@vmake_name,
			GETDATE()
		)
	end

	if (@pAction = 2) --update 
	Begin

		update af_vehicle_make set 
		make_name = @vmake_name
		where make_id = @vmake_id

	end
	if @@ERROR <> 0
	begin
		set @pResultNo = 1
		set @pResultReason = 'Error Occured when inserting setting'
		return
	end
	else
	begin
		set @pResultNo = 0
		set @pResultReason = 'SUCCESS'
		return
	end
END

GRANT EXECUTE ON sp_af_vehicle_make_manage TO public;

GO
/****** Object:  StoredProcedure [dbo].[sp_af_vehicle_manage]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	Author: Ruan Pienaar
	Date Created: 2020-01-29
	Changes --

*/

CREATE PROCEDURE [dbo].[sp_af_vehicle_manage]

@pvehicle_id varchar(50),
@pcustomer_id varchar(50),
@pclient_id varchar(50),
@pvin varchar(50),
@pregno varchar(50),
@pvehicle_make varchar(50),
@pvehicle_model varchar(50),
@pvehicle_sub_model varchar(50),
@pvehicle_year varchar(50),
@puser_id varchar(50),
@pAction int,
@pResultReason varchar(255) out,
@pResultNo int out

AS
BEGIN

declare @vvehilce_id varchar(30)
declare @vcustomer_id varchar(50)
declare @vclient_id varchar(50)
declare @vvin varchar(50)
declare @vregno varchar(50)
declare @vvehicle_make varchar(50)
declare @vvehicle_model varchar(50)
declare @vvehicle_sub_model varchar(50)
declare @vvehicle_year varchar(50)
declare @vAction int
declare @vuser_id varchar(50)

set @vvehilce_id = @pvehicle_id
set @vcustomer_id = @pcustomer_id
set @vclient_id = @pclient_id
set @vvin = @pvin
set @vregno = @pregno
set @vvehicle_make = @pvehicle_make
set @vvehicle_model = @pvehicle_model
set @vvehicle_sub_model = @pvehicle_sub_model
set @vvehicle_year = @pvehicle_year
set @vuser_id = @puser_id
set @vAction = @pAction


	if (@pAction = 1) --insert 
	Begin
		insert into af_vehicle 
		(
			vehicleid,
			customerid,
			clientid,
			vin,
			regno,
			vehiclemake,
			vehiclemodel,
			vehiclesubmodel,
			vehicleyear,
			systemdate,
			system_id

		)
		values
		(
			dbo.vf_af_GenID(CHECKSUM(newid())),
			@vcustomer_id,
			@vclient_id,
			@vvin,
			@vregno,
			@vvehicle_make,
			@vvehicle_model,
			@vvehicle_sub_model,
			@vvehicle_year,
			convert(varchar,getdate(),120),
			@vuser_id
		)
	end
	if (@vAction = 2) --update 
	Begin
	
		update af_vehicle  set 
		clientid = @vclient_id,
		vin = @vvin,
		regno = @vregno,
		vehiclemake = @vvehicle_make,
		vehiclemodel = @vvehicle_model,
		vehiclesubmodel = @vvehicle_sub_model,
		vehicleyear = @vvehicle_year,
		touch_id = @vuser_id,
		customerid = @vcustomer_id,
		touch_date = convert(varchar,getdate(),120)
		where vehicleid = @vvehilce_id

	end
	if @@ERROR <> 0
	begin
		set @pResultNo = 1
		set @pResultReason = 'Error Occured when inserting setting'
		return
	end
	else
	begin
		set @pResultNo = 0
		set @pResultReason = 'SUCCESS'
		return
	end
END

GRANT EXECUTE ON sp_af_vehicle_manage TO public;

GO
/****** Object:  StoredProcedure [dbo].[sp_af_vehicle_model_manage]    Script Date: 2020-09-14 09:13:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	Author: Ruan Pienaar
	Date Created: 2020-01-29
	Changes --

*/

CREATE PROCEDURE [dbo].[sp_af_vehicle_model_manage]
 
@pmodel_id varchar(50),
@pmodel_name varchar(50),
@pmake_id varchar(50),
@pAction int,
@pResultReason varchar(255) out,
@pResultNo int out

AS
BEGIN

declare @vmodel_id varchar(50)
declare @vmodel_name varchar(50)
declare @vmake_id varchar(50)

set @vmodel_id = @pmodel_id
set @vmodel_name = @pmodel_name
set @vmake_id = @pmake_id

	if (@pAction = 1) --insert 
	Begin
		insert into af_vehicle_model
		(
			model_id,
			model_name,
			make_id,
			systemdate

		)
		values
		(
			dbo.vf_af_GenID(CHECKSUM(newid())),
			@vmodel_name,
			@vmake_id,
			GETDATE()
		)
	end

	if (@pAction = 2) --update 
	Begin

		update af_vehicle_model set 
		model_name = @vmodel_name,
		make_id = @vmake_id
		where model_id = @vmodel_id

	end
	if @@ERROR <> 0
	begin
		set @pResultNo = 1
		set @pResultReason = 'Error Occured when inserting setting'
		return
	end
	else
	begin
		set @pResultNo = 0
		set @pResultReason = 'SUCCESS'
		return
	end
END

GRANT EXECUTE ON sp_af_vehicle_model_manage TO public;

GO
USE [master]
GO
ALTER DATABASE [main_autoflow_db] SET  READ_WRITE 
GO
