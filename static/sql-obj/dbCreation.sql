USE [master]
GO
/****** Object:  Database [GNREPORT_SMNYL]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE DATABASE [GNREPORT_SMNYL]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GNREPORT_SMNYL', FILENAME = N'D:\MssqlData\GNREPORT_SMNYL_data.mdf' , SIZE = 10485760KB , MAXSIZE = UNLIMITED, FILEGROWTH = 5485760KB ), 
 FILEGROUP [Diciembre_2024] 
( NAME = N'Diciembre_2024', FILENAME = N'D:\MssqlData\Diciembre_2024.ndf' , SIZE = 10485760KB , MAXSIZE = UNLIMITED, FILEGROWTH = 5485760KB ), 
 FILEGROUP [Enero_2025] 
( NAME = N'Enero_2025', FILENAME = N'D:\MssqlData\Enero_2025.ndf' , SIZE = 10485760KB , MAXSIZE = UNLIMITED, FILEGROWTH = 5485760KB ), 
 FILEGROUP [Febrero_2025] 
( NAME = N'Febrero_2025', FILENAME = N'D:\MssqlData\Febrero_2025.ndf' , SIZE = 10485760KB , MAXSIZE = UNLIMITED, FILEGROWTH = 5485760KB ), 
 FILEGROUP [Marzo_2025] 
( NAME = N'Marzo_2025', FILENAME = N'D:\MssqlData\Marzo_2025.ndf' , SIZE = 10485760KB , MAXSIZE = UNLIMITED, FILEGROWTH = 5485760KB ), 
 FILEGROUP [Abril_2025] 
( NAME = N'Abril_2025', FILENAME = N'D:\MssqlData\Abril_2025.ndf' , SIZE = 10485760KB , MAXSIZE = UNLIMITED, FILEGROWTH = 5485760KB ), 
 FILEGROUP [Mayo_2025] 
( NAME = N'Mayo_2025', FILENAME = N'D:\MssqlData\Mayo_2025.ndf' , SIZE = 10485760KB , MAXSIZE = UNLIMITED, FILEGROWTH = 5485760KB ), 
 FILEGROUP [Junio_2025] 
( NAME = N'Junio_2025', FILENAME = N'D:\MssqlData\Junio_2025.ndf' , SIZE = 10485760KB , MAXSIZE = UNLIMITED, FILEGROWTH = 5485760KB ), 
 FILEGROUP [Julio_2025] 
( NAME = N'Julio_2025', FILENAME = N'D:\MssqlData\Julio_2025.ndf' , SIZE = 10485760KB , MAXSIZE = UNLIMITED, FILEGROWTH = 5485760KB )
 LOG ON 
( NAME = N'GNREPORT_SMNYL_log', FILENAME = N'G:\MssqlLog\GNREPORT_SMNYL_log.ldf' , SIZE = 1048576KB , MAXSIZE = 1073741824KB , FILEGROWTH = 5485760KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [GNREPORT_SMNYL] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GNREPORT_SMNYL].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GNREPORT_SMNYL] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET ARITHABORT OFF 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET  MULTI_USER 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GNREPORT_SMNYL] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GNREPORT_SMNYL] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [GNREPORT_SMNYL] SET QUERY_STORE = OFF
GO
USE [GNREPORT_SMNYL]
GO
/****** Object:  User [stage]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE USER [stage] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [reportes]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE USER [reportes] FOR LOGIN [reportes] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [etl_user]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE USER [etl_user] FOR LOGIN [etl_user] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [ctorres]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE USER [ctorres] FOR LOGIN [ctorres] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [cdc]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE USER [cdc] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[cdc]
GO
/****** Object:  User [amorgado]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE USER [amorgado] FOR LOGIN [amorgado] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [user_sp]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE ROLE [user_sp]
GO
/****** Object:  DatabaseRole [user_qa]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE ROLE [user_qa]
GO
/****** Object:  DatabaseRole [user_practicante]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE ROLE [user_practicante]
GO
/****** Object:  DatabaseRole [db_executor]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE ROLE [db_executor]
GO
ALTER ROLE [db_owner] ADD MEMBER [stage]
GO
ALTER ROLE [db_datareader] ADD MEMBER [stage]
GO
ALTER ROLE [db_datareader] ADD MEMBER [reportes]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [reportes]
GO
ALTER ROLE [db_owner] ADD MEMBER [etl_user]
GO
ALTER ROLE [db_owner] ADD MEMBER [ECC-INSG-SQL01\norton.bascunan]
GO
ALTER ROLE [db_owner] ADD MEMBER [ctorres]
GO
ALTER ROLE [db_owner] ADD MEMBER [cdc]
GO
ALTER ROLE [db_owner] ADD MEMBER [amorgado]
GO
/****** Object:  Schema [cdc]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE SCHEMA [cdc]
GO
/****** Object:  PartitionFunction [PF_Dia_Dim_Conversation]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION FUNCTION [PF_Dia_Dim_Conversation](datetime) AS RANGE LEFT FOR VALUES (N'2024-12-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2025-02-01T00:00:00.000', N'2025-03-01T00:00:00.000', N'2025-04-01T00:00:00.000', N'2025-05-01T00:00:00.000', N'2025-06-01T00:00:00.000', N'2025-06-07T00:00:00.000')
GO
/****** Object:  PartitionFunction [PF_Dia_Dim_ConversationAggregateMetrics]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION FUNCTION [PF_Dia_Dim_ConversationAggregateMetrics](datetime) AS RANGE LEFT FOR VALUES (N'2024-12-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2025-02-01T00:00:00.000', N'2025-03-01T00:00:00.000', N'2025-04-01T00:00:00.000', N'2025-05-01T00:00:00.000', N'2025-06-01T00:00:00.000', N'2025-06-07T00:00:00.000')
GO
/****** Object:  PartitionFunction [PF_Dia_Dim_ConversationCampaignAggregateMetrics]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION FUNCTION [PF_Dia_Dim_ConversationCampaignAggregateMetrics](datetime) AS RANGE LEFT FOR VALUES (N'2024-12-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2025-02-01T00:00:00.000', N'2025-03-01T00:00:00.000', N'2025-04-01T00:00:00.000', N'2025-05-01T00:00:00.000', N'2025-06-01T00:00:00.000', N'2025-06-07T00:00:00.000')
GO
/****** Object:  PartitionFunction [PF_Dia_Dim_ConversationDayQueueAggregateMetrics]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION FUNCTION [PF_Dia_Dim_ConversationDayQueueAggregateMetrics](datetime) AS RANGE LEFT FOR VALUES (N'2024-12-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2025-02-01T00:00:00.000', N'2025-03-01T00:00:00.000', N'2025-04-01T00:00:00.000', N'2025-05-01T00:00:00.000', N'2025-06-01T00:00:00.000', N'2025-06-07T00:00:00.000')
GO
/****** Object:  PartitionFunction [PF_Dia_Dim_ConversationDivisions]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION FUNCTION [PF_Dia_Dim_ConversationDivisions](datetime) AS RANGE LEFT FOR VALUES (N'2024-12-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2025-02-01T00:00:00.000', N'2025-03-01T00:00:00.000', N'2025-04-01T00:00:00.000', N'2025-05-01T00:00:00.000', N'2025-06-01T00:00:00.000', N'2025-06-07T00:00:00.000')
GO
/****** Object:  PartitionFunction [PF_Dia_Dim_ConversationQueueAggregateMetrics]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION FUNCTION [PF_Dia_Dim_ConversationQueueAggregateMetrics](datetime) AS RANGE LEFT FOR VALUES (N'2024-12-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2025-02-01T00:00:00.000', N'2025-03-01T00:00:00.000', N'2025-04-01T00:00:00.000', N'2025-05-01T00:00:00.000', N'2025-06-01T00:00:00.000', N'2025-06-07T00:00:00.000')
GO
/****** Object:  PartitionFunction [PF_Dia_Dim_ConversationUserAggregateMetrics]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION FUNCTION [PF_Dia_Dim_ConversationUserAggregateMetrics](datetime) AS RANGE LEFT FOR VALUES (N'2024-12-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2025-02-01T00:00:00.000', N'2025-03-01T00:00:00.000', N'2025-04-01T00:00:00.000', N'2025-05-01T00:00:00.000', N'2025-06-01T00:00:00.000', N'2025-06-07T00:00:00.000')
GO
/****** Object:  PartitionFunction [PF_Dia_Dim_ConversationWrapUpCodeAggregateMetrics]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION FUNCTION [PF_Dia_Dim_ConversationWrapUpCodeAggregateMetrics](datetime) AS RANGE LEFT FOR VALUES (N'2024-12-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2025-02-01T00:00:00.000', N'2025-03-01T00:00:00.000', N'2025-04-01T00:00:00.000', N'2025-05-01T00:00:00.000', N'2025-06-01T00:00:00.000', N'2025-06-07T00:00:00.000')
GO
/****** Object:  PartitionFunction [PF_Dia_Dim_DataParticipant]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION FUNCTION [PF_Dia_Dim_DataParticipant](datetime) AS RANGE LEFT FOR VALUES (N'2024-12-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2025-02-01T00:00:00.000', N'2025-03-01T00:00:00.000', N'2025-04-01T00:00:00.000', N'2025-05-01T00:00:00.000', N'2025-06-01T00:00:00.000', N'2025-06-07T00:00:00.000')
GO
/****** Object:  PartitionFunction [PF_Dia_Dim_FlowAggregateMetrics]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION FUNCTION [PF_Dia_Dim_FlowAggregateMetrics](datetime) AS RANGE LEFT FOR VALUES (N'2024-12-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2025-02-01T00:00:00.000', N'2025-03-01T00:00:00.000', N'2025-04-01T00:00:00.000', N'2025-05-01T00:00:00.000', N'2025-06-01T00:00:00.000', N'2025-06-07T00:00:00.000')
GO
/****** Object:  PartitionFunction [PF_Dia_Dim_Participant]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION FUNCTION [PF_Dia_Dim_Participant](datetime) AS RANGE LEFT FOR VALUES (N'2024-12-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2025-02-01T00:00:00.000', N'2025-03-01T00:00:00.000', N'2025-04-01T00:00:00.000', N'2025-05-01T00:00:00.000', N'2025-06-01T00:00:00.000', N'2025-06-07T00:00:00.000')
GO
/****** Object:  PartitionFunction [PF_Dia_Dim_Seg_requestedRoutingSkillIds]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION FUNCTION [PF_Dia_Dim_Seg_requestedRoutingSkillIds](datetime) AS RANGE LEFT FOR VALUES (N'2024-12-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2025-02-01T00:00:00.000', N'2025-03-01T00:00:00.000', N'2025-04-01T00:00:00.000', N'2025-05-01T00:00:00.000', N'2025-06-01T00:00:00.000', N'2025-06-07T00:00:00.000')
GO
/****** Object:  PartitionFunction [PF_Dia_Dim_Segment]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION FUNCTION [PF_Dia_Dim_Segment](datetime) AS RANGE LEFT FOR VALUES (N'2024-12-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2025-02-01T00:00:00.000', N'2025-03-01T00:00:00.000', N'2025-04-01T00:00:00.000', N'2025-05-01T00:00:00.000', N'2025-06-01T00:00:00.000', N'2025-06-07T00:00:00.000')
GO
/****** Object:  PartitionFunction [PF_Dia_Dim_Session]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION FUNCTION [PF_Dia_Dim_Session](datetime) AS RANGE LEFT FOR VALUES (N'2024-12-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2025-02-01T00:00:00.000', N'2025-03-01T00:00:00.000', N'2025-04-01T00:00:00.000', N'2025-05-01T00:00:00.000', N'2025-06-01T00:00:00.000', N'2025-06-07T00:00:00.000')
GO
/****** Object:  PartitionFunction [PF_Dia_Dim_SessionFlow]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION FUNCTION [PF_Dia_Dim_SessionFlow](datetime) AS RANGE LEFT FOR VALUES (N'2024-12-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2025-02-01T00:00:00.000', N'2025-03-01T00:00:00.000', N'2025-04-01T00:00:00.000', N'2025-05-01T00:00:00.000', N'2025-06-01T00:00:00.000', N'2025-06-07T00:00:00.000')
GO
/****** Object:  PartitionFunction [PF_Dia_Dim_SessionFlowOutcomes]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION FUNCTION [PF_Dia_Dim_SessionFlowOutcomes](datetime) AS RANGE LEFT FOR VALUES (N'2024-12-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2025-02-01T00:00:00.000', N'2025-03-01T00:00:00.000', N'2025-04-01T00:00:00.000', N'2025-05-01T00:00:00.000', N'2025-06-01T00:00:00.000', N'2025-06-07T00:00:00.000')
GO
/****** Object:  PartitionFunction [PF_Dia_Dim_SessionMetrics]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION FUNCTION [PF_Dia_Dim_SessionMetrics](datetime) AS RANGE LEFT FOR VALUES (N'2024-12-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2025-02-01T00:00:00.000', N'2025-03-01T00:00:00.000', N'2025-04-01T00:00:00.000', N'2025-05-01T00:00:00.000', N'2025-06-01T00:00:00.000', N'2025-06-07T00:00:00.000')
GO
/****** Object:  PartitionFunction [PF_Dia_Dim_UserAggregateMetrics]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION FUNCTION [PF_Dia_Dim_UserAggregateMetrics](datetime) AS RANGE LEFT FOR VALUES (N'2024-12-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2025-02-01T00:00:00.000', N'2025-03-01T00:00:00.000', N'2025-04-01T00:00:00.000', N'2025-05-01T00:00:00.000', N'2025-06-01T00:00:00.000', N'2025-06-07T00:00:00.000')
GO
/****** Object:  PartitionFunction [PF_Dia_Dim_UserStatusDetails]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION FUNCTION [PF_Dia_Dim_UserStatusDetails](datetime) AS RANGE LEFT FOR VALUES (N'2024-12-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2025-02-01T00:00:00.000', N'2025-03-01T00:00:00.000', N'2025-04-01T00:00:00.000', N'2025-05-01T00:00:00.000', N'2025-06-01T00:00:00.000', N'2025-06-07T00:00:00.000')
GO
/****** Object:  PartitionFunction [PF_Dia_H_UserStatusDetails]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION FUNCTION [PF_Dia_H_UserStatusDetails](datetime) AS RANGE LEFT FOR VALUES (N'2024-12-01T00:00:00.000', N'2025-01-01T00:00:00.000', N'2025-02-01T00:00:00.000', N'2025-03-01T00:00:00.000', N'2025-04-01T00:00:00.000', N'2025-05-01T00:00:00.000', N'2025-06-01T00:00:00.000', N'2025-06-07T00:00:00.000')
GO
/****** Object:  PartitionScheme [PSCH_Dia_Dim_Conversation]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION SCHEME [PSCH_Dia_Dim_Conversation] AS PARTITION [PF_Dia_Dim_Conversation] TO ([Diciembre_2024], [Enero_2025], [Febrero_2025], [Marzo_2025], [Abril_2025], [Mayo_2025], [Junio_2025], [Julio_2025], [PRIMARY])
GO
/****** Object:  PartitionScheme [PSCH_Dia_Dim_ConversationAggregateMetrics]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION SCHEME [PSCH_Dia_Dim_ConversationAggregateMetrics] AS PARTITION [PF_Dia_Dim_ConversationAggregateMetrics] TO ([Diciembre_2024], [Enero_2025], [Febrero_2025], [Marzo_2025], [Abril_2025], [Mayo_2025], [Junio_2025], [Julio_2025], [PRIMARY])
GO
/****** Object:  PartitionScheme [PSCH_Dia_Dim_ConversationCampaignAggregateMetrics]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION SCHEME [PSCH_Dia_Dim_ConversationCampaignAggregateMetrics] AS PARTITION [PF_Dia_Dim_ConversationCampaignAggregateMetrics] TO ([Diciembre_2024], [Enero_2025], [Febrero_2025], [Marzo_2025], [Abril_2025], [Mayo_2025], [Junio_2025], [Julio_2025], [PRIMARY])
GO
/****** Object:  PartitionScheme [PSCH_Dia_Dim_ConversationDayQueueAggregateMetrics]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION SCHEME [PSCH_Dia_Dim_ConversationDayQueueAggregateMetrics] AS PARTITION [PF_Dia_Dim_ConversationDayQueueAggregateMetrics] TO ([Diciembre_2024], [Enero_2025], [Febrero_2025], [Marzo_2025], [Abril_2025], [Mayo_2025], [Junio_2025], [Julio_2025], [PRIMARY])
GO
/****** Object:  PartitionScheme [PSCH_Dia_Dim_ConversationDivisions]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION SCHEME [PSCH_Dia_Dim_ConversationDivisions] AS PARTITION [PF_Dia_Dim_ConversationDivisions] TO ([Diciembre_2024], [Enero_2025], [Febrero_2025], [Marzo_2025], [Abril_2025], [Mayo_2025], [Junio_2025], [Julio_2025], [PRIMARY])
GO
/****** Object:  PartitionScheme [PSCH_Dia_Dim_ConversationQueueAggregateMetrics]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION SCHEME [PSCH_Dia_Dim_ConversationQueueAggregateMetrics] AS PARTITION [PF_Dia_Dim_ConversationQueueAggregateMetrics] TO ([Diciembre_2024], [Enero_2025], [Febrero_2025], [Marzo_2025], [Abril_2025], [Mayo_2025], [Junio_2025], [Julio_2025], [PRIMARY])
GO
/****** Object:  PartitionScheme [PSCH_Dia_Dim_ConversationUserAggregateMetrics]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION SCHEME [PSCH_Dia_Dim_ConversationUserAggregateMetrics] AS PARTITION [PF_Dia_Dim_ConversationUserAggregateMetrics] TO ([Diciembre_2024], [Enero_2025], [Febrero_2025], [Marzo_2025], [Abril_2025], [Mayo_2025], [Junio_2025], [Julio_2025], [PRIMARY])
GO
/****** Object:  PartitionScheme [PSCH_Dia_Dim_ConversationWrapUpCodeAggregateMetrics]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION SCHEME [PSCH_Dia_Dim_ConversationWrapUpCodeAggregateMetrics] AS PARTITION [PF_Dia_Dim_ConversationWrapUpCodeAggregateMetrics] TO ([Diciembre_2024], [Enero_2025], [Febrero_2025], [Marzo_2025], [Abril_2025], [Mayo_2025], [Junio_2025], [Julio_2025], [PRIMARY])
GO
/****** Object:  PartitionScheme [PSCH_Dia_Dim_DataParticipant]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION SCHEME [PSCH_Dia_Dim_DataParticipant] AS PARTITION [PF_Dia_Dim_DataParticipant] TO ([Diciembre_2024], [Enero_2025], [Febrero_2025], [Marzo_2025], [Abril_2025], [Mayo_2025], [Junio_2025], [Julio_2025], [PRIMARY])
GO
/****** Object:  PartitionScheme [PSCH_Dia_Dim_FlowAggregateMetrics]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION SCHEME [PSCH_Dia_Dim_FlowAggregateMetrics] AS PARTITION [PF_Dia_Dim_FlowAggregateMetrics] TO ([Diciembre_2024], [Enero_2025], [Febrero_2025], [Marzo_2025], [Abril_2025], [Mayo_2025], [Junio_2025], [Julio_2025], [PRIMARY])
GO
/****** Object:  PartitionScheme [PSCH_Dia_Dim_Participant]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION SCHEME [PSCH_Dia_Dim_Participant] AS PARTITION [PF_Dia_Dim_Participant] TO ([Diciembre_2024], [Enero_2025], [Febrero_2025], [Marzo_2025], [Abril_2025], [Mayo_2025], [Junio_2025], [Julio_2025], [PRIMARY])
GO
/****** Object:  PartitionScheme [PSCH_Dia_Dim_Seg_requestedRoutingSkillIds]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION SCHEME [PSCH_Dia_Dim_Seg_requestedRoutingSkillIds] AS PARTITION [PF_Dia_Dim_Seg_requestedRoutingSkillIds] TO ([Diciembre_2024], [Enero_2025], [Febrero_2025], [Marzo_2025], [Abril_2025], [Mayo_2025], [Junio_2025], [Julio_2025], [PRIMARY])
GO
/****** Object:  PartitionScheme [PSCH_Dia_Dim_Segment]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION SCHEME [PSCH_Dia_Dim_Segment] AS PARTITION [PF_Dia_Dim_Segment] TO ([Diciembre_2024], [Enero_2025], [Febrero_2025], [Marzo_2025], [Abril_2025], [Mayo_2025], [Junio_2025], [Julio_2025], [PRIMARY])
GO
/****** Object:  PartitionScheme [PSCH_Dia_Dim_Session]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION SCHEME [PSCH_Dia_Dim_Session] AS PARTITION [PF_Dia_Dim_Session] TO ([Diciembre_2024], [Enero_2025], [Febrero_2025], [Marzo_2025], [Abril_2025], [Mayo_2025], [Junio_2025], [Julio_2025], [PRIMARY])
GO
/****** Object:  PartitionScheme [PSCH_Dia_Dim_SessionFlow]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION SCHEME [PSCH_Dia_Dim_SessionFlow] AS PARTITION [PF_Dia_Dim_SessionFlow] TO ([Diciembre_2024], [Enero_2025], [Febrero_2025], [Marzo_2025], [Abril_2025], [Mayo_2025], [Junio_2025], [Julio_2025], [PRIMARY])
GO
/****** Object:  PartitionScheme [PSCH_Dia_Dim_SessionFlowOutcomes]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION SCHEME [PSCH_Dia_Dim_SessionFlowOutcomes] AS PARTITION [PF_Dia_Dim_SessionFlowOutcomes] TO ([Diciembre_2024], [Enero_2025], [Febrero_2025], [Marzo_2025], [Abril_2025], [Mayo_2025], [Junio_2025], [Julio_2025], [PRIMARY])
GO
/****** Object:  PartitionScheme [PSCH_Dia_Dim_SessionMetrics]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION SCHEME [PSCH_Dia_Dim_SessionMetrics] AS PARTITION [PF_Dia_Dim_SessionMetrics] TO ([Diciembre_2024], [Enero_2025], [Febrero_2025], [Marzo_2025], [Abril_2025], [Mayo_2025], [Junio_2025], [Julio_2025], [PRIMARY])
GO
/****** Object:  PartitionScheme [PSCH_Dia_Dim_UserAggregateMetrics]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION SCHEME [PSCH_Dia_Dim_UserAggregateMetrics] AS PARTITION [PF_Dia_Dim_UserAggregateMetrics] TO ([Diciembre_2024], [Enero_2025], [Febrero_2025], [Marzo_2025], [Abril_2025], [Mayo_2025], [Junio_2025], [Julio_2025], [PRIMARY])
GO
/****** Object:  PartitionScheme [PSCH_Dia_Dim_UserStatusDetails]    Script Date: 12/12/2024 6:41:38 PM ******/
CREATE PARTITION SCHEME [PSCH_Dia_Dim_UserStatusDetails] AS PARTITION [PF_Dia_Dim_UserStatusDetails] TO ([Diciembre_2024], [Enero_2025], [Febrero_2025], [Marzo_2025], [Abril_2025], [Mayo_2025], [Junio_2025], [Julio_2025], [PRIMARY])
GO
/****** Object:  UserDefinedFunction [dbo].[ConvertirMilisegundosAHora]    Script Date: 12/12/2024 6:41:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ConvertirMilisegundosAHora] (@miliSegundos DECIMAL(25, 2))
RETURNS VARCHAR(20)
AS
BEGIN

	
	DECLARE @segundos DECIMAL(25, 4) = CAST(@milisegundos AS DECIMAL(25, 2)) / 1000;
	
	DECLARE @horas INT = @segundos / 3600;
	DECLARE @minutos INT = (@segundos % 3600) / 60;
	DECLARE @segundos_restantes INT = @segundos % 60;
	DECLARE @hora_formateada VARCHAR(20);

	IF @horas > 999 
	BEGIN
		SET @hora_formateada = RIGHT('00' + CAST(@horas AS VARCHAR(4)), 4) + ':';
	END
	ELSE IF @horas > 99 
	BEGIN
		SET @hora_formateada = RIGHT('00' + CAST(@horas AS VARCHAR(3)), 3) + ':';
	END
	ELSE
	BEGIN
		SET @hora_formateada = RIGHT('00' + CAST(@horas AS VARCHAR(2)), 2) + ':';
	END
	
	SET @hora_formateada = @hora_formateada +
		RIGHT('00' + CAST(@minutos AS VARCHAR(2)), 2) + ':' +
		RIGHT('00' + CAST(@segundos_restantes AS VARCHAR(2)), 2);

	
	--SET @hora_formateada = CONCAT(REPLACE(STR(CAST(@segundos / 3600 AS VARCHAR(3)), 3), SPACE(1), '0') ,
	--RIGHT(CAST(CONVERT(varchar, DATEADD(ms, @segundos * 1000, 0), 108) AS VARCHAR(8)),6)) 

	RETURN @hora_formateada;

	

END

GO
/****** Object:  UserDefinedFunction [dbo].[ConvertirMilisegundosAHora3Digitos]    Script Date: 12/12/2024 6:41:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ConvertirMilisegundosAHora3Digitos] (@miliSegundos DECIMAL(25, 2))
RETURNS VARCHAR(9)
AS
BEGIN

	DECLARE @segundos DECIMAL(10, 4) = CAST(@milisegundos AS DECIMAL(25, 2)) / 1000;
	
	DECLARE @horas INT = @segundos / 3600;
	DECLARE @minutos INT = (@segundos % 3600) / 60;
	DECLARE @segundos_restantes INT = @segundos % 60;

	DECLARE @hora_formateada VARCHAR(9);

	SET @hora_formateada = 
		RIGHT('000' + CAST(@horas AS VARCHAR(3)), 3) + ':' +
		RIGHT('00' + CAST(@minutos AS VARCHAR(2)), 2) + ':' +
		RIGHT('00' + CAST(@segundos_restantes AS VARCHAR(2)), 2);

	RETURN @hora_formateada;

	

END

GO
/****** Object:  UserDefinedFunction [dbo].[Redondear]    Script Date: 12/12/2024 6:41:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Redondear](@numeroDecimal DECIMAL(25, 2))
RETURNS INT
AS
BEGIN
    DECLARE @resultado INT;

    SET @resultado = 
        CASE 
            WHEN @numeroDecimal - FLOOR(@numeroDecimal) = 0.5 THEN FLOOR(@numeroDecimal)
            ELSE ROUND(@numeroDecimal, 0)
        END;

    RETURN @resultado;
END;
GO
/****** Object:  Table [dbo].[blank_session_dataparticipant]    Script Date: 12/12/2024 6:41:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[blank_session_dataparticipant](
	[conversationId] [uniqueidentifier] NOT NULL,
	[conversationDate] [int] NULL,
	[type] [varchar](32) NOT NULL,
	[processDate] [int] NULL,
	[count] [int] NOT NULL,
	[organizationId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_blank_session_dataparticipant] PRIMARY KEY CLUSTERED 
(
	[conversationId] ASC,
	[type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Control_Insight]    Script Date: 12/12/2024 6:41:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Control_Insight](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[coleccion] [nvarchar](100) NULL,
	[tabla_en_sql] [nvarchar](100) NULL,
	[registro_mas_antiguo] [datetimeoffset](7) NULL,
	[registro_mas_nuevo] [datetimeoffset](7) NULL,
	[cantidad_de_registros] [bigint] NULL,
	[Fecha] [datetime] NULL,
	[intervalo_inicio] [datetimeoffset](7) NULL,
	[intervalo_fin] [datetimeoffset](7) NULL,
 CONSTRAINT [PK__Control___3214EC27A648FC6F] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[conv]    Script Date: 12/12/2024 6:41:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[conv](
	[conversationId] [uniqueidentifier] NOT NULL,
	[conversationStart] [datetime] NULL,
	[conversationEnd] [datetime] NULL,
	[originatingDirectionId] [int] NOT NULL,
	[conversationStartHourId] [varchar](6) NOT NULL,
	[conversationStartTimeId] [int] NOT NULL,
	[mediaStatsMinConversationMos] [float] NULL,
	[mediaStatsMinConversationRFactor] [float] NULL,
	[organizationId] [uniqueidentifier] NOT NULL,
	[externalTag] [varchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[conversationIds_To_Consolidate]    Script Date: 12/12/2024 6:41:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[conversationIds_To_Consolidate](
	[conversationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_conversationIds_To_Consolidate] PRIMARY KEY CLUSTERED 
(
	[conversationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Campaign]    Script Date: 12/12/2024 6:41:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Campaign](
	[campaignId] [uniqueidentifier] NOT NULL,
	[campaignDsc] [varchar](250) NULL,
	[divisionId] [uniqueidentifier] NOT NULL,
	[queueId] [uniqueidentifier] NULL,
	[scriptId] [uniqueidentifier] NULL,
	[contactListId] [uniqueidentifier] NULL,
	[dateCreated] [datetime] NULL,
	[dateModified] [datetime] NULL,
	[dialingMode] [varchar](250) NULL,
	[campaignStatus] [varchar](250) NULL,
	[callerName] [varchar](250) NULL,
	[callerAddress] [varchar](250) NULL,
	[priority] [int] NULL,
	[outboundLineCount] [int] NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_Campaign] PRIMARY KEY CLUSTERED 
(
	[campaignId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_CampaignQueue]    Script Date: 12/12/2024 6:41:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_CampaignQueue](
	[bpo] [varchar](100) NOT NULL,
	[division] [varchar](100) NOT NULL,
	[campania] [varchar](100) NOT NULL,
	[campaniaGenesys] [varchar](100) NULL,
	[cola] [varchar](100) NOT NULL,
	[nivel] [smallint] NULL,
	[tipo] [varchar](10) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_CampaignQueue] PRIMARY KEY CLUSTERED 
(
	[bpo] ASC,
	[division] ASC,
	[campania] ASC,
	[cola] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_ContactList]    Script Date: 12/12/2024 6:41:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_ContactList](
	[contactListId] [uniqueidentifier] NOT NULL,
	[contactListDsc] [varchar](250) NULL,
	[divisionId] [uniqueidentifier] NOT NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_ContactList] PRIMARY KEY CLUSTERED 
(
	[contactListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Conversation]    Script Date: 12/12/2024 6:41:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Conversation](
	[conversationId] [uniqueidentifier] NOT NULL,
	[conversationStart] [datetime] NOT NULL,
	[conversationEnd] [datetime] NULL,
	[originatingDirectionId] [int] NOT NULL,
	[conversationStartHourId] [varchar](6) NOT NULL,
	[conversationStartTimeId] [int] NOT NULL,
	[mediaStatsMinConversationMos] [float] NULL,
	[mediaStatsMinConversationRFactor] [float] NULL,
	[organizationId] [uniqueidentifier] NOT NULL,
	[externalTag] [varchar](250) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_Conversation] PRIMARY KEY CLUSTERED 
(
	[conversationId] ASC,
	[conversationStart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PSCH_Dia_Dim_Conversation]([conversationStart])
) ON [PSCH_Dia_Dim_Conversation]([conversationStart])
GO
/****** Object:  Table [dbo].[Dim_ConversationAggregateMetrics]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_ConversationAggregateMetrics](
	[clientId] [varchar](64) NOT NULL,
	[organizationId] [varchar](64) NOT NULL,
	[divisionId] [varchar](64) NOT NULL,
	[queueId] [varchar](64) NOT NULL,
	[userId] [varchar](64) NOT NULL,
	[mediaType] [varchar](32) NOT NULL,
	[originatingDirectionId] [int] NOT NULL,
	[startTime] [datetime] NOT NULL,
	[endTime] [datetime] NULL,
	[startHourId] [varchar](6) NOT NULL,
	[startTimeId] [int] NOT NULL,
	[metric] [varchar](128) NOT NULL,
	[count] [bigint] NULL,
	[sum] [bigint] NULL,
	[min] [bigint] NULL,
	[max] [bigint] NULL,
	[ratio] [decimal](18, 15) NULL,
	[numerator] [bigint] NULL,
	[denominator] [bigint] NULL,
	[target] [decimal](18, 15) NULL,
	[timestamp] [bigint] NULL,
	[metricType] [varchar](10) NOT NULL,
	[current] [decimal](18, 15) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_ConversationAggregateMetrics] PRIMARY KEY CLUSTERED 
(
	[clientId] ASC,
	[organizationId] ASC,
	[divisionId] ASC,
	[queueId] ASC,
	[userId] ASC,
	[mediaType] ASC,
	[originatingDirectionId] ASC,
	[startTime] ASC,
	[metric] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PSCH_Dia_Dim_ConversationAggregateMetrics]([startTime])
) ON [PSCH_Dia_Dim_ConversationAggregateMetrics]([startTime])
GO
/****** Object:  Table [dbo].[Dim_ConversationCampaignAggregateMetrics]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_ConversationCampaignAggregateMetrics](
	[clientId] [varchar](64) NOT NULL,
	[organizationId] [varchar](64) NOT NULL,
	[divisionId] [varchar](64) NOT NULL,
	[campaignId] [varchar](64) NOT NULL,
	[contactListId] [varchar](64) NOT NULL,
	[mediaType] [varchar](32) NOT NULL,
	[startTime] [datetime] NOT NULL,
	[endTime] [datetime] NOT NULL,
	[startHourId] [varchar](6) NOT NULL,
	[startTimeId] [int] NOT NULL,
	[metric] [varchar](128) NOT NULL,
	[count] [bigint] NULL,
	[countNegative] [bigint] NULL,
	[countPositive] [bigint] NULL,
	[p95] [bigint] NULL,
	[p99] [bigint] NULL,
	[sum] [bigint] NULL,
	[min] [bigint] NULL,
	[max] [bigint] NULL,
	[ratio] [decimal](18, 15) NULL,
	[numerator] [bigint] NULL,
	[denominator] [bigint] NULL,
	[target] [decimal](18, 15) NULL,
	[current] [decimal](18, 15) NULL,
	[metricType] [varchar](10) NOT NULL,
	[timestamp] [bigint] NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_ConversationCampaignAggregateMetrics] PRIMARY KEY CLUSTERED 
(
	[clientId] ASC,
	[organizationId] ASC,
	[divisionId] ASC,
	[campaignId] ASC,
	[contactListId] ASC,
	[mediaType] ASC,
	[startTime] ASC,
	[metric] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PSCH_Dia_Dim_ConversationCampaignAggregateMetrics]([startTime])
) ON [PSCH_Dia_Dim_ConversationCampaignAggregateMetrics]([startTime])
GO
/****** Object:  Table [dbo].[Dim_ConversationDayQueueAggregateMetrics]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_ConversationDayQueueAggregateMetrics](
	[clientId] [varchar](64) NOT NULL,
	[organizationId] [varchar](64) NOT NULL,
	[divisionId] [varchar](64) NOT NULL,
	[queueId] [varchar](64) NOT NULL,
	[mediaType] [varchar](32) NOT NULL,
	[originatingDirectionId] [int] NOT NULL,
	[startTime] [datetime] NOT NULL,
	[endTime] [datetime] NULL,
	[startHourId] [varchar](6) NOT NULL,
	[startTimeId] [int] NOT NULL,
	[metric] [varchar](128) NOT NULL,
	[count] [bigint] NULL,
	[sum] [bigint] NULL,
	[min] [bigint] NULL,
	[max] [bigint] NULL,
	[ratio] [decimal](18, 15) NULL,
	[numerator] [bigint] NULL,
	[denominator] [bigint] NULL,
	[target] [decimal](18, 15) NULL,
	[timestamp] [bigint] NULL,
	[metricType] [varchar](10) NOT NULL,
	[current] [decimal](18, 15) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_ConversationDayQueueAggregateMetrics] PRIMARY KEY CLUSTERED 
(
	[clientId] ASC,
	[organizationId] ASC,
	[divisionId] ASC,
	[queueId] ASC,
	[mediaType] ASC,
	[originatingDirectionId] ASC,
	[startTime] ASC,
	[metric] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PSCH_Dia_Dim_ConversationDayQueueAggregateMetrics]([startTime])
) ON [PSCH_Dia_Dim_ConversationDayQueueAggregateMetrics]([startTime])
GO
/****** Object:  Table [dbo].[Dim_ConversationDivisions]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_ConversationDivisions](
	[conversationId] [uniqueidentifier] NOT NULL,
	[divisionId] [uniqueidentifier] NOT NULL,
	[conversationStart] [datetime] NOT NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_ConversationDivisions_1] PRIMARY KEY CLUSTERED 
(
	[conversationId] ASC,
	[divisionId] ASC,
	[conversationStart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PSCH_Dia_Dim_ConversationDivisions]([conversationStart])
) ON [PSCH_Dia_Dim_ConversationDivisions]([conversationStart])
GO
/****** Object:  Table [dbo].[Dim_ConversationEvaluations]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_ConversationEvaluations](
	[conversationId] [uniqueidentifier] NOT NULL,
	[evaluationId] [uniqueidentifier] NOT NULL,
	[userId] [uniqueidentifier] NOT NULL,
	[queueId] [uniqueidentifier] NOT NULL,
	[formId] [uniqueidentifier] NOT NULL,
	[evaluatorId] [uniqueidentifier] NULL,
	[evaluationSourceId] [uniqueidentifier] NULL,
	[evaluationSourceType] [varchar](32) NULL,
	[evaluationSourceName] [varchar](256) NULL,
	[contextId] [uniqueidentifier] NULL,
	[status] [varchar](32) NOT NULL,
	[mediaType] [varchar](256) NULL,
	[agentHasRead] [bit] NULL,
	[assigneeApplicable] [bit] NULL,
	[neverRelease] [bit] NULL,
	[hasAssistanceFailed] [bit] NULL,
	[anyFailedKillQuestions] [bit] NULL,
	[releaseDate] [datetime] NULL,
	[assignedDate] [datetime] NULL,
	[changedDate] [datetime] NULL,
	[authorizedActions] [varchar](512) NULL,
	[totalScore] [decimal](18, 15) NULL,
	[totalCriticalScore] [decimal](18, 15) NULL,
	[totalNonCriticalScore] [decimal](18, 15) NULL,
	[comments] [varchar](512) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_Evaluation] PRIMARY KEY CLUSTERED 
(
	[conversationId] ASC,
	[evaluationId] ASC,
	[userId] ASC,
	[queueId] ASC,
	[formId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_ConversationEvaluationsQuestionsGroupScores]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_ConversationEvaluationsQuestionsGroupScores](
	[evaluationId] [uniqueidentifier] NOT NULL,
	[questionGroupId] [uniqueidentifier] NOT NULL,
	[totalScore] [decimal](18, 15) NULL,
	[maxTotalScore] [decimal](18, 15) NULL,
	[markedNA] [bit] NULL,
	[totalCriticalScore] [decimal](18, 15) NULL,
	[maxTotalCriticalScore] [decimal](18, 15) NULL,
	[totalNonCriticalScore] [decimal](18, 15) NULL,
	[maxTotalNonCriticalScore] [decimal](18, 15) NULL,
	[totalScoreUnweighted] [decimal](18, 15) NULL,
	[maxTotalScoreUnweighted] [decimal](18, 15) NULL,
	[totalCriticalScoreUnweighted] [decimal](18, 15) NULL,
	[maxTotalCriticalScoreUnweighted] [decimal](18, 15) NULL,
	[totalNonCriticalScoreUnweighted] [decimal](18, 15) NULL,
	[maxTotalNonCriticalScoreUnweighted] [decimal](18, 15) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_ConversationEvaluationsQuestionsGroupScores] PRIMARY KEY CLUSTERED 
(
	[evaluationId] ASC,
	[questionGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_ConversationEvaluationsQuestionsScores]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_ConversationEvaluationsQuestionsScores](
	[evaluationId] [uniqueidentifier] NOT NULL,
	[questionGroupId] [uniqueidentifier] NOT NULL,
	[questionId] [uniqueidentifier] NOT NULL,
	[answerId] [uniqueidentifier] NULL,
	[score] [int] NULL,
	[markedNA] [bit] NULL,
	[failedKillQuestion] [bit] NULL,
	[comments] [varchar](512) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_ConversationEvaluationsQuestionsScores] PRIMARY KEY CLUSTERED 
(
	[evaluationId] ASC,
	[questionGroupId] ASC,
	[questionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_ConversationQueueAggregateMetrics]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_ConversationQueueAggregateMetrics](
	[clientId] [varchar](64) NOT NULL,
	[organizationId] [varchar](64) NOT NULL,
	[divisionId] [varchar](64) NOT NULL,
	[queueId] [varchar](64) NOT NULL,
	[mediaType] [varchar](32) NOT NULL,
	[originatingDirectionId] [int] NOT NULL,
	[startTime] [datetime] NOT NULL,
	[endTime] [datetime] NULL,
	[startHourId] [varchar](6) NOT NULL,
	[startTimeId] [int] NOT NULL,
	[metric] [varchar](128) NOT NULL,
	[count] [bigint] NULL,
	[sum] [bigint] NULL,
	[min] [bigint] NULL,
	[max] [bigint] NULL,
	[ratio] [decimal](18, 15) NULL,
	[numerator] [bigint] NULL,
	[denominator] [bigint] NULL,
	[target] [decimal](18, 15) NULL,
	[timestamp] [bigint] NULL,
	[metricType] [varchar](10) NOT NULL,
	[current] [decimal](18, 15) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_ConversationQueueAggregateMetrics] PRIMARY KEY CLUSTERED 
(
	[clientId] ASC,
	[organizationId] ASC,
	[divisionId] ASC,
	[queueId] ASC,
	[mediaType] ASC,
	[originatingDirectionId] ASC,
	[startTime] ASC,
	[metric] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PSCH_Dia_Dim_ConversationQueueAggregateMetrics]([startTime])
) ON [PSCH_Dia_Dim_ConversationQueueAggregateMetrics]([startTime])
GO
/****** Object:  Table [dbo].[Dim_ConversationUserAggregateMetrics]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_ConversationUserAggregateMetrics](
	[clientId] [varchar](64) NOT NULL,
	[organizationId] [varchar](64) NOT NULL,
	[divisionId] [varchar](64) NOT NULL,
	[userId] [varchar](64) NOT NULL,
	[mediaType] [varchar](32) NOT NULL,
	[originatingDirectionId] [int] NOT NULL,
	[startTime] [datetime] NOT NULL,
	[endTime] [datetime] NULL,
	[startHourId] [varchar](6) NOT NULL,
	[startTimeId] [int] NOT NULL,
	[metric] [varchar](128) NOT NULL,
	[count] [bigint] NULL,
	[sum] [bigint] NULL,
	[min] [bigint] NULL,
	[max] [bigint] NULL,
	[ratio] [decimal](18, 15) NULL,
	[numerator] [bigint] NULL,
	[denominator] [bigint] NULL,
	[target] [decimal](18, 15) NULL,
	[timestamp] [bigint] NULL,
	[metricType] [varchar](10) NOT NULL,
	[current] [decimal](18, 15) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_ConversationUserAggregateMetrics] PRIMARY KEY CLUSTERED 
(
	[clientId] ASC,
	[organizationId] ASC,
	[divisionId] ASC,
	[userId] ASC,
	[mediaType] ASC,
	[originatingDirectionId] ASC,
	[startTime] ASC,
	[metric] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PSCH_Dia_Dim_ConversationUserAggregateMetrics]([startTime])
) ON [PSCH_Dia_Dim_ConversationUserAggregateMetrics]([startTime])
GO
/****** Object:  Table [dbo].[Dim_ConversationWrapUpCodeAggregateMetrics]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_ConversationWrapUpCodeAggregateMetrics](
	[clientId] [varchar](64) NOT NULL,
	[organizationId] [varchar](64) NOT NULL,
	[divisionId] [varchar](64) NOT NULL,
	[queueId] [varchar](64) NOT NULL,
	[wrapUpCode] [varchar](64) NOT NULL,
	[mediaType] [varchar](32) NOT NULL,
	[originatingDirectionId] [int] NOT NULL,
	[startTime] [datetime] NOT NULL,
	[endTime] [datetime] NULL,
	[startHourId] [varchar](6) NOT NULL,
	[startTimeId] [int] NOT NULL,
	[metric] [varchar](128) NOT NULL,
	[count] [bigint] NULL,
	[sum] [bigint] NULL,
	[min] [bigint] NULL,
	[max] [bigint] NULL,
	[ratio] [decimal](18, 15) NULL,
	[numerator] [bigint] NULL,
	[denominator] [bigint] NULL,
	[target] [decimal](18, 15) NULL,
	[metricType] [varchar](10) NOT NULL,
	[current] [decimal](18, 15) NULL,
	[timestamp] [bigint] NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_ConversationWrapUpCodeAggregateMetrics] PRIMARY KEY CLUSTERED 
(
	[clientId] ASC,
	[organizationId] ASC,
	[divisionId] ASC,
	[queueId] ASC,
	[wrapUpCode] ASC,
	[originatingDirectionId] ASC,
	[mediaType] ASC,
	[metric] ASC,
	[startTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PSCH_Dia_Dim_ConversationWrapUpCodeAggregateMetrics]([startTime])
) ON [PSCH_Dia_Dim_ConversationWrapUpCodeAggregateMetrics]([startTime])
GO
/****** Object:  Table [dbo].[Dim_DataParticipant]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_DataParticipant](
	[participantId] [uniqueidentifier] NOT NULL,
	[attributeName] [varchar](250) NOT NULL,
	[attributeValue] [varchar](250) NOT NULL,
	[conversationId] [uniqueidentifier] NOT NULL,
	[conversationStart] [datetime] NOT NULL,
	[startTime] [datetime] NULL,
	[endTime] [datetime] NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [XPK_Dim_DataParticipant] PRIMARY KEY CLUSTERED 
(
	[participantId] ASC,
	[attributeName] ASC,
	[conversationStart] ASC,
	[conversationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PSCH_Dia_Dim_DataParticipant]([conversationStart])
) ON [PSCH_Dia_Dim_DataParticipant]([conversationStart])
GO
/****** Object:  Table [dbo].[Dim_Department]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Department](
	[departmentId] [int] NOT NULL,
	[departmentName] [varchar](250) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [XPKDim_Department] PRIMARY KEY CLUSTERED 
(
	[departmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_DisconnectType]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_DisconnectType](
	[disconnectTypeId] [int] NOT NULL,
	[disconnectTypeDsc] [char](32) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [XPKDim_DisconnectType] PRIMARY KEY CLUSTERED 
(
	[disconnectTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Division]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Division](
	[divisionId] [uniqueidentifier] NOT NULL,
	[divisionName] [varchar](250) NULL,
	[organizationId] [uniqueidentifier] NOT NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_Division] PRIMARY KEY CLUSTERED 
(
	[divisionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Edge]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Edge](
	[edgeId] [uniqueidentifier] NOT NULL,
	[edgeName] [varchar](250) NULL,
	[organizationId] [uniqueidentifier] NOT NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_Edge] PRIMARY KEY CLUSTERED 
(
	[edgeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_EvaluationForm]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_EvaluationForm](
	[formId] [uniqueidentifier] NOT NULL,
	[organizationId] [uniqueidentifier] NOT NULL,
	[name] [varchar](128) NOT NULL,
	[modifiedDate] [datetime] NULL,
	[published] [bit] NOT NULL,
	[contextId] [uniqueidentifier] NOT NULL,
	[weightMode] [varchar](64) NOT NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_EvaluationForm] PRIMARY KEY CLUSTERED 
(
	[formId] ASC,
	[organizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_EvaluationQuestion]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_EvaluationQuestion](
	[questionGroupId] [uniqueidentifier] NOT NULL,
	[questionId] [uniqueidentifier] NOT NULL,
	[text] [varchar](128) NOT NULL,
	[helpText] [varchar](128) NULL,
	[type] [varchar](64) NOT NULL,
	[naEnabled] [bit] NOT NULL,
	[commentsRequired] [bit] NOT NULL,
	[isCritical] [bit] NOT NULL,
	[isKill] [bit] NOT NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_EvaluationQuestion] PRIMARY KEY CLUSTERED 
(
	[questionGroupId] ASC,
	[questionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_EvaluationQuestionGroups]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_EvaluationQuestionGroups](
	[formId] [uniqueidentifier] NOT NULL,
	[questionGroupId] [uniqueidentifier] NOT NULL,
	[name] [varchar](128) NOT NULL,
	[type] [varchar](64) NOT NULL,
	[defaultAnswersToHighest] [bit] NOT NULL,
	[defaultAnswersToNA] [bit] NOT NULL,
	[naEnabled] [bit] NOT NULL,
	[weight] [decimal](18, 15) NOT NULL,
	[manualWeight] [bit] NOT NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_EvaluationQuestionGroups] PRIMARY KEY CLUSTERED 
(
	[formId] ASC,
	[questionGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_EvaluationQuestionOptions]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_EvaluationQuestionOptions](
	[questionGroupId] [uniqueidentifier] NOT NULL,
	[questionId] [uniqueidentifier] NOT NULL,
	[optionId] [uniqueidentifier] NOT NULL,
	[text] [varchar](128) NOT NULL,
	[value] [int] NOT NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_EvaluationQuestionOptions] PRIMARY KEY CLUSTERED 
(
	[questionGroupId] ASC,
	[questionId] ASC,
	[optionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Flow]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Flow](
	[flowId] [uniqueidentifier] NOT NULL,
	[flowName] [varchar](200) NULL,
	[divisionId] [uniqueidentifier] NOT NULL,
	[flowType] [varchar](100) NULL,
	[publishedVersionId] [varchar](10) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_Flow] PRIMARY KEY CLUSTERED 
(
	[flowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_FlowAggregateMetrics]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_FlowAggregateMetrics](
	[clientId] [varchar](64) NOT NULL,
	[organizationId] [varchar](64) NOT NULL,
	[divisionId] [varchar](64) NOT NULL,
	[flowId] [varchar](64) NOT NULL,
	[startTime] [datetime] NOT NULL,
	[endTime] [datetime] NOT NULL,
	[startHourId] [varchar](6) NOT NULL,
	[startTimeId] [int] NOT NULL,
	[mediaType] [varchar](32) NOT NULL,
	[originatingDirectionId] [int] NOT NULL,
	[entryType] [varchar](100) NOT NULL,
	[entryReason] [varchar](100) NOT NULL,
	[exitReason] [varchar](100) NOT NULL,
	[transferType] [varchar](100) NOT NULL,
	[transferTargetAddress] [varchar](100) NOT NULL,
	[metric] [varchar](100) NOT NULL,
	[count] [bigint] NULL,
	[sum] [bigint] NULL,
	[min] [bigint] NULL,
	[max] [bigint] NULL,
	[ratio] [decimal](18, 15) NULL,
	[numerator] [bigint] NULL,
	[denominator] [bigint] NULL,
	[target] [decimal](18, 15) NULL,
	[metricType] [varchar](10) NOT NULL,
	[current] [decimal](18, 15) NULL,
	[timestamp] [bigint] NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_FlowAggregateMetrics] PRIMARY KEY CLUSTERED 
(
	[clientId] ASC,
	[organizationId] ASC,
	[divisionId] ASC,
	[flowId] ASC,
	[mediaType] ASC,
	[originatingDirectionId] ASC,
	[entryType] ASC,
	[entryReason] ASC,
	[exitReason] ASC,
	[transferType] ASC,
	[transferTargetAddress] ASC,
	[startTime] ASC,
	[metric] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PSCH_Dia_Dim_FlowAggregateMetrics]([startTime])
) ON [PSCH_Dia_Dim_FlowAggregateMetrics]([startTime])
GO
/****** Object:  Table [dbo].[Dim_FlowOutcome]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_FlowOutcome](
	[flowOutcomeId] [uniqueidentifier] NOT NULL,
	[flowOutcomeName] [varchar](200) NULL,
	[divisionId] [uniqueidentifier] NOT NULL,
	[actionName] [varchar](20) NULL,
	[actionStatus] [varchar](20) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_FlowOutcome] PRIMARY KEY CLUSTERED 
(
	[flowOutcomeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Hour]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Hour](
	[hourId] [varchar](6) NOT NULL,
	[shortHourId] [int] NULL,
	[shortMinuteId] [int] NULL,
	[shortSecondId] [int] NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [XPKDim_Hour] PRIMARY KEY CLUSTERED 
(
	[hourId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_MediaType]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_MediaType](
	[mediaTypeId] [int] NOT NULL,
	[mediaTypeName] [varchar](250) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [XPKDim_MediaType] PRIMARY KEY CLUSTERED 
(
	[mediaTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Organization]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Organization](
	[organizationId] [uniqueidentifier] NOT NULL,
	[name_g] [varchar](200) NULL,
	[defaultLanguage] [varchar](10) NULL,
	[defaultCountryCode] [varchar](10) NULL,
	[thirdPartyOrgName] [varchar](100) NULL,
	[domain_g] [varchar](100) NULL,
	[thirdPartyOrgId] [varchar](50) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [XPKDim_Organization] PRIMARY KEY CLUSTERED 
(
	[organizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_OriginatingDirection]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_OriginatingDirection](
	[originatingDirectionId] [int] NOT NULL,
	[originatingDirectionDsc] [varchar](50) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [XPKDim_OriginatingDirection] PRIMARY KEY CLUSTERED 
(
	[originatingDirectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Participant]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Participant](
	[participantId] [uniqueidentifier] NOT NULL,
	[participantName] [varchar](300) NULL,
	[externalContactId] [varchar](50) NULL,
	[externalOrganizationId] [varchar](50) NULL,
	[userId] [uniqueidentifier] NULL,
	[purposeId] [int] NOT NULL,
	[departmentId] [int] NULL,
	[conversationId] [uniqueidentifier] NOT NULL,
	[divisionUserId] [uniqueidentifier] NULL,
	[conversationStart] [datetime] NOT NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_Participant] PRIMARY KEY CLUSTERED 
(
	[participantId] ASC,
	[conversationId] ASC,
	[conversationStart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PSCH_Dia_Dim_Participant]([conversationStart])
) ON [PSCH_Dia_Dim_Participant]([conversationStart])
GO
/****** Object:  Table [dbo].[Dim_PresenceStatus]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_PresenceStatus](
	[presenceStatusDefinitionId] [uniqueidentifier] NOT NULL,
	[typePresenceStatusId] [int] NOT NULL,
	[presenceStatusDefinitionDsc] [varchar](50) NULL,
	[primary_g] [bit] NULL,
	[systemPresence] [varchar](50) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [XPKDim_PresenceStatus] PRIMARY KEY CLUSTERED 
(
	[typePresenceStatusId] ASC,
	[presenceStatusDefinitionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Purpose]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Purpose](
	[purposeId] [int] NOT NULL,
	[purposeName] [varchar](100) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [XPKDim_Purpose] PRIMARY KEY CLUSTERED 
(
	[purposeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Queue]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Queue](
	[queueId] [uniqueidentifier] NOT NULL,
	[queueName] [varchar](250) NULL,
	[divisionId] [uniqueidentifier] NOT NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_Queue] PRIMARY KEY CLUSTERED 
(
	[queueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_QueuesToValidate3level]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_QueuesToValidate3level](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[queueName] [varchar](300) NULL,
 CONSTRAINT [PK__Dim_Queu__3213E83F4F7A4349] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_QueueUser]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_QueueUser](
	[id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[queueId] [uniqueidentifier] NULL,
	[queueName] [varchar](250) NULL,
	[userId] [uniqueidentifier] NULL,
	[userName] [varchar](500) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_QueueUser] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Seg_requestedRoutingSkillIds]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Seg_requestedRoutingSkillIds](
	[sessionId] [uniqueidentifier] NOT NULL,
	[skillId] [uniqueidentifier] NOT NULL,
	[segmentTypeId] [int] NOT NULL,
	[disconnectTypeId] [int] NOT NULL,
	[segmentStart] [datetime] NOT NULL,
	[participantId] [uniqueidentifier] NOT NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_Seg_requestedRoutingSkillIds] PRIMARY KEY CLUSTERED 
(
	[sessionId] ASC,
	[skillId] ASC,
	[segmentTypeId] ASC,
	[disconnectTypeId] ASC,
	[segmentStart] ASC,
	[participantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PSCH_Dia_Dim_Seg_requestedRoutingSkillIds]([segmentStart])
) ON [PSCH_Dia_Dim_Seg_requestedRoutingSkillIds]([segmentStart])
GO
/****** Object:  Table [dbo].[Dim_Segment]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Segment](
	[segmentStart] [datetime] NOT NULL,
	[segmentEnd] [datetime] NULL,
	[wrapUpNote] [varchar](300) NULL,
	[queueId] [uniqueidentifier] NULL,
	[audioMuted] [bit] NULL,
	[conference] [bit] NULL,
	[destinationConversationId] [uniqueidentifier] NULL,
	[destinationSessionId] [uniqueidentifier] NULL,
	[errorCode] [varchar](300) NULL,
	[groupId] [uniqueidentifier] NULL,
	[sourceConversationId] [uniqueidentifier] NULL,
	[requestedLanguageId] [uniqueidentifier] NULL,
	[sourceSessionId] [uniqueidentifier] NULL,
	[subject_g] [varchar](200) NULL,
	[videoMuted] [bit] NULL,
	[sessionId] [uniqueidentifier] NOT NULL,
	[segmentOrder] [int] NULL,
	[segmentDuration] [int] NULL,
	[segmentTypeId] [int] NOT NULL,
	[disconnectTypeId] [int] NOT NULL,
	[wrapUpId] [varchar](200) NULL,
	[participantId] [uniqueidentifier] NOT NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_Segment] PRIMARY KEY CLUSTERED 
(
	[sessionId] ASC,
	[segmentTypeId] ASC,
	[disconnectTypeId] ASC,
	[segmentStart] ASC,
	[participantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PSCH_Dia_Dim_Segment]([segmentStart])
) ON [PSCH_Dia_Dim_Segment]([segmentStart])
GO
/****** Object:  Table [dbo].[Dim_SegmentType]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_SegmentType](
	[segmentTypeId] [int] NOT NULL,
	[segmentTypeDsc] [char](18) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [XPKDim_SegmentType] PRIMARY KEY CLUSTERED 
(
	[segmentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Session]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Session](
	[sessionId] [uniqueidentifier] NOT NULL,
	[acwSkipped] [bit] NULL,
	[addressFrom] [varchar](500) NULL,
	[addressOther] [varchar](500) NULL,
	[addressSelf] [varchar](500) NULL,
	[addressTo] [varchar](500) NULL,
	[agentBullseyeRing] [int] NULL,
	[agentOwned] [bit] NULL,
	[agentRank] [int] NULL,
	[ani] [varchar](200) NULL,
	[assignerId] [uniqueidentifier] NULL,
	[callbackScheduledTime] [datetime] NULL,
	[callbackUserName] [varchar](200) NULL,
	[cobrowseRole] [varchar](200) NULL,
	[cobrowseRoomId] [varchar](200) NULL,
	[deliveryStatus] [varchar](100) NULL,
	[deliveryStatusChangeDate] [datetime] NULL,
	[direction] [varchar](50) NULL,
	[dispositionAnalyzer] [varchar](200) NULL,
	[dispositionName] [varchar](200) NULL,
	[dnis] [varchar](200) NULL,
	[edgeId] [uniqueidentifier] NULL,
	[flowInType] [varchar](200) NULL,
	[flowOutType] [varchar](200) NULL,
	[journeyActionId] [uniqueidentifier] NULL,
	[journeyActionMapId] [uniqueidentifier] NULL,
	[journeyActionMapVersion] [int] NULL,
	[journeyCustomerId] [varchar](50) NULL,
	[journeyCustomerIdType] [varchar](200) NULL,
	[journeyCustomerSessionId] [varchar](200) NULL,
	[journeyCustomerSessionIdType] [varchar](200) NULL,
	[mediaBridgeId] [varchar](200) NULL,
	[mediaCount] [int] NULL,
	[messageType] [varchar](200) NULL,
	[monitoredParticipantId] [uniqueidentifier] NULL,
	[peerId] [uniqueidentifier] NULL,
	[protocolCallId] [varchar](200) NULL,
	[provider_g] [varchar](200) NULL,
	[recording] [bit] NULL,
	[remote_g] [varchar](200) NULL,
	[remoteNameDisplayable] [varchar](200) NULL,
	[routingRing] [int] NULL,
	[screenShareAddressSelf] [varchar](200) NULL,
	[screenShareRoomId] [varchar](200) NULL,
	[roomId] [varchar](200) NULL,
	[scriptId] [uniqueidentifier] NULL,
	[selectedAgentId] [uniqueidentifier] NULL,
	[selectedAgentRank] [int] NULL,
	[sessionDnis] [varchar](200) NULL,
	[sharingScreen] [bit] NULL,
	[skipEnabled] [bit] NULL,
	[timeoutSeconds] [int] NULL,
	[usedRouting] [varchar](200) NULL,
	[videoAddressSelf] [varchar](200) NULL,
	[videoRoomId] [varchar](200) NULL,
	[mediaTypeId] [int] NOT NULL,
	[participantId] [uniqueidentifier] NOT NULL,
	[outboundCampaignId] [uniqueidentifier] NULL,
	[outboundContactListId] [uniqueidentifier] NULL,
	[outboundContactId] [char](40) NULL,
	[agentAssistantId] [uniqueidentifier] NULL,
	[authenticated] [bit] NULL,
	[coachedParticipantId] [uniqueidentifier] NULL,
	[bargedParticipantId] [uniqueidentifier] NULL,
	[bcc_g] [varchar](500) NULL,
	[cc_g] [varchar](500) NULL,
	[requestedRoutings] [varchar](200) NULL,
	[callbackNumber] [varchar](200) NULL,
	[originalSessionId] [uniqueidentifier] NULL,
	[conversationStart] [datetime] NOT NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_Session] PRIMARY KEY CLUSTERED 
(
	[sessionId] ASC,
	[participantId] ASC,
	[conversationStart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PSCH_Dia_Dim_Session]([conversationStart])
) ON [PSCH_Dia_Dim_Session]([conversationStart])
GO
/****** Object:  Table [dbo].[Dim_SessionFlow]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_SessionFlow](
	[flowId] [uniqueidentifier] NOT NULL,
	[endingLanguage] [varchar](100) NULL,
	[entryReason] [varchar](100) NULL,
	[entryType] [varchar](100) NULL,
	[exitReason] [varchar](100) NULL,
	[flowVersion] [varchar](50) NULL,
	[issuedCallback] [bit] NULL,
	[startingLanguage] [varchar](100) NULL,
	[transferTargetAddress] [varchar](100) NULL,
	[transferTargetName] [varchar](100) NULL,
	[transferType] [varchar](100) NULL,
	[sessionId] [uniqueidentifier] NOT NULL,
	[participantId] [uniqueidentifier] NOT NULL,
	[conversationStart] [datetime] NOT NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_SessionFlow_1] PRIMARY KEY CLUSTERED 
(
	[flowId] ASC,
	[sessionId] ASC,
	[participantId] ASC,
	[conversationStart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PSCH_Dia_Dim_SessionFlow]([conversationStart])
) ON [PSCH_Dia_Dim_SessionFlow]([conversationStart])
GO
/****** Object:  Table [dbo].[Dim_SessionFlowOutcomes]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_SessionFlowOutcomes](
	[flowOutcomeEndTimestamp] [datetime] NULL,
	[flowOutcomeId] [uniqueidentifier] NOT NULL,
	[flowOutcomeStartTimestamp] [datetime] NOT NULL,
	[flowOutcomeValue] [varchar](200) NULL,
	[sessionId] [uniqueidentifier] NOT NULL,
	[flowId] [uniqueidentifier] NOT NULL,
	[participantId] [uniqueidentifier] NOT NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_SessionFlowOutcomes] PRIMARY KEY CLUSTERED 
(
	[flowOutcomeId] ASC,
	[sessionId] ASC,
	[flowId] ASC,
	[participantId] ASC,
	[flowOutcomeStartTimestamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PSCH_Dia_Dim_SessionFlowOutcomes]([flowOutcomeStartTimestamp])
) ON [PSCH_Dia_Dim_SessionFlowOutcomes]([flowOutcomeStartTimestamp])
GO
/****** Object:  Table [dbo].[Dim_SessionMetrics]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_SessionMetrics](
	[emitDate] [datetime] NOT NULL,
	[name_g] [varchar](200) NOT NULL,
	[value_g] [int] NULL,
	[sessionId] [uniqueidentifier] NOT NULL,
	[participantId] [uniqueidentifier] NOT NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_DimSessionMetrics] PRIMARY KEY CLUSTERED 
(
	[name_g] ASC,
	[sessionId] ASC,
	[emitDate] ASC,
	[participantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PSCH_Dia_Dim_SessionMetrics]([emitDate])
) ON [PSCH_Dia_Dim_SessionMetrics]([emitDate])
GO
/****** Object:  Table [dbo].[Dim_Skill]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Skill](
	[skillId] [uniqueidentifier] NOT NULL,
	[skillDsc] [varchar](250) NULL,
	[organizationId] [uniqueidentifier] NOT NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_Skill] PRIMARY KEY CLUSTERED 
(
	[skillId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Time]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Time](
	[timeId] [int] NOT NULL,
	[timeDt] [datetime] NULL,
	[timeDsc] [varchar](25) NULL,
	[timeAnio] [int] NULL,
	[timeMonth] [int] NULL,
	[timeMonthName] [varchar](20) NULL,
	[timeDay] [int] NULL,
	[timeYearDay] [int] NULL,
	[timeSemester] [int] NULL,
	[timeTrimester] [int] NULL,
	[timeBimester] [int] NULL,
	[timeWeek] [int] NULL,
	[timeWeekDay] [int] NULL,
	[timeTrimesterDsc] [varchar](10) NULL,
	[timeMonthNameShort] [varchar](10) NULL,
	[timeWeekDayDsc] [varchar](10) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [XPKDim_Time] PRIMARY KEY CLUSTERED 
(
	[timeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Traduction_Atributo_by_Campania]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Traduction_Atributo_by_Campania](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[key] [varchar](250) NOT NULL,
	[etiquetaAtributo] [varchar](250) NULL,
 CONSTRAINT [PK__Dim_Trad__3213E83F200CC932] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Traduction_Canal]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Traduction_Canal](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[key] [varchar](250) NOT NULL,
	[canal] [varchar](250) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK__Dim_Trad__3213E83F08AEE1BA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Traduction_Externos]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Traduction_Externos](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[key] [varchar](250) NOT NULL,
	[externalName] [varchar](250) NULL,
 CONSTRAINT [PK__Dim_Trad__3213E83FDB8BEE76] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Traduction_IVR_Campaign]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Traduction_IVR_Campaign](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ivr] [varchar](100) NULL,
	[campania] [varchar](100) NULL,
 CONSTRAINT [PK__Dim_Trad__3213E83F832C41C0] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Traduction_IVRs]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Traduction_IVRs](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[key] [varchar](250) NOT NULL,
	[ivrName] [varchar](250) NULL,
 CONSTRAINT [PK__Dim_Trad__3213E83F8CB38FFA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Traduction_Queues]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Traduction_Queues](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[key] [varchar](250) NOT NULL,
	[queueName] [varchar](250) NULL,
 CONSTRAINT [PK__Dim_Trad__3213E83F1AA1F7F2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Traduction_Report_IVR_Options]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Traduction_Report_IVR_Options](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[key] [varchar](350) NOT NULL,
	[ivrType] [varchar](250) NOT NULL,
	[flowIvr] [varchar](250) NOT NULL,
	[campania] [varchar](100) NOT NULL,
	[optionIvr] [varchar](50) NOT NULL,
	[description] [varchar](500) NULL,
	[flag] [varchar](250) NULL,
	[selfManage] [bit] NULL,
 CONSTRAINT [PK__Dim_Trad__3213E83F8040FD32] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Trunk]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Trunk](
	[trunkId] [uniqueidentifier] NOT NULL,
	[trunkName] [varchar](250) NULL,
	[trunkType] [varchar](250) NULL,
	[organizationId] [uniqueidentifier] NOT NULL,
	[edgeId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Dim_Trunk] PRIMARY KEY CLUSTERED 
(
	[trunkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_TypePresenceStatus]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_TypePresenceStatus](
	[typePresenceStatusId] [int] NOT NULL,
	[typePresenceStatusDsc] [varchar](20) NULL,
 CONSTRAINT [XPKDim_TypePresenceStatus] PRIMARY KEY CLUSTERED 
(
	[typePresenceStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_User]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_User](
	[userId] [uniqueidentifier] NOT NULL,
	[userName] [varchar](500) NULL,
	[userEmail] [varchar](250) NULL,
	[userJabberId] [varchar](250) NULL,
	[departmentId] [int] NOT NULL,
	[state] [varchar](50) NULL,
	[title] [varchar](200) NULL,
	[divisionId] [uniqueidentifier] NOT NULL,
	[managerId] [uniqueidentifier] NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_User] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_UserAggregateMetrics]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_UserAggregateMetrics](
	[clientId] [varchar](64) NOT NULL,
	[organizationId] [varchar](64) NOT NULL,
	[divisionId] [varchar](64) NOT NULL,
	[userId] [varchar](64) NOT NULL,
	[startTime] [datetime] NOT NULL,
	[endTime] [datetime] NULL,
	[startHourId] [varchar](6) NOT NULL,
	[startTimeId] [int] NOT NULL,
	[metric] [varchar](128) NOT NULL,
	[qualifier] [varchar](64) NOT NULL,
	[sum] [bigint] NULL,
	[count] [bigint] NULL,
	[min] [bigint] NULL,
	[max] [bigint] NULL,
	[metricType] [varchar](10) NOT NULL,
	[presenceStatusDefinitionId] [varchar](64) NOT NULL,
	[timestamp] [bigint] NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_UserAggregateMetrics] PRIMARY KEY CLUSTERED 
(
	[clientId] ASC,
	[organizationId] ASC,
	[divisionId] ASC,
	[userId] ASC,
	[presenceStatusDefinitionId] ASC,
	[metric] ASC,
	[qualifier] ASC,
	[startTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PSCH_Dia_Dim_UserAggregateMetrics]([startTime])
) ON [PSCH_Dia_Dim_UserAggregateMetrics]([startTime])
GO
/****** Object:  Table [dbo].[Dim_UserStatusDetails]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_UserStatusDetails](
	[clientId] [varchar](64) NOT NULL,
	[organizationId] [uniqueidentifier] NOT NULL,
	[divisionId] [uniqueidentifier] NOT NULL,
	[userId] [uniqueidentifier] NOT NULL,
	[presenceStatusDefinitionId] [uniqueidentifier] NOT NULL,
	[typePresenceStatusId] [int] NOT NULL,
	[systemPresence] [varchar](128) NOT NULL,
	[routingStatus] [varchar](64) NOT NULL,
	[startTime] [datetime] NOT NULL,
	[endTime] [datetime] NULL,
	[startHourId] [varchar](6) NOT NULL,
	[startTimeId] [int] NOT NULL,
	[timestamp] [datetime] NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Dim_UserStatusDetails] PRIMARY KEY CLUSTERED 
(
	[clientId] ASC,
	[organizationId] ASC,
	[divisionId] ASC,
	[userId] ASC,
	[presenceStatusDefinitionId] ASC,
	[typePresenceStatusId] ASC,
	[systemPresence] ASC,
	[routingStatus] ASC,
	[startTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PSCH_Dia_Dim_UserStatusDetails]([startTime])
) ON [PSCH_Dia_Dim_UserStatusDetails]([startTime])
GO
/****** Object:  Table [dbo].[Dim_WrapUp]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_WrapUp](
	[wrapUpId] [varchar](200) NOT NULL,
	[wrapUpDsc] [varchar](250) NOT NULL,
	[organizationId] [uniqueidentifier] NOT NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [XPKDim_WrapUp] PRIMARY KEY CLUSTERED 
(
	[wrapUpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorLog](
	[ErrorID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ErrorMessage] [nvarchar](4000) NULL,
	[ErrorSeverity] [int] NULL,
	[ErrorState] [int] NULL,
	[ErrorTime] [datetime] NULL,
 CONSTRAINT [PK__ErrorLog__358565CA877760B9] PRIMARY KEY CLUSTERED 
(
	[ErrorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[reprocess_conversation]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reprocess_conversation](
	[conversationId] [uniqueidentifier] NOT NULL,
	[conversationDate] [int] NULL,
	[type] [varchar](32) NOT NULL,
 CONSTRAINT [PK_reprocess_conversation] PRIMARY KEY CLUSTERED 
(
	[conversationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tb_Campaign_Info]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tb_Campaign_Info](
	[campaignId] [uniqueidentifier] NOT NULL,
	[timeId] [int] NOT NULL,
	[hourId] [varchar](6) NOT NULL,
	[campaignName] [varchar](250) NULL,
	[dialingMode] [varchar](250) NULL,
	[contactListId] [uniqueidentifier] NULL,
	[contactListName] [varchar](250) NULL,
	[queueId] [uniqueidentifier] NULL,
	[queueName] [varchar](250) NULL,
	[campaignStatus] [varchar](250) NULL,
	[callerAddress] [varchar](250) NULL,
	[outboundLineCount] [numeric](22, 6) NULL,
	[skipPreviewDisabled] [bit] NULL,
	[priority] [numeric](22, 6) NULL,
	[noAnswerTimeout] [numeric](22, 6) NULL,
	[previewTimeOutSeconds] [numeric](22, 6) NULL,
	[alwaysRunning] [bit] NULL,
	[numberOfContactsCalled] [numeric](22, 6) NULL,
	[totalNumberOfContacts] [numeric](22, 6) NULL,
	[percentage] [numeric](22, 6) NULL,
	[contactRate_attempts] [numeric](22, 6) NULL,
	[contactRate_connects] [numeric](22, 6) NULL,
	[contactRate_connectRatio] [numeric](22, 6) NULL,
	[idleAgents] [numeric](22, 6) NULL,
	[effectiveIdleAgents] [numeric](22, 6) NULL,
	[adjustedCallsPerAgent] [numeric](22, 6) NULL,
	[outstandingCalls] [numeric](22, 6) NULL,
	[scheduledCalls] [numeric](22, 6) NULL,
	[timeZoneRescheduledCalls] [numeric](22, 6) NULL,
	[FechaInsercion] [datetime] NULL,
 CONSTRAINT [PK_Tb_Campaign_Info] PRIMARY KEY CLUSTERED 
(
	[campaignId] ASC,
	[timeId] ASC,
	[hourId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tb_Edge_Metrics]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tb_Edge_Metrics](
	[edgeId] [uniqueidentifier] NOT NULL,
	[timeId] [int] NOT NULL,
	[hourId] [varchar](6) NOT NULL,
	[name] [varchar](250) NOT NULL,
	[value] [numeric](22, 6) NULL,
 CONSTRAINT [PK_Tb_Edge_Metrics] PRIMARY KEY CLUSTERED 
(
	[edgeId] ASC,
	[timeId] ASC,
	[hourId] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TB_Estado_Validaciones_Tablas_Intermedias]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TB_Estado_Validaciones_Tablas_Intermedias](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fechaInicio] [datetime] NULL,
	[fechaFinal] [datetime] NULL,
	[fechaEjecucion] [datetime] NULL,
	[proceso] [varchar](100) NULL,
	[paso_proceso] [varchar](100) NULL,
	[faltantes_Tx] [int] NULL,
	[faltantes_NConsultado] [int] NULL,
	[p1] [int] NULL,
	[p2] [int] NULL,
	[p3] [int] NULL,
 CONSTRAINT [PK__TB_Estad__3213E83FE769D091] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tb_Inbound_Agents_By_Queue]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tb_Inbound_Agents_By_Queue](
	[queueId] [uniqueidentifier] NOT NULL,
	[timeId] [int] NOT NULL,
	[hourId] [varchar](6) NOT NULL,
	[metric_g] [varchar](250) NOT NULL,
	[stats_g] [numeric](22, 6) NULL,
	[qualifier_g] [varchar](250) NOT NULL,
	[mediaType] [varchar](250) NULL,
 CONSTRAINT [PK_Tb_Inbound_Agents_By_Queue] PRIMARY KEY CLUSTERED 
(
	[queueId] ASC,
	[timeId] ASC,
	[hourId] ASC,
	[metric_g] ASC,
	[qualifier_g] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tb_QueueMembers]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tb_QueueMembers](
	[queueId] [uniqueidentifier] NOT NULL,
	[userId] [uniqueidentifier] NOT NULL,
	[hourId] [varchar](6) NOT NULL,
	[timeId] [int] NOT NULL,
 CONSTRAINT [PK_Tb_QueueMembers] PRIMARY KEY CLUSTERED 
(
	[queueId] ASC,
	[userId] ASC,
	[timeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tb_Trunk_Metrics]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tb_Trunk_Metrics](
	[trunkId] [uniqueidentifier] NOT NULL,
	[timeId] [int] NOT NULL,
	[hourId] [varchar](6) NOT NULL,
	[name] [varchar](250) NOT NULL,
	[value] [numeric](22, 6) NULL,
	[edgeId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Tb_Trunk_Metrics] PRIMARY KEY CLUSTERED 
(
	[trunkId] ASC,
	[timeId] ASC,
	[hourId] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tb_User_Status_By_Queue]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tb_User_Status_By_Queue](
	[queueId] [uniqueidentifier] NOT NULL,
	[agentId] [uniqueidentifier] NOT NULL,
	[timeId] [int] NOT NULL,
	[hourId] [varchar](6) NOT NULL,
	[presenceStatusDefinitionId] [uniqueidentifier] NOT NULL,
	[typePresenceStatusId] [int] NOT NULL,
	[presence_definition_modification_date] [datetime] NULL,
	[outofoffice_active] [bit] NULL,
	[routing_status_start_time] [datetime] NULL,
 CONSTRAINT [PK_Tb_User_Status_By_Queue] PRIMARY KEY CLUSTERED 
(
	[queueId] ASC,
	[agentId] ASC,
	[timeId] ASC,
	[hourId] ASC,
	[presenceStatusDefinitionId] ASC,
	[typePresenceStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [NonClusteredIndex-20231115-165208]    Script Date: 12/12/2024 6:41:39 PM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20231115-165208] ON [dbo].[blank_session_dataparticipant]
(
	[type] ASC,
	[processDate] ASC,
	[organizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [NonClusteredIndex-20231102-111117]    Script Date: 12/12/2024 6:41:39 PM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20231102-111117] ON [dbo].[Dim_CampaignQueue]
(
	[bpo] ASC,
	[campania] ASC,
	[tipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [NonClusteredIndex-20240909-212930]    Script Date: 12/12/2024 6:41:39 PM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20240909-212930] ON [dbo].[Dim_CampaignQueue]
(
	[cola] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [NonClusteredIndex-20231102-111252]    Script Date: 12/12/2024 6:41:39 PM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20231102-111252] ON [dbo].[Dim_Traduction_Atributo_by_Campania]
(
	[key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [NonClusteredIndex-20231102-111229]    Script Date: 12/12/2024 6:41:39 PM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20231102-111229] ON [dbo].[Dim_Traduction_Canal]
(
	[key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [NonClusteredIndex-20231102-111309]    Script Date: 12/12/2024 6:41:39 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20231102-111309] ON [dbo].[Dim_Traduction_Externos]
(
	[key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [NonClusteredIndex-20231102-111340]    Script Date: 12/12/2024 6:41:39 PM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20231102-111340] ON [dbo].[Dim_Traduction_IVRs]
(
	[key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [NonClusteredIndex-20231102-111358]    Script Date: 12/12/2024 6:41:39 PM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20231102-111358] ON [dbo].[Dim_Traduction_Queues]
(
	[key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [NonClusteredIndex-20231109-164600]    Script Date: 12/12/2024 6:41:39 PM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20231109-164600] ON [dbo].[Dim_Traduction_Report_IVR_Options]
(
	[key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_Dim_User_I]    Script Date: 12/12/2024 6:41:39 PM ******/
CREATE NONCLUSTERED INDEX [IDX_Dim_User_I] ON [dbo].[Dim_User]
(
	[divisionId] ASC
)
INCLUDE([userName],[userEmail],[userJabberId],[departmentId],[state],[title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_Tb_Campaign_Info_I]    Script Date: 12/12/2024 6:41:39 PM ******/
CREATE NONCLUSTERED INDEX [IDX_Tb_Campaign_Info_I] ON [dbo].[Tb_Campaign_Info]
(
	[timeId] ASC,
	[campaignStatus] ASC
)
INCLUDE([queueId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IDX_Tb_Campaign_Info_II]    Script Date: 12/12/2024 6:41:39 PM ******/
CREATE NONCLUSTERED INDEX [IDX_Tb_Campaign_Info_II] ON [dbo].[Tb_Campaign_Info]
(
	[timeId] ASC,
	[hourId] ASC
)
INCLUDE([campaignName],[dialingMode],[queueName],[campaignStatus]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_Tb_Campaign_Info_QueueId]    Script Date: 12/12/2024 6:41:39 PM ******/
CREATE NONCLUSTERED INDEX [IDX_Tb_Campaign_Info_QueueId] ON [dbo].[Tb_Campaign_Info]
(
	[queueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Control_Insight] ADD  CONSTRAINT [DF__Control_I__Fecha__24E777C3]  DEFAULT (getdate()) FOR [Fecha]
GO
ALTER TABLE [dbo].[Dim_Campaign] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_CampaignQueue] ADD  CONSTRAINT [DF__Dim_Campa__Fecha__47477CBF]  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_ContactList] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_Conversation] ADD  CONSTRAINT [DF__Dim_Conve__Fecha__18F6A22A]  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_ConversationAggregateMetrics] ADD  CONSTRAINT [DF__Dim_Conve__Fecha__1ADEEA9C]  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_ConversationCampaignAggregateMetrics] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_ConversationDayQueueAggregateMetrics] ADD  CONSTRAINT [DF__Dim_Conve__Fecha__1CC7330E]  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_ConversationDivisions] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_ConversationEvaluations] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_ConversationEvaluationsQuestionsGroupScores] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_ConversationEvaluationsQuestionsScores] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_ConversationQueueAggregateMetrics] ADD  CONSTRAINT [DF__Dim_Conve__Fecha__1EAF7B80]  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_ConversationUserAggregateMetrics] ADD  CONSTRAINT [DF__Dim_Conve__Fecha__2097C3F2]  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_ConversationWrapUpCodeAggregateMetrics] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_DataParticipant] ADD  CONSTRAINT [DF__Dim_DataP__Fecha__170E59B8]  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_Department] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_DisconnectType] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_Division] ADD  CONSTRAINT [DF__Dim_Divis__Fecha__4D005615]  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_Edge] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_EvaluationForm] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_EvaluationQuestion] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_EvaluationQuestionGroups] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_EvaluationQuestionOptions] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_Flow] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_FlowAggregateMetrics] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_FlowOutcome] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_Hour] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_MediaType] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_Organization] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_OriginatingDirection] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_Participant] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_PresenceStatus] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_Purpose] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_Queue] ADD  CONSTRAINT [DF__Dim_Queue__Fecha__4B180DA3]  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_QueueUser] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_Seg_requestedRoutingSkillIds] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_Segment] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_SegmentType] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_Session] ADD  CONSTRAINT [DF__Dim_Sessi__Fecha__22800C64]  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_SessionFlow] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_SessionFlowOutcomes] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_SessionMetrics] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_Skill] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_Time] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_Traduction_Canal] ADD  CONSTRAINT [DF__Dim_Tradu__Fecha__05CEBF1D]  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_User] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_UserStatusDetails] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_WrapUp] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[ErrorLog] ADD  CONSTRAINT [DF__ErrorLog__ErrorT__26CFC035]  DEFAULT (getdate()) FOR [ErrorTime]
GO
ALTER TABLE [dbo].[Tb_Campaign_Info] ADD  DEFAULT (getdate()) FOR [FechaInsercion]
GO
ALTER TABLE [dbo].[Dim_Campaign]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_Campaign_Dim_Division] FOREIGN KEY([divisionId])
REFERENCES [dbo].[Dim_Division] ([divisionId])
GO
ALTER TABLE [dbo].[Dim_Campaign] CHECK CONSTRAINT [FK_Dim_Campaign_Dim_Division]
GO
ALTER TABLE [dbo].[Dim_ContactList]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_ContactList_Dim_Division] FOREIGN KEY([divisionId])
REFERENCES [dbo].[Dim_Division] ([divisionId])
GO
ALTER TABLE [dbo].[Dim_ContactList] CHECK CONSTRAINT [FK_Dim_ContactList_Dim_Division]
GO
ALTER TABLE [dbo].[Dim_Conversation]  WITH NOCHECK ADD  CONSTRAINT [R_115] FOREIGN KEY([conversationStartTimeId])
REFERENCES [dbo].[Dim_Time] ([timeId])
GO
ALTER TABLE [dbo].[Dim_Conversation] CHECK CONSTRAINT [R_115]
GO
ALTER TABLE [dbo].[Dim_Conversation]  WITH NOCHECK ADD  CONSTRAINT [R_116] FOREIGN KEY([conversationStartHourId])
REFERENCES [dbo].[Dim_Hour] ([hourId])
GO
ALTER TABLE [dbo].[Dim_Conversation] CHECK CONSTRAINT [R_116]
GO
ALTER TABLE [dbo].[Dim_Conversation]  WITH NOCHECK ADD  CONSTRAINT [R_117] FOREIGN KEY([organizationId])
REFERENCES [dbo].[Dim_Organization] ([organizationId])
GO
ALTER TABLE [dbo].[Dim_Conversation] CHECK CONSTRAINT [R_117]
GO
ALTER TABLE [dbo].[Dim_Conversation]  WITH NOCHECK ADD  CONSTRAINT [R_82] FOREIGN KEY([originatingDirectionId])
REFERENCES [dbo].[Dim_OriginatingDirection] ([originatingDirectionId])
GO
ALTER TABLE [dbo].[Dim_Conversation] CHECK CONSTRAINT [R_82]
GO
ALTER TABLE [dbo].[Dim_ConversationDivisions]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_ConversationDivisions_Dim_Division] FOREIGN KEY([divisionId])
REFERENCES [dbo].[Dim_Division] ([divisionId])
GO
ALTER TABLE [dbo].[Dim_ConversationDivisions] CHECK CONSTRAINT [FK_Dim_ConversationDivisions_Dim_Division]
GO
ALTER TABLE [dbo].[Dim_DataParticipant]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_DataParticipant_Dim_Participant] FOREIGN KEY([participantId], [conversationId], [conversationStart])
REFERENCES [dbo].[Dim_Participant] ([participantId], [conversationId], [conversationStart])
GO
ALTER TABLE [dbo].[Dim_DataParticipant] CHECK CONSTRAINT [FK_Dim_DataParticipant_Dim_Participant]
GO
ALTER TABLE [dbo].[Dim_Division]  WITH NOCHECK ADD  CONSTRAINT [R_65] FOREIGN KEY([organizationId])
REFERENCES [dbo].[Dim_Organization] ([organizationId])
GO
ALTER TABLE [dbo].[Dim_Division] CHECK CONSTRAINT [R_65]
GO
ALTER TABLE [dbo].[Dim_Edge]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_Edge_Org] FOREIGN KEY([organizationId])
REFERENCES [dbo].[Dim_Organization] ([organizationId])
GO
ALTER TABLE [dbo].[Dim_Edge] CHECK CONSTRAINT [FK_Dim_Edge_Org]
GO
ALTER TABLE [dbo].[Dim_Flow]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_Flow_Dim_Division] FOREIGN KEY([divisionId])
REFERENCES [dbo].[Dim_Division] ([divisionId])
GO
ALTER TABLE [dbo].[Dim_Flow] CHECK CONSTRAINT [FK_Dim_Flow_Dim_Division]
GO
ALTER TABLE [dbo].[Dim_FlowOutcome]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_FlowOutcome_Dim_Division] FOREIGN KEY([divisionId])
REFERENCES [dbo].[Dim_Division] ([divisionId])
GO
ALTER TABLE [dbo].[Dim_FlowOutcome] CHECK CONSTRAINT [FK_Dim_FlowOutcome_Dim_Division]
GO
ALTER TABLE [dbo].[Dim_Participant]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_Participant_Dim_Department] FOREIGN KEY([departmentId])
REFERENCES [dbo].[Dim_Department] ([departmentId])
GO
ALTER TABLE [dbo].[Dim_Participant] CHECK CONSTRAINT [FK_Dim_Participant_Dim_Department]
GO
ALTER TABLE [dbo].[Dim_Participant]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_Participant_Dim_Division] FOREIGN KEY([divisionUserId])
REFERENCES [dbo].[Dim_Division] ([divisionId])
GO
ALTER TABLE [dbo].[Dim_Participant] CHECK CONSTRAINT [FK_Dim_Participant_Dim_Division]
GO
ALTER TABLE [dbo].[Dim_Participant]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_Participant_Dim_User] FOREIGN KEY([userId])
REFERENCES [dbo].[Dim_User] ([userId])
GO
ALTER TABLE [dbo].[Dim_Participant] CHECK CONSTRAINT [FK_Dim_Participant_Dim_User]
GO
ALTER TABLE [dbo].[Dim_Participant]  WITH NOCHECK ADD  CONSTRAINT [R_85] FOREIGN KEY([purposeId])
REFERENCES [dbo].[Dim_Purpose] ([purposeId])
GO
ALTER TABLE [dbo].[Dim_Participant] CHECK CONSTRAINT [R_85]
GO
ALTER TABLE [dbo].[Dim_PresenceStatus]  WITH NOCHECK ADD  CONSTRAINT [R_110] FOREIGN KEY([typePresenceStatusId])
REFERENCES [dbo].[Dim_TypePresenceStatus] ([typePresenceStatusId])
GO
ALTER TABLE [dbo].[Dim_PresenceStatus] CHECK CONSTRAINT [R_110]
GO
ALTER TABLE [dbo].[Dim_Queue]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_Queue_Dim_Division] FOREIGN KEY([divisionId])
REFERENCES [dbo].[Dim_Division] ([divisionId])
GO
ALTER TABLE [dbo].[Dim_Queue] CHECK CONSTRAINT [FK_Dim_Queue_Dim_Division]
GO
ALTER TABLE [dbo].[Dim_Seg_requestedRoutingSkillIds]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_Seg_requestedRoutingSkillIds_Dim_Segment] FOREIGN KEY([sessionId], [segmentTypeId], [disconnectTypeId], [segmentStart], [participantId])
REFERENCES [dbo].[Dim_Segment] ([sessionId], [segmentTypeId], [disconnectTypeId], [segmentStart], [participantId])
GO
ALTER TABLE [dbo].[Dim_Seg_requestedRoutingSkillIds] CHECK CONSTRAINT [FK_Dim_Seg_requestedRoutingSkillIds_Dim_Segment]
GO
ALTER TABLE [dbo].[Dim_Seg_requestedRoutingSkillIds]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_Seg_requestedRoutingSkillIds_Dim_Skill] FOREIGN KEY([skillId])
REFERENCES [dbo].[Dim_Skill] ([skillId])
GO
ALTER TABLE [dbo].[Dim_Seg_requestedRoutingSkillIds] CHECK CONSTRAINT [FK_Dim_Seg_requestedRoutingSkillIds_Dim_Skill]
GO
ALTER TABLE [dbo].[Dim_Segment]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_Segment_Dim_Queue] FOREIGN KEY([queueId])
REFERENCES [dbo].[Dim_Queue] ([queueId])
GO
ALTER TABLE [dbo].[Dim_Segment] NOCHECK CONSTRAINT [FK_Dim_Segment_Dim_Queue]
GO
ALTER TABLE [dbo].[Dim_Segment]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_Segment_Dim_WrapUp] FOREIGN KEY([wrapUpId])
REFERENCES [dbo].[Dim_WrapUp] ([wrapUpId])
GO
ALTER TABLE [dbo].[Dim_Segment] NOCHECK CONSTRAINT [FK_Dim_Segment_Dim_WrapUp]
GO
ALTER TABLE [dbo].[Dim_Segment]  WITH NOCHECK ADD  CONSTRAINT [R_100] FOREIGN KEY([segmentTypeId])
REFERENCES [dbo].[Dim_SegmentType] ([segmentTypeId])
GO
ALTER TABLE [dbo].[Dim_Segment] NOCHECK CONSTRAINT [R_100]
GO
ALTER TABLE [dbo].[Dim_Segment]  WITH NOCHECK ADD  CONSTRAINT [R_101] FOREIGN KEY([disconnectTypeId])
REFERENCES [dbo].[Dim_DisconnectType] ([disconnectTypeId])
GO
ALTER TABLE [dbo].[Dim_Segment] NOCHECK CONSTRAINT [R_101]
GO
ALTER TABLE [dbo].[Dim_Session]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_Session_Dim_Campaign] FOREIGN KEY([outboundCampaignId])
REFERENCES [dbo].[Dim_Campaign] ([campaignId])
GO
ALTER TABLE [dbo].[Dim_Session] CHECK CONSTRAINT [FK_Dim_Session_Dim_Campaign]
GO
ALTER TABLE [dbo].[Dim_Session]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_Session_Dim_ContactList] FOREIGN KEY([outboundContactListId])
REFERENCES [dbo].[Dim_ContactList] ([contactListId])
GO
ALTER TABLE [dbo].[Dim_Session] CHECK CONSTRAINT [FK_Dim_Session_Dim_ContactList]
GO
ALTER TABLE [dbo].[Dim_Session]  WITH NOCHECK ADD  CONSTRAINT [R_90] FOREIGN KEY([mediaTypeId])
REFERENCES [dbo].[Dim_MediaType] ([mediaTypeId])
GO
ALTER TABLE [dbo].[Dim_Session] CHECK CONSTRAINT [R_90]
GO
ALTER TABLE [dbo].[Dim_SessionFlow]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_SessionFlow_Dim_Flow] FOREIGN KEY([flowId])
REFERENCES [dbo].[Dim_Flow] ([flowId])
GO
ALTER TABLE [dbo].[Dim_SessionFlow] CHECK CONSTRAINT [FK_Dim_SessionFlow_Dim_Flow]
GO
ALTER TABLE [dbo].[Dim_SessionFlow]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_SessionFlow_Dim_Session] FOREIGN KEY([sessionId], [participantId], [conversationStart])
REFERENCES [dbo].[Dim_Session] ([sessionId], [participantId], [conversationStart])
GO
ALTER TABLE [dbo].[Dim_SessionFlow] CHECK CONSTRAINT [FK_Dim_SessionFlow_Dim_Session]
GO
ALTER TABLE [dbo].[Dim_SessionFlowOutcomes]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_SessionFlowOutcomes_Dim_SessionFlowOutcomes] FOREIGN KEY([flowOutcomeId])
REFERENCES [dbo].[Dim_FlowOutcome] ([flowOutcomeId])
GO
ALTER TABLE [dbo].[Dim_SessionFlowOutcomes] CHECK CONSTRAINT [FK_Dim_SessionFlowOutcomes_Dim_SessionFlowOutcomes]
GO
ALTER TABLE [dbo].[Dim_Skill]  WITH NOCHECK ADD  CONSTRAINT [R_75] FOREIGN KEY([organizationId])
REFERENCES [dbo].[Dim_Organization] ([organizationId])
GO
ALTER TABLE [dbo].[Dim_Skill] CHECK CONSTRAINT [R_75]
GOx
ALTER TABLE [dbo].[Dim_Trunk]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_Trunk_Dim_Edge] FOREIGN KEY([edgeId])
REFERENCES [dbo].[Dim_Edge] ([edgeId])
GO
ALTER TABLE [dbo].[Dim_Trunk] CHECK CONSTRAINT [FK_Dim_Trunk_Dim_Edge]
GO
ALTER TABLE [dbo].[Dim_Trunk]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_Trunk_Org] FOREIGN KEY([organizationId])
REFERENCES [dbo].[Dim_Organization] ([organizationId])
GO
ALTER TABLE [dbo].[Dim_Trunk] CHECK CONSTRAINT [FK_Dim_Trunk_Org]
GO
ALTER TABLE [dbo].[Dim_User]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_User_Dim_Division] FOREIGN KEY([divisionId])
REFERENCES [dbo].[Dim_Division] ([divisionId])
GO
ALTER TABLE [dbo].[Dim_User] CHECK CONSTRAINT [FK_Dim_User_Dim_Division]
GO
ALTER TABLE [dbo].[Dim_User]  WITH NOCHECK ADD  CONSTRAINT [R_87] FOREIGN KEY([departmentId])
REFERENCES [dbo].[Dim_Department] ([departmentId])
GO
ALTER TABLE [dbo].[Dim_User] CHECK CONSTRAINT [R_87]
GO
ALTER TABLE [dbo].[Dim_WrapUp]  WITH NOCHECK ADD  CONSTRAINT [R_70] FOREIGN KEY([organizationId])
REFERENCES [dbo].[Dim_Organization] ([organizationId])
GO
ALTER TABLE [dbo].[Dim_WrapUp] CHECK CONSTRAINT [R_70]
GO
ALTER TABLE [dbo].[Tb_Campaign_Info]  WITH NOCHECK ADD  CONSTRAINT [FK_Tb_Campaign_Info_Dim_Campaign] FOREIGN KEY([campaignId])
REFERENCES [dbo].[Dim_Campaign] ([campaignId])
GO
ALTER TABLE [dbo].[Tb_Campaign_Info] CHECK CONSTRAINT [FK_Tb_Campaign_Info_Dim_Campaign]
GO
ALTER TABLE [dbo].[Tb_Campaign_Info]  WITH NOCHECK ADD  CONSTRAINT [FK_Tb_Campaign_Info_Dim_ContactList] FOREIGN KEY([contactListId])
REFERENCES [dbo].[Dim_ContactList] ([contactListId])
GO
ALTER TABLE [dbo].[Tb_Campaign_Info] CHECK CONSTRAINT [FK_Tb_Campaign_Info_Dim_ContactList]
GO
ALTER TABLE [dbo].[Tb_Campaign_Info]  WITH NOCHECK ADD  CONSTRAINT [FK_Tb_Campaign_Info_Dim_Queue] FOREIGN KEY([queueId])
REFERENCES [dbo].[Dim_Queue] ([queueId])
GO
ALTER TABLE [dbo].[Tb_Campaign_Info] CHECK CONSTRAINT [FK_Tb_Campaign_Info_Dim_Queue]
GO
ALTER TABLE [dbo].[Tb_Edge_Metrics]  WITH NOCHECK ADD  CONSTRAINT [FK_Tb_Edge_Metrics_Dim_Edge] FOREIGN KEY([edgeId])
REFERENCES [dbo].[Dim_Edge] ([edgeId])
GO
ALTER TABLE [dbo].[Tb_Edge_Metrics] CHECK CONSTRAINT [FK_Tb_Edge_Metrics_Dim_Edge]
GO
ALTER TABLE [dbo].[Tb_Edge_Metrics]  WITH NOCHECK ADD  CONSTRAINT [FK_Tb_Edge_Metrics_Dim_Hour] FOREIGN KEY([hourId])
REFERENCES [dbo].[Dim_Hour] ([hourId])
GO
ALTER TABLE [dbo].[Tb_Edge_Metrics] CHECK CONSTRAINT [FK_Tb_Edge_Metrics_Dim_Hour]
GO
ALTER TABLE [dbo].[Tb_Edge_Metrics]  WITH NOCHECK ADD  CONSTRAINT [FK_Tb_Edge_Metrics_Dim_Time] FOREIGN KEY([timeId])
REFERENCES [dbo].[Dim_Time] ([timeId])
GO
ALTER TABLE [dbo].[Tb_Edge_Metrics] CHECK CONSTRAINT [FK_Tb_Edge_Metrics_Dim_Time]
GO
ALTER TABLE [dbo].[Tb_Inbound_Agents_By_Queue]  WITH NOCHECK ADD  CONSTRAINT [FK_Tb_Inbound_Agents_By_Queue_Dim_Hour] FOREIGN KEY([hourId])
REFERENCES [dbo].[Dim_Hour] ([hourId])
GO
ALTER TABLE [dbo].[Tb_Inbound_Agents_By_Queue] CHECK CONSTRAINT [FK_Tb_Inbound_Agents_By_Queue_Dim_Hour]
GO
ALTER TABLE [dbo].[Tb_Inbound_Agents_By_Queue]  WITH NOCHECK ADD  CONSTRAINT [FK_Tb_Inbound_Agents_By_Queue_Dim_Queue] FOREIGN KEY([queueId])
REFERENCES [dbo].[Dim_Queue] ([queueId])
GO
ALTER TABLE [dbo].[Tb_Inbound_Agents_By_Queue] CHECK CONSTRAINT [FK_Tb_Inbound_Agents_By_Queue_Dim_Queue]
GO
ALTER TABLE [dbo].[Tb_Inbound_Agents_By_Queue]  WITH NOCHECK ADD  CONSTRAINT [FK_Tb_Inbound_Agents_By_Queue_Dim_Time] FOREIGN KEY([timeId])
REFERENCES [dbo].[Dim_Time] ([timeId])
GO
ALTER TABLE [dbo].[Tb_Inbound_Agents_By_Queue] CHECK CONSTRAINT [FK_Tb_Inbound_Agents_By_Queue_Dim_Time]
GO
ALTER TABLE [dbo].[Tb_Trunk_Metrics]  WITH NOCHECK ADD  CONSTRAINT [FK_Tb_Trunk_Metrics_Dim_Edge] FOREIGN KEY([edgeId])
REFERENCES [dbo].[Dim_Edge] ([edgeId])
GO
ALTER TABLE [dbo].[Tb_Trunk_Metrics] CHECK CONSTRAINT [FK_Tb_Trunk_Metrics_Dim_Edge]
GO
ALTER TABLE [dbo].[Tb_Trunk_Metrics]  WITH NOCHECK ADD  CONSTRAINT [FK_Tb_Trunk_Metrics_Dim_Hour] FOREIGN KEY([hourId])
REFERENCES [dbo].[Dim_Hour] ([hourId])
GO
ALTER TABLE [dbo].[Tb_Trunk_Metrics] CHECK CONSTRAINT [FK_Tb_Trunk_Metrics_Dim_Hour]
GO
ALTER TABLE [dbo].[Tb_Trunk_Metrics]  WITH NOCHECK ADD  CONSTRAINT [FK_Tb_Trunk_Metrics_Dim_Time] FOREIGN KEY([timeId])
REFERENCES [dbo].[Dim_Time] ([timeId])
GO
ALTER TABLE [dbo].[Tb_Trunk_Metrics] CHECK CONSTRAINT [FK_Tb_Trunk_Metrics_Dim_Time]
GO
ALTER TABLE [dbo].[Tb_Trunk_Metrics]  WITH NOCHECK ADD  CONSTRAINT [FK_Tb_Trunk_Metrics_Dim_Trunk] FOREIGN KEY([trunkId])
REFERENCES [dbo].[Dim_Trunk] ([trunkId])
GO
ALTER TABLE [dbo].[Tb_Trunk_Metrics] CHECK CONSTRAINT [FK_Tb_Trunk_Metrics_Dim_Trunk]
GO
ALTER TABLE [dbo].[Tb_User_Status_By_Queue]  WITH NOCHECK ADD  CONSTRAINT [FK_Tb_User_Status_By_Queue_Dim_Hour] FOREIGN KEY([hourId])
REFERENCES [dbo].[Dim_Hour] ([hourId])
GO
ALTER TABLE [dbo].[Tb_User_Status_By_Queue] CHECK CONSTRAINT [FK_Tb_User_Status_By_Queue_Dim_Hour]
GO
ALTER TABLE [dbo].[Tb_User_Status_By_Queue]  WITH NOCHECK ADD  CONSTRAINT [FK_Tb_User_Status_By_Queue_Dim_PresenceStatus] FOREIGN KEY([typePresenceStatusId], [presenceStatusDefinitionId])
REFERENCES [dbo].[Dim_PresenceStatus] ([typePresenceStatusId], [presenceStatusDefinitionId])
GO
ALTER TABLE [dbo].[Tb_User_Status_By_Queue] CHECK CONSTRAINT [FK_Tb_User_Status_By_Queue_Dim_PresenceStatus]
GO
ALTER TABLE [dbo].[Tb_User_Status_By_Queue]  WITH NOCHECK ADD  CONSTRAINT [FK_Tb_User_Status_By_Queue_Dim_Queue] FOREIGN KEY([queueId])
REFERENCES [dbo].[Dim_Queue] ([queueId])
GO
ALTER TABLE [dbo].[Tb_User_Status_By_Queue] CHECK CONSTRAINT [FK_Tb_User_Status_By_Queue_Dim_Queue]
GO
ALTER TABLE [dbo].[Tb_User_Status_By_Queue]  WITH NOCHECK ADD  CONSTRAINT [FK_Tb_User_Status_By_Queue_Dim_Time] FOREIGN KEY([timeId])
REFERENCES [dbo].[Dim_Time] ([timeId])
GO
ALTER TABLE [dbo].[Tb_User_Status_By_Queue] CHECK CONSTRAINT [FK_Tb_User_Status_By_Queue_Dim_Time]
GO
ALTER TABLE [dbo].[Tb_User_Status_By_Queue]  WITH NOCHECK ADD  CONSTRAINT [FK_Tb_User_Status_By_Queue_Dim_User] FOREIGN KEY([agentId])
REFERENCES [dbo].[Dim_User] ([userId])
GO
ALTER TABLE [dbo].[Tb_User_Status_By_Queue] CHECK CONSTRAINT [FK_Tb_User_Status_By_Queue_Dim_User]
GO
/****** Object:  StoredProcedure [dbo].[Borrado_Particion_dia]    Script Date: 12/12/2024 6:41:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   procedure [dbo].[Borrado_Particion_dia]
as
BEGIN
-- Paso 1 
/* Identificar el nombre del filegroup correspondiente a la partición 1, la cual sera reautilizada post borrado de partición*/ 
Declare @Archivo varchar(5)
SET @Archivo = (SELECT top 1
	f.name AS file_group
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(OBJECT_ID) = 'Dim_SessionMetrics'
AND p.partition_number = 1)
print @archivo

-- Paso 2
/* Se valida la fecha del ultimo boundary de la partición para aplicar el dia siguiente como un split range de la partición*/ 
Declare @fecha varchar(30)
set @fecha = (SELECT
            top 1
            ISNULL (
                CASE ppt.[name] --Format the value for displaying
                    WHEN N'date' THEN LEFT(CONVERT(varchar(30), CONVERT(date, prv.[value] ), 120), 10)
                    WHEN N'datetime' THEN CONVERT(varchar(30), CONVERT(datetime, prv.[value]), 121)
                    WHEN N'datetime2' THEN CONVERT(varchar(30), CONVERT(datetime2, prv.[value]), 121)
                    ELSE CONVERT(varchar(30), prv.[value] )
                END
                , N''
            )                                               AS LeftBoundaryStr
            
        FROM sys.partition_functions pf --information about partition function
        INNER JOIN sys.partition_parameters pp ON pp.function_id = pf.function_id AND pp.parameter_id = 1   --information about partition function parameter
        INNER JOIN sys.types ppt ON ppt.system_type_id = pp.system_type_id  --information about the parameter data type
       -- CROSS APPLY [Partitions] p 
       LEFT JOIN sys.partition_range_values prv ON prv.function_id = pf.function_id 
	   --AND prv.boundary_id = p.PartitionID - 1 
	   AND prv.parameter_id = 1
	   order by 1 desc)
set @fecha = (select DATEADD(day,1,@fecha))


-- Paso 3
/* Se borran las FK de las tablas que tienen restriccion para el borrado de particiones*/

ALTER TABLE [dbo].[Dim_Seg_requestedRoutingSkillIds] DROP CONSTRAINT [FK_Dim_Seg_requestedRoutingSkillIds_Dim_Segment]

ALTER TABLE [dbo].[Dim_SessionFlow] DROP CONSTRAINT [FK_Dim_SessionFlow_Dim_Session]

ALTER TABLE [dbo].[Dim_DataParticipant] DROP CONSTRAINT [FK_Dim_DataParticipant_Dim_Participant]

ALTER TABLE [dbo].[Dim_ConversationDivisions] DROP CONSTRAINT [FK_Dim_ConversationDivisions_Dim_Conversation]

ALTER TABLE [dbo].[Dim_Participant] DROP CONSTRAINT [FK_Dim_Participant_Dim_Conversation]

/*sacar articulo de la publicacion */

Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_DataParticipant' ,@status = N'inactive'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_SessionFlowOutcomes' ,@status = N'inactive'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_SessionFlow' ,@status = N'inactive'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_SessionMetrics' ,@status = N'inactive'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_Seg_requestedRoutingSkillIds' ,@status = N'inactive'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_Segment' ,@status = N'inactive'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_Session' ,@status = N'inactive'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_Participant' ,@status = N'inactive'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_ConversationDivisions' ,@status = N'inactive'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_Conversation' ,@status = N'inactive'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_ConversationAggregateMetrics' ,@status = N'inactive'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_ConversationDayQueueAggregateMetrics' ,@status = N'inactive'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_ConversationQueueAggregateMetrics' ,@status = N'inactive'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_ConversationUserAggregateMetrics' ,@status = N'inactive'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_FlowAggregateMetrics' ,@status = N'inactive'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_UserAggregateMetrics' ,@status = N'inactive'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'H_UserDetails' ,@status = N'inactive'

-- Paso 4
/* Se borra la partición 1 que siempre sera la mas antigua */ 

exec [dbo].[sp_tblDropPartition] N'Dim_DataParticipant',1, NULL,NULL,1,1 
exec [dbo].[sp_tblDropPartition] N'Dim_SessionFlowOutcomes',1, NULL,NULL,1,1
exec [dbo].[sp_tblDropPartition] N'Dim_SessionFlow',1, NULL,NULL,1,1 
exec [dbo].[sp_tblDropPartition] N'Dim_SessionMetrics',1, NULL,NULL,1,1 
exec [dbo].[sp_tblDropPartition] N'Dim_Seg_requestedRoutingSkillIds',1, NULL,NULL,1,1 
exec [dbo].[sp_tblDropPartition] N'Dim_Segment',1, NULL,NULL,1,1 
exec [dbo].[sp_tblDropPartition] N'Dim_Session',1, NULL,NULL,1,1 
exec [dbo].[sp_tblDropPartition] N'Dim_Participant',1, NULL,NULL,1,1 
exec [dbo].[sp_tblDropPartition] N'Dim_ConversationDivisions',1, NULL,NULL,1,1 
exec [dbo].[sp_tblDropPartition] N'Dim_Conversation',1, NULL,NULL,1,1
exec [dbo].[sp_tblDropPartition] N'Dim_ConversationAggregateMetrics',1, NULL,NULL,1,1
exec [dbo].[sp_tblDropPartition] N'Dim_ConversationDayQueueAggregateMetrics',1, NULL,NULL,1,1
exec [dbo].[sp_tblDropPartition] N'Dim_ConversationQueueAggregateMetrics',1, NULL,NULL,1,1
exec [dbo].[sp_tblDropPartition] N'Dim_ConversationUserAggregateMetrics',1, NULL,NULL,1,1
exec [dbo].[sp_tblDropPartition] N'Dim_FlowAggregateMetrics',1, NULL,NULL,1,1
exec [dbo].[sp_tblDropPartition] N'Dim_UserAggregateMetrics',1, NULL,NULL,1,1
exec [dbo].[sp_tblDropPartition] N'H_UserDetails',1, NULL,NULL,1,1

-- Paso 5
/* Se reutiliza el archivo fisico anteriormente vaciado por el borrado de partición */ 
declare @sql1 varchar(256)
declare @sql2 varchar(256)

Set @sql1 = 'ALTER PARTITION SCHEME [PSCH_Dia_Dim_Conversation] NEXT USED '+@Archivo
exec (@sql1)
Set @sql1 = 'ALTER PARTITION SCHEME [PSCH_Dia_Dim_ConversationAggregateMetrics] NEXT USED '+@Archivo
exec (@sql1)
Set @sql1 = 'ALTER PARTITION SCHEME [PSCH_Dia_Dim_ConversationDayQueueAggregateMetrics] NEXT USED '+@Archivo
exec (@sql1)
Set @sql1 = 'ALTER PARTITION SCHEME [PSCH_Dia_Dim_ConversationDivisions] NEXT USED '+@Archivo
exec (@sql1)
Set @sql1 = 'ALTER PARTITION SCHEME [PSCH_Dia_Dim_ConversationQueueAggregateMetrics] NEXT USED '+@Archivo
exec (@sql1)
Set @sql1 = 'ALTER PARTITION SCHEME [PSCH_Dia_Dim_ConversationUserAggregateMetrics] NEXT USED '+@Archivo
exec (@sql1)
Set @sql1 = 'ALTER PARTITION SCHEME [PSCH_Dia_Dim_DataParticipant] NEXT USED '+@Archivo
exec (@sql1)
Set @sql1 = 'ALTER PARTITION SCHEME [PSCH_Dia_Dim_FlowAggregateMetrics] NEXT USED '+@Archivo
exec (@sql1)
Set @sql1 = 'ALTER PARTITION SCHEME [PSCH_Dia_Dim_Participant] NEXT USED '+@Archivo
exec (@sql1)
Set @sql1 = 'ALTER PARTITION SCHEME [PSCH_Dia_Dim_Seg_requestedRoutingSkillIds] NEXT USED '+@Archivo
exec (@sql1)
Set @sql1 = 'ALTER PARTITION SCHEME [PSCH_Dia_Dim_Segment] NEXT USED '+@Archivo
exec (@sql1)
Set @sql1 = 'ALTER PARTITION SCHEME [PSCH_Dia_Dim_Session] NEXT USED '+@Archivo
exec (@sql1)
Set @sql1 = 'ALTER PARTITION SCHEME [PSCH_Dia_Dim_SessionFlow] NEXT USED '+@Archivo
exec (@sql1)
Set @sql1 = 'ALTER PARTITION SCHEME [PSCH_Dia_Dim_SessionFlowOutcomes] NEXT USED '+@Archivo
exec (@sql1)
Set @sql1 = 'ALTER PARTITION SCHEME [PSCH_Dia_Dim_SessionMetrics] NEXT USED '+@Archivo
exec (@sql1)
Set @sql1 = 'ALTER PARTITION SCHEME [PSCH_Dia_Dim_UserAggregateMetrics] NEXT USED '+@Archivo
exec (@sql1)
Set @sql1 = 'ALTER PARTITION SCHEME [PSCH_Dia_H_UserDetails] NEXT USED '+@Archivo
exec (@sql1)


Set @sql2 = 'ALTER PARTITION FUNCTION [PF_Dia_Dim_Conversation]() SPLIT RANGE ('''+@fecha+''')'
exec (@sql2)
Set @sql2 = 'ALTER PARTITION FUNCTION [PF_Dia_Dim_ConversationAggregateMetrics]() SPLIT RANGE ('''+@fecha+''')'
exec (@sql2)
Set @sql2 = 'ALTER PARTITION FUNCTION [PF_Dia_Dim_ConversationDayQueueAggregateMetrics]() SPLIT RANGE ('''+@fecha+''')'
exec (@sql2)
Set @sql2 = 'ALTER PARTITION FUNCTION [PF_Dia_Dim_ConversationDivisions]() SPLIT RANGE ('''+@fecha+''')'
exec (@sql2)
Set @sql2 = 'ALTER PARTITION FUNCTION [PF_Dia_Dim_ConversationQueueAggregateMetrics]() SPLIT RANGE ('''+@fecha+''')'
exec (@sql2)
Set @sql2 = 'ALTER PARTITION FUNCTION [PF_Dia_Dim_ConversationUserAggregateMetrics]() SPLIT RANGE ('''+@fecha+''')'
exec (@sql2)
Set @sql2 = 'ALTER PARTITION FUNCTION [PF_Dia_Dim_DataParticipant]() SPLIT RANGE ('''+@fecha+''')'
exec (@sql2)
Set @sql2 = 'ALTER PARTITION FUNCTION [PF_Dia_Dim_FlowAggregateMetrics]() SPLIT RANGE ('''+@fecha+''')'
exec (@sql2)
Set @sql2 = 'ALTER PARTITION FUNCTION [PF_Dia_Dim_Participant]() SPLIT RANGE ('''+@fecha+''')'
exec (@sql2)
Set @sql2 = 'ALTER PARTITION FUNCTION [PF_Dia_Dim_Seg_requestedRoutingSkillIds]() SPLIT RANGE ('''+@fecha+''')'
exec (@sql2)
Set @sql2 = 'ALTER PARTITION FUNCTION [PF_Dia_Dim_Segment]() SPLIT RANGE ('''+@fecha+''')'
exec (@sql2)
Set @sql2 = 'ALTER PARTITION FUNCTION [PF_Dia_Dim_Session]() SPLIT RANGE ('''+@fecha+''')'
exec (@sql2)
Set @sql2 = 'ALTER PARTITION FUNCTION [PF_Dia_Dim_SessionFlow]() SPLIT RANGE ('''+@fecha+''')'
exec (@sql2)
Set @sql2 = 'ALTER PARTITION FUNCTION [PF_Dia_Dim_SessionFlowOutcomes]() SPLIT RANGE ('''+@fecha+''')'
exec (@sql2)
Set @sql2 = 'ALTER PARTITION FUNCTION [PF_Dia_Dim_SessionMetrics]() SPLIT RANGE ('''+@fecha+''')'
exec (@sql2)
Set @sql2 = 'ALTER PARTITION FUNCTION [PF_Dia_Dim_UserAggregateMetrics]() SPLIT RANGE ('''+@fecha+''')'
exec (@sql2)
Set @sql2 = 'ALTER PARTITION FUNCTION [PF_Dia_H_UserDetails]() SPLIT RANGE ('''+@fecha+''')'
exec (@sql2)

-- Paso 6
/* Se crean las FKS borradas antes del borrado de partición */ 

ALTER TABLE [dbo].[Dim_SessionFlow]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_SessionFlow_Dim_Session] FOREIGN KEY([sessionId], [participantId], [conversationStart])
REFERENCES [dbo].[Dim_Session] ([sessionId], [participantId], [conversationStart])


ALTER TABLE [dbo].[Dim_SessionFlow] CHECK CONSTRAINT [FK_Dim_SessionFlow_Dim_Session]

ALTER TABLE [dbo].[Dim_DataParticipant]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_DataParticipant_Dim_Participant] FOREIGN KEY([participantId], [conversationId], [conversationStart])
REFERENCES [dbo].[Dim_Participant] ([participantId], [conversationId], [conversationStart])


ALTER TABLE [dbo].[Dim_DataParticipant] CHECK CONSTRAINT [FK_Dim_DataParticipant_Dim_Participant]


ALTER TABLE [dbo].[Dim_ConversationDivisions]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_ConversationDivisions_Dim_Conversation] FOREIGN KEY([conversationId], [conversationStart])
REFERENCES [dbo].[Dim_Conversation] ([conversationId], [conversationStart])


ALTER TABLE [dbo].[Dim_ConversationDivisions] CHECK CONSTRAINT [FK_Dim_ConversationDivisions_Dim_Conversation]


ALTER TABLE [dbo].[Dim_Participant]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_Participant_Dim_Conversation] FOREIGN KEY([conversationId], [conversationStart])
REFERENCES [dbo].[Dim_Conversation] ([conversationId], [conversationStart])


ALTER TABLE [dbo].[Dim_Participant] CHECK CONSTRAINT [FK_Dim_Participant_Dim_Conversation]


ALTER TABLE [dbo].[Dim_Seg_requestedRoutingSkillIds]  WITH NOCHECK ADD  CONSTRAINT [FK_Dim_Seg_requestedRoutingSkillIds_Dim_Segment] FOREIGN KEY([sessionId], [segmentTypeId], [disconnectTypeId], [segmentStart], [participantId])
REFERENCES [dbo].[Dim_Segment] ([sessionId], [segmentTypeId], [disconnectTypeId], [segmentStart], [participantId])


ALTER TABLE [dbo].[Dim_Seg_requestedRoutingSkillIds] CHECK CONSTRAINT [FK_Dim_Seg_requestedRoutingSkillIds_Dim_Segment]


/*volver articulo de la publicacion */

Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_DataParticipant' ,@status = N'active'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_SessionFlowOutcomes' ,@status = N'active'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_SessionFlow' ,@status = N'active'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_SessionMetrics' ,@status = N'active'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_Seg_requestedRoutingSkillIds' ,@status = N'active'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_Segment' ,@status = N'active'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_Session' ,@status = N'active'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_Participant' ,@status = N'active'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_ConversationDivisions' ,@status = N'active'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_Conversation' ,@status = N'active'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_ConversationAggregateMetrics' ,@status = N'active'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_ConversationDayQueueAggregateMetrics' ,@status = N'active'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_ConversationQueueAggregateMetrics' ,@status = N'active'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_ConversationUserAggregateMetrics' ,@status = N'active'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_FlowAggregateMetrics' ,@status = N'active'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'Dim_UserAggregateMetrics' ,@status = N'active'
Exec sp_changesubstatus @publication = 'Publication_GNREPORT_SMNYL_DimPartition' ,@article = N'H_UserDetails' ,@status = N'active'

Exec sp_reinitsubscription @publication = 'Publication_GNREPORT_SMNYL_DimPartition',@article = 'Dim_DataParticipant',@subscriber = 'EC2AMAZ-B2DMIU6',@destination_db = 'GNREPORT_SMNYL',@invalidate_snapshot = 1
Exec sp_reinitsubscription @publication = 'Publication_GNREPORT_SMNYL_DimPartition',@article = 'Dim_SessionFlowOutcomes',@subscriber = 'EC2AMAZ-B2DMIU6',@destination_db = 'GNREPORT_SMNYL',@invalidate_snapshot = 1
Exec sp_reinitsubscription @publication = 'Publication_GNREPORT_SMNYL_DimPartition',@article = 'Dim_SessionFlow',@subscriber = 'EC2AMAZ-B2DMIU6',@destination_db = 'GNREPORT_SMNYL',@invalidate_snapshot = 1
Exec sp_reinitsubscription @publication = 'Publication_GNREPORT_SMNYL_DimPartition',@article = 'Dim_SessionMetrics',@subscriber = 'EC2AMAZ-B2DMIU6',@destination_db = 'GNREPORT_SMNYL',@invalidate_snapshot = 1
Exec sp_reinitsubscription @publication = 'Publication_GNREPORT_SMNYL_DimPartition',@article = 'Dim_Seg_requestedRoutingSkillIds',@subscriber = 'EC2AMAZ-B2DMIU6',@destination_db = 'GNREPORT_SMNYL',@invalidate_snapshot = 1
Exec sp_reinitsubscription @publication = 'Publication_GNREPORT_SMNYL_DimPartition',@article = 'Dim_Segment',@subscriber = 'EC2AMAZ-B2DMIU6',@destination_db = 'GNREPORT_SMNYL',@invalidate_snapshot = 1
Exec sp_reinitsubscription @publication = 'Publication_GNREPORT_SMNYL_DimPartition',@article = 'Dim_Session',@subscriber = 'EC2AMAZ-B2DMIU6',@destination_db = 'GNREPORT_SMNYL',@invalidate_snapshot = 1
Exec sp_reinitsubscription @publication = 'Publication_GNREPORT_SMNYL_DimPartition',@article = 'Dim_Participant',@subscriber = 'EC2AMAZ-B2DMIU6',@destination_db = 'GNREPORT_SMNYL',@invalidate_snapshot = 1
Exec sp_reinitsubscription @publication = 'Publication_GNREPORT_SMNYL_DimPartition',@article = 'Dim_ConversationDivisions',@subscriber = 'EC2AMAZ-B2DMIU6',@destination_db = 'GNREPORT_SMNYL',@invalidate_snapshot = 1
Exec sp_reinitsubscription @publication = 'Publication_GNREPORT_SMNYL_DimPartition',@article = 'Dim_Conversation',@subscriber = 'EC2AMAZ-B2DMIU6',@destination_db = 'GNREPORT_SMNYL',@invalidate_snapshot = 1
Exec sp_reinitsubscription @publication = 'Publication_GNREPORT_SMNYL_DimPartition',@article = 'Dim_ConversationAggregateMetrics',@subscriber = 'EC2AMAZ-B2DMIU6',@destination_db = 'GNREPORT_SMNYL',@invalidate_snapshot = 1
Exec sp_reinitsubscription @publication = 'Publication_GNREPORT_SMNYL_DimPartition',@article = 'Dim_ConversationDayQueueAggregateMetrics',@subscriber = 'EC2AMAZ-B2DMIU6',@destination_db = 'GNREPORT_SMNYL',@invalidate_snapshot = 1
Exec sp_reinitsubscription @publication = 'Publication_GNREPORT_SMNYL_DimPartition',@article = 'Dim_ConversationQueueAggregateMetrics',@subscriber = 'EC2AMAZ-B2DMIU6',@destination_db = 'GNREPORT_SMNYL',@invalidate_snapshot = 1
Exec sp_reinitsubscription @publication = 'Publication_GNREPORT_SMNYL_DimPartition',@article = 'Dim_ConversationUserAggregateMetrics',@subscriber = 'EC2AMAZ-B2DMIU6',@destination_db = 'GNREPORT_SMNYL',@invalidate_snapshot = 1
Exec sp_reinitsubscription @publication = 'Publication_GNREPORT_SMNYL_DimPartition',@article = 'Dim_FlowAggregateMetrics',@subscriber = 'EC2AMAZ-B2DMIU6',@destination_db = 'GNREPORT_SMNYL',@invalidate_snapshot = 1
Exec sp_reinitsubscription @publication = 'Publication_GNREPORT_SMNYL_DimPartition',@article = 'Dim_UserAggregateMetrics',@subscriber = 'EC2AMAZ-B2DMIU6',@destination_db = 'GNREPORT_SMNYL',@invalidate_snapshot = 1
Exec sp_reinitsubscription @publication = 'Publication_GNREPORT_SMNYL_DimPartition',@article = 'H_UserDetails',@subscriber = 'EC2AMAZ-B2DMIU6',@destination_db = 'GNREPORT_SMNYL',@invalidate_snapshot = 1

 Exec sp_startpublication_snapshot @Publication = 'Publication_GNREPORT_SMNYL_DimPartition'
 END
GO
USE [master]
GO
ALTER DATABASE [GNREPORT_SMNYL] SET  READ_WRITE 
GO
